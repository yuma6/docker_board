<template>
  <form @submit.prevent="submitted">
    <textarea name="content"></textarea>
    <button type="submit">投稿</button>
  </form>
</template>

<script>
import axios from "axios";

export default {
  name: 'Post',
  methods: {
    submitted(e) {
      // 送信するデータを作る
      const data = new FormData(e.target);
      const obj = {
        post: {
          content: data.get("content"),
        }
      };
      const config = {
        headers: {
          "X-CSRF-Token": localStorage.csrf,
        },
        withCredentials: true,
      };

      // 送信する
      axios.post("http://localhost:3000/api/posts", obj, config).then(response => {
        // 投稿に成功した
        const data = response.data;
        alert(data.success);
      });
    }
  }
}
</script>

<style scoped>
</style>