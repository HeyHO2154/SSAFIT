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
    const user = {
      userId: this.username,
      userPw: this.password,
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
        // 사용자 정보를 localStorage에 저장
        sessionStorage.setItem("user", JSON.stringify(response.data));

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