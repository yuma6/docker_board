<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="8">
        <v-data-iterator :items="descPosts" :items-per-page.sync="itemsPerPage" :page.sync="page" hide-default-footer>
          <template v-slot:header>
            <v-row class="mt-2" align="center" justify="center">
              <span class="grey--text">items per page</span>
              <v-menu offset-y>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn dark text color="primary" class="ml-2" v-bind="attrs" v-on="on">
                    {{ itemsPerPage }}
                    <v-icon>mdi-chevron-down</v-icon>
                  </v-btn>
                </template>
                <v-list>
                  <v-list-item v-for="(number, index) in itemsPerPageArray" :key="index" @click="updateitemsPerPage(number)">
                    <v-list-item-title>{{ number }}</v-list-item-title>
                  </v-list-item>
                </v-list>
              </v-menu>
              <v-spacer></v-spacer>
              <span class="mr-4 grey--text">
                Page {{ page }} of {{ numberOfPages }}
              </span>
              <v-btn dark color="blue darken-3" class="mr-1" @click="formerPage">
                <v-icon>mdi-chevron-left</v-icon>
              </v-btn>
              <v-btn dark color="blue darken-3" class="ml-1" @click="nextPage">
                <v-icon>mdi-chevron-right</v-icon>
              </v-btn>
            </v-row>
          </template>

          <template #default="{ items }">
            <v-row>
              <v-col v-for="item in items" :key="item.id" cols="12">
                <v-card>
                  <v-card-title>{{ item.user_name }}#{{ item.user_id }}</v-card-title>
                  <v-card-text class="text-left">
                    {{ item.content }}
                  </v-card-text>
                  <v-card-text class="text-left">
                    {{item.created_at.getFullYear()}}/{{1+item.created_at.getMonth()}}/{{item.created_at.getDate()}}
                    {{item.created_at.getHours()}}時{{item.created_at.getMinutes()}}分{{item.created_at.getSeconds()}}秒
                  </v-card-text>
                </v-card>
              </v-col>
            </v-row>
          </template>

          <template v-slot:footer>
            <v-row class="mt-2" align="center" justify="center">
              <span class="grey--text">items per page</span>
              <v-menu offset-y>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn dark text color="primary" class="ml-2" v-bind="attrs" v-on="on">
                    {{ itemsPerPage }}
                    <v-icon>mdi-chevron-down</v-icon>
                  </v-btn>
                </template>
                <v-list>
                  <v-list-item v-for="(number, index) in itemsPerPageArray" :key="index" @click="updateitemsPerPage(number)">
                    <v-list-item-title>{{ number }}</v-list-item-title>
                  </v-list-item>
                </v-list>
              </v-menu>
              <v-spacer></v-spacer>
              <span class="mr-4 grey--text">
                Page {{ page }} of {{ numberOfPages }}
              </span>
              <v-btn dark color="blue darken-3" class="mr-1" @click="formerPage">
                <v-icon>mdi-chevron-left</v-icon>
              </v-btn>
              <v-btn dark color="blue darken-3" class="ml-1" @click="nextPage">
                <v-icon>mdi-chevron-right</v-icon>
              </v-btn>
            </v-row>
          </template>

        </v-data-iterator>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import axios from "axios";

export default {
  name: 'List',
  data() {
    return {
      itemsPerPageArray: [5, 10, 20],
      page: 1,
      itemsPerPage: 5,
    }
  },
  mounted() {
    axios.get("http://localhost:3000/api/posts").then((response)=>{
      this.$store.state.posts = response.data;
      for (const post of this.$store.state.posts) {
        post.created_at = new Date(post.created_at);
      }
    });
  },
  computed: {
    numberOfPages () {
      return Math.ceil(this.$store.state.posts.length / this.itemsPerPage)
    },
    descPosts () {
      return this.$store.getters.posts.slice().reverse()
    }
  },
  methods: {
    nextPage () {
      if (this.page + 1 <= this.numberOfPages) this.page += 1
    },
    formerPage () {
      if (this.page - 1 >= 1) this.page -= 1
    },
    updateitemsPerPage (number) {
      this.itemsPerPage = number
    },
  },
}
</script>