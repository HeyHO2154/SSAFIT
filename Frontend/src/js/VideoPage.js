
import { ref, computed, onMounted } from "vue";
import axios from "axios";

export default {
  name: "VideoPage",
  props: {
    videoId: {
      type: String,
      required: true,
      default: '' // 기본값
    },
    videoUrl: {
      type: String,
      required: true,
      default: ''
    },
    category: {
      type: String,
      required: false,
      default: ''
    },
    views: {
      type: [String, Number], // 숫자 또는 문자열
      required: false,
      default: ''
    },
    difficulty: {
      type: [String, Number], // 숫자 또는 문자열
      required: false,
      default: ''  
    },
  },
  data() {
    return {
      difficultyHSJ23: "",
    };
  },
  computed: {
    computedVideoUrl() {
      // YouTube URL 형식으로 변환
      if (this.videoUrl.includes('youtube.com') || this.videoUrl.includes('youtu.be')) {
        const videoId = this.extractVideoId(this.videoUrl);
        return `https://www.youtube.com/embed/${videoId}?autoplay=1&mute=1`;
      }
      // 다른 URL 형식인 경우 그대로 반환
      return this.videoUrl;
    }
  },
  methods: {
    difficultyHSJ() {
      let result = '';
      if (this.difficulty <= 7) {
        result = "초급"+" "+this.difficulty;
      } else if (this.difficulty <= 14) {
        result = "중급"+" "+(this.difficulty-7);
      } else {
        result = "고급"+" "+(this.difficulty-14);
      }
      return result;
    },
    extractVideoId(url) {
      try {
        const urlObj = new URL(url);
        // `v` 파라미터가 있는 경우 (https://www.youtube.com/watch?v=ID)
        if (urlObj.searchParams.has('v')) {
          return urlObj.searchParams.get('v');
        }
        // 짧은 URL 형식 (https://youtu.be/ID)
        if (urlObj.hostname === 'youtu.be') {
          return urlObj.pathname.slice(1); // `pathname`에서 첫 슬래시 제거
        }
        // embed 형식 처리 (https://www.youtube.com/embed/ID)
        if (urlObj.pathname.startsWith('/embed/')) {
          return urlObj.pathname.split('/embed/')[1];
        }
        return ''; // 동영상 ID가 없으면 빈 문자열 반환
      } catch (e) {
        console.error('Invalid URL', e);
        return '';
      }
    }
  },
  mounted() {
    console.log(this.videoUrl); // videoUrl 출력
  },
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
    const newComment = ref({ content:'' }); // 새 댓글  수정항아아아아ㅏㅇㅁ
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
        text: newComment.value.content, // 수정하마하마마마맘ㅁ
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