<template>
  <v-form @submit.prevent="submitted">
    <LoginUser :name="name" :id="id"/>
    <NewUser v-if="display"/>
    <div v-if="autoHide">{{message[0]}}</div>
    <div v-if="display">
      <vue-loading v-if="loading" type="spin" color="#333" :size="{ width: '50px', height: '50px' }"></vue-loading>
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
            <v-btn v-if="!loading" type="submit">ログイン</v-btn>
          </v-col>
        </v-row>
      </v-container>
    </div>
  </v-form>
</template>

<script>
import { VueLoading } from 'vue-loading-template'
import axios from "axios"
import NewUser from './NewUser.vue'
import LoginUser from './LoginUser.vue'

export default {
  name: 'Login',
  components: {
    VueLoading,
    NewUser,
    LoginUser,
  },
  data() {
    return {
      message: "",
      loading: false,
      display: true,
      autoHide: false,
      name: undefined,
      id: undefined,
    }
  },
  mounted(){
    if (sessionStorage.user_name != undefined){
      this.display = false
      this.name = sessionStorage.user_name
      this.id = sessionStorage.user_id
    }
  },
  methods: {
    submitted(e) {
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

      axios.post("http://localhost:3000/api/login", obj, config).then(response => {
        const data = response.data;
        localStorage.csrf = data.csrf;
        if(data.user_name){
          sessionStorage.user_name = data.user_name
          sessionStorage.user_id = data.user_id
          this.name = data.user_name
          this.id = data.user_id
        }
        this.message = data.message
        this.loading = false;
        this.autoHide = true
        setTimeout(() => {
          this.autoHide = false}
          ,3000
        )
        if(data.result == true){
          this.display = false
        }
      });
    },
  },
}
</script>