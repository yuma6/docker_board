<template>
  <v-app>
    <LoginUser/>
    <NewUser/>
    <Login/>
    <Post/>
    <List/>
  </v-app>
</template>

<script>
import NewUser from './components/NewUser.vue'
import Login from './components/Login.vue'
import Post from './components/Post.vue'
import List from './components/List.vue'
import LoginUser from './components/LoginUser.vue'

export default {
  components: {
    NewUser,
    Login,
    Post,
    List,
    LoginUser
  },
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
