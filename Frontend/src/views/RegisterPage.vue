<template>
    <div>
      <h1>Register Page</h1>
      <form @submit.prevent="handleRegister">
        <input type="text" placeholder="Username" v-model="username" />
        <input type="email" placeholder="Email" v-model="email" />
        <input type="password" placeholder="Password" v-model="password" />
        <button type="submit">Register</button>
      </form>
    </div>
  </template>
  
  <script>
  export default {
    name: 'RegisterPage',
    data() {
      return {
        username: '',
        email: '',
        password: '',
      };
    },
    methods: {
      handleRegister() {
        console.log(`Username: ${this.username}, Email: ${this.email}`);
      },
    },
  };
  </script>
  