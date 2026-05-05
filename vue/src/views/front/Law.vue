<template>
  <div class="law-container">
    <!-- 页面标题 -->
    <div class="page-header">
      <div class="header-icon">
        <i class="el-icon-warning"></i>
      </div>
      <div class="header-content">
        <h1 class="header-title">法律法规</h1>
        <p class="header-desc">依法治理，服务群众。了解最新法规政策，提升治理能力</p>
      </div>
    </div>

    <!-- 分类标签 -->
    <el-card class="category-card">
      <div class="category-list">
        <div 
          class="category-item" 
          :class="{ 'category-item-active': currentType === '' }"
          @click="selectType('')">
          全部
        </div>
        <div 
          class="category-item" 
          :class="{ 'category-item-active': currentType === '政策解读' }"
          @click="selectType('政策解读')">
          政策解读
        </div>
        <div 
          class="category-item" 
          :class="{ 'category-item-active': currentType === '法规动态' }"
          @click="selectType('法规动态')">
          法规动态
        </div>
      </div>
    </el-card>

    <!-- 资讯列表 -->
    <div class="news-list">
      <div v-if="tableData.length === 0" class="empty-state">
        <i class="el-icon-folder-opened"></i>
        <p>暂无资讯</p>
      </div>
      
      <div 
        v-for="item in tableData" 
        :key="item.id" 
        class="news-item"
        @click="goDetail(item.id)">
        <div v-if="item.cover" class="news-cover">
          <img :src="item.cover" alt="">
        </div>
        
        <div class="news-content">
          <div class="news-header">
            <el-tag 
              class="news-tag"
              :type="item.type === '政策解读' ? 'danger' : item.type === '法规动态' ? 'warning' : 'info'"
              size="small">
              {{ item.type }}
            </el-tag>
            <h3 class="news-title">{{ item.title }}</h3>
          </div>
          
          <p class="news-desc">{{ item.descr }}</p>
          
          <div class="news-meta">
            <div class="meta-info">
              <span class="meta-item">
                <i class="el-icon-user"></i>
                {{ item.author }}
              </span>
              <span class="meta-item">
                <i class="el-icon-time"></i>
                {{ item.publishTime }}
              </span>
              <span class="meta-item">
                <i class="el-icon-view"></i>
                {{ item.readCount || 0 }}
              </span>
            </div>
            <div class="view-btn">
              查看详情 <i class="el-icon-arrow-right"></i>
            </div>
          </div>
        </div>
      </div>

      <!-- 分页 -->
      <div class="pagination-wrapper" v-if="total > 0">
        <el-pagination
          background
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-size="pageSize"
          layout="total, prev, pager, next"
          :total="total">
        </el-pagination>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "FrontLaw",
  data() {
    return {
      currentType: '',
      tableData: [],
      pageNum: 1,
      pageSize: 10,
      total: 0
    }
  },
  mounted() {
    this.load()
  },
  methods: {
    selectType(type) {
      this.currentType = type
      this.load()
    },
    load() {
      this.$request.get('/law/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          type: this.currentType || null,
          status: '已发布'
        }
      }).then(res => {
        this.tableData = res.data?.list || []
        this.total = res.data?.total || 0
      })
    },
    handleCurrentChange(pageNum) {
      this.pageNum = pageNum
      this.load()
    },
    goDetail(id) {
      this.$router.push('/front/lawDetail?id=' + id)
    }
  }
}
</script>

<style scoped>
.law-container {
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

/* 顶部分类卡片 */
.category-card {
  border-radius: 4px;
  margin-bottom: 15px;
}

.category-list {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.category-item {
  padding: 8px 20px;
  font-size: 14px;
  cursor: pointer;
  transition: background-color 0.2s;
  color: #606266;
  background-color: #f5f7fa;
  user-select: none;
}

.category-item:hover {
  background-color: #e8f0f8;
  color: #1d3557;
}

.category-item-active {
  background-color: #1d3557;
  color: #fff;
}

.category-item-active:hover {
  background-color: #264e78;
}

/* 资讯列表 */
.news-list {
  background: #fff;
  border-radius: 4px;
  padding: 20px;
  border: 1px solid #e8e8e8;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
}

/* 空状态 */
.empty-state {
  text-align: center;
  padding: 60px 20px;
}

.empty-state i {
  font-size: 56px;
  color: #ddd;
  margin-bottom: 12px;
}

.empty-state p {
  font-size: 14px;
  color: #999;
  margin: 0;
}

/* 资讯项 */
.news-item {
  display: flex;
  gap: 20px;
  padding: 20px;
  cursor: pointer;
  transition: background-color 0.2s;
  border-bottom: 1px solid #f0f0f0;
}

.news-item:last-child {
  border-bottom: none;
}

.news-item:hover {
  background: #f8f9fa;
}

/* 封面图 */
.news-cover {
  width: 220px;
  height: 160px;
  flex-shrink: 0;
  overflow: hidden;
  background: #f5f5f5;
}

.news-cover img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

/* 内容区 */
.news-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  min-width: 0;
}

.news-header {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 10px;
}

.news-tag {
  flex-shrink: 0;
}

.news-title {
  font-size: 17px;
  font-weight: 600;
  color: #333;
  margin: 0;
  line-height: 1.5;
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.news-item:hover .news-title {
  color: #1d3557;
}

.news-desc {
  font-size: 14px;
  color: #666;
  line-height: 1.7;
  margin: 0 0 14px 0;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

/* 底部元数据 */
.news-meta {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-top: 10px;
  border-top: 1px solid #f0f0f0;
}

.meta-info {
  display: flex;
  gap: 16px;
  flex-wrap: wrap;
}

.meta-item {
  display: flex;
  align-items: center;
  gap: 5px;
  font-size: 13px;
  color: #999;
}

.meta-item i {
  font-size: 13px;
}

.view-btn {
  font-size: 13px;
  color: #1d3557;
  display: flex;
  align-items: center;
  gap: 4px;
}

.news-item:hover .view-btn {
  color: #264e78;
}

/* 分页 */
.pagination-wrapper {
  margin-top: 24px;
  padding-top: 24px;
  border-top: 1px solid #f0f0f0;
  text-align: center;
}

/* 响应式设计 */
@media (max-width: 1024px) {
  .law-container {
    width: 95%;
  }
}

@media (max-width: 768px) {
  .law-container {
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
    font-size: 24px;
  }
  
  .news-item {
    flex-direction: column;
    padding: 20px;
  }
  
  .news-cover {
    width: 100%;
    height: 180px;
  }
  
  .news-meta {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }
}
</style>

