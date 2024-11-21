import axios from "axios";

export default {
    name: 'LoginPage',
    
  data() {
    return {
      username: '',
      password: '',
    };
    },
  
  methods: {
    async handleLogin() {
  try {
    // user 객체 생성
    const user = {
      userId: this.username, // usernaddme과 매핑
      userPw: this.password, // password와 매핑
    };

    // POST 요청
    const response = await axios.post(
      "http://localhost:8080/users/login",
      {
        userId: user.userId,
        userPw: user.userPw,
      },
      {
        headers: {
          "Content-Type": "application/json",
        },
      }
      );
      
    if (response.data.userId === user.userId) {
      this.$router.push({ name: "Main" });
    } else {
      this.errorMessage = "로그인 실패";
    }
  } catch (error) {
    this.errorMessage = "서버 요청 중 오류가 발생했습니다.";
  }
},
    goRegisterPage() {
    this.$router.push({ name: 'Register' });
  },

  },
};