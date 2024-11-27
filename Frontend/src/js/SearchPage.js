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
          "http://70.12.50.104:8080/videos/getSearchVideo",
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