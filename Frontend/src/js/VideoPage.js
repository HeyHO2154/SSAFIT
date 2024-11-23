// VideoPage.js
import { createApp, ref, computed } from 'https://unpkg.com/vue@3/dist/vue.esm-browser.js';

// Vue 애플리케이션 생성
const app = createApp({
  setup() {
    // 상태 정의
    const categories = ref([
      { id: 'shoulders', name: '어깨' },
      { id: 'arms', name: '팔' },
      { id: 'chest', name: '가슴' },
      { id: 'back', name: '등' },
      { id: 'abs', name: '복부' },
      { id: 'legs', name: '하체' }
    ]);

    const activeCategory = ref('shoulders');
    const currentDifficultyLevel = ref(1);
    const isLiked = ref(false);
    const newComment = ref('');

    // Mock 데이터 정의
    const videos = ref([
      {
        id: 1,
        title: '제목입니다만 불만이라도???',
        category: '가슴',
        views: 1564,
        thumbnail: '/placeholder.svg?height=80&width=128',
        videoUrl: 'https://example.com/video1.mp4',
        difficultyLevel: 1
      },
      // 더 많은 비디오를 추가할 수 있습니다.
    ]);

    const comments = ref([
      {
        id: 1,
        userName: 'User1',
        userAvatar: '/placeholder.svg?height=40&width=40',
        text: '이영상으로 운동하다가 죽을 뻔했어요 정말 추천합니다 친시팡 하이파이브 하고 플레이했어요',
        likes: 45,
        isOwnComment: false
      },
      // 더 많은 댓글을 추가할 수 있습니다.
    ]);

    // 현재 비디오 선택
    const currentVideo = ref(videos.value[0]);

    // 필터링된 비디오 목록 계산
    const filteredVideos = computed(() => {
      return videos.value.filter(
        video =>
          video.category === activeCategory.value &&
          video.difficultyLevel === currentDifficultyLevel.value
      );
    });

    // 메소드 정의
    const setActiveCategory = (categoryId) => {
      activeCategory.value = categoryId;
    };

    const setDifficultyLevel = (level) => {
      currentDifficultyLevel.value = level;
    };

    const toggleLike = () => {
      isLiked.value = !isLiked.value;
    };

    const submitComment = () => {
      if (!newComment.value.trim()) return;
      
      comments.value.unshift({
        id: Date.now(),
        userName: 'Current User',
        userAvatar: '/placeholder.svg?height=40&width=40',
        text: newComment.value,
        likes: 0,
        isOwnComment: true
      });
      
      newComment.value = '';
    };

    const selectVideo = (video) => {
      currentVideo.value = video;
    };

    return {
      categories,
      activeCategory,
      currentDifficultyLevel,
      isLiked,
      newComment,
      videos,
      comments,
      currentVideo,
      filteredVideos,
      setActiveCategory,
      setDifficultyLevel,
      toggleLike,
      submitComment,
      selectVideo
    };
  }
});

// Vue 애플리케이션 마운트
app.mount('#app');