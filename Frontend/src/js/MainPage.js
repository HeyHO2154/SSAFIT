// import axios from "axios";
import axios from "axios";

export default {
  name: "MainPage",
  data() {
    return {
      // 초기 데이터 선언
      categories: ['어깨', '등', '가슴', '팔', '복부', '하체'], // 카테고리 목록
      selectedCategory: '어깨', // 선택된 카테고리
      currentLevel: 1, // 현재 레벨
      customStyles: [
        { left: '11.7%', top: '45.5%' }, // 1번 버튼 위치
        { left: '22.3%', top: '45.5%' }, // 2번 버튼 위치
        { left: '30.8%', top: '60.5%' }, // 3번 버튼 위치
        { left: '42.5%', top: '60.5%' }, // 4번 버튼 위치
        { left: '57.3%', top: '27.4%' }, // 5번 버튼 위치
        { left: '76%', top: '27.4%' }, // 6번 버튼 위치
        { left: '87.5%', top: '43%' }, // 7번째 버튼 위치
      ],

      username: '',
      showingVideoInfo: false, // 비디오 정보 표시 여부
      currentVideoInfo: '', // 현재 비디오 정보
      currentVideoLevel: 1, // 현재 비디오 레벨
      showingCompare: false, // 비교 화면 표시 여부
      notificationsCollapsed: false, // 알림 접힘 상태 (초기값: 펼쳐짐)
      userMessage: '오늘부터 운동 1일!!', // 사용자 메시지
      followers: 80, // 팔로워 수
      crewName: '운동부자', // 크루 이름
      hasNewNotifications: true, // 새 알림 여부
      roadmapBackgrounds: ['#e6f2ff', '#fff2e6', '#e6ffe6'], // 로드맵 배경 색상
      notifications: [
        { id: 1, tag: 'Follow', user: 'User1' },
        { id: 2, tag: 'Like', user: 'User2' },
        { id: 3, tag: 'Comment', user: 'User3' },
      ], // 알림 목록
    };
  },
  methods: {
    // 카테고리 선택
    selectCategory(category) {
      this.selectedCategory = category;
    },
    // 비디오 정보 표시
    showVideoInfo(level) {
      this.showingVideoInfo = true;
      this.currentVideoInfo = `This is information about the level ${level} video.`;
      this.currentVideoLevel = level;
    },
    
    // 비디오 정보 숨기기
    hideVideoInfo() {
      this.showingVideoInfo = false;
    },

    // 버튼 클릭 처리
    async handleButtonClick(n) {
      console.log(this.selectedCategory);
      console.log(n + this.currentLevel * 7 - 7);
      let levelsss = n + this.currentLevel * 7 - 7;
      try {
        const response = await axios.post(
          "http://localhost:8080/videos/getAllVideos"
        );
        let videos = response.data.sort(() => Math.random() - 0.5); // 데이터를 랜덤으로 섞어서 저장
        let hsj = 0;
        //console.log(videos);
        for (let index = 0; index < videos.length; index++) {
          if (videos[index].category == this.selectedCategory && videos[index].difficulty == levelsss) {
            hsj = index;
            break;
          }
        }
        this.$router.push({
          name: "VideoPage",
          query: {
            videoId: videos[hsj].videoId,
            url: videos[hsj].url,
            category: videos[hsj].category,
            views: videos[hsj].views,
          },
        });
      } catch (error) {
        console.error("Error fetching videos:", error);
      }
    },

    // 특정 레벨의 비디오로 이동
    goToVideo(level) {
      if (level <= this.currentLevel + 1) {
        console.log(`Navigating to level ${level} video`);
      }
    },
    // 현재 레벨 변경
    changeLevel(level) {
      this.currentLevel = level;
    },
    // 비교 화면 토글
    toggleCompare() {
      this.showingCompare = !this.showingCompare;
    },
    // 알림 접힘 상태 토글
    toggleNotifications() {
      this.notificationsCollapsed = !this.notificationsCollapsed;
    },
  },
  mounted() {
    console.log("MainPage mounted");
    
    const user = sessionStorage.getItem("user");
    
    if (!user) {
      // 세션에 user 객체가 없으면 로그인 페이지로 이동
      
        this.$router.push({ name: "Login" });
    } else {
      this.username = JSON.parse(sessionStorage.getItem("user"))?.userId || '';
      
    }

  },
};
