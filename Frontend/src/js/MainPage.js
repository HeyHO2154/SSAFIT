// import axios from "axios";
import axios from "axios";

export default {
  name: "MainPage",
  data() {
    return {
      showAd: true, // 광고 이미지를 표시할지 여부
      // 초기 데이터 선언
      categories: ['어깨', '등', '가슴', '팔', '복부', '하체'], // 카테고리 목록
      selectedCategory: '어깨', // 선택된 카테고리
      currentLevel: 1, // 현재 레벨
      customStyles: [
        { left: '12%', top: '45.2%' }, // 1번 버튼 위치
        { left: '22.4%', top: '45.2%' }, // 2번 버튼 위치
        { left: '30.7%', top: '60.1%' }, // 3번 버튼 위치
        { left: '42.2%', top: '60.1%' }, // 4번 버튼 위치
        { left: '56.5%', top: '27.4%' }, // 5번 버튼 위치
        { left: '74.9%', top: '27.4%' }, // 6번 버튼 위치
        { left: '86.1%', top: '42.9%' }, // 7번째 버튼 위치
      ],
      customStyless: [
        { left: '10%', top: '27.2%' }, // 1번 버튼 위치
        { left: '20.4%', top: '27.2%' }, // 2번 버튼 위치
        { left: '28.7%', top: '42.1%' }, // 3번 버튼 위치
        { left: '40.2%', top: '42.1%' }, // 4번 버튼 위치
        { left: '54.5%', top: '9.4%' }, // 5번 버튼 위치
        { left: '72.9%', top: '9.4%' }, // 6번 버튼 위치
        { left: '84.1%', top: '24.9%' }, // 7번째 버튼 위치
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
    redirectToAd() {
      window.open("https://play.google.com/store/apps/details?id=com.hsj.powerclicker", "_blank");
      this.showAd = false; // 클릭 시 광고 이미지를 숨김
    },
    currentLevel22() {
      if (this.currentLevel == 1) {
        return '초급';
      }
      if (this.currentLevel == 2) {
        return '중급';
      }
      if (this.currentLevel == 3) {
        return '고급';
      }
    },
    // 카테고리 선택
    selectCategory(category) {
      this.selectedCategory = category;
    },
    // 비디오 정보 표시
    showVideoInfo(n) {
      this.showingVideoInfo = true;
      this.currentVideoInfo = `클릭하면 ${n}단계 영상으로 이동합니다`;
    },
    
    // 비디오 정보 숨기기
    hideVideoInfo() {
      this.showingVideoInfo = false;
    },

    async getMainInfo(userId) {
      try {
        const response = await axios.post(
          "http://70.12.50.104:8080/users/getFollowersNum",
          { userId: userId } // userId만 포함된 객체를 전송
        );
        this.followers = response.data; // 데이터를 저장 (랜덤 섞기는 이후에 처리)
      } catch (error) {
        console.error("Error fetching followers:", error);
      }
      try {
        this.crewName = JSON.parse(sessionStorage.getItem("user"))?.crew; // 데이터를 저장 (랜덤 섞기는 이후에 처리)
      } catch (error) {
        console.error("Error fetching followers:", error);
      }
    },

    // 버튼 클릭 처리
    async handleButtonClick(n) {
      let levelsss = n + this.currentLevel * 7 - 7;
      if (n <= this.currentLevel+1) {
        try {
          const response = await axios.post(
            "http://70.12.50.104:8080/videos/getAllVideos"
          );
          let videos = response.data;
          let hsj = 0;
          for (let index = 0; index < videos.length; index++) {
            if (videos[index].category == this.selectedCategory && videos[index].difficulty == levelsss) {
              console.log("find");
              hsj = index;
              break;
            }
          }
          console.log(this.selectedCategory, levelsss);
          console.log(videos[hsj].category, videos[hsj].difficulty);
          console.log(videos[hsj].videoId);
          this.$router.push({
            name: "VideoPage",
            query: {
              videoId: videos[hsj].videoId,
              url: videos[hsj].url,
              category: videos[hsj].category,
              views: videos[hsj].views,
              difficulty: videos[hsj].difficulty,
            },
          });
        } catch (error) {
          console.error("Error fetching videos:", error);
        }
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
    const user = sessionStorage.getItem("user");
    if (!user) {
      this.$router.push({ name: "Login" });
    } else {
      this.username = JSON.parse(sessionStorage.getItem("user"))?.nickname || '';
      this.getMainInfo(this.username);
    }

  },
};
