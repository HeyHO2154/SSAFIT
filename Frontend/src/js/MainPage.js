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
    },
  },
  methods: {
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
    filterVideos(category) {
      this.selectedCategory = category; // 선택된 카테고리를 업데이트
    },
    async addVideoView(video) {
      try {
        const response = await axios.post(
          "http://localhost:8080/videos/addViews",
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
      this.fetchVideos(); // 컴포넌트가 마운트되면 비디오 목록을 로드
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