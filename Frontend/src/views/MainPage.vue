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
        <button @click="goLoginPage">🧑</button>
        <button @click="goLoginPage">로그인</button>
      </div>
    </header>
    <div class="youtube-content">
      <aside class="sidebar">
        <ul>
          <li @click="filterVideos('전체')">홈</li>
          <li @click="filterVideos('인기')">인기 급상승</li>
          <li @click="filterVideos('구독')">구독</li>
          <li @click="filterVideos('내 동영상')">내 동영상</li>
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
    categories: ["전체", "등", "어깨", "팔", "하체", "복부", "가슴"],
    selectedCategory: "전체",
    searchQuery: "",
    isVideosLoaded: false, // 데이터를 불러왔는지 확인하는 플래그
  };
},
  computed: {
    // 선택된 카테고리에 따라 비디오를 필터링
    filteredVideos() {
      if (this.selectedCategory === "전체") {
        return this.videos; // 전체 카테고리일 경우 모든 비디오 반환
      }
      return this.videos.filter(
        (video) => video.category === this.selectedCategory
      );
    },
  },
  methods: {
    async fetchVideos() {
    if (this.isVideosLoaded) return; // 이미 로드된 경우 중복 호출 방지
    try {
      const response = await axios.post(
        "http://70.12.50.104:8080/videos/getAllVideos"
      );
      this.videos = response.data.sort(() => Math.random() - 0.5);
      this.isVideosLoaded = true; // 로드 완료 상태로 변경
    } catch (error) {
      console.error("Error fetching videos:", error);
    }
  },
    filterVideos(category) {
      this.selectedCategory = category; // 선택된 카테고리를 업데이트
    },
    async addVideoView(video) {
      try {
        const response = await axios.post(
          "http://70.12.50.104:8080/videos/addViews",
          { videoId: video.videoId, views: 1 }
        );
        return response.data;
      } catch (error) {
        console.error("Error in addVideoView:", error);
        return video;
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
    goMainPage() {
    if (!this.isVideosLoaded) {
      this.fetchVideos(); // 비디오가 로드되지 않았을 때만 호출
    }
    this.$router.push({ name: "Main" });
  },
    goLoginPage() {
      this.$router.push({ name: "Login" });
    },
    searchVideos() {
      if (this.searchQuery.trim()) {
        this.$router.push({ name: "SearchPage", query: { q: this.searchQuery } });
      }
    },
  },
  mounted() {
    this.fetchVideos(); // 컴포넌트가 마운트되면 비디오 목록을 로드
  },
};
</script>

<style src="../css/MainPage.css"></style>
