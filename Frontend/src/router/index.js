import { createRouter, createWebHistory } from 'vue-router';

import MainPage from '../views/MainPage.vue';
import LoginPage from '../views/LoginPage.vue';
import RegisterPage from '../views/RegisterPage.vue';
import SurveyPage from '../views/SurveyPage.vue';
import VideoPage from '../views/VideoPage.vue';
import MyPage from '../views/MyPage.vue';
import CharacterCustomizePage from '../views/CharacterCustomizePage.vue';

const routes = [
  { path: '/', component: MainPage, name: 'Main' },
  { path: '/login', component: LoginPage, name: 'Login' },
  { path: '/register', component: RegisterPage, name: 'Register' },
  { path: '/survey', component: SurveyPage, name: 'Survey' },
    { path: '/video', component: VideoPage, name: 'Video' },
    { path: '/video/:id', component: VideoPage, name: 'Video' },
  { path: '/mypage', component: MyPage, name: 'MyPage' },
  { path: '/customize', component: CharacterCustomizePage, name: 'Customize' },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
