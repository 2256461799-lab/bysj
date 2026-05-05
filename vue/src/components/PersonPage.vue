<template>
  <div class="person-page">
    <div class="profile-card">
      <div class="card-header">
        <h3>个人资料</h3>
        <el-button size="small" @click="updatePassword">
          <i class="el-icon-lock"></i> 修改密码
        </el-button>
      </div>
      <div class="card-body">
        <div class="avatar-section">
          <el-upload
              class="avatar-uploader"
              :action="$baseUrl + '/files/upload'"
              :show-file-list="false"
              :on-success="handleAvatarSuccess"
          >
            <img v-if="user.avatar" :src="user.avatar" class="avatar" />
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
          <p class="avatar-tip">点击上传头像</p>
        </div>
        <el-form :model="user" label-width="80px" class="profile-form">
          <el-form-item label="用户名" prop="username">
            <el-input v-model="user.username" placeholder="用户名" disabled></el-input>
          </el-form-item>
          <el-form-item label="姓名" prop="name">
            <el-input v-model="user.name" placeholder="姓名"></el-input>
          </el-form-item>
          <el-form-item label="电话" prop="phone">
            <el-input v-model="user.phone" placeholder="电话"></el-input>
          </el-form-item>
          <el-form-item label="邮箱" prop="email">
            <el-input v-model="user.email" placeholder="邮箱"></el-input>
          </el-form-item>
          <div class="form-actions">
            <el-button type="primary" @click="update">
              <i class="el-icon-check"></i> 保存
            </el-button>
          </div>
        </el-form>
      </div>
    </div>

    <el-dialog title="修改密码" :visible.sync="dialogVisible" width="30%" :close-on-click-modal="false" destroy-on-close>
      <el-form :model="user" label-width="80px" style="padding-right: 20px" :rules="rules" ref="formRef">
        <el-form-item label="原始密码" prop="password">
          <el-input show-password v-model="user.password" placeholder="原始密码"></el-input>
        </el-form-item>
        <el-form-item label="新密码" prop="newPassword">
          <el-input show-password v-model="user.newPassword" placeholder="新密码"></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input show-password v-model="user.confirmPassword" placeholder="确认密码"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>

export default {
  data() {
    const validatePassword = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请确认密码'))
      } else if (value !== this.user.newPassword) {
        callback(new Error('确认密码错误'))
      } else {
        callback()
      }
    }
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      dialogVisible: false,

      rules: {
        password: [
          { required: true, message: '请输入原始密码', trigger: 'blur' },
        ],
        newPassword: [
          { required: true, message: '请输入新密码', trigger: 'blur' },
        ],
        confirmPassword: [
          { validator: validatePassword, required: true, trigger: 'blur' },
        ],
      }
    }
  },
  created() {

  },
  methods: {
    update() {
      // 保存当前的用户信息到数据库
      this.$request.put('/user/update', this.user).then(res => {
        if (res.code === '200') {
          // 成功更新
          this.$message.success('保存成功')
          // 更新浏览器缓存里的用户信息
          localStorage.setItem('xm-user', JSON.stringify(this.user))

          // 触发父级的数据更新
          this.$emit('update:user')
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    handleAvatarSuccess(response, file, fileList) {
      // 把user的头像属性换成上传的图片的链接
      this.$set(this.user, 'avatar', response.data)
    },
    // 修改密码
    updatePassword() {
      this.dialogVisible = true
    },
    save() {
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.$request.put('/updatePassword', this.user).then(res => {
            if (res.code === '200') {
              // 成功更新
              this.$message.success('修改密码成功')
              this.$router.push('/login')
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    }
  }
}
</script>

<style scoped>
.person-page {
  max-width: 800px;
  margin: 0 auto;
}

.profile-card {
  background: #fff;
  border: 1px solid #e8e8e8;
  border-radius: 4px;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
}

.card-header {
  padding: 18px 24px;
  border-bottom: 1px solid #f0f0f0;
  display: flex;
  align-items: center;
  justify-content: space-between;
  background: #fafafa;
}

.card-header h3 {
  margin: 0;
  font-size: 16px;
  font-weight: 600;
  color: #333;
}

.card-body {
  padding: 30px 24px;
}

.avatar-section {
  text-align: center;
  margin-bottom: 32px;
}

.avatar-tip {
  margin: 8px 0 0;
  font-size: 13px;
  color: #999;
}

/deep/.el-upload {
  border-radius: 50%;
}

/deep/.avatar-uploader .el-upload {
  border: 2px dashed #ddd;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  border-radius: 50%;
  transition: border-color 0.2s;
}

/deep/.avatar-uploader .el-upload:hover {
  border-color: #1d3557;
}

.avatar-uploader-icon {
  font-size: 32px;
  color: #bbb;
  width: 100px;
  height: 100px;
  line-height: 100px;
  text-align: center;
  border-radius: 50%;
}

.avatar {
  width: 100px;
  height: 100px;
  display: block;
  border-radius: 50%;
  object-fit: cover;
}

.profile-form {
  max-width: 500px;
  margin: 0 auto;
}

/deep/.el-form-item {
  margin-bottom: 20px;
}

/deep/.el-form-item__label {
  font-weight: 600;
  color: #333;
  font-size: 14px;
}

/deep/.el-input__inner {
  border-radius: 4px;
  height: 38px;
  line-height: 38px;
}

/deep/.el-input__inner:focus {
  border-color: #1d3557;
}

/deep/.el-input.is-disabled .el-input__inner {
  background-color: #f8f8f8;
  color: #999;
}

.form-actions {
  text-align: center;
  margin-top: 32px;
  padding-top: 24px;
  border-top: 1px solid #f0f0f0;
}

/* 对话框样式 */
/deep/ .el-dialog {
  border-radius: 4px;
}

/deep/ .el-dialog__header {
  background: #fafafa;
  border-bottom: 1px solid #e8e8e8;
  padding: 16px 20px;
}

/deep/ .el-dialog__title {
  font-size: 16px;
  font-weight: 600;
  color: #333;
}

/deep/ .el-dialog__body {
  padding: 24px 20px;
}

/deep/ .el-dialog__footer {
  padding: 12px 20px;
  border-top: 1px solid #f0f0f0;
}
</style>
