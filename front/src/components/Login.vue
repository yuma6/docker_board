<template>
  <form @submit.prevent="submitted">
    <input type="text" name="email" placeholder="メール">
    <input type="password" name="password" placeholder="パスワード">
    <button type="submit">ログイン</button>
  </form>
</template>

<script>
import axios from "axios";

export default {
  name: 'Login',
  methods: {
    submitted(e) {
      // 送信するデータを作る
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
        alert(data.success);

        // LocalStorage に CSRF トークンを保存する
        localStorage.csrf = data.csrf;
      }, error => {
        // ログインに失敗した
        const data = error.response.data;

        // 失敗した理由を alert で表示する
        alert(data.errors[0]);
      });
    },
  },
}
</script>

<style scoped>
</style>