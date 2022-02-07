<template>
  <v-form @submit.prevent="submitted" v-if="display">
    <vue-loading v-if="loading" type="spin" color="#333" :size="{ width: '50px', height: '50px' }"></vue-loading>
    <div v-else>{{message[0]}}</div>
    <v-container>
      <v-row class="justify-center">
        <v-col cols="12" sm="2" md="2">
          <v-text-field type="text" name="email" label="メール" outlined></v-text-field>
        </v-col>
        <v-col cols="12" sm="2" md="2">
          <v-text-field type="password" name="password" label="パスワード" outlined></v-text-field>
        </v-col>
        <v-col cols="12" sm="2" md="2">
          <v-text-field type="text" name="name" label="ユーザー名" outlined></v-text-field>
        </v-col>
      </v-row>
      <v-row class="justify-center">
        <v-col cols="12" sm="3" md="3">
          <v-btn type="submit">ユーザー登録</v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-form>
</template>

<script>
import { VueLoading } from 'vue-loading-template'
import axios from "axios";

export default {
  name: 'NewUser',
  components: {
    VueLoading
  },
  data() {
    return {
      message: "",
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
      this.loading = true
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

      axios.post("http://localhost:3000/api/create", obj, config).then(response => {
        const data = response.data;
        console.log(data)
        this.loading = false
        this.message = data.message
        if(data.result == true){
          window.setTimeout(()=>{
                window.location.reload();
          }, 2500);
        }
      });
    },
  },
}
</script>