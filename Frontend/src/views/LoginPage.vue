<template>
  <div>
    <h1>Login Page</h1>
    <form @submit.prevent="handleLogin">
      <input type="text" placeholder="Username" v-model="username" />
      <input type="password" placeholder="Password" v-model="password" />
      <button type="submit" @click="goToMainPage">Login</button>
    </form>
  </div>
</template>

<script>
export default {
  name: 'LoginPage',
  data() {
    return {
      username: '',
      password: '',
    };
  },
  methods: {
    handleLogin() {
      console.log(`Username: ${this.username}, Password: ${this.password}`);
    },
    goToMainPage() {
        this.$router.push({ name: 'Main' });
    },
  },
};
</script>