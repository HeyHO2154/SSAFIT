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
        <!-- 카테고리 필터 -->
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
      videos: [], // 모든 비디오 데이터를 저장
      categories: ["전체", "브베", "먹방", "아이돌", "음악"], // 카테고리 목록
      selectedCategory: "전체", // 현재 선택된 카테고리
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
      try {
        const response = await axios.post(
          "http://localhost:8080/videos/getAllVideos"
        );
        this.videos = response.data.sort(() => Math.random() - 0.5); // 데이터를 랜덤으로 섞어서 저장
      } catch (error) {
        console.error("Error fetching videos:", error);
      }
    },
    filterVideos(category) {
      this.selectedCategory = category; // 선택된 카테고리를 업데이트
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
          console.error("Error in addVideoView:", error);
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
      console.log(video);
      video = await this.addVideoView(video);
      console.log(video);
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
    this.fetchVideos(); // 컴포넌트가 마운트되면 비디오 목록을 로드
  },
};
</script>

<style src="../css/MainPage.css"></style>