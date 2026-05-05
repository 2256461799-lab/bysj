<template>
  <div>
  <!--头部-->
    <div class="front-header">
      <div class="front-header-left">
        <img src="@/assets/imgs/logo.png" alt="">
        <div class="title">网格化依法治理平台</div>
      </div>
      <div class="front-header-center">
        <div class="front-header-nav">
          <el-menu :default-active="$route.path" mode="horizontal" router>
						<el-menu-item index="/front/home">
              <i class="el-icon-s-home"></i>
              <span>首页</span>
            </el-menu-item>
						
						<el-menu-item index="/front/law">
              <i class="el-icon-warning-outline"></i>
              <span>法律法规</span>
            </el-menu-item>
						<el-menu-item index="/front/knowledge">
              <i class="el-icon-reading"></i>
              <span>治理案例库</span>
            </el-menu-item>
            <el-menu-item index="/front/blog">
              <i class="el-icon-chat-dot-round"></i>
              <span>工作交流</span>
            </el-menu-item>
						<el-menu-item index="/front/activity">
              <i class="el-icon-trophy"></i>
              <span>任务中心</span>
            </el-menu-item>
						
						<el-menu-item index="/front/learningClass">
              <i class="el-icon-video-camera"></i>
              <span>法治培训</span>
            </el-menu-item>
						
            <el-menu-item index="/front/report">
              <i class="el-icon-phone-outline"></i>
              <span>事件上报</span>
            </el-menu-item>
						<el-menu-item index="/front/person">
              <i class="el-icon-user"></i>
              <span>个人中心</span>
            </el-menu-item>
          </el-menu>
        </div>
      </div>
      <div class="front-header-right">
        <div v-if="!user.username" class="header-buttons">
          <el-button size="small" @click="$router.push('/login')">登录</el-button>
          <el-button size="small" type="primary" @click="$router.push('/register')">注册</el-button>
        </div>
        <div v-else>
          <el-dropdown>
            <div class="front-header-dropdown">
              <img :src="user.avatar" alt="">
              <div class="user-info">
                <span>{{ user.name }}</span>
                <i class="el-icon-arrow-down"></i>
              </div>
            </div>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item>
                <div style="text-decoration: none" @click="logout">
                  <i class="el-icon-switch-button"></i> 退出登录
                </div>
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </div>
    </div>
    <!--主体-->
    <div class="main-body">
      <router-view ref="child" @update:user="updateUser" />
    </div>

    <!-- AI治理助手 -->
    <ai-assistant></ai-assistant>
  </div>

</template>

<script>
import AiAssistant from '@/components/AiAssistant.vue'

export default {
  name: "FrontLayout",
  components: {
    AiAssistant
  },

  data () {
    return {
      top: '',
      notice: [],
      user: JSON.parse(localStorage.getItem("xm-user") || '{}'),
      title:'',
    }
  },

  methods: {
    updateUser() {
      this.user = JSON.parse(localStorage.getItem('xm-user') || '{}')   // 重新获取下用户的最新信息
    },
    // 退出登录
    logout() {
      localStorage.removeItem("xm-user");
      this.$router.push("/login");
    },
  }

}
</script>

<style scoped>
  @import "../assets/css/front.css";
</style>
