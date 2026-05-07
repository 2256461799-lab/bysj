<template>
  <div class="manager-container">
    <div class="manager-header">
      <div class="manager-header-left">
        <img src="../assets/imgs/logo.png" />
        <div class="title">网格化依法治理管理平台</div>
      </div>

      <div class="manager-header-center">
        <el-breadcrumb separator-class="el-icon-arrow-right">
          <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
          <el-breadcrumb-item :to="{ path: $route.path }">{{ $route.meta.name }}</el-breadcrumb-item>
        </el-breadcrumb>
      </div>

      <div class="manager-header-right">
        <el-dropdown placement="bottom">
          <div class="avatar">
            <img :src="user.avatar || 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png'" />
            <div>{{ user.name ||  '管理员' }}</div>
          </div>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item @click.native="goToPerson">个人信息</el-dropdown-item>
            <el-dropdown-item @click.native="$router.push('/password')">修改密码</el-dropdown-item>
            <el-dropdown-item @click.native="logout">退出登录</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </div>

    <div class="manager-main">
      <div class="manager-main-left">
        <el-menu 
          :default-openeds="['info', 'user', 'learning']" 
          router 
          style="border: none" 
          :default-active="$route.path"
          text-color="#333333" 
          active-text-color="#409EFF">
          
          <el-menu-item index="/home">
            <span slot="title">系统首页</span>
          </el-menu-item>
          <el-submenu index="info">
            <template slot="title">
              <span>信息管理</span>
            </template>
            
            <el-menu-item index="/category">事件分类</el-menu-item>
            <el-menu-item index="/blog">工作日志</el-menu-item>
            <el-menu-item index="/activity">治理任务</el-menu-item>
            <el-menu-item index="/comment">评论信息</el-menu-item>
            <el-menu-item index="/activitySign">签到信息</el-menu-item>
            <el-menu-item index="/law">法律法规</el-menu-item>
            <el-menu-item index="/knowledge">治理案例库</el-menu-item>
            <el-menu-item index="/report">事件上报</el-menu-item>
          </el-submenu>

          <el-submenu index="learning">
            <template slot="title">
              <span>法治培训</span>
            </template>
            <el-menu-item index="/chapter">章节管理</el-menu-item>
            <el-menu-item index="/lesson">课时管理</el-menu-item>
          </el-submenu>

          <el-submenu index="user">
            <template slot="title">
              <span>用户管理</span>
            </template>
            <el-menu-item index="/admin">管理员信息</el-menu-item>
            <el-menu-item index="/user">网格员/社区居民信息</el-menu-item>
          </el-submenu>
        </el-menu>
      </div>

      <div class="manager-main-right">
        <router-view @update:user="updateUser" />
      </div>
    </div>

  </div>
</template>

<script>
export default {
  name: "Manager",
  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
    }
  },
  created() {
    // 👇 顺手帮你把之前提到的 && 安全漏洞修为了 || 👇
    if (!this.user.id || this.user.role !== "ADMIN") {
      this.$router.push('/login')
    }
  },
  methods: {
    updateUser() {
      this.user = JSON.parse(localStorage.getItem('xm-user') || '{}')   // 重新获取下用户的最新信息
    },
    goToPerson() {
      if (this.user.role === 'ADMIN') {
        this.$router.push('/adminPerson')
      }
    },
    logout() {
      localStorage.removeItem('xm-user')
      this.$router.push('/login')
    }
  }
}
</script>

<style scoped>
@import "../assets/css/manager.css";

/* 👇 修复2：双重保险，用 CSS 强制把菜单字变黑，防止被全局样式污染 👇 */
::v-deep .el-menu-item, 
::v-deep .el-submenu__title {
  color: #333333 !important;
}

::v-deep .el-menu-item.is-active {
  color: #409EFF !important;
  background-color: #ecf5ff !important;
}
</style>