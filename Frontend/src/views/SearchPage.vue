<template>
    <div class="youtube-main">
      <header class="youtube-header">
        <div class="logo" @click="goMainPage()">
          <img src="@/assets/youtube-logo.png" alt="Logo" />
        </div>
        <div class="search-bar">
          <input
            type="text"
            placeholder="검색"
            v-model="searchQuery"
            @keypress.enter="searchVideos"
          />
          <button @click="searchVideos">🔍</button>
        </div>
        <div class="user-icons">
          <button>🔔</button>
          <button>🧑</button>
        </div>
      </header>
      <div class="youtube-content">
        <aside class="sidebar">
          <ul>
            <li @click="goMainPage">홈</li>
            <li>인기 급상승</li>
            <li>구독</li>
            <li>내 동영상</li>
          </ul>
        </aside>
        <main class="main-content">
          <div v-if="searchResults.length" class="video-list">
            <div
              class="video-item"
              v-for="video in searchResults"
              :key="video.videoId"
              @click="goToVideo(video)"
            >
              <img :src="getThumbnailUrl(video.url)" alt="Thumbnail" class="thumbnail" />
              <div class="video-details">
                <h3 class="video-title">{{ video.videoId }}</h3>
                <p class="video-info">조회수 {{ video.views }}</p>
                <p class="channel-name">{{ video.category }}</p>
              </div>
            </div>
          </div>
          <p v-else>검색 결과가 없습니다.</p>
        </main>
      </div>
    </div>
  </template>
  
  <script>
  import axios from "axios";
  
  export default {
    name: "SearchPage",
    data() {
      return {
        searchQuery: this.$route.query.q || "",
        searchResults: [],
      };
    },
    methods: {
      async searchVideos() {
        try {
          const response = await axios.post(
            "http://localhost:8080/videos/getSearchVideo",
            this.searchQuery,
            {
              headers: {
                "Content-Type": "text/plain",
              },
            }
          );
          this.searchResults = response.data;
        } catch (error) {
          console.error("Error searching videos:", error);
        }
      },
      getThumbnailUrl(videoUrl) {
        const videoId = videoUrl.split("v=")[1];
        const ampersandPosition = videoId.indexOf("&");
        if (ampersandPosition !== -1) {
          return `https://img.youtube.com/vi/${videoId.substring(
            0,
            ampersandPosition
          )}/0.jpg`;
        }
        return `https://img.youtube.com/vi/${videoId}/0.jpg`;
      },
      goToVideo(video) {
        this.$router.push({
          name: "VideoPage",
          query: {
            videoId: video.videoId,
            url: video.url,
            category: video.category,
            views: video.views,
          },
        });
      },
      goMainPage() {
        this.$router.push({ name: "Main" });
      },
    },
    mounted() {
      this.searchVideos();
    },
  };
  </script>
  <style src="../css/SearchPage.css"></style>