<template>
  <div class="activity-detail-container">
    <!-- 活动头部信息 -->
    <div class="activity-header">
      <div class="activity-cover-wrapper">
        <img :src="activity.cover" alt="" class="activity-cover-image">
      </div>

      <div class="activity-info">
        <h1 class="activity-name">{{ activity.name }}</h1>
        <p class="activity-description">{{ activity.descr }}</p>
        
        <div class="activity-meta">
          <div class="meta-item">
            <i class="el-icon-time"></i>
            <span class="meta-label">时间</span>
            <span class="meta-value">{{ activity.start }} ~ {{ activity.end }}</span>
          </div>
          <div class="meta-item">
            <i class="el-icon-location-outline"></i>
            <span class="meta-label">地址</span>
            <a class="meta-link" :href="activity.address" v-if="activity.form === '线上活动'">{{ activity.address }}</a>
            <span class="meta-value" v-else>{{ activity.address }}</span>
            <el-tag class="form-tag" type="primary" size="small">{{ activity.form }}</el-tag>
          </div>
          <div class="meta-item" v-if="activity.host">
            <i class="el-icon-office-building"></i>
            <span class="meta-label">主办方</span>
            <span class="meta-value">{{ activity.host }}</span>
          </div>
        </div>

        <div class="activity-actions">
          <div class="action-left">
            <el-button 
              class="sign-btn" 
              :class="{ 'btn-disabled': activity.isEnd }"
              type="primary" 
              size="medium"
              disabled 
              v-if="activity.isEnd">
              已结束
            </el-button>
            <el-button 
              class="sign-btn signed"
              type="success" 
              size="medium"
              v-else-if="activity.isSign"
              @click="cancel"
              @mouseenter.native="signText='取消报名'"
              @mouseleave.native="signText='已报名'">
              {{ signText }}
            </el-button>
            <el-button 
              class="sign-btn"
              type="primary" 
              size="medium"
              v-else 
              @click="sign">
              立即报名
            </el-button>
          </div>

          <div class="action-right">
            <div class="stat-item" :class="{ active: activity.isLike }" @click="like">
              <i class="el-icon-star-on"></i>
              <span>点赞 {{ activity.likesCount || 0 }}</span>
            </div>
            <div class="stat-item" :class="{ active: activity.isCollect }" @click="collect">
              <i class="el-icon-collection"></i>
              <span>收藏 {{ activity.collectCount || 0 }}</span>
            </div>
            <div class="stat-item">
              <i class="el-icon-view"></i>
              <span>阅读 {{ activity.readCount || 0 }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 活动详情内容 -->
    <div class="activity-content-card">
      <div class="section-title">
        <span class="title-text">活动详情</span>
      </div>
      <div class="content-wrapper">
        <div class="w-e-text" v-html="activity.content"></div>
      </div>
    </div>

    <!-- 评论区 -->
    <div class="comment-section">
      <Comment :fid="activityId" module="活动" />
    </div>
  </div>
</template>

<script>
import Comment from "@/components/Comment";
export default {
  name: "ActivityDetail",
  components: {Comment},
  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      activity: {},
      activityId: this.$route.query.activityId,
      signText:'已报名',
    }
  },
  created() {
    this.load()
    this.$request.put('/activity/updateReadCount/' + this.activityId)
  },
  methods: {
    cancel() {   // 单个删除
      this.$confirm('您确定取消报名吗？', '确认取消', {type: "warning"}).then(response => {
        this.$request.delete('/activitySign/delete/user/' + this.activityId + '/' + this.user.id).then(res => {
          if (res.code === '200') {   // 表示操作成功
            this.$message.success('操作成功')
            window.location.reload()
          } else {
            this.$message.error(res.msg)  // 弹出错误的信息
          }
        })
      }).catch(() => {
      })
    },
    collect() {
      this.$request.post('/collect/set', { fid: this.activityId, module: '活动' }).then(res => {
        if (res.code === '200') {
          this.$message.success('操作成功')
          this.load()
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    like() {
      this.$request.post('/likes/set', { fid: this.activityId, module: '活动' }).then(res => {
        if (res.code === '200') {
          this.$message.success('操作成功')
          this.load()
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    sign() {
      this.$request.post('/activitySign/add', { activityId: this.activityId }).then(res => {
        if (res.code === '200') {
          this.$message.success('报名成功')
          this.load()
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    load() {
      this.$request.get('/activity/selectById/' + this.activityId).then(res => {
        this.activity = res.data || {}
      })
    }
  }
}
</script>

<style scoped>
.activity-detail-container {
  width: 75%;
  max-width: 960px;
  margin: 20px auto;
}

/* 活动头部卡片 */
.activity-header {
  background: #fff;
  border-radius: 4px;
  padding: 35px 40px;
  margin-bottom: 15px;
  display: flex;
  gap: 30px;
  border: 1px solid #e8e8e8;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
}

/* 封面图 */
.activity-cover-wrapper {
  width: 360px;
  flex-shrink: 0;
}

.activity-cover-image {
  width: 100%;
  height: 280px;
  object-fit: cover;
  border-radius: 4px;
  border: 1px solid #e8e8e8;
}

/* 活动信息 */
.activity-info {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.activity-name {
  font-size: 28px;
  font-weight: 600;
  color: #1a1a1a;
  margin: 0 0 16px 0;
  line-height: 1.4;
}

.activity-description {
  color: #606266;
  font-size: 15px;
  line-height: 1.8;
  margin: 0 0 24px 0;
  text-align: justify;
}

/* 元数据 */
.activity-meta {
  margin-bottom: 24px;
}

.meta-item {
  display: flex;
  align-items: center;
  padding: 10px 0;
  color: #606266;
  font-size: 14px;
}

.meta-item i {
  font-size: 16px;
  color: #909399;
  margin-right: 12px;
  width: 16px;
}

.meta-label {
  color: #909399;
  margin-right: 12px;
  min-width: 60px;
}

.meta-value {
  color: #303133;
}

.meta-link {
  color: #1d3557;
  text-decoration: none;
  transition: color 0.3s;
}

.meta-link:hover {
  color: #264e78;
  text-decoration: underline;
}

.form-tag {
  margin-left: 10px;
}

/* 操作按钮区 */
.activity-actions {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-top: 20px;
  border-top: 1px solid #e8e8e8;
  margin-top: auto;
}

.action-left {
  flex-shrink: 0;
}

.sign-btn {
  padding: 12px 32px;
  font-size: 15px;
  font-weight: 500;
  border-radius: 6px;
}

.sign-btn.btn-disabled {
  opacity: 0.6;
}

.sign-btn.signed {
  min-width: 120px;
}

/* 统计信息 */
.action-right {
  display: flex;
  gap: 8px;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 8px 16px;
  background: #f5f7fa;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.3s ease;
  user-select: none;
  font-size: 14px;
  color: #606266;
}

.stat-item:hover {
  background: #e8f0f8;
  color: #1d3557;
}

.stat-item.active {
  background: #e8f0f8;
  color: #1d3557;
}

.stat-item i {
  font-size: 16px;
}

/* 活动详情卡片 */
.activity-content-card {
  background: #fff;
  border-radius: 4px;
  padding: 35px 40px;
  margin-bottom: 15px;
  border: 1px solid #e8e8e8;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
}

.section-title {
  margin-bottom: 24px;
  padding-bottom: 16px;
  border-bottom: 1px solid #e8e8e8;
}

.title-text {
  font-size: 20px;
  font-weight: 600;
  color: #1a1a1a;
  position: relative;
  padding-left: 12px;
}

.title-text::before {
  content: '';
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 3px;
  height: 18px;
  background: #1d3557;
  border-radius: 2px;
}

.content-wrapper {
  line-height: 1.8;
}

/* 评论区 */
.comment-section {
  background: #fff;
  border-radius: 4px;
  padding: 35px 40px;
  margin-bottom: 15px;
  border: 1px solid #e8e8e8;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
}

/* 富文本内容样式 */
.w-e-text {
  font-size: 16px;
  color: #333;
  line-height: 1.8;
}

.w-e-text h2 {
  font-size: 22px;
  font-weight: 600;
  color: #1a1a1a;
  margin: 20px 0 12px 0;
  padding-bottom: 8px;
  border-bottom: 1px solid #e8e8e8;
}

.w-e-text h3 {
  font-size: 18px;
  font-weight: 600;
  color: #1a1a1a;
  margin: 20px 0 12px 0;
  padding-left: 10px;
  border-left: 3px solid #1d3557;
}

.w-e-text p {
  margin: 15px 0;
  line-height: 1.8;
}

.w-e-text ul, .w-e-text ol {
  padding-left: 25px;
  margin: 15px 0;
}

.w-e-text li {
  margin: 6px 0;
  line-height: 1.8;
}

.w-e-text strong {
  font-weight: 600;
  color: #1d3557;
}

.w-e-text table {
  border-collapse: collapse;
  width: 100%;
  margin: 15px 0;
}

.w-e-text table th,
.w-e-text table td {
  border: 1px solid #e8e8e8;
  padding: 10px 12px;
  text-align: left;
}
  
.w-e-text table th {
  background: #f5f5f5;
  font-weight: 600;
  color: #333;
}

/* 响应式设计 */
@media (max-width: 1024px) {
  .activity-detail-container {
    width: 90%;
  }
  
  .activity-header {
    flex-direction: column;
    padding: 30px;
  }
  
  .activity-cover-wrapper {
    width: 100%;
  }
  
  .activity-cover-image {
    height: 240px;
  }
  
  .activity-actions {
    flex-direction: column;
    gap: 16px;
    align-items: stretch;
  }
  
  .action-right {
    justify-content: space-between;
  }
}

@media (max-width: 768px) {
  .activity-detail-container {
    width: 100%;
    padding: 0 10px;
    margin: 10px auto;
  }
  
  .activity-header,
  .activity-content-card,
  .comment-section {
    padding: 24px 20px;
    border-radius: 4px;
    margin-bottom: 15px;
  }
  
  .activity-name {
    font-size: 22px;
  }
  
  .section-title .title-text {
    font-size: 18px;
  }
}
</style>
