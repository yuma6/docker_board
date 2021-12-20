<template>
  <form @submit.prevent="submitted">
    <input type="text" name="email" placeholder="メール">
    <input type="password" name="password" placeholder="パスワード">
    <input type="text" name="name" placeholder="ユーザー名">
    <button type="submit">ユーザー登録</button>
  </form>
</template>

<script>
import axios from "axios";

export default {
  name: 'NewUser',
  methods: {
    submitted(e) {
      // 送信するデータを作る
      const data = new FormData(e.target);
      const obj = {
        user: {
          email: data.get("email"),
          password: data.get("password"),
          name: data.get("name")
        }
      };
      const config = {
        withCredentials: true,
      };

      // 送信する
      axios.post("http://localhost:3000/api/create", obj, config).then(response => {
        // 登録に成功した
        const data = response.data;
        alert(data.success);
      });
    },
  },
}
</script>

<style scoped>
</style>