<template>
  <div class="container">
    <div style="width: 380px; padding: 50px 30px; background-color: white; border-radius: 5px;">
      <div style="text-align: center; font-size: 24px; margin-bottom: 30px; color: #333">网格化依法治理平台</div>
      <el-form :model="form" :rules="rules" ref="formRef">
        <el-form-item prop="username">
          <el-input size="medium" prefix-icon="el-icon-user" placeholder="请输入账号" v-model="form.username"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input size="medium" prefix-icon="el-icon-lock" placeholder="请输入密码" show-password  v-model="form.password"></el-input>
        </el-form-item>
        <el-form-item prop="role">
          <el-radio-group v-model="form.role">
            <el-radio label="ADMIN">管理员</el-radio>
            <el-radio label="USER">网格员/社区居民</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item prop="code">
          <div style="display: flex">
            <el-input style="flex: 1" size="medium" placeholder="请输入验证码" v-model="form.code"></el-input>
            <Identify :identifyCode="identifyCode" @click.native="refreshCode" />
          </div>
        </el-form-item>
        <el-form-item>
          <el-button size="medium" style="width: 100%; background-color: #2a60c9; border-color: #2a60c9; color: white" @click="login">登 录</el-button>
        </el-form-item>
        <div style="display: flex; align-items: center">
          <div style="flex: 1"></div>
          <div style="flex: 1; text-align: right">
            还没有账号？请 <a href="/register">注册</a>
          </div>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script>
import Identify from "@/components/Identify";

export default {
  name: "Login",
  components: {
    Identify
  },
  data() {
    return {
      form: {
        role: 'ADMIN',
        code: ''
      },
      rules: {
        username: [
          { required: true, message: '请输入账号', trigger: 'blur' },
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
        ],
        role: [
          { required: true, message: '请选择登录身份', trigger: 'change' }
        ],
        code: [
          { required: true, message: '请输入验证码', trigger: 'blur' }
        ]
      },
      identifyCode: '',
      identifyCodes: '123456789ABCDEFGHGKMNPQRSTUVWXY',
    }
  },
  mounted() {
    this.refreshCode()
  },
  methods: {
    refreshCode() {
      this.identifyCode = ''
      this.makeCode(this.identifyCodes, 4)
    },
    makeCode(o, l) {
      for (let i = 0; i < l; i++) {
        this.identifyCode += this.identifyCodes[Math.floor(Math.random() * this.identifyCodes.length)]
      }
    },
    login() {
      this.$refs['formRef'].validate((valid) => {
        if (!valid) return

        if (this.form.code.toLowerCase() !== this.identifyCode.toLowerCase()) {
          this.$message.warning('验证码错误')
          this.refreshCode()
          return
        }

        this.$request.post('/login', this.form).then(res => {
          if (res.code === '200') {
            // 【修改】登录前先清空旧的缓存，防止旧数据污染
            localStorage.clear() 
            // 存入新的用户信息
            localStorage.setItem("xm-user", JSON.stringify(res.data))
            this.$message.success('登录成功')
            
            setTimeout(() => {
              // 【修改】核心修改：不用 router.push，改用 window.location.href 强制刷新
              if (res.data.role === 'ADMIN') {
                window.location.href = '/home'
              } else {
                window.location.href = '/front/home'
              }
            }, 500)
          } else {
            this.refreshCode()
            this.$message.error(res.msg)
          }
        })
      })
    }
  }
}
</script>

<style scoped>
.container {
  height: 100vh;
  overflow: hidden;
  background-image: url("@/assets/imgs/bg.jpg");
  background-size: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #666;
}
a {
  color: #2a60c9;
}
</style>