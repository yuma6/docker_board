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
        post.created_at = new Date(post.created_at)
        Vue.set(state.posts, 0, post)
      }
    },
    getters: {
      posts(state) {return state.posts}
    }
});