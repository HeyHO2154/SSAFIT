
import { ref, computed, onMounted } from "vue";
import axios from "axios";

export default {
  name: "VideoPage",
  setup() {
    // 카테고리 및 알림 상태
    const categories = ref([
      { id: "shoulders", name: "어깨" },
      { id: "arms", name: "등" },
      { id: "chest", name: "가슴" },
      { id: "back", name: "팔" },
      { id: "abs", name: "복부" },
      { id: "legs", name: "하체" },
    ]);
    const notificationsCollapsed = ref(false);
    const hasNewNotifications = ref(true);

    // 초기 상태 설정
    const videos = ref([]); // 비디오 배열 초기화
    const currentVideo = ref(null); // 현재 선택된 비디오
    const comments = ref([]); // 댓글 목록 초기화
    const newComment = ref(""); // 새 댓글
    const isLiked = ref(false); // 좋아요 상태

    const activeCategory = ref("shoulders");
    const currentDifficultyLevel = ref(1);

    // 관련 비디오 필터링
    const filteredVideos = computed(() =>
      videos.value.filter(
        (video) =>
          video.category === activeCategory.value &&
          video.difficultyLevel === currentDifficultyLevel.value
      )
    );

    // 카테고리 설정
    const setActiveCategory = (categoryId) => {
      activeCategory.value = categoryId;
    };

    // 난이도 설정
    const setDifficultyLevel = (level) => {
      currentDifficultyLevel.value = level;
    };

    // 좋아요 상태 토글
    const toggleLike = () => {
      isLiked.value = !isLiked.value;
    };

    // 댓글 추가
    const submitComment = () => {
      if (!newComment.value.trim()) return;

      comments.value.unshift({
        id: Date.now(),
        userName: "Current User",
        userAvatar: "https://via.placeholder.com/40",
        text: newComment.value,
        likes: 0,
        isOwnComment: true,
      });

      newComment.value = "";
    };

    // 비디오 선택
    const selectVideo = (video) => {
      currentVideo.value = video;
    };

    // 알림 토글
    const toggleNotifications = () => {
      notificationsCollapsed.value = !notificationsCollapsed.value;
    };

    // 비디오 및 댓글 로드
    const fetchVideosAndComments = async () => {
      try {
        const videoResponse = await axios.get("http://localhost:8080/videos");
        videos.value = videoResponse.data || [];
        currentVideo.value = videos.value.length > 0 ? videos.value[0] : null;

        const commentsResponse = await axios.get("http://localhost:8080/comments");
        comments.value = commentsResponse.data || [];
      } catch (error) {
        console.error("데이터 로드 실패:", error);
      }
    };

    // 컴포넌트 마운트 시 데이터 로드
    onMounted(fetchVideosAndComments);

    return {
      categories,
      notificationsCollapsed,
      hasNewNotifications,
      toggleNotifications,
      videos,
      comments,
      currentVideo,
      newComment,
      isLiked,
      activeCategory,
      currentDifficultyLevel,
      filteredVideos,
      setActiveCategory,
      setDifficultyLevel,
      toggleLike,
      submitComment,
      selectVideo,
    };
  },
};