<template>
    <div>
      {{ user.user_name }}#{{ user.user_id }}
    </div>
</template>

<script>

export default {
  name: 'PostView',
  data() {
    return {
      user: [],
    }
  },
  mounted() {
      if (sessionStorage.user_name != "undefined" && (sessionStorage.user_name != undefined))
        this.user = sessionStorage
  },
}
</script>