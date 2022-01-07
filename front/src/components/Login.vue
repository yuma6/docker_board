<template>
  <form @submit.prevent="submitted">
      <vue-loading v-show="loading" type="spin" color="#333" :size="{ width: '50px', height: '50px' }"></vue-loading>
      <div v-show="!loading" v-for="result of result" :key="result">
        {{ result }}
      </div>
    <input type="text" name="email" placeholder="メール">
    <input type="password" name="password" placeholder="パスワード">
    <button type="submit">ログイン</button>
  </form>
</template>

<script>
import { VueLoading } from 'vue-loading-template'
import axios from "axios";

export default {
  name: 'Login',
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
        user: {
          email: data.get("email"),
          password: data.get("password"),
        }
      };
      const config = {
        withCredentials: true,
      };

      // 送信する
      axios.post("http://localhost:3000/api/login", obj, config).then(response => {
        // ログインに成功した
        const data = response.data;
        this.result = data.result
        this.loading = false
        // console.log(this.result)

        // LocalStorage に CSRF トークンを保存する
        localStorage.csrf = data.csrf;
      });
    },
  },
}
</script>

<style scoped>
</style>