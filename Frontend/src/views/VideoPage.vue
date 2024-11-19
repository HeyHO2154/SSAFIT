<template>
  <div class="video-page">
    <header class="video-header">
      <div class="logo" @click="goMainPage()">
        <img src="@/assets/youtube-logo.png" alt="Logo" />
      </div>
      <div class="search-bar">
        <input type="text" placeholder="Search" />
        <button>🔍</button>
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
          <p class="video-description">카테고리 : {{ category }}  - 조회수 : {{ views }}</p>
        </div>
      </main>
      <aside class="related-videos">
        <h2>관련 영상</h2>
        <ul>
          <li v-for="relatedVideo in relatedVideos" :key="relatedVideo.videoId">
            <img :src="getThumbnailUrl(relatedVideo.url)" alt="Thumbnail" />
            <span>{{ relatedVideo.videoId }}</span>
          </li>
        </ul>
      </aside>
    </div>
  </div>
</template>

<script>
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
    relatedVideos: {
      type: Array,
      default: () => [],
    },
  },
  methods: {
    getThumbnailUrl(videoUrl) {
      const videoId = videoUrl.split("v=")[1];
      const ampersandPosition = videoId.indexOf("&");
      if (ampersandPosition !== -1) {
        return `https://img.youtube.com/vi/${videoId.substring(0, ampersandPosition)}/0.jpg`;
      }
      return `https://img.youtube.com/vi/${videoId}/0.jpg`;
    },
    goMainPage() {
            this.$router.push({name: "Main",});
        },
  },
};
</script>

<style src="../css/VideoPage.css"></style>
