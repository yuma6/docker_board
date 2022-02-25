<template>
  <v-form @submit.prevent="submitted">
    <div v-if="autoHide">{{message[0]}}</div>
    <div v-if="display">
      <vue-loading v-if="loading" type="spin" color="#333" :size="{ width: '50px', height: '50px' }"></vue-loading>
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
            <v-btn v-if="!loading" type="submit">ユーザー登録</v-btn>
          </v-col>
        </v-row>
      </v-container>
    </div>
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
      display: true,
      autoHide: false,
    }
  },
  mounted(){
      if (sessionStorage.user_name != undefined)
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
        this.loading = false
        this.autoHide = true
        this.message = data.message
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