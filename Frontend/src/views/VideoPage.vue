<template>
  <div class="video-page">
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
    <div class="main-container">
      <main class="video-content">
        <!-- 영상 플레이어 -->
        <div class="video-player">
          <template v-if="videoUrl.includes('youtube.com')">
            <iframe
              :src="`${videoUrl.replace('watch?v=', 'embed/')}?autoplay=1&mute=1`"
              frameborder="0"
              allowfullscreen
            ></iframe>
          </template>
          <template v-else>
            <video controls autoplay muted>
              <source :src="videoUrl" type="video/mp4" />
              Your browser does not support the video tag.
            </video>
          </template>
        </div>
        <!-- 영상 제목 및 설명 -->
        <div class="video-info">
          <h1 class="video-title">{{ videoId }}</h1>
          <p class="video-description">
            카테고리 : {{ category }} - 조회수 : {{ views }}
          </p>
        </div>
      </main>
      <aside class="related-videos">
        <h2>관련 영상</h2>
        <ul>
          <li
            v-for="relatedVideo in filteredRelatedVideos"
            :key="relatedVideo.videoId"
            @click="goToVideo(relatedVideo)"
          >
            <img :src="getThumbnailUrl(relatedVideo.url)" alt="Thumbnail" />
            <span>{{ relatedVideo.videoId }}</span>
          </li>
        </ul>
      </aside>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "VideoPage",
  props: {
    videoUrl: {
      type: String,
      required: true,
    },
    videoId: {
      type: String,
      required: true,
    },
    category: {
      type: String,
      required: true,
    },
    views: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      relatedVideos: [], // 관련 영상 데이터를 저장
      searchQuery: "", // 검색어 입력 데이터
    };
  },
  computed: {
    // 현재 재생 중인 비디오를 제외한 관련 영상 목록 필터링
    filteredRelatedVideos() {
      return this.relatedVideos.filter(
        (video) => video.videoId !== this.videoId
      );
    },
  },
  watch: {
    // videoId가 변경될 때마다 관련 영상을 다시 로드
    videoId: {
      immediate: true,
      handler() {
        this.fetchRelatedVideos();
      },
    },
  },
  methods: {
    async fetchRelatedVideos() {
      try {
        const videoData = {
          videoUrl: this.videoUrl,
          videoId: this.videoId,
          category: this.category,
          views: this.views,
        };

        // 백엔드 API 호출
        const response = await axios.post(
          "http://70.12.50.104:8080/videos/getCategoryVideo",
          videoData
        );

        // 관련 영상 데이터를 랜덤으로 섞음
        this.relatedVideos = response.data.sort(() => Math.random() - 0.5);
      } catch (error) {
        console.error("Error fetching related videos:", error);
      }
    },
    searchVideos() {
      if (this.searchQuery.trim()) {
        this.$router.push({ name: "SearchPage", query: { q: this.searchQuery } });
      }
    },
    getThumbnailUrl(videoUrl) {
      const videoId = videoUrl.split("v=")[1];
      const ampersandPosition = videoId ? videoId.indexOf("&") : -1;
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
      video = await this.addVideoView(video); // 백엔드로 조회수 증가 요청
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
    async addVideoView(video) {
      try {
        // 백엔드 API를 호출하여 조회수 증가
        const response = await axios.post(
          "http://70.12.50.104:8080/videos/addView",
          video
        );
        return response.data;
      } catch (error) {
        console.error("Error adding video view:", error);
        return video;
      }
    },
    goMainPage() {
      this.$router.push({ name: "Main" });
    },
  },
};
</script>

<style src="../css/VideoPage.css"></style>
