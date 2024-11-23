// MainPage.js

import { createApp, ref } from 'https://unpkg.com/vue@3/dist/vue.esm-browser.js';

const app = createApp({
  setup() {
    const categories = ['어깨', '등', '가슴', '팔', '복부', '하체'];
    const selectedCategory = ref('shoulders');
    const currentLevel = ref(3);
    const showingVideoInfo = ref(false);
    const currentVideoInfo = ref('');
    const currentVideoLevel = ref(1);
    const showingCompare = ref(false);
    const notificationsCollapsed = ref(false);  // 초기 상태: 펼쳐진 상태로 설정
    const userMessage = ref('오늘부터 운동 1일!!');
    const followers = ref(80);
    const crewName = ref('운동부자');
    const hasNewNotifications = ref(true);

    const roadmapBackgrounds = ['#e6f2ff', '#fff2e6', '#e6ffe6'];

    const notifications = [
      { id: 1, tag: 'Follow', user: 'User1' },
      { id: 2, tag: 'Like', user: 'User2' },
      { id: 3, tag: 'Comment', user: 'User3' },
    ];

    const selectCategory = (category) => {
      selectedCategory.value = category;
    };

    const showVideoInfo = (level) => {
      showingVideoInfo.value = true;
      currentVideoInfo.value = `This is information about the level ${level} video.`;
      currentVideoLevel.value = level;
    };

    const hideVideoInfo = () => {
      showingVideoInfo.value = false;
    };

    const goToVideo = (level) => {
      if (level <= currentLevel.value + 1) {
        console.log(`Navigating to level ${level} video`);
      }
    };

    const changeLevel = (level) => {
      currentLevel.value = level;
    };

    const toggleCompare = () => {
      showingCompare.value = !showingCompare.value;
    };

    const toggleNotifications = () => {
      // 상태를 반전시켜 펼침/접힘 동작을 제어합니다.
      notificationsCollapsed.value = !notificationsCollapsed.value;
    };

    return {
      categories,
      selectedCategory,
      currentLevel,
      showingVideoInfo,
      currentVideoInfo,
      currentVideoLevel,
      showingCompare,
      notificationsCollapsed,
      userMessage,
      followers,
      crewName,
      hasNewNotifications,
      roadmapBackgrounds,
      notifications,
      selectCategory,
      showVideoInfo,
      hideVideoInfo,
      goToVideo,
      changeLevel,
      toggleCompare,
      toggleNotifications,
    };
  },
});

app.mount('#app');
