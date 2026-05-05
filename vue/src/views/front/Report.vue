<template>
  <div class="report-container">
    <!-- 页面标题 -->
    <div class="page-header">
      <div class="header-icon">
        <i class="el-icon-warning"></i>
      </div>
      <div class="header-content">
        <h1 class="header-title">事件上报</h1>
        <p class="header-desc">发现问题隐患？请立即上报，助力网格治理！</p>
      </div>
    </div>

    <!-- 举报表单 -->
    <div class="report-content">
      <el-form :model="form" :rules="rules" ref="reportForm" label-width="100px" class="report-form">
        <!-- 基本信息 -->
        <div class="form-section">
          <div class="section-title">基本信息</div>
          
          <el-form-item label="上报类型" prop="type">
            <el-radio-group v-model="form.type">
              <el-radio label="安全隐患">安全隐患</el-radio>
              <el-radio label="矛盾纠纷">矛盾纠纷</el-radio>
            </el-radio-group>
          </el-form-item>

          <el-form-item label="上报标题" prop="title">
            <el-input 
              v-model="form.title" 
              placeholder="请输入上报标题，简要描述事件情况"
              maxlength="100"
              show-word-limit>
            </el-input>
          </el-form-item>

          <el-form-item label="详细内容" prop="content">
            <el-input
              type="textarea"
              v-model="form.content"
              :rows="8"
              placeholder="请详细描述事件经过、地点、时间等信息，越详细越有助于我们处理"
              maxlength="2000"
              show-word-limit>
            </el-input>
          </el-form-item>
        </div>

        <!-- 联系信息 -->
        <div class="form-section">
          <div class="section-title">联系信息</div>
          
          <el-form-item label="联系人姓名" prop="contactName">
            <el-input 
              v-model="form.contactName" 
              placeholder="请输入您的真实姓名">
            </el-input>
          </el-form-item>

          <el-form-item label="联系电话" prop="contactPhone">
            <el-input 
              v-model="form.contactPhone" 
              placeholder="请输入您的手机号码，方便我们联系您"
              maxlength="11">
            </el-input>
          </el-form-item>

          <el-form-item label="详细地址" prop="address">
            <el-input 
              v-model="form.address" 
              placeholder="请输入事件发生的详细地址"
              maxlength="200"
              show-word-limit>
            </el-input>
          </el-form-item>
        </div>

        <!-- 可疑信息 -->
        <div class="form-section">
          <div class="section-title">相关信息（选填）</div>
          
          <el-form-item label="涉及地点">
            <el-input 
              v-model="form.suspectPhone" 
              placeholder="事件发生的具体地点">
            </el-input>
          </el-form-item>

          <el-form-item label="所属网格">
            <el-input 
              v-model="form.suspectAccount" 
              placeholder="所属网格区域名称">
            </el-input>
          </el-form-item>

          <el-form-item label="关联信息">
            <el-input 
              v-model="form.suspectLink" 
              placeholder="其他相关信息或链接">
            </el-input>
          </el-form-item>

          <el-form-item label="涉及人数">
            <el-input 
              v-model.number="form.amount" 
              placeholder="如涉及多人，请填写人数"
              type="number">
              <template slot="append">人</template>
            </el-input>
          </el-form-item>
        </div>

        <!-- 证据材料 -->
        <div class="form-section">
          <div class="section-title">证据材料（选填）</div>
          
          <el-form-item label="上传证据">
            <el-upload
              :action="$baseUrl + '/files/upload'"
              :headers="{ token: user.token }"
              list-type="picture-card"
              :on-success="handleUploadSuccess"
              :on-remove="handleRemove"
              :file-list="fileList"
              accept="image/*"
              :limit="5">
              <i class="el-icon-plus"></i>
              <div slot="tip" class="el-upload__tip">支持上传现场照片等证据图片，最多5张</div>
            </el-upload>
          </el-form-item>
        </div>

        <!-- 操作按钮 -->
        <div class="form-actions">
          <el-button type="primary" @click="submitReport" :loading="submitting">提交上报</el-button>
          <el-button @click="resetForm">重置</el-button>
          <el-button @click="goToMyReports">查看我的上报</el-button>
        </div>
      </el-form>
    </div>

    <!-- 温馨提示 -->
    <div class="tips-card">
      <div class="tips-title">
        <i class="el-icon-info"></i>
        温馨提示
      </div>
      <div class="tips-list">
        <p>1. 请如实填写上报信息，提供尽可能详细的事件线索</p>
        <p>2. 我们会对您的个人信息严格保密</p>
        <p>3. 提交后可在"个人中心-我的上报"中查看处理进度</p>
        <p>4. 如遇紧急情况，请立即拨打110报警</p>
      </div>
    </div>

    <Footer />
  </div>
</template>

<script>
import Footer from "@/components/Footer";

export default {
  name: "FrontReport",
  components: {
    Footer
  },
  data() {
    // 手机号验证
    const validatePhone = (rule, value, callback) => {
      if (!value) {
        callback(new Error('请输入联系电话'))
      } else if (!/^1[3-9]\d{9}$/.test(value)) {
        callback(new Error('请输入正确的手机号码'))
      } else {
        callback()
      }
    }

    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      form: {
        type: '安全隐患',
        title: '',
        content: '',
        contactName: '',
        contactPhone: '',
        address: '',
        suspectPhone: '',
        suspectAccount: '',
        suspectLink: '',
        amount: null,
        evidence: '',
        status: '待处理',
        reportTime: '',
        userId: null
      },
      rules: {
        type: [
          { required: true, message: '请选择上报类型', trigger: 'change' }
        ],
        title: [
          { required: true, message: '请输入上报标题', trigger: 'blur' },
          { min: 5, max: 100, message: '标题长度在 5 到 100 个字符', trigger: 'blur' }
        ],
        content: [
          { required: true, message: '请输入详细内容', trigger: 'blur' },
          { min: 10, max: 2000, message: '内容长度在 10 到 2000 个字符', trigger: 'blur' }
        ],
        contactName: [
          { required: true, message: '请输入联系人姓名', trigger: 'blur' }
        ],
        contactPhone: [
          { required: true, validator: validatePhone, trigger: 'blur' }
        ],
        address: [
          { required: true, message: '请输入详细地址', trigger: 'blur' }
        ]
      },
      fileList: [],
      evidenceUrls: [],
      submitting: false
    }
  },
  created() {
    // 获取当前登录用户信息
    if (this.user.id) {
      this.form.userId = this.user.id
      this.form.contactName = this.user.name || ''
      this.form.contactPhone = this.user.phone || ''
    }
  },
  methods: {
    // 文件上传成功
    handleUploadSuccess(response, file, fileList) {
      if (response.code === '200') {
        this.evidenceUrls.push(response.data)
        this.form.evidence = this.evidenceUrls.join(',')
      } else {
        this.$message.error('上传失败：' + response.msg)
      }
    },
    // 删除文件
    handleRemove(file, fileList) {
      // 从 evidenceUrls 中移除对应的URL
      const index = this.fileList.findIndex(f => f.uid === file.uid)
      if (index > -1) {
        this.evidenceUrls.splice(index, 1)
        this.form.evidence = this.evidenceUrls.join(',')
      }
    },
    // 提交举报
    submitReport() {
      this.$refs.reportForm.validate((valid) => {
        if (valid) {
          // 检查是否登录
          if (!this.form.userId) {
            this.$confirm('您还未登录，是否前往登录？', '提示', {
              confirmButtonText: '去登录',
              cancelButtonText: '取消',
              type: 'warning'
            }).then(() => {
              this.$router.push('/login')
            })
            return
          }

          // 格式化当前时间
          const now = new Date()
          const year = now.getFullYear()
          const month = String(now.getMonth() + 1).padStart(2, '0')
          const day = String(now.getDate()).padStart(2, '0')
          const hours = String(now.getHours()).padStart(2, '0')
          const minutes = String(now.getMinutes()).padStart(2, '0')
          const seconds = String(now.getSeconds()).padStart(2, '0')
          this.form.reportTime = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`

          this.submitting = true
          this.$request.post('/report/add', this.form).then(res => {
            if (res.code === '200') {
              this.$message.success('事件上报成功，我们会尽快处理！')
              this.resetForm()
              // 3秒后跳转到个人中心查看举报
              setTimeout(() => {
                this.$router.push('/front/person')
              }, 2000)
            } else {
              this.$message.error(res.msg || '提交失败，请稍后重试')
            }
          }).catch(err => {
            this.$message.error('提交失败，请稍后重试')
            console.error(err)
          }).finally(() => {
            this.submitting = false
          })
        } else {
          this.$message.warning('请完善必填信息')
          return false
        }
      })
    },
    // 重置表单
    resetForm() {
      this.$refs.reportForm.resetFields()
      this.fileList = []
      this.evidenceUrls = []
      this.form.evidence = ''
      // 保留用户信息
      if (this.user.id) {
        this.form.contactName = this.user.name || ''
        this.form.contactPhone = this.user.phone || ''
      }
    },
    // 跳转到我的举报
    goToMyReports() {
      this.$router.push('/front/person')
    }
  }
}
</script>

<style scoped>
.report-container {
  width: 80%;
  max-width: 1200px;
  margin: 20px auto;
}

/* 页面标题 */
.page-header {
  background: #fff;
  border-radius: 4px;
  padding: 28px;
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  gap: 18px;
  border: 1px solid #e8e8e8;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
}

.header-icon {
  width: 54px;
  height: 54px;
  background: #1d3557;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.header-icon i {
  font-size: 28px;
  color: #fff;
}

.header-content {
  flex: 1;
}

.header-title {
  font-size: 24px;
  font-weight: 600;
  color: #333;
  margin: 0 0 6px 0;
}

.header-desc {
  font-size: 14px;
  color: #666;
  margin: 0;
  line-height: 1.6;
}

/* 表单内容 */
.report-content {
  background: #fff;
  border-radius: 4px;
  padding: 30px;
  border: 1px solid #e8e8e8;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
  margin-bottom: 20px;
}

.report-form {
  max-width: 100%;
}

/* 表单分区 */
.form-section {
  margin-bottom: 30px;
  padding-bottom: 20px;
  border-bottom: 1px solid #f0f0f0;
}

.form-section:last-of-type {
  border-bottom: none;
  margin-bottom: 0;
  padding-bottom: 0;
}

.section-title {
  font-size: 16px;
  font-weight: 600;
  color: #333;
  margin-bottom: 20px;
  padding-left: 10px;
  border-left: 3px solid #1d3557;
}

/* 修复：深度选择器标准写法，消除报错 */
::v-deep .el-form-item__label {
  font-weight: 500;
  color: #606266;
}

::v-deep .el-input__inner,
::v-deep .el-textarea__inner {
  border-radius: 4px;
}

::v-deep .el-radio-group {
  line-height: 32px;
}

::v-deep .el-upload__tip {
  color: #999;
  font-size: 12px;
  line-height: 1.5;
  margin-top: 8px;
}

::v-deep .el-upload-list__item {
  border-radius: 4px;
}

/* 操作按钮 */
.form-actions {
  text-align: center;
  padding-top: 20px;
  border-top: 1px solid #f0f0f0;
  margin-top: 20px;
}

.form-actions .el-button {
  min-width: 120px;
  padding: 12px 20px;
}

/* 温馨提示 */
.tips-card {
  background: #fff;
  border-radius: 4px;
  padding: 20px 24px;
  border: 1px solid #e8e8e8;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
}

.tips-title {
  font-size: 15px;
  font-weight: 600;
  color: #457b9d;
  margin-bottom: 12px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.tips-title i {
  font-size: 16px;
}

.tips-list {
  font-size: 14px;
  color: #666;
  line-height: 1.8;
}

.tips-list p {
  margin: 6px 0;
}

.tips-list p:first-child {
  margin-top: 0;
}

.tips-list p:last-child {
  margin-bottom: 0;
  color: #f56c6c;
}

/* 响应式设计 */
@media (max-width: 1024px) {
  .report-container {
    width: 95%;
  }
}

@media (max-width: 768px) {
  .report-container {
    width: 100%;
    padding: 0 10px;
    margin: 10px auto;
  }

  .page-header {
    flex-direction: column;
    text-align: center;
    padding: 24px;
  }

  .header-title {
    font-size: 20px;
  }

  .report-content {
    padding: 20px;
  }

  .section-title {
    font-size: 15px;
  }

  ::v-deep .el-form-item__label {
    text-align: left;
  }

  .form-actions .el-button {
    min-width: 100px;
    padding: 10px 15px;
    margin: 5px;
  }
}
</style>