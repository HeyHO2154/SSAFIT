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
      type: String, // 숫자로 다룰 경우 Number로 변경
      required: true,
    },
  },
  data() {
    return {
      relatedVideos: [], // 관련 영상 목록
      searchQuery: "", // 검색어
      comments: [], // 댓글 목록
      newComment: {
        username: "",
        content: "",
      },
    };
  },
  created() {
    this.addVideoView(); // 조회수 증가
    this.fetchRelatedVideos(); // 관련 영상 로드
    this.fetchComments(); // 댓글 로드
  },
  computed: {
    // 현재 비디오 제외 관련 영상 필터링
    filteredRelatedVideos() {
      return this.relatedVideos.filter((video) => video.videoId !== this.videoId);
    },
  },
  methods: {
    async addVideoView() {
      try {
        const response = await axios.post("http://localhost:8080/videos/addViews", {
          videoId: this.videoId,
        });
        console.log("조회수 증가:", response.data.views);
      } catch (error) {
        console.error("조회수 증가 실패:", error);
      }
    },
    async fetchRelatedVideos() {
      try {
        const response = await axios.post(
          "http://localhost:8080/videos/getCategoryVideo",
          {
            videoId: this.videoId,
            category: this.category,
          }
        );
        this.relatedVideos = response.data.sort(() => Math.random() - 0.5);
      } catch (error) {
        console.error("관련 영상 로드 실패:", error);
      }
    },
    async fetchComments() {
      try {
        const response = await axios.get(`http://localhost:8080/videos/${this.videoId}/comments`);
        this.comments = response.data;
      } catch (error) {
        console.error("댓글 로드 실패:", error);
      }
    },
    async addComment() {
      if (!this.newComment.username.trim() || !this.newComment.content.trim()) {
        alert("사용자명과 댓글 내용을 입력해주세요!");
        return;
      }
      try {
        const response = await axios.post(
          `http://localhost:8080/videos/${this.videoId}/comments`,
          this.newComment
        );
        this.comments.push(response.data);
        this.newComment.username = "";
        this.newComment.content = "";
      } catch (error) {
        console.error("댓글 등록 실패:", error);
      }
    },
    getThumbnailUrl(videoUrl) {
      const videoId = videoUrl.split("v=")[1];
      const ampersandPosition = videoId ? videoId.indexOf("&") : -1;
      if (ampersandPosition !== -1) {
        return `https://img.youtube.com/vi/${videoId.substring(0, ampersandPosition)}/0.jpg`;
      }
      return `https://img.youtube.com/vi/${videoId}/0.jpg`;
    },
    async goToVideo(video) {
      await this.addVideoView(); // 조회수 증가
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
  },
};