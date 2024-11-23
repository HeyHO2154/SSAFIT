import { ref } from 'vue'

export default {
  setup() {
    const categories = ['어깨', 'back', 'chest', 'arms', 'abdomen', 'lower body']
    const selectedCategory = ref('shoulders')
    const currentLevel = ref(3)
    const showingVideoInfo = ref(false)
    const currentVideoInfo = ref('')
    const currentVideoLevel = ref(1)
    const showingCompare = ref(false)
    const notificationsCollapsed = ref(false)
    const userMessage = ref('Hello, welcome to my profile!')
    const followers = ref(80)
    const crewName = ref('운동부자')
    const hasNewNotifications = ref(true)

    const roadmapBackgrounds = ['#e6f2ff', '#fff2e6', '#e6ffe6']

    const notifications = [
      { id: 1, tag: 'Follow', user: 'User1' },
      { id: 2, tag: 'Like', user: 'User2' },
      { id: 3, tag: 'Comment', user: 'User3' },
    ]

    const selectCategory = (category) => {
      selectedCategory.value = category
    }

    const showVideoInfo = (level) => {
      showingVideoInfo.value = true
      currentVideoInfo.value = `This is information about the level ${level} video.`
      currentVideoLevel.value = level
    }

    const hideVideoInfo = () => {
      showingVideoInfo.value = false
    }

    const goToVideo = (level) => {
      if (level <= currentLevel.value + 1) {
        console.log(`Navigating to level ${level} video`)
      }
    }

    const changeLevel = (level) => {
      currentLevel.value = level
    }

    const toggleCompare = () => {
      showingCompare.value = !showingCompare.value
    }

    const toggleNotifications = () => {
      notificationsCollapsed.value = !notificationsCollapsed.value
    }

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
    }
  },
}
