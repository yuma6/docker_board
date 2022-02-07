<template>
  <v-form @submit.prevent="submitted">
    <vue-loading v-if="loading" type="spin" color="#333" :size="{ width: '50px', height: '50px' }"></vue-loading>
    <div v-else>{{message[0]}}</div>
    <v-container>
      <v-row class="justify-center">
        <v-col cols="12" sm="6" md="6">
          <v-textarea name="content" outlined></v-textarea>
        </v-col>
      </v-row>
      <v-row class="justify-center">
        <v-col cols="12" sm="3" md="3">
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
      message: "",
      loading: false
    }
  },
  methods: {
    submitted(e) {
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
        this.message = data.message
        if(data.result == true){
          window.setTimeout(()=>{
                window.location.reload();
          }, 2500);
        }
      });
    }
  }
}
</script>