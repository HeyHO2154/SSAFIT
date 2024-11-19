import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import axios from 'axios';

const app = createApp(App);

// Axios 전역 등록
app.config.globalProperties.$axios = axios;

app.use(router).mount('#app');
