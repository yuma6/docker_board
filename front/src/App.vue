<template>
  <div id="app">
    <NewUser/>
    <Login/>
    <Post/>
    
    <ul>
      <vue-loading v-show="loading" type="spin" color="#333" :size="{ width: '50px', height: '50px' }"></vue-loading>
      <li v-show="!loading" v-for="post of posts" :key="post.id">
        {{ post.content }}
      </li>
    </ul>
  </div>
</template>

<script>
import NewUser from './components/NewUser.vue'
import Login from './components/Login.vue'
import Post from './components/Post.vue'
import { VueLoading } from 'vue-loading-template'
import axios from "axios";

export default {
  name: 'List',
  data() {
    return {
      posts: [],
      loading: true
    }
  },
  mounted() {
    axios.get("http://localhost:3000/api/posts").then((response)=>{
      const data = response.data;
      this.posts = data.posts;
      this.loading = false
    });
  },
  components: {
    NewUser,
    Login,
    Post,
    VueLoading
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
