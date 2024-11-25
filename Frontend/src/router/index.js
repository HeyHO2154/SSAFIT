import { createRouter, createWebHistory } from 'vue-router';

import MainPage from '../views/MainPage.vue';
import LoginPage from '../views/LoginPage.vue';
import RegisterPage from '../views/RegisterPage.vue';
import VideoPage from '../views/VideoPage.vue';
import MyPage from '../views/MyPage.vue';
import SearchPage from '../views/SearchPage.vue'; // SearchPage 컴포넌트 추가

const routes = [
  { path: '/', component: MainPage, name: 'Main' },
  { path: '/login', component: LoginPage, name: 'Login' },
  { path: '/register', component: RegisterPage, name: 'Register' },
  { path: '/mypage', component: MyPage, name: 'MyPage' },
  {
    path: '/video',
    component: VideoPage,
    name: 'VideoPage',
    props: route => ({
      videoId: route.query.videoId || '',
      videoUrl: route.query.url || '',
      category: route.query.category || '',
      views: route.query.views || '',
    }),
  },
  { 
    path: '/search',  // SearchPage 라우트 추가
    component: SearchPage, 
    name: 'SearchPage',
    props: route => ({
      searchQuery: route.query.q || ''
    })
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
