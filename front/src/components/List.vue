<template>
  <div class="hello">
    <ul>
      <li v-for="post of posts" :key="post.id">
        <span>{{ post.content }}/</span>
        <span v-if="users[post.user_id]">{{users[post.user_id].name}}</span>
        <span v-else>削除されたユーザー</span>
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
      users: []
    }
  },
  mounted() {
    axios.get("http://localhost:3000/api/posts").then((response)=>{
      const data = response.data;
      this.posts = data.posts;
      this.users = data.users;
      // console.log(this.posts)
    });
  },
}
</script>

<style scoped>
ul{
  list-style: none;
}
</style>