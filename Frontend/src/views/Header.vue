<template>
  <header class="header">
    <nav>
        <div class="logo" @click="goMainPage()">
         <img src="@/assets/youtube-logo.png" alt="Logo" />
        </div>
      <ul class="HeaderUl">
        <li @click="goMyPage">마이페이지</li>
        <li @click="goLoginPage">로그인</li>
        <li>햄버거</li>
      </ul>
    </nav>
  </header>

</template>

<script>
export default {
    name: 'MainHeader',
    methods: {
    goMainPage() {
      this.fetchVideos(); // 컴포넌트가 마운트되면 비디오 목록을 로드
      this.$router.push({ name: "Main" });
    },
    goMyPage() {
        this.$router.push({ name: "MyPage" });
    },
    goLoginPage() {
      this.$router.push({ name: "Login" });
    },
  },
};
</script>

<style src="../css/Header.css"></style>
