<template>
<<<<<<< Updated upstream
    <div class="youtube-main">
      <header class="youtube-header">
        <div class="logo" @click="goMainPage()">
          <img src="@/assets/youtube-logo.png" alt="Logo" />
=======
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
          <li @click="filterVideos('전체')">홈</li>
          <li @click="filterVideos('인기')">추천 헬스 영상</li>
          <li @click="filterVideos('구독')">팔로우</li>
          <li @click="filterVideos('내 동영상')">찜한 동영상</li>
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
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
  </template>
  
  <script>
  import axios from "axios";
  
  export default {
    name: "MainPage",
    data() {
      return {
          videos: [], // 초기 데이터 비우기
      };
=======
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "MainPage",
  data() {
    return {
      videos: [], // 모든 비디오 데이터를 저장
      categories: ["전체", "등", "어깨", "팔", "하체", "복부", "가슴"], // 카테고리 목록
      selectedCategory: "전체", // 현재 선택된 카테고리
      searchQuery: "", // 검색어
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
>>>>>>> Stashed changes
    },
    methods: {
        addVideoView(video) {
    return axios.post("http://localhost:8080/videos/addViews", {
        videoId: video.videoId,
        views: 1,
    })
    .then((response) => {
        console.log("Response from addViews:", response.data); // 응답 데이터 확인
        return response.data; // response.data를 반환
    })
    .catch((error) => {
        console.error("Error in addVideoView:", error);
        return video; // 에러 발생 시 기존 video 객체 반환
    });
},

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
  