<template>
  <form @submit.prevent="submitted">
      <vue-loading v-show="loading" type="spin" color="#333" :size="{ width: '50px', height: '50px' }"></vue-loading>
      <div v-show="!loading" v-for="result of result" :key="result">
        {{ result }}
      </div>
    <textarea name="content"></textarea>
    <button type="submit">投稿</button>
  </form>
</template>

<script>
import { VueLoading } from 'vue-loading-template'
import axios from "axios";

export default {
  name: 'Post',
  components: {
    VueLoading
  },
  data() {
    return {
      result: [],
      loading: false
    }
  },
  methods: {
    submitted(e) {
      // 送信するデータを作る
      this.loading = true
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
        this.result = data.result
        this.loading = false
        // console.log(this.result)
        // alert(data.result);
      });
    }
  }
}
</script>

<style scoped>
</style>