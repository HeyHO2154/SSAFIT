import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter_onestore_inapp/flutter_onestore_inapp.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../Login.dart';

class Upgrade extends StatefulWidget {
  @override
  _UpgradeState createState() => _UpgradeState();
}

class _UpgradeState extends State<Upgrade> {
  Random random = Random();
  int totalPoints = 0;
  bool isFactoryActive = false;
  DateTime? factoryEndTime;
  Timer? refreshTimer;
  TextEditingController _userIdController = TextEditingController();
  late OneStoreAuthClient _authClient;
  late PurchaseClientManager _clientManager;
  late StreamSubscription<List<PurchaseData>> _subscription;
  List<ProductDetail> _products = [];

  @override
  void initState() {
    super.initState();
    _initializeOneStoreInApp();
    _fetchPoints();
    _loadFactoryStatus();
    refreshTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _checkFactoryStatus();
    });
  }

  void _initializeOneStoreInApp() async {
    _authClient = OneStoreAuthClient();
    _clientManager = PurchaseClientManager.instance;

    _clientManager.initialize('MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCHUJl9vv7TjqyI/A+EMzSQZ42pm/DsZgICxDxwEhGsEOO1FOyYQCaL1y+rC/vauqYlFn54bweGsi/UuahxYaM0RTwkIIyNtgXFZrURdUXW+4Vlm3gzzBlHNVycBUVaYTRGs2SlvboBm8uKhH8OXByijQBuE9/z3Di7SIKAnYcb4wIDAQAB');

    final signInResult = await _authClient.launchSignInFlow();
    if (signInResult.isSuccess()) {
      _loadProducts();
      _checkAndConsumePendingPurchases(); // 소비되지 않은 구매 내역 확인 및 소비 처리
    } else {
      _showErrorDialog("원스토어 로그인에 실패했습니다.");
    }

    _subscription = _clientManager.purchasesUpdatedStream.listen(
          (purchases) => _onPurchaseUpdated(purchases),
      onError: (error) => _handlePurchaseError(error),
    );
  }

// 소비되지 않은 구매 내역을 확인하고 소비하는 함수 추가
  void _checkAndConsumePendingPurchases() async {
    final response = await _clientManager.queryPurchases(productType: ProductType.inapp);

    if (response.iapResult.isSuccess()) {
      for (var purchaseData in response.purchasesList) {
        if (_isConsumable(purchaseData.productId)) {
          // 소비성 상품일 경우, consumePurchase를 통해 소비 처리
          final consumeResult = await _clientManager.consumePurchase(purchaseData: purchaseData);
          if (consumeResult.isSuccess()) {
            print("이전 미소비 구매 소비 완료: ${purchaseData.productId}");
          } else {
            print("이전 미소비 구매 소비 실패: ${purchaseData.productId}");
          }
        } else {
          // 구독 상품 등 소비가 필요하지 않은 경우 acknowledge 호출
          final acknowledgeResult = await _clientManager.acknowledgePurchase(purchaseData: purchaseData);
          if (acknowledgeResult.isSuccess()) {
            print("이전 미확인 구매 확인 완료: ${purchaseData.productId}");
          } else {
            print("이전 미확인 구매 확인 실패: ${purchaseData.productId}");
          }
        }
      }
    } else {
      print("구매 내역 조회 실패: ${response.iapResult.message}");
    }
  }


  Future<void> _fetchPoints() async {
    final response = await http.get(
        Uri.parse("${Login.url}/api/getPoints?user_id=${Login.userId}"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        totalPoints = data['points'];
      });
    } else {
      print("포인트 정보를 가져오는 중 오류 발생: ${response.body}");
    }
  }

  Future<void> _increasePoints(int points) async {
    final response = await http.post(
      Uri.parse("${Login.url}/api/increase"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user_id": Login.userId, "points": points}),
    );

    if (response.statusCode == 200) {
      setState(() {
        totalPoints += points;
      });
    } else {
      print("포인트 증가 중 오류 발생: ${response.body}");
    }
  }

  Future<void> _decreasePoints(int points) async {
    final response = await http.post(
      Uri.parse("${Login.url}/api/decrease"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user_id": Login.userId, "points": points}),
    );

    if (response.statusCode == 200) {
      setState(() {
        totalPoints -= points;
      });
    } else {
      print("포인트 감소 중 오류 발생: ${response.body}");
    }
  }

  Future<void> _updateUserId() async {
    await _fetchPoints();
    if (totalPoints >= 1000) {
      final response = await http.post(
        Uri.parse("${Login.url}/api/updateUserId"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user_id": Login.userId,
          "new_user_id": _userIdController.text,
        }),
      );

      if (response.statusCode == 200) {
        print("아이디 변경 성공: ${response.body}");
        await _updateLocalUserId(_userIdController.text);
        setState(() {
          Login.userId = _userIdController.text;
          _userIdController.clear();
        });
        _decreasePoints(1000);
      } else if (response.statusCode == 409) {
        _showErrorDialog("이미 존재하는 아이디입니다.");
      } else {
        _showErrorDialog("아이디 변경에 실패했습니다.");
      }
    } else {
      _showErrorDialog("포인트가 부족하여 아이디를 변경할 수 없습니다.");
    }
  }

  Future<void> _updateLocalUserId(String newUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', newUserId);
  }

  Future<void> _toggleFactoryActivation() async {
    if (isFactoryActive) {
      _deactivateFactory(4000);
    } else if (totalPoints >= 5000) {
      await _decreasePoints(5000);
      setState(() {
        isFactoryActive = true;
        factoryEndTime = DateTime.now().add(Duration(hours: 3));
      });
      _saveFactoryStatus();
    }
  }

  Future<void> _deactivateFactory(int pointsToReturn) async {
    await _increasePoints(pointsToReturn);
    setState(() {
      isFactoryActive = false;
      factoryEndTime = null;
    });
    _removeFactoryStatus();
  }

  Future<void> _saveFactoryStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFactoryActive', isFactoryActive);
    await prefs.setString(
        'factoryEndTime', factoryEndTime?.toIso8601String() ?? '');
  }

  Future<void> _loadFactoryStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? savedFactoryStatus = prefs.getBool('isFactoryActive');
    String? savedEndTimeString = prefs.getString('factoryEndTime');

    if (savedFactoryStatus == true && savedEndTimeString != null) {
      DateTime savedEndTime = DateTime.parse(savedEndTimeString);
      if (savedEndTime.isAfter(DateTime.now())) {
        setState(() {
          isFactoryActive = true;
          factoryEndTime = savedEndTime;
        });
      } else {
        _deactivateFactory(6000);
      }
    }
  }

  Future<void> _removeFactoryStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isFactoryActive');
    await prefs.remove('factoryEndTime');
  }

  void _checkFactoryStatus() {
    if (isFactoryActive && factoryEndTime != null) {
      if (factoryEndTime!.isBefore(DateTime.now())) {
        _deactivateFactory(6000);
      } else {
        setState(() {});
      }
    }
  }

  String _formatFactoryEndTime() {
    if (factoryEndTime == null) return '';
    Duration remaining = factoryEndTime!.difference(DateTime.now());
    final hours = remaining.inHours.toString().padLeft(2, '0');
    final minutes = remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = remaining.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "6,000포인트 회수까지 남은 시간: $hours:$minutes:$seconds";
  }

  void _loadProducts() async {
    const List<String> productIds = ['point_1000', 'point_5500', 'point_12000'];
    final response = await _clientManager.queryProductDetails(
      productIds: productIds,
      productType: ProductType.inapp,
    );
    print("Loaded products: $_products");
    if (response != null && response.productDetailsList.isNotEmpty) {
      setState(() {
        _products = response.productDetailsList;
      });
    } else {
      print("상품 정보 불러오기에 실패");
    }
  }
  void _buyProduct(ProductDetail product) async {
    final result = await _clientManager.launchPurchaseFlow(
      productDetail: product,
      quantity: 1,
      developerPayload: 'optional_payload',
    );

    if (result.isSuccess()) {
      print("구매 성공");
    } else {
      print("구매 실패");
    }
  }
  void _onPurchaseUpdated(List<PurchaseData> purchases) async {
    for (var purchase in purchases) {
      if (purchase.purchaseState == PurchaseState.purchased) {
        await _grantPoints(purchase.productId);

        // 소비성 상품인지 확인하고 소비 작업을 수행합니다.
        if (_isConsumable(purchase.productId)) {
          // 소비 작업 (consume)
          final consumeResult = await _clientManager.consumePurchase(purchaseData: purchase);

          if (consumeResult.isSuccess()) {
            print("구매 소비 완료");
          } else {
            print("구매 소비 실패");
          }
        } else {
          // 관리형 상품이거나 구독 상품의 경우에는 확인 작업 (acknowledge) 수행
          final acknowledgeResult = await _clientManager.acknowledgePurchase(purchaseData: purchase);

          if (acknowledgeResult.isSuccess()) {
            print("구매 확인 완료");
          } else {
            print("구매 확인 실패");
          }
        }
      }
    }
  }

// 소비성 상품을 구분하는 메서드 (필요에 따라 정의)
  bool _isConsumable(String productId) {
    return productId == 'point_1000' || productId == 'point_5500' || productId == 'point_12000';
  }


  Future<void> _grantPoints(String productId) async {
    int pointsToGrant = 0;
    if (productId == 'point_1000') {
      pointsToGrant = 1000;
    } else if (productId == 'point_5500') {
      pointsToGrant = 5500;
    } else if (productId == 'point_12000') {
      pointsToGrant = 12000;
    }
    await _increasePoints(pointsToGrant);
  }

  void _handlePurchaseError(error) {
    print("결제 오류 발생: $error");
    _showErrorDialog("결제 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
  }


  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("에러"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("확인"),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    _subscription.cancel();
    _clientManager.dispose();
    refreshTimer?.cancel();
    super.dispose();
  }

  Widget _buildPointBox(String points, String price, int increaseAmount, String imagePath, {String? bonus}) {
    return GestureDetector(
      onTap: () {
        final product = _products.firstWhere(
              (p) => p.productId == (increaseAmount == 1000 ? "point_1000" : increaseAmount == 5500 ? "point_5500" : "point_12000"),
          orElse: () => throw Exception("Product not found"),
        );
        if (product != null) {
          _buyProduct(product);
        } else {
          print("Product not found");
        }
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(imagePath, width: 60, height: 60),
                SizedBox(height: 5),
                Text(points, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.yellow.shade900)),
                SizedBox(height: 0),
                Text(price, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey.shade500)),
              ],
            ),
          ),
          if (bonus != null)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Text(
                  bonus,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Text(
                  "$totalPoints P",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                ),
                Text(
                  "업그레이드를 통해 수익성을 강화하세요!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "( 공장 활성화시 3시간마다 자동 수익 )",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "닉네임 바꾸기",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _userIdController,
                        decoration: InputDecoration(
                          hintText: "${Login.userId}",
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: totalPoints >= 1000 ? _updateUserId : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "닉네임 변경 (1000 P)",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "포인트 충전",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 160,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildPointBox(
                          "1,000 포인트", "1,000원", 1000, "assets/money1.png"),
                      SizedBox(width: 16),
                      _buildPointBox(
                          "5,500 포인트", "5,000원", 5500, "assets/money2.png",
                          bonus: "+10%"),
                      SizedBox(width: 16),
                      _buildPointBox(
                          "12,000 포인트", "10,000원", 12000, "assets/money3.png",
                          bonus: "+20%"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "자동화 공장",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ColorFiltered(
                      colorFilter: isFactoryActive
                          ? ColorFilter.mode(
                          Colors.transparent, BlendMode.multiply)
                          : ColorFilter.mode(Colors.grey, BlendMode.saturation),
                      child: Image.asset("assets/factory.png",
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 40),
                    ),
                    Positioned(
                      child: ElevatedButton(
                        onPressed: isFactoryActive || totalPoints >= 5000 ? _toggleFactoryActivation : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isFactoryActive ? Colors.green : Colors.lightBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          isFactoryActive ? (factoryEndTime!.isAfter(DateTime.now()) ? "4천 포인트 회수하기" : "6천 포인트 회수하기") : "공장 활성화 (5000 P)",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                if (isFactoryActive)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      factoryEndTime!.isAfter(DateTime.now())
                          ? _formatFactoryEndTime()
                          : "시간이 만료되어 6천 포인트 지금 회수 가능합니다!",
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
