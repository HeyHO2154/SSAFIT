<template>
  <div>
    <h1>Login Page</h1>
    <form @submit.prevent="handleLogin">
      <input type="text" placeholder="Username" v-model="username" />
      <input type="password" placeholder="Password" v-model="password" />
      <button type="submit">로그인</button>
      <p v-if="errorMessage" style="color: red;">{{ errorMessage }}</p>
      <button @click="goRegisterPage">회원가입</button>
    </form>
  </div>
</template>

<script>
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
      userId: this.username, // username과 매핑
      userPw: this.password, // password와 매핑
    };

    // POST 요청
    const response = await axios.post(
      "http://70.12.50.104:8080/users/login",
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

    console.log(response.data.userId);
    console.log(user.userId);

    if (response.data.userId === user.userId) {
      // 로그인 성공 시 메인 페이지로 이동
      this.$router.push({ name: "Main" });
    } else {
      // 로그인 실패 메시지 표시
      this.errorMessage = "로그인 실패";
    }
  } catch (error) {
    console.error("Error in handleLogin:", error);
    this.errorMessage = "서버 요청 중 오류가 발생했습니다.";
  }
},
goRegisterPage() {
    this.$router.push({ name: 'Register' });
  },

  },
};
</script>