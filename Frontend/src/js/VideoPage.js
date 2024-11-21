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

comments: [
      { username: "User1", content: "정말 좋은 영상이에요!" },
      { username: "User2", content: "유익한 정보 감사합니다!" },
      { username: "User3", content: "재미있게 보고 갑니다." },
    ],
    newComment: {
      username: "",
      content: "",
      },
    
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
        this.fetchComments(); // 댓글 로드
      },
    },
    },
  
  methods: {
    async addComment() {
    if (this.newComment.username.trim() && this.newComment.content.trim()) {
      try {
        const response = await axios.post(
          `http://localhost:8080/videos/${this.videoId}/comments`,
          { ...this.newComment }
        );
        this.comments.push(response.data); // 저장된 댓글 추가
        this.newComment.username = "";
        this.newComment.content = "";
      } catch (error) {
        console.error("Error adding comment:", error);
        alert("댓글 저장 중 문제가 발생했습니다!");
      }
    } else {
      alert("사용자명과 댓글 내용을 입력해주세요!");
    }
  },
  async fetchComments() {
    try {
      const response = await axios.get(
        `http://localhost:8080/videos/${this.videoId}/comments`
      );
      this.comments = response.data;
    } catch (error) {
      console.error("Error fetching comments:", error);
    }
  },
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
          "http://localhost:8080/videos/getCategoryVideo",
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
          "http://localhost:8080/videos/addView",
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