<template>
  <div class="home-page">
    <!-- 顶部横幅 -->
    <div class="hero-banner">
      <div class="hero-bg"></div>
      <div class="hero-content">
        <h1>网格化依法治理平台</h1>
        <p>推进基层社会治理现代化 · 构建共建共治共享新格局</p>
      </div>
    </div>

    <!-- 功能导航 -->
    <div class="nav-section">
      <div class="container">
        <div class="nav-grid">
          <div class="nav-card" @click="$router.push('/front/law')">
            <div class="nav-icon" style="background:#e8f4fd;color:#1677b3;">
              <i class="el-icon-document"></i>
            </div>
            <div class="nav-text">
              <h3>法律法规</h3>
              <p>政策解读与法规动态</p>
            </div>
          </div>
          <div class="nav-card" @click="$router.push('/front/knowledge')">
            <div class="nav-icon" style="background:#e8f8e8;color:#2e8b57;">
              <i class="el-icon-reading"></i>
            </div>
            <div class="nav-text">
              <h3>治理案例库</h3>
              <p>典型案例与治理指南</p>
            </div>
          </div>
          <div class="nav-card" @click="$router.push('/front/learningClass')">
            <div class="nav-icon" style="background:#fff3e0;color:#d48806;">
              <i class="el-icon-video-camera"></i>
            </div>
            <div class="nav-text">
              <h3>法治培训</h3>
              <p>在线学习培训课程</p>
            </div>
          </div>
          <div class="nav-card" @click="$router.push('/front/report')">
            <div class="nav-icon" style="background:#fde8e8;color:#c0392b;">
              <i class="el-icon-edit-outline"></i>
            </div>
            <div class="nav-text">
              <h3>事件上报</h3>
              <p>网格事件在线上报</p>
            </div>
          </div>
          <div class="nav-card" @click="$router.push('/front/blog')">
            <div class="nav-icon" style="background:#f0e8fd;color:#6a3db5;">
              <i class="el-icon-chat-dot-round"></i>
            </div>
            <div class="nav-text">
              <h3>工作交流</h3>
              <p>网格员经验分享</p>
            </div>
          </div>
          <div class="nav-card" @click="$router.push('/front/activity')">
            <div class="nav-icon" style="background:#e0f2f1;color:#00796b;">
              <i class="el-icon-date"></i>
            </div>
            <div class="nav-text">
              <h3>任务中心</h3>
              <p>治理任务与活动</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 法律法规 -->
    <div class="content-section">
      <div class="container">
        <div class="section-title-bar">
          <div class="title-left">
            <span class="title-line"></span>
            <h2>法律法规</h2>
          </div>
          <a class="more-link" @click="$router.push('/front/law')">
            更多 <i class="el-icon-arrow-right"></i>
          </a>
        </div>
        <div class="article-list">
          <div
            v-for="item in antifraudList"
            :key="item.id"
            class="article-item"
            @click="$router.push('/front/antifraudDetail?id=' + item.id)"
          >
            <img v-if="item.cover" :src="item.cover" class="article-cover" alt="">
            <div class="article-info">
              <el-tag size="mini" :type="item.type === '政策解读' ? 'danger' : item.type === '法规动态' ? 'warning' : 'info'">
                {{ item.type }}
              </el-tag>
              <h3>{{ item.title }}</h3>
              <p>{{ item.descr }}</p>
              <div class="article-meta">
                <span><i class="el-icon-view"></i> {{ item.readCount || 0 }}</span>
                <span><i class="el-icon-time"></i> {{ item.publishTime }}</span>
              </div>
            </div>
          </div>
          <div v-if="antifraudList.length === 0" class="empty-tip">暂无数据</div>
        </div>
      </div>
    </div>

    <!-- 法治培训 -->
    <div class="content-section alt-bg">
      <div class="container">
        <div class="section-title-bar">
          <div class="title-left">
            <span class="title-line"></span>
            <h2>法治培训</h2>
          </div>
          <a class="more-link" @click="$router.push('/front/learningClass')">
            更多 <i class="el-icon-arrow-right"></i>
          </a>
        </div>
        <div class="course-grid">
          <div
            v-for="item in chapterList"
            :key="item.id"
            class="course-card"
            @click="$router.push('/front/learningClass')"
          >
            <img v-if="item.cover" :src="item.cover" class="course-cover" alt="">
            <div class="course-info">
              <h3>{{ item.title }}</h3>
              <p>{{ item.descr }}</p>
              <span class="course-tag">{{ item.lessonCount || 0 }} 课时</span>
            </div>
          </div>
          <div v-if="chapterList.length === 0" class="empty-tip">暂无数据</div>
        </div>
      </div>
    </div>

    <Footer />
  </div>
</template>

<script>
import Footer from "@/components/Footer";

export default {
  name: "FrontIndex",
  components: {
    Footer
  },
  data() {
    return {
      antifraudList: [],
      chapterList: [],
      quizList: []
    }
  },
  created() {
    this.loadAntifraud()
    this.loadChapter()
    this.loadQuiz()
  },
  methods: {
    loadAntifraud() {
      this.$request.get('/law/selectPage', {
        params: { pageNum: 1, pageSize: 4, status: '已发布' }
      }).then(res => {
        this.antifraudList = res.data?.list || []
      })
    },
    loadChapter() {
      this.$request.get('/chapter/selectPage', {
        params: { pageNum: 1, pageSize: 3, status: '已发布' }
      }).then(res => {
        this.chapterList = res.data?.list || []
      })
    },
  }
}
</script>

<style scoped>
.index-page {
  background: #f0f2f5;
}

/* 顶部横幅 */
.hero-banner {
  position: relative;
  height: 260px;
  overflow: hidden;
}
.hero-bg {
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  background: linear-gradient(135deg, #1d3557 0%, #264e78 50%, #2a6496 100%);
}
.hero-content {
  position: relative;
  z-index: 1;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #fff;
  text-align: center;
}
.hero-content h1 {
  font-size: 30px;
  font-weight: 600;
  margin: 0 0 10px 0;
  letter-spacing: 3px;
}
.hero-content > p {
  font-size: 15px;
  margin: 0 0 28px 0;
  color: rgba(255,255,255,0.75);
  letter-spacing: 1px;
}
.hero-stats {
  display: flex;
  align-items: center;
  gap: 0;
  background: rgba(255,255,255,0.1);
  border-radius: 6px;
  padding: 14px 36px;
}
.stat-item {
  text-align: center;
  padding: 0 24px;
}
.stat-num {
  font-size: 26px;
  font-weight: 700;
  color: #fff;
  line-height: 1.2;
}
.stat-label {
  font-size: 12px;
  color: rgba(255,255,255,0.65);
  margin-top: 4px;
}
.stat-divider {
  width: 1px;
  height: 32px;
  background: rgba(255,255,255,0.2);
}

/* 功能导航 */
.nav-section {
  background: #fff;
  padding: 28px 0;
  border-bottom: 1px solid #e8e8e8;
}
.container {
  width: 80%;
  max-width: 1200px;
  margin: 0 auto;
}
.nav-grid {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  gap: 16px;
}
.nav-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 20px 12px;
  cursor: pointer;
  border-radius: 4px;
  transition: background 0.2s;
}
.nav-card:hover {
  background: #f5f7fa;
}
.nav-icon {
  width: 48px;
  height: 48px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 22px;
  margin-bottom: 10px;
}
.nav-text {
  text-align: center;
}
.nav-text h3 {
  margin: 0 0 3px 0;
  font-size: 14px;
  font-weight: 600;
  color: #333;
}
.nav-text p {
  margin: 0;
  font-size: 12px;
  color: #999;
}

/* 内容区块 */
.content-section {
  padding: 36px 0;
  background: #fff;
  margin-bottom: 0;
}
.content-section.alt-bg {
  background: #f7f8fa;
}
.section-title-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
}
.title-left {
  display: flex;
  align-items: center;
  gap: 10px;
}
.title-line {
  display: inline-block;
  width: 4px;
  height: 20px;
  background: #1d3557;
  border-radius: 2px;
}
.section-title-bar h2 {
  margin: 0;
  font-size: 18px;
  font-weight: 600;
  color: #1a1a1a;
}
.more-link {
  font-size: 13px;
  color: #888;
  cursor: pointer;
  transition: color 0.2s;
}
.more-link:hover {
  color: #1d3557;
}

/* 文章列表 */
.article-list {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
}
.article-item {
  display: flex;
  gap: 14px;
  padding: 14px;
  background: #fafbfc;
  border: 1px solid #eee;
  border-radius: 4px;
  cursor: pointer;
  transition: border-color 0.2s, box-shadow 0.2s;
}
.article-item:hover {
  border-color: #c8d6e5;
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}
.article-cover {
  width: 140px;
  height: 100px;
  object-fit: cover;
  border-radius: 3px;
  flex-shrink: 0;
}
.article-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  min-width: 0;
}
.article-info h3 {
  margin: 6px 0;
  font-size: 15px;
  font-weight: 600;
  color: #333;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.article-item:hover .article-info h3 {
  color: #1d3557;
}
.article-info p {
  margin: 0 0 auto 0;
  font-size: 13px;
  color: #777;
  line-height: 1.5;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}
.article-meta {
  display: flex;
  gap: 14px;
  font-size: 12px;
  color: #aaa;
  margin-top: 6px;
}
.article-meta i {
  margin-right: 3px;
}

/* 课程网格 */
.course-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
}
.course-card {
  background: #fff;
  border: 1px solid #eee;
  border-radius: 4px;
  overflow: hidden;
  cursor: pointer;
  transition: border-color 0.2s, box-shadow 0.2s;
}
.course-card:hover {
  border-color: #c8d6e5;
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}
.course-cover {
  width: 100%;
  height: 130px;
  object-fit: cover;
  display: block;
}
.course-info {
  padding: 14px;
}
.course-info h3 {
  margin: 0 0 6px 0;
  font-size: 15px;
  font-weight: 600;
  color: #333;
}
.course-card:hover .course-info h3 {
  color: #1d3557;
}
.course-info p {
  margin: 0 0 10px 0;
  font-size: 13px;
  color: #777;
  line-height: 1.5;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}
.course-tag {
  display: inline-block;
  font-size: 12px;
  color: #1d3557;
  background: #e8f0f8;
  padding: 2px 8px;
  border-radius: 2px;
}

.empty-tip {
  grid-column: 1 / -1;
  text-align: center;
  padding: 40px;
  color: #bbb;
  font-size: 14px;
}

/* 响应式 */
@media (max-width: 1024px) {
  .container { width: 95%; }
  .nav-grid { grid-template-columns: repeat(3, 1fr); }
  .course-grid { grid-template-columns: repeat(2, 1fr); }
}
@media (max-width: 768px) {
  .hero-banner { height: 200px; }
  .hero-content h1 { font-size: 22px; }
  .nav-grid { grid-template-columns: repeat(2, 1fr); }
  .article-list, .course-grid { grid-template-columns: 1fr; }
  .article-item { flex-direction: column; }
  .article-cover { width: 100%; height: 140px; }
}
</style>
