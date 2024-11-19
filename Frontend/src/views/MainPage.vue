<template>
    <div class="youtube-main">
      <header class="youtube-header">
        <div class="logo" @click="goMainPage()">
          <img src="@/assets/youtube-logo.png" alt="Logo" />
        </div>
        <div class="search-bar">
          <input type="text" placeholder="Search" />
          <button>🔍</button>
        </div>
        <div class="user-icons">
          <button>🔔</button>
          <button>🧑</button>
        </div>
      </header>
  
      <div class="youtube-content">
        <aside class="sidebar">
          <ul>
            <li>Home</li>
            <li>Trending</li>
            <li>Subscriptions</li>
            <li>Library</li>
          </ul>
        </aside>
        <main class="main-content">
          <div class="video-grid">
            <div class="video-card" v-for="video in videos" :key="video.videoId" @click="goToVideo(video)">
                <img :src="getThumbnailUrl(video.url)" alt="Thumbnail" />
                <div class="video-info">
                  <h3>{{ video.videoId }}</h3>
                  <p>조회수: {{ video.views }}</p>
                </div>
              </div>              
          </div>
        </main>
      </div>
    </div>
  </template>
  
  <script>
  import axios from "axios";
  
  export default {
    name: "MainPage",
    data() {
      return {
        videos: [], // 초기 데이터 비우기
      };
    },
    methods: {
      async fetchVideos() {
        try {
          const response = await axios.post("http://localhost:8080/videos/getAllVideos");
          this.videos = response.data; // 데이터를 저장
        } catch (error) {
          console.error("Error fetching videos:", error);
        }
      },
      // YouTube URL에서 video_id 추출 후 썸네일 URL 생성
      getThumbnailUrl(videoUrl) {
        const videoId = videoUrl.split("v=")[1]; // "v=" 뒤에 오는 video_id 추출
        const ampersandPosition = videoId.indexOf("&");
        if (ampersandPosition !== -1) {
          return `https://img.youtube.com/vi/${videoId.substring(0, ampersandPosition)}/0.jpg`;
        }
        return `https://img.youtube.com/vi/${videoId}/0.jpg`;
        },
        goToVideo(video) {
            this.$router.push({
                name: "VideoPage",
                params: {
                id: video.videoId, // 필수 경로 파라미터 전달
                },
                query: {
                    url: video.url, // 추가적인 정보는 query로 전달
                    category: video.category,
                    views: video.views
                },
            });
        },
        goMainPage() {this.$router.push({name: "Main",});},
    },
    mounted() {
      this.fetchVideos();
    },
  };
  </script>
  
  <style src="../css/MainPage.css"></style>
  