


<template>
  <div id="app">
    <Header></Header>
    <router-view></router-view>
  </div>
</template>

<script>
import Header from './views/components/Header.vue';

export default {
  components: {
    Header,
  },
};
</script>

<style>
#app {
  font-family: 'SBAggroM';
  margin: 0;
  padding: 0;
}
</style>
