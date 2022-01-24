<template>
  <div class="hello">
    <ul>
      <li v-for="post of posts" :key="post.id">
        <span>投稿:{{ post.content }}/名前:{{ post.name }}/id:{{ post.user_id }}</span>
        <!--ユーザーが削除されると投稿も表示されなくなる。dbには残っている-->
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
      posts: []
    }
  },
  mounted() {
    axios.get("http://localhost:3000/api/posts").then((response)=>{
      this.posts = response.data;
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