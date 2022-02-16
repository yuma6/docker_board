<template>
    <div>
      {{ name }}#{{ id }}
    </div>
</template>

<script>

export default {
  name: 'PostView',
  props:{
    name: {
      default: "未ログインユーザー",
    },
    id: {
      default: 0
    },
  },
}
</script>