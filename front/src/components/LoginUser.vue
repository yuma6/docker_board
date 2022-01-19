<template>
  <ul>
    <div v-for="user of user" :key="user.id">
      {{ user }}
    </div>
  </ul>
</template>

<script>

export default {
  name: 'PostView',
  data() {
    return {
      user: ["ログインされていません"],
    }
  },
  mounted() {//sessionStrageが存在しないため、新しくページを開いたときにはエラーが出る(動かす上で問題は出ていない)
      if (sessionStorage.user_name != "undefined")
        {this.user = [sessionStorage.user_name]}
      else if (sessionStorage.user_name == "undefined")
        {this.user = ["ログインされていません"]}
  },
}
</script>

<style scoped>

</style>