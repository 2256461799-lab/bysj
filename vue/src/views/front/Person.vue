<template>
  <div class="person-container">
    <el-tabs v-model="activeName" @tab-click="clickTab" class="person-tabs">
      <el-tab-pane label="个人资料" name="个人资料">
        <person-page />
      </el-tab-pane>
      <el-tab-pane label="我发表的日志" name="我发表的日志">
        <div class="action-bar">
          <el-button type="primary" @click="addBlog">
            <i class="el-icon-edit"></i> 发表新日志
          </el-button>
        </div>
        <div class="content-wrapper">
          <blog-list type="user" :show-opt="true" />
        </div>
      </el-tab-pane>
      <el-tab-pane label="我报名的活动" name="我报名的活动">
        <activity-list type="user" :span="8" />
      </el-tab-pane>
      <el-tab-pane label="我的点赞" name="我的点赞">
        <div class="filter-bar">
          <div class="filter-tabs">
            <div class="filter-item" :class="{'active':likesCurrent==='日志'}" @click="changeLikesCurrent('日志')">
              <i class="el-icon-document"></i> 日志
            </div>
            <div class="filter-item" :class="{'active':likesCurrent==='活动'}" @click="changeLikesCurrent('活动')">
              <i class="el-icon-star-off"></i> 活动
            </div>
          </div>
        </div>
        <div class="content-wrapper">
          <blog-list v-if="likesCurrent==='日志'" type="like"></blog-list>
          <activity-list v-if="likesCurrent==='活动'" :span="8" type="like"></activity-list>
        </div>
      </el-tab-pane>
      <el-tab-pane label="我的收藏" name="我的收藏">
        <div class="filter-bar">
          <div class="filter-tabs">
            <div class="filter-item" :class="{'active':likesCurrent==='日志'}" @click="changeLikesCurrent('日志')">
              <i class="el-icon-document"></i> 日志
            </div>
            <div class="filter-item" :class="{'active':likesCurrent==='活动'}" @click="changeLikesCurrent('活动')">
              <i class="el-icon-star-off"></i> 活动
            </div>
          </div>
        </div>
        <div class="content-wrapper">
          <blog-list v-if="likesCurrent==='日志'" type="collect"></blog-list>
          <activity-list v-if="likesCurrent==='活动'" :span="8" type="collect"></activity-list>
        </div>
      </el-tab-pane>
      
      <el-tab-pane label="我的上报" name="我的上报">
        <div class="table-container">
          <el-table :data="reportList" stripe>
            <el-table-column prop="type" label="上报类型" width="120"></el-table-column>
            <el-table-column prop="title" label="标题" min-width="200"></el-table-column>
            <el-table-column prop="reportTime" label="上报时间" width="180"></el-table-column>
            <el-table-column prop="status" label="状态" width="100">
              <template v-slot="scope">
                <el-tag v-if="scope.row.status === '待处理'" type="warning" size="small">{{ scope.row.status }}</el-tag>
                <el-tag v-else-if="scope.row.status === '处理中'" type="primary" size="small">{{ scope.row.status }}</el-tag>
                <el-tag v-else-if="scope.row.status === '已处理'" type="success" size="small">{{ scope.row.status }}</el-tag>
                <el-tag v-else type="info" size="small">{{ scope.row.status }}</el-tag>
              </template>
            </el-table-column>
            <el-table-column label="操作" width="120">
              <template v-slot="scope">
                <el-button size="small" type="text" @click="viewReport(scope.row)">查看详情</el-button>
              </template>
            </el-table-column>
          </el-table>
          <div class="pagination-wrapper" v-if="reportTotal > 0">
            <el-pagination
              background
              @current-change="handleReportPageChange"
              :current-page="reportPageNum"
              :page-size="reportPageSize"
              layout="total, prev, pager, next"
              :total="reportTotal">
            </el-pagination>
          </div>
        </div>
      </el-tab-pane>
    </el-tabs>

    <!-- 举报详情对话框 -->
    <el-dialog title="上报详情" :visible.sync="reportDialogVisible" width="60%">
      <div v-if="currentReport">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="上报类型">{{ currentReport.type }}</el-descriptions-item>
          <el-descriptions-item label="上报标题">{{ currentReport.title }}</el-descriptions-item>
          <el-descriptions-item label="上报时间">{{ currentReport.reportTime }}</el-descriptions-item>
          <el-descriptions-item label="状态">
            <el-tag v-if="currentReport.status === '待处理'" type="warning">{{ currentReport.status }}</el-tag>
            <el-tag v-else-if="currentReport.status === '处理中'" type="primary">{{ currentReport.status }}</el-tag>
            <el-tag v-else-if="currentReport.status === '已处理'" type="success">{{ currentReport.status }}</el-tag>
            <el-tag v-else type="info">{{ currentReport.status }}</el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="联系人姓名" v-if="currentReport.contactName">{{ currentReport.contactName }}</el-descriptions-item>
          <el-descriptions-item label="联系电话" v-if="currentReport.contactPhone">{{ currentReport.contactPhone }}</el-descriptions-item>
          <el-descriptions-item label="详细地址" :span="2" v-if="currentReport.address">{{ currentReport.address }}</el-descriptions-item>
          <el-descriptions-item label="涉及地点" v-if="currentReport.suspectPhone">{{ currentReport.suspectPhone }}</el-descriptions-item>
          <el-descriptions-item label="所属网格" v-if="currentReport.suspectAccount">{{ currentReport.suspectAccount }}</el-descriptions-item>
          <el-descriptions-item label="关联信息" v-if="currentReport.suspectLink" :span="2">{{ currentReport.suspectLink }}</el-descriptions-item>
          <el-descriptions-item label="涉及人数" v-if="currentReport.amount">{{ currentReport.amount }} 人</el-descriptions-item>
          <el-descriptions-item label="详细内容" :span="2">
            <div v-html="currentReport.content"></div>
          </el-descriptions-item>
          <el-descriptions-item label="证据附件" :span="2" v-if="currentReport.evidence">
            <div v-for="(file, index) in currentReport.evidence.split(',')" :key="index" style="display: inline-block; margin-right: 10px">
              <el-image 
                style="width: 100px; height: 100px; cursor: pointer"
                :src="file"
                :preview-src-list="currentReport.evidence.split(',')"
                fit="cover">
              </el-image>
            </div>
          </el-descriptions-item>
          <el-descriptions-item label="处理人" v-if="currentReport.handler">{{ currentReport.handler }}</el-descriptions-item>
          <el-descriptions-item label="处理时间" v-if="currentReport.handleTime">{{ currentReport.handleTime }}</el-descriptions-item>
          <el-descriptions-item label="处理结果" :span="2" v-if="currentReport.handleResult">
            <div v-html="currentReport.handleResult"></div>
          </el-descriptions-item>
        </el-descriptions>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="reportDialogVisible = false">关 闭</el-button>
      </span>
    </el-dialog>

    <Footer />
  </div>
</template>

<script>
import Footer from "@/components/Footer";
import PersonPage from "@/components/PersonPage";
import BlogList from "@/components/BlogList";
import ActivityList from "@/components/ActivityList";

export default {
  components: {
    ActivityList,
    BlogList,
    Footer,
    PersonPage
  },
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
          {required: true, message: '请输入原始密码', trigger: 'blur'},
        ],
        newPassword: [
          {required: true, message: '请输入新密码', trigger: 'blur'},
        ],
        confirmPassword: [
          {validator: validatePassword, required: true, trigger: 'blur'},
        ],
      },
      activeName: '个人资料',
      likesCurrent:'日志',
      
      // 上报相关数据
      reportList: [],
      reportPageNum: 1,
      reportPageSize: 10,
      reportTotal: 0,
      reportDialogVisible: false,
      currentReport: null
    }
  },
  created() {

  },
  methods: {
    changeLikesCurrent(likesCurrent){
      this.likesCurrent=likesCurrent
    },
    // 加载举报列表
    loadReportList() {
      this.$request.get('/report/selectPage', {
        params: {
          pageNum: this.reportPageNum,
          pageSize: this.reportPageSize,
          userId: this.user.id
        }
      }).then(res => {
        if (res.code === '200') {
          this.reportList = res.data?.list || []
          this.reportTotal = res.data?.total || 0
        }
      })
    },
    // 举报分页切换
    handleReportPageChange(pageNum) {
      this.reportPageNum = pageNum
      this.loadReportList()
    },
    // 查看举报详情
    viewReport(row) {
      this.currentReport = row
      this.reportDialogVisible = true
    },
    addBlog() {
      window.open('/front/newBlog')
    },
    clickTab(tab) {
      console.log(tab)
      // 当切换到"我的举报"标签时，加载举报列表
      if (tab.name === '我的上报') {
        this.loadReportList()
      }
    },
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
.person-container {
  width: 75%;
  max-width: 1200px;
  margin: 20px auto;
}

/* 标签页样式 */
.person-tabs {
  background: #fff;
  border-radius: 4px;
  border: 1px solid #e8e8e8;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
}

/deep/ .el-tabs__header {
  margin: 0;
  padding: 0 20px;
  background: #fafafa;
  border-bottom: 1px solid #e8e8e8;
}

/deep/ .el-tabs__nav-wrap::after {
  display: none;
}

/deep/ .el-tabs__item {
  font-size: 14px;
  padding: 0 20px;
  height: 48px;
  line-height: 48px;
  color: #666;
}

/deep/ .el-tabs__item:hover {
  color: #1d3557;
}

/deep/ .el-tabs__item.is-active {
  color: #1d3557;
  font-weight: 600;
}

/deep/ .el-tabs__active-bar {
  height: 2px;
  background-color: #1d3557;
}

/deep/ .el-tabs__content {
  padding: 20px;
}

/* 操作栏 */
.action-bar {
  background: #fff;
  padding: 16px;
  margin-bottom: 16px;
  border: 1px solid #e8e8e8;
  border-radius: 4px;
}

/* 筛选栏 */
.filter-bar {
  background: #fff;
  padding: 16px;
  margin-bottom: 16px;
  border: 1px solid #e8e8e8;
  border-radius: 4px;
}

.filter-tabs {
  display: flex;
  gap: 8px;
}

.filter-item {
  padding: 8px 20px;
  cursor: pointer;
  transition: all 0.2s;
  background-color: #f5f5f5;
  color: #666;
  font-size: 14px;
  border: 1px solid transparent;
}

.filter-item i {
  margin-right: 4px;
}

.filter-item:hover {
  background-color: #e8f0f8;
  color: #1d3557;
  border-color: #a8dadc;
}

.filter-item.active {
  background-color: #1d3557;
  color: #fff;
  border-color: #1d3557;
}

/* 内容区域 */
.content-wrapper {
  margin-top: 16px;
}

/* 表格容器 */
.table-container {
  background: #fff;
  border: 1px solid #e8e8e8;
  border-radius: 4px;
}

/deep/ .el-table {
  border: none;
}

/deep/ .el-table th {
  background: #fafafa;
  font-weight: 600;
  color: #333;
  border-bottom: 1px solid #e8e8e8;
}

/deep/ .el-table td {
  color: #666;
}

/deep/ .el-table--enable-row-hover .el-table__body tr:hover > td {
  background-color: #f8f8f8;
}

.pagination-wrapper {
  padding: 16px;
  text-align: center;
  border-top: 1px solid #f0f0f0;
}

/* 卡片样式 */
/deep/ .el-card {
  border-radius: 4px;
  border: 1px solid #e8e8e8;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
}

/deep/ .el-form-item__label {
  font-weight: 600;
  color: #333;
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
  padding: 20px;
}

/deep/ .el-descriptions {
  border-radius: 4px;
}

/deep/ .el-descriptions__header {
  margin-bottom: 16px;
}

/deep/ .el-descriptions-item__label {
  font-weight: 600;
  color: #333;
  background: #fafafa;
}

/* 标签样式 */
/deep/ .el-tag {
  border: none;
}

/* 按钮样式 */
/deep/ .el-button--text {
  color: #1d3557;
}

/deep/ .el-button--text:hover {
  color: #264e78;
}
</style>
