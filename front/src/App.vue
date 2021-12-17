<template>
  <div id="app">
    <img alt="Vue logo" src="./assets/logo.png">
    <NewUser msg="Welcome to Your Vue.js App"/>
    <Login msg="Welcome to Your Vue.js App"/>
    <Post msg="Welcome to Your Vue.js App"/>
  </div>
</template>

<script>
import NewUser from './components/NewUser.vue'
import Login from './components/Login.vue'
import Post from './components/Post.vue'

export default {
  name: 'App',
  components: {
    NewUser,
    Login,
    Post
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
