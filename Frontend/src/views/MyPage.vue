<template>
    <div class="full-screen-image">
        <!-- <div class="test">{{names}}</div>
        <div class="asd" @click="navigate"></div> -->
    </div>
</template>
  
<script>

export default {
    name: 'ImageFullScreen',
    data(){
        return {
            names: 'asd',
        }
    },
    methods: {
        navigate() {
            this.$router.push('/'); // '/login'은 Login.vue에 설정된 라우터 경로
        },
    },
};
</script>

<style scoped>
    .asd {
        position: absolute; /* 위치를 절대값으로 설정 */
        top: 36.5%; /* 상단에서 600px 아래로 이동 */
        left: 45%; /* 왼쪽에서 100px 우측으로 이동 */
        width: 4%; /* 네모의 가로 길이 */
        height: 8%; /* 네모의 세로 길이 */
        background-color: rgba(0, 0, 0, 0.01); /* 반투명 검정색 */
        cursor: pointer; /* 클릭 가능하도록 포인터 커서 표시 */
    }
    .test {
        position: absolute; /* 위치를 절대값으로 설정 */
        top: 22%; /* 상단에서 500px 아래로 이동 */
        left: 82.6%; /* 왼쪽에서 100px 우측으로 이동 */
        color: red; /* 텍스트가 잘 보이도록 흰색으로 설정 */
        font-size: 24px; /* 텍스트 크기 설정 */
        font-weight: bold; /* 텍스트 굵게 설정 */
        cursor: pointer; /* 클릭 가능하도록 포인터 커서 표시 */
    }
    .full-screen-image {
        position: relative; /* 내부 요소가 이 요소를 기준으로 위치하도록 설정 */
        width: 100vw;
        height: 100vh;
        background-image: url('../assets/MyPage.jpg');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;      
    }
</style>
