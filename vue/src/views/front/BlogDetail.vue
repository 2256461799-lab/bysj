<template>
  <div class="blog-detail-container">
    <!-- 文章头部卡片 -->
    <div class="article-header">
      <div class="article-type">
        <el-tag 
          type="primary"
          size="medium">
          {{ blog.categoryName || '交流互动' }}
        </el-tag>
      </div>
      
      <h1 class="article-title">{{ blog.title }}</h1>
      
      <div class="article-meta">
        <span class="meta-item">
          <i class="el-icon-user"></i>
          {{ blog.userName }}
        </span>
        <span class="meta-item">
          <i class="el-icon-time"></i>
          {{ blog.date }}
        </span>
        <span class="meta-item">
          <i class="el-icon-view"></i>
          {{ blog.readCount || 0 }}
        </span>
      </div>
    </div>

    <!-- 文章内容卡片 -->
    <div class="article-content-card">
      <!-- 简介摘要 -->
      <div v-if="blog.descr" class="article-summary">
        <div class="summary-text">{{ blog.descr }}</div>
      </div>

      <!-- 正文内容 -->
      <div class="article-body">
        <div class="w-e-text" v-html="blog.content"></div>
      </div>

      <!-- 标签区域 -->
      <div v-if="tagsArr.length > 0" class="article-tags">
        <span class="tags-label">标签</span>
        <div class="tags-list">
          <el-tag 
            v-for="(tag, index) in tagsArr" 
            :key="index" 
            size="small"
            type="info">
            {{ tag }}
          </el-tag>
        </div>
      </div>

      <!-- 操作按钮区域 -->
      <div class="article-actions">
        <el-button 
          :type="blog.userLike ? 'warning' : 'default'"
          :icon="blog.userLike ? 'el-icon-star-on' : 'el-icon-star-off'"
          @click="setLikes"
          size="medium">
          点赞 {{ blog.likesCount || 0 }}
        </el-button>
        <el-button 
          :type="blog.userCollect ? 'warning' : 'default'"
          :icon="blog.userCollect ? 'el-icon-collection' : 'el-icon-collection-tag'"
          @click="setCollect"
          size="medium">
          收藏 {{ blog.collectCount || 0 }}
        </el-button>
        <el-button 
          @click="$router.back()" 
          size="medium">
          <i class="el-icon-back"></i>
          返回列表
        </el-button>
      </div>
    </div>
    
    <!-- 评论区 -->
    <div class="comment-wrapper">
      <Comment :fid="blogId" module="帖子"></Comment>
    </div>
    
    <Footer/>
  </div>
</template>

<script>
import Footer from "@/components/Footer";
import Comment from "@/components/Comment.vue";
export default {
  name: "BlogDetail",
  components: {
    Comment,
    Footer
  },
  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      blogId: parseInt(this.$route.query.blogId),  // 转换为数字
      blog: {},
      tagsArr: [],
      recommendList: []
    }
  },
  created() {
    this.load()
    this.$request.put('/blog/updateReadCount/' + this.blogId)
  },
  methods: {
    setLikes() {
      console.log('当前用户:', this.user)
      if (!this.user.id) {
        this.$message.warning('请先登录')
        this.$router.push('/login')
        return
      }
      console.log('发送点赞请求:', {fid: this.blogId, module: '博客'})
      this.$request.post('/likes/set', {fid: this.blogId, module: '博客'}).then(res => {
        console.log('点赞响应:', res)
        if (res.code === '200') {
          this.$message.success('操作成功')
          this.load()  // 重新加载数据
        } else {
          this.$message.error(res.msg || '操作失败')
        }
      }).catch(err => {
        console.error('点赞失败:', err)
        this.$message.error('操作失败，请稍后重试')
      })
    },
    setCollect() {
      if (!this.user.id) {
        this.$message.warning('请先登录')
        this.$router.push('/login')
        return
      }
      this.$request.post('/collect/set', {fid: this.blogId, module: '博客'}).then(res => {
        if (res.code === '200') {
          this.$message.success('操作成功')
          this.load()  // 重新加载数据
        } else {
          this.$message.error(res.msg || '操作失败')
        }
      }).catch(err => {
        console.error('收藏失败:', err)
        this.$message.error('操作失败，请稍后重试')
      })
    },
    load() {
      console.log('加载博客数据, blogId:', this.blogId)
      this.$request.get('/blog/selectById/' + this.blogId).then(res => {
        console.log('博客数据响应:', res)
        this.blog = res.data || {}
        console.log('博客点赞状态:', {
          likesCount: this.blog.likesCount,
          userLike: this.blog.userLike,
          collectCount: this.blog.collectCount,
          userCollect: this.blog.userCollect
        })
        this.tagsArr = JSON.parse(this.blog.tags || '[]')
      })

      this.$request.get('/blog/selectRecommend/' + this.blogId).then(res => {
        this.recommendList = res.data || []
      })
    }
  }
}
</script>

<style scoped>
.blog-detail-container {
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
  margin-bottom: 15px;
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
  display: flex;
  justify-content: center;
  gap: 15px;
}

/* 评论区 */
.comment-wrapper {
  background: #fff;
  border-radius: 4px;
  padding: 35px 40px;
  border: 1px solid #e8e8e8;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
  margin-bottom: 15px;
}

/* 响应式设计 */
@media (max-width: 1024px) {
  .blog-detail-container {
    width: 90%;
  }
}

@media (max-width: 768px) {
  .blog-detail-container {
    width: 100%;
    padding: 0 10px;
    margin: 10px auto;
  }
  
  .article-header,
  .article-content-card,
  .comment-wrapper {
    padding: 24px 20px;
  }
  
  .article-title {
    font-size: 22px;
  }
  
  .article-meta {
    flex-wrap: wrap;
    gap: 15px;
  }
  
  .article-actions {
    flex-direction: column;
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
