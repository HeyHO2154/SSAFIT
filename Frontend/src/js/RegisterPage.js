import axios from "axios";

export default {
  name: "RegisterPage",
  data() {
    return {
      userId: "",
      userPw: "",
      nickname: "",
      errorMessage: "", // 에러 메시지를 저장할 변수
    };
  },
  methods: {
  async handleRegister() {
    try {
      // user 객체 생성
      const user = {
        userId: this.userId,
        userPw: this.userPw,
        nickname: this.nickname,
      };

      // POST 요청
      const response = await axios.post(
  "http://localhost:8080/users/register",
  {
    userId: user.userId,
    userPw: user.userPw,
    nickname: user.nickname,
  },
  {
    headers: {
      "Content-Type": "application/json",
    },
  }
);


      if (response.data) {
        // 회원가입 성공 시 로그인 페이지로 이동
        // 회원가입 성공 팝업창
        this.$router.push({ name: "Login" });
      } else {
        // 중복된 아이디 에러 메시지 표시
        this.errorMessage = "중복된 아이디입니다. 다른 아이디를 사용해주세요.";
      }
    } catch (error) {
      console.error("Error in handleRegister:", error);
      this.errorMessage = "서버 요청 중 오류가 발생했습니다.";
    }
    },
    
    goLoginPage() {
      this.$router.push({ name: "Login" });
    },
},


};