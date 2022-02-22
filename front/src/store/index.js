import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex);

export default new Vuex.Store({
    state () {
      return {
        posts: []
      }
    },
    mutations: {
      add_post (state,post) {
        state.posts.push(post)
      }
    },
    getters: {
      posts(state) {return state.posts}
    }
});