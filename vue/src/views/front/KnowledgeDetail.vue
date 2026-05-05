<template>
  <div class="knowledge-detail-container">
    <!-- 文章头部卡片 -->
    <div class="article-header">
      <div class="article-type">
        <el-tag 
          :type="form.type === '防骗指南' ? 'primary' : 'warning'"
          size="medium">
          {{ form.type }}
        </el-tag>
        <el-tag 
          v-if="form.category" 
          size="medium"
          type="info"
          style="margin-left: 8px">
          {{ form.category }}
        </el-tag>
      </div>
      
      <h1 class="article-title">{{ form.title }}</h1>
      
      <div class="article-meta">
        <span class="meta-item">
          <i class="el-icon-user"></i>
          {{ form.author }}
        </span>
        <span class="meta-item">
          <i class="el-icon-time"></i>
          {{ form.publishTime }}
        </span>
        <span class="meta-item">
          <i class="el-icon-view"></i>
          {{ form.readCount || 0 }}
        </span>
      </div>
    </div>

    <!-- 文章内容卡片 -->
    <div class="article-content-card">
      <!-- 简介摘要 -->
      <div v-if="form.descr" class="article-summary">
        <div class="summary-text">{{ form.descr }}</div>
      </div>

      <!-- 正文内容 -->
      <div class="article-body">
        <div class="w-e-text" v-html="form.content"></div>
      </div>

      <!-- 标签区域 -->
      <div v-if="form.tags" class="article-tags">
        <span class="tags-label">标签</span>
        <div class="tags-list">
          <el-tag 
            v-for="(tag, index) in JSON.parse(form.tags)" 
            :key="index" 
            size="small"
            type="info">
            {{ tag }}
          </el-tag>
        </div>
      </div>

      <!-- 返回按钮 -->
      <div class="article-actions">
        <el-button @click="$router.back()" size="medium">
          <i class="el-icon-back"></i>
          返回列表
        </el-button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "FrontKnowledgeDetail",
  data() {
    return {
      id: this.$route.query.id,
      form: {}
    }
  },
  mounted() {
    this.load()
  },
  methods: {
    load() {
      this.$request.get('/knowledge/selectById/' + this.id).then(res => {
        this.form = res.data || {}
        // 更新浏览量
        this.$request.put('/knowledge/updateReadCount/' + this.id)
      })
    }
  }
}
</script>

<style scoped>
.knowledge-detail-container {
  width: 75%;
  max-width: 960px;
  margin: 20px auto;
}

/* 文章头部 */
.article-header {
  background: #fff;
  border-radius: 4px;
  padding: 35px 40px;
  margin-bottom: 15px;
  text-align: center;
  border: 1px solid #e8e8e8;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
}

.article-type {
  margin-bottom: 18px;
}

.article-title {
  font-size: 28px;
  font-weight: 600;
  color: #1a1a1a;
  line-height: 1.5;
  margin: 0 0 20px 0;
}

.article-meta {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 20px;
  padding-top: 18px;
  border-top: 1px solid #e8e8e8;
}

.meta-item {
  display: flex;
  align-items: center;
  gap: 5px;
  color: #999;
  font-size: 14px;
}

.meta-item i {
  font-size: 14px;
}

/* 文章内容卡片 */
.article-content-card {
  background: #fff;
  border-radius: 4px;
  padding: 35px 40px;
  border: 1px solid #e8e8e8;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
}

/* 简介摘要 */
.article-summary {
  background: #e8f0f8;
  border-left: 3px solid #1d3557;
  padding: 16px 18px;
  margin-bottom: 28px;
  color: #666;
  font-size: 15px;
  line-height: 1.8;
}

.summary-text {
  color: #666;
  font-size: 15px;
  line-height: 1.8;
}

/* 文章正文 */
.article-body {
  font-size: 16px;
  line-height: 1.8;
  color: #333;
  margin-bottom: 30px;
}

/* 标签区域 */
.article-tags {
  padding: 20px 0 0 0;
  border-top: 1px solid #f0f0f0;
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  gap: 10px;
}

.tags-label {
  color: #999;
  font-size: 14px;
}

.tags-list {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

/* 操作按钮 */
.article-actions {
  text-align: center;
  padding-top: 20px;
  border-top: 1px solid #f0f0f0;
}

/* 响应式设计 */
@media (max-width: 1024px) {
  .knowledge-detail-container {
    width: 90%;
  }
}

@media (max-width: 768px) {
  .knowledge-detail-container {
    width: 100%;
    padding: 0 10px;
    margin: 10px auto;
  }
  
  .article-header,
  .article-content-card {
    padding: 24px 20px;
  }
  
  .article-title {
    font-size: 22px;
  }
  
  .article-meta {
    flex-wrap: wrap;
    gap: 15px;
  }
}
</style>

<style>
/* 富文本内容样式 */
.w-e-text {
  font-size: 16px;
  color: #333;
  line-height: 1.8;
}

.w-e-text p {
  margin: 15px 0;
  line-height: 1.8;
}

.w-e-text h1,
.w-e-text h2,
.w-e-text h3,
.w-e-text h4,
.w-e-text h5,
.w-e-text h6 {
  margin: 20px 0 12px 0;
  font-weight: 600;
  color: #1a1a1a;
}

.w-e-text h2 {
  font-size: 22px;
  padding-bottom: 8px;
  border-bottom: 1px solid #e8e8e8;
}

.w-e-text h3 {
  font-size: 18px;
  padding-left: 10px;
  border-left: 3px solid #1d3557;
}

.w-e-text ul,
.w-e-text ol {
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

.w-e-text blockquote {
  border-left: 3px solid #ddd;
  padding: 12px 15px;
  margin: 15px 0;
  background: #f9f9f9;
  color: #666;
}

.w-e-text code {
  background: #f5f5f5;
  padding: 2px 6px;
  margin: 0 3px;
  font-family: 'Courier New', Courier, monospace;
  font-size: 14px;
  color: #d14;
}

.w-e-text pre {
  background: #f5f5f5;
  border: 1px solid #e8e8e8;
  padding: 15px;
  margin: 15px 0;
  overflow-x: auto;
}

.w-e-text pre code {
  background: transparent;
  color: #333;
  padding: 0;
  margin: 0;
}

.w-e-text img {
  max-width: 100%;
  height: auto;
  display: block;
  margin: 18px auto;
}

.w-e-text table {
  width: 100%;
  border-collapse: collapse;
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

.w-e-text a {
  color: #1d3557;
  text-decoration: none;
}

.w-e-text a:hover {
  text-decoration: underline;
}
</style>



