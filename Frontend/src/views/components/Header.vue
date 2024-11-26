<template>
  <header class="header">
    <nav>
      <div class="logo" @click="goMainPage">
        <img src="@/assets/youtube-logo.png" alt="Logo" />
      </div>
      <ul class="HeaderUl">
        <li @click="goMyPage">마이페이지</li>
        <li v-if="isLoggedIn" @click="logout">로그아웃</li>
        <li v-else @click="goLoginPage">로그인</li>
        <li>햄버거</li>
      </ul>
    </nav>
  </header>
</template>

<script>
import axios from "axios";

export default {
  name: "MainHeader",
  data() {
    return {
      isLoggedIn: false, // 로그인 상태 확인
    };
  },
  methods: {
    checkLoginStatus() {
      // 세션에서 사용자 정보를 확인
      const user = JSON.parse(sessionStorage.getItem("user"));
      this.isLoggedIn = !!user;
    },
    goMainPage() {
      this.fetchVideos();
      this.$router.push({ name: "Main" });
    },
    goMyPage() {
      this.fetchVideos();
      this.$router.push({ name: "MyPage" });
    },
    goLoginPage() {
      this.$router.push({ name: "Login" });
    },
    logout() {
      // 로그아웃 처리!
      sessionStorage.removeItem("user");
      this.isLoggedIn = false;
      window.location.reload();
    },
    async fetchVideos() {
      const user = JSON.parse(sessionStorage.getItem("user"));
      if (user) {
        console.log("Logged in user:", user);
      } else {
        this.$router.push({ name: "Login" });
      }
      try {
        const response = await axios.post(
          "http://localhost:8080/videos/getAllVideos"
        );
        this.videos = response.data.sort(() => Math.random() - 0.5);
      } catch (error) {
        console.error("Error fetching videos:", error);
      }
    },
  },
  mounted() {
    // 컴포넌트가 마운트되면 로그인 상태 확인
    this.checkLoginStatus();
  },
  watch: {
    // 라우터 변경 시 로그인 상태 확인
    $route: "checkLoginStatus",
  },
};
</script>

<style>
/* 스타일은 기존 코드와 동일 */
@font-face {
  font-family: "SBAggroM";
  src: url("https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/SBAggroM.woff")
    format("woff");
  font-weight: 300;
}

.header {
  color: #4b89dc;
  padding-left: 5%;
  padding-right: 5%;
  padding-top: 0.3%;
  padding-bottom: 0.3%;
  display: flex;
  align-items: center;
  font-family: SBAggroM;
  border-bottom: 1.5px solid #4b89dc;
  background-color: aliceblue;
}

nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
}

.header .logo img {
  cursor: pointer;
  height: 40px;
}

.header .HeaderUl {
  list-style: none;
  display: flex;
  gap: 2rem;
  cursor: pointer;
  margin-left: auto;
  padding: 0;
  font-size: 1em;
}

a {
  text-decoration: none;
  color: white;
}

a:hover {
  color: #aaa;
}
</style>
