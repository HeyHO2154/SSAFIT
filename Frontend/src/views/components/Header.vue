<template>
  <header class="header">
    <nav>
        <div class="logo" @click="goMainPage">
         <img src="@/assets/youtube-logo.png" alt="Logo" />
        </div>
      <ul class="HeaderUl">
        <li @click="goMainPage">마이페이지</li>
        <li @click="goLoginPage">로그인</li>
        <li>햄버거</li>
      </ul>
    </nav>
  </header>

</template>

<script>
import axios from "axios";

export default {
    name: 'MainHeader',
    methods: {
    goMainPage() {
      this.fetchVideos(); // 컴포넌트가 마운트되면 비디오 목록을 로드
      this.$router.push({ name: "Main" });
    },
    goLoginPage() {
      this.$router.push({ name: "Login" });
    },
      async fetchVideos() {
          const user = JSON.parse(sessionStorage.getItem("user"));
      if (user) {
        console.log("Logged in user:", user);
      } else {
        this.$router.push({ name: "Login" }); // 로그인이 안 되어 있으면 로그인 페이지로 이동
      }
      try {
        const response = await axios.post(
          "http://localhost:8080/videos/getAllVideos"
        );
        this.videos = response.data.sort(() => Math.random() - 0.5); // 데이터를 랜덤으로 섞어서 저장
      } catch (error) {
        console.error("Error fetching videos:", error);
      }
    },
  },
};
</script>

<style src>
@font-face {
  font-family: 'SBAggroM';
  src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/SBAggroM.woff') format('woff');
  font-weight: 300;
  /* font-style: normal; */
}

.header {
    /* background-color: #333; */
    color: #4B89DC;
    padding-left: 5%;
    padding-right: 5%;
    padding-top: 1.8%;
    padding-bottom: 1.8%;
    display: flex;
    /* justify-content: space-between; */
    align-items: center;
    height: 0px;
    font-family:SBAggroM;
    border-bottom: 1.5px solid #4B89DC;
  }
  
  nav{
    display: flex; /* 자식 요소들을 가로로 배치 */
    justify-content: space-between; /* 좌우 간격을 일정하게 분배 */
    align-items: center; /* 세로 중앙 정렬 */
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
  
  /* body{
    
  } */

</style>
