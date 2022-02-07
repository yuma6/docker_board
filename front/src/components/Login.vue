<template>
  <v-form @submit.prevent="submitted" v-if="display">
    <vue-loading v-show="loading" type="spin" color="#333" :size="{ width: '50px', height: '50px' }"></vue-loading>
    <v-container>
      <v-row class="justify-center">
        <v-col cols="12" sm="3" md="3">
          <v-text-field type="text" name="email" label="メール" outlined></v-text-field>
        </v-col>
        <v-col cols="12" sm="3" md="3">
          <v-text-field type="password" name="password" label="パスワード" outlined></v-text-field>
        </v-col>
      </v-row>
      <v-row class="justify-center">
        <v-col cols="12" sm="3" md="3">
          <v-btn type="submit">ログイン</v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-form>
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
      loading: false,
      display: true
    }
  },
  mounted(){
    if (sessionStorage.user_name != "undefined" && (sessionStorage.user_name != undefined))
      {this.display = false}
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
        // console.log(data)
        localStorage.csrf = data.csrf;
        sessionStorage.user_name = data.user_name
        sessionStorage.user_id = data.user_id
        this.loading = false;
        this.result = alert(data.result)
        this.$router.go({path: this.$router.currentRoute.path, force: true})
        // console.log(this.result)

        // LocalStorage に CSRF トークンを保存する
      });
    },
  },
}
</script>