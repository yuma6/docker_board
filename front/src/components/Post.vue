<template>
  <v-form @submit.prevent="submitted">
    <vue-loading v-show="loading" type="spin" color="#333" :size="{ width: '50px', height: '50px' }"></vue-loading>
    <v-container>
      <v-row class="justify-center">
        <v-col cols="12" sm="7" md="7">
          <v-textarea name="content" outlined></v-textarea>
        </v-col>
      </v-row>
      <v-row class="justify-center">
        <v-col cols="12" sm="2" md="2">
          <v-btn type="submit">投稿</v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-form>
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

      axios.post("http://localhost:3000/api/posts", obj, config).then(response => {
        const data = response.data;
        this.loading = false
        this.result = alert(data.result)
        this.$router.go({path: this.$router.currentRoute.path, force: true})
      });
    }
  }
}
</script>