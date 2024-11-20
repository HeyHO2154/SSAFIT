<template>
  <div class="youtube-main">
    <header class="youtube-header">
      <div class="logo" @click="goMainPage">
        <img src="@/assets/youtube-logo.png" alt="Logo" />
      </div>
      <div class="search-bar">
        <input type="text" placeholder="검색" v-model="searchQuery" @keyup.enter="searchVideos"/>
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
          <li>홈</li>
          <li>인기 급상승</li>
          <li>구독</li>
          <li>내 동영상</li>
        </ul>
      </aside>
      <main class="main-content">
        <div class="category-filter">
          <button
            v-for="category in categories"
            :key="category"
            :class="{ active: selectedCategory === category }"
            @click="filterVideos(category)"
          >
            {{ category }}
          </button>
        </div>
        <div class="video-grid">
          <div
            class="video-card"
            v-for="video in filteredVideos"
            :key="video.videoId"
            @click="goToVideo(video)"
          >
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
      videos: [],
      categories: ["전체", "브베", "먹방", "아이돌", "음악"],
      selectedCategory: "전체",
      searchQuery: "",
    };
  },
  computed: {
    filteredVideos() {
      if (this.selectedCategory === "전체") {
        return this.videos;
      }
      return this.videos.filter(
        (video) => video.category === this.selectedCategory
      );
    },
  },
  methods: {
    async fetchVideos() {
      try {
        const response = await axios.post(
          "http://localhost:8080/videos/getAllVideos"
        );
        this.videos = response.data.sort(() => Math.random() - 0.5);
      } catch (error) {
        console.error("Error fetching videos:", error.message);
      }
    },
    async searchVideos() {
      try {
        if (!this.searchQuery.trim()) {
          this.fetchVideos();
          return;
        }
        const response = await axios.post(
          "http://localhost:8080/videos/getSearchVideo",
          this.searchQuery.trim(),
          {
            headers: {
              "Content-Type": "text/plain",
            },
          }
        );
        this.videos = response.data;
      } catch (error) {
        console.error("Error searching videos:", error.message);
      }
    },
    filterVideos(category) {
      this.selectedCategory = category;
    },
    addVideoView(video) {
      return axios
        .post("http://localhost:8080/videos/addViews", {
          videoId: video.videoId,
          views: 1,
        })
        .then((response) => {
          console.log("Response from addViews:", response.data);
          return response.data;
        })
        .catch((error) => {
          console.error("Error in addVideoView:", error.message);
          return video;
        });
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
    async goToVideo(video) {
      video = await this.addVideoView(video);
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
    async goMainPage() {
      this.searchQuery = ""; // 검색어 초기화
      this.selectedCategory = "전체"; // 카테고리 초기화
      await this.fetchVideos(); // 전체 비디오 다시 로드
    },
  },
  mounted() {
    this.fetchVideos();
  },
};
</script>

<style src="../css/MainPage.css"></style>
