<template>
  <div class="hello">
    <ul>
      <li v-for="post of posts" :key="post.id">
        {{ post.content }}
      </li>
    </ul>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: 'List',
  data() {
    return {
      posts: [],
    }
  },
  mounted() {
    axios.get("http://localhost:3000/api/posts").then((response)=>{
      const data = response.data;
      this.posts = data.posts;
    });
  },
}
</script>

<style scoped>
</style>