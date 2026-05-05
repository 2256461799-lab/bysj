<template>
  <div id="app">
    <router-view :key="routeFullPath"/>
  </div>
</template>

<script>
export default {
  name: 'App',
  computed: {
    // 用计算属性包装路由路径，避免模板直接调用$route的报错
    routeFullPath() {
      return this.$route.fullPath
    }
  }
}
</script>