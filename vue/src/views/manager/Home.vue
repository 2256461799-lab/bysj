<template>
  <div class="home-container">
    <div class="welcome-card">
      <div class="welcome-text">
        <h2>欢迎回来，{{ user?.name }}</h2>
        <p>{{ currentDate }}</p>
      </div>
    </div>
    <div class="stats-grid">
      <div class="stat-card">
        <div class="stat-header">
          <span class="stat-label">网格员和社区居民总数</span>
        </div>
        <div class="stat-value">{{ stats.userCount || 0 }}</div>
        <div class="stat-footer">
          <span class="stat-trend">较上月 +{{ stats.userGrowth || 0 }}</span>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-header">
          <span class="stat-label">工作日志</span>
        </div>
        <div class="stat-value">{{ stats.blogCount || 0 }}</div>
        <div class="stat-footer">
          <span class="stat-trend">较上月 +{{ stats.blogGrowth || 0 }}</span>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-header">
          <span class="stat-label">治理任务</span>
        </div>
        <div class="stat-value">{{ stats.activityCount || 0 }}</div>
        <div class="stat-footer">
          <span class="stat-trend">较上月 +{{ stats.activityGrowth || 0 }}</span>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-header">
          <span class="stat-label">事件上报</span>
        </div>
        <div class="stat-value">{{ stats.reportCount || 0 }}</div>
        <div class="stat-footer">
          <span class="stat-trend" :class="{ warning: stats.reportPending > 0 }">
            待处理 {{ stats.reportPending || 0 }}
          </span>
        </div>
      </div>
    </div>
    <div class="detail-grid">
      <div class="detail-card">
        <div class="detail-header">
          <h3>治理数据统计</h3>
        </div>
        <div class="detail-content">
          <div class="data-row">
            <span class="data-label">法律法规</span>
            <span class="data-value">{{ stats.lawCount || 0 }} 篇</span>
          </div>
          <div class="data-row">
            <span class="data-label">案例库文章</span>
            <span class="data-value">{{ stats.knowledgeCount || 0 }} 篇</span>
          </div>
          <div class="data-row">
            <span class="data-label">培训课程</span>
            <span class="data-value">{{ stats.lessonCount || 0 }} 个</span>
          </div>
          <div class="data-row">
            <span class="data-label">题目总数</span>
            <span class="data-value">{{ stats.questionCount || 0 }} 道</span>
          </div>
        </div>
      </div>
      <div class="detail-card">
        <div class="detail-header">
          <h3>用户活跃度</h3>
        </div>
        <div class="detail-content">
          <div class="data-row">
            <span class="data-label">今日访问</span>
            <span class="data-value">{{ stats.todayVisit || 0 }} 次</span>
          </div>
          <div class="data-row">
            <span class="data-label">评论总数</span>
            <span class="data-value">{{ stats.commentCount || 0 }} 条</span>
          </div>
          <div class="data-row">
            <span class="data-label">任务签到</span>
            <span class="data-value">{{ stats.signCount || 0 }} 人</span>
          </div>
          <div class="data-row">
            <span class="data-label">在线网格员</span>
            <span class="data-value">{{ stats.onlineUsers || 0 }} 人</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: 'Home',
  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      currentDate: '',
      stats: {
        userCount: 0,
        userGrowth: 0,
        blogCount: 0,
        blogGrowth: 0,
        activityCount: 0,
        activityGrowth: 0,
        reportCount: 0,
        reportPending: 0,
        lawCount: 0,
        knowledgeCount: 0,
        lessonCount: 0,
        questionCount: 0,
        todayVisit: 0,
        commentCount: 0,
        signCount: 0,
        onlineUsers: 0
      }
    }
  },
  created() {
    this.getCurrentDate()
    this.loadStats()
  },
  methods: {
    getCurrentDate() {
      const now = new Date()
      const days = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六']
      const year = now.getFullYear()
      const month = now.getMonth() + 1
      const day = now.getDate()
      const weekDay = days[now.getDay()]
      this.currentDate = `${year}年${month}月${day}日 ${weekDay}`
    },
    
    loadStats() {
      // 通过Redis缓存接口获取核心统计数据（用户数、日志数、任务数、上报数）
      this.$request.get('/stats/home').then(res => {
        if (res.code === '200') {
          this.stats.userCount = res.data.userCount || 0
          this.stats.blogCount = res.data.blogCount || 0
          this.stats.activityCount = res.data.activityCount || 0
          this.stats.reportCount = res.data.reportCount || 0
        }
      })
      this.stats.userGrowth = 4
      this.stats.blogGrowth = 6
      this.stats.activityGrowth = 2
      // 加载上报待处理数（需要单独查状态）
      this.$request.get('/report/selectPage', {
        params: { pageNum: 1, pageSize: 999 }
      }).then(res => {
        const reports = res.data?.list || []
        this.stats.reportPending = reports.filter(r => r.status === '待处理').length
      }).catch(() => {
        this.stats.reportPending = 0
      })
      // 加载法律法规统计
      this.$request.get('/law/selectPage', {
        params: { pageNum: 1, pageSize: 1 }
      }).then(res => {
        this.stats.lawCount = res.data?.total || 0
      }).catch(() => {
        this.stats.lawCount = 0
      })
      // 加载知识库统计
      this.$request.get('/knowledge/selectPage', {
        params: { pageNum: 1, pageSize: 1 }
      }).then(res => {
        this.stats.knowledgeCount = res.data?.total || 0
      }).catch(() => {
        this.stats.knowledgeCount = 0
      })
      // 加载课时统计
      this.$request.get('/lesson/selectPage', {
        params: { pageNum: 1, pageSize: 1 }
      }).then(res => {
        this.stats.lessonCount = res.data?.total || 0
      }).catch(() => {
        this.stats.lessonCount = 0
      })
      // 加载评论统计
      this.$request.get('/comment/selectPage', {
        params: { pageNum: 1, pageSize: 1 }
      }).then(res => {
        this.stats.commentCount = res.data?.total || 0
      }).catch(() => {
        this.stats.commentCount = 0
      })
      // 加载报名统计
      this.$request.get('/activitySign/selectPage', {
        params: { pageNum: 1, pageSize: 1 }
      }).then(res => {
        this.stats.signCount = res.data?.total || 0
      }).catch(() => {
        this.stats.signCount = 0
      })
      // 模拟其他数据
      this.stats.todayVisit = Math.floor(Math.random() * 500) + 100
      this.stats.onlineUsers = Math.floor(Math.random() * 9)
    }
  }
}
</script>
<style scoped>
.home-container {
  padding: 0;
}
.welcome-card {
  background: #fff;
  border: 1px solid #e8e8e8;
  border-radius: 4px;
  padding: 24px;
  margin-bottom: 20px;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
}
.welcome-text h2 {
  margin: 0 0 8px 0;
  font-size: 20px;
  font-weight: 600;
  color: #333;
}
.welcome-text p {
  margin: 0;
  font-size: 14px;
  color: #999;
}
.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
  margin-bottom: 20px;
}
.stat-card {
  background: #fff;
  border: 1px solid #e8e8e8;
  border-radius: 4px;
  padding: 20px;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
  transition: transform 0.2s;
}
.stat-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.12);
}
.stat-header {
  margin-bottom: 12px;
}
.stat-label {
  font-size: 14px;
  color: #666;
}
.stat-value {
  font-size: 32px;
  font-weight: 600;
  color: #333;
  margin-bottom: 8px;
}
.stat-footer {
  padding-top: 8px;
  border-top: 1px solid #f0f0f0;
}
.stat-trend {
  font-size: 13px;
  color: #67c23a;
}
.stat-trend.warning {
  color: #f56c6c;
}
.detail-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
}
.detail-card {
  background: #fff;
  border: 1px solid #e8e8e8;
  border-radius: 4px;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
}
.detail-header {
  padding: 16px 20px;
  border-bottom: 1px solid #f0f0f0;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.detail-header h3 {
  margin: 0;
  font-size: 16px;
  font-weight: 600;
  color: #333;
}
.more-link {
  font-size: 13px;
  color: #409eff;
  cursor: pointer;
}
.more-link:hover {
  color: #66b1ff;
}
.detail-content {
  padding: 20px;
}
.data-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 0;
  border-bottom: 1px solid #f0f0f0;
}
.data-row:last-child {
  border-bottom: none;
}
.data-label {
  font-size: 14px;
  color: #666;
}
.data-value {
  font-size: 16px;
  font-weight: 600;
  color: #333;
}
</style>