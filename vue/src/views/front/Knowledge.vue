<template>
  <div class="knowledge-container">
    <!-- 页面标题 -->
    <div class="page-header">
      <div class="header-icon">
        <i class="el-icon-reading"></i>
      </div>
      <div class="header-content">
        <h1 class="header-title">治理案例库</h1>
        <p class="header-desc">系统化学习治理知识，全面提升依法治理能力</p>
      </div>
    </div>

    <!-- 分类标签 -->
    <el-card class="category-card">
      <div class="category-section">
        <span class="section-label">知识类型</span>
        <div class="category-list">
          <div 
            class="category-item" 
            :class="{ 'category-item-active': currentType === '' }"
            @click="selectType('')">
            全部
          </div>
          <div 
            class="category-item" 
            :class="{ 'category-item-active': currentType === '治理指南' }"
            @click="selectType('治理指南')">
            治理指南
          </div>
          <div 
            class="category-item" 
            :class="{ 'category-item-active': currentType === '典型案例' }"
            @click="selectType('典型案例')">
            典型案例
          </div>
        </div>
      </div>

      <div v-if="currentType === '治理指南'" class="category-section sub-category">
        <span class="section-label">领域分类</span>
        <div class="category-list">
          <div 
            class="category-item small" 
            :class="{ 'category-item-active': currentCategory === '' }"
            @click="selectCategory('')">
            全部领域
          </div>
          <div 
            class="category-item small" 
            :class="{ 'category-item-active': currentCategory === '矛盾调解' }"
            @click="selectCategory('矛盾调解')">
            矛盾调解
          </div>
          <div 
            class="category-item small" 
            :class="{ 'category-item-active': currentCategory === '安全管理' }"
            @click="selectCategory('安全管理')">
            安全管理
          </div>
          <div 
            class="category-item small" 
            :class="{ 'category-item-active': currentCategory === '环境治理' }"
            @click="selectCategory('环境治理')">
            环境治理
          </div>
        </div>
      </div>
    </el-card>

    <!-- 知识列表 -->
    <div class="knowledge-list">
      <div v-if="tableData.length === 0" class="empty-state">
        <i class="el-icon-folder-opened"></i>
        <p>暂无知识</p>
      </div>
      
      <div 
        v-for="item in tableData" 
        :key="item.id" 
        class="knowledge-item"
        @click="goDetail(item.id)">
        <div v-if="item.cover" class="knowledge-cover">
          <img :src="item.cover" alt="">
        </div>
        
        <div class="knowledge-content">
          <div class="knowledge-header">
            <el-tag 
              class="knowledge-tag"
              :type="item.type === '治理指南' ? 'primary' : 'warning'"
              size="small">
              {{ item.type }}
            </el-tag>
            <el-tag 
              v-if="item.category" 
              class="knowledge-tag"
              size="small"
              type="info">
              {{ item.category }}
            </el-tag>
            <h3 class="knowledge-title">{{ item.title }}</h3>
          </div>
          
          <p class="knowledge-desc">{{ item.descr }}</p>
          
          <div class="knowledge-meta">
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
  name: "FrontKnowledge",
  data() {
    return {
      currentType: '',
      currentCategory: '',
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
      this.currentCategory = ''
      this.load()
    },
    selectCategory(category) {
      this.currentCategory = category
      this.load()
    },
    load() {
      this.$request.get('/knowledge/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          type: this.currentType || null,
          category: this.currentCategory || null,
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
      this.$router.push('/front/knowledgeDetail?id=' + id)
    }
  }
}
</script>

<style scoped>
.knowledge-container {
  width: 80%;
  max-width: 1200px;
  margin: 20px auto;
}

/* 页面标题 */
.page-header {
  background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
  border-radius: 4px;
  padding: 30px;
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  gap: 20px;
  border: 1px solid #e8e8e8;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
}

.header-icon {
  width: 60px;
  height: 60px;
  background: linear-gradient(135deg, #1d3557 0%, #264e78 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.header-icon i {
  font-size: 32px;
  color: #fff;
}

.header-content {
  flex: 1;
}

.header-title {
  font-size: 28px;
  font-weight: 600;
  color: #1a1a1a;
  margin: 0 0 8px 0;
}

.header-desc {
  font-size: 15px;
  color: #606266;
  margin: 0;
  line-height: 1.6;
}

/* 分类卡片 */
.category-card {
  margin-bottom: 20px;
}

.category-section {
  display: flex;
  align-items: center;
  gap: 15px;
}

.category-section.sub-category {
  margin-top: 15px;
  padding-top: 15px;
  border-top: 1px solid #f0f0f0;
}

.section-label {
  font-size: 14px;
  color: #999;
  white-space: nowrap;
}

.category-list {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  flex: 1;
}

.category-item {
  padding: 8px 18px;
  font-size: 14px;
  cursor: pointer;
  transition: background-color 0.2s;
  color: #606266;
  background-color: #f5f7fa;
  user-select: none;
}

.category-item.small {
  padding: 6px 14px;
  font-size: 13px;
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

/* 知识列表 */
.knowledge-list {
  background: #fff;
  border-radius: 4px;
  padding: 24px;
  border: 1px solid #e8e8e8;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
}

/* 空状态 */
.empty-state {
  text-align: center;
  padding: 80px 20px;
}

.empty-state i {
  font-size: 64px;
  color: #ddd;
  margin-bottom: 16px;
}

.empty-state p {
  font-size: 16px;
  color: #999;
  margin: 0;
}

/* 知识项 */
.knowledge-item {
  display: flex;
  gap: 24px;
  padding: 24px;
  cursor: pointer;
  transition: background-color 0.2s;
  border-bottom: 1px solid #f0f0f0;
}

.knowledge-item:last-child {
  border-bottom: none;
}

.knowledge-item:hover {
  background: #f8f9fa;
}

/* 封面图 */
.knowledge-cover {
  width: 220px;
  height: 160px;
  flex-shrink: 0;
  overflow: hidden;
  background: #f5f5f5;
}

.knowledge-cover img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

/* 内容区 */
.knowledge-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  min-width: 0;
}

.knowledge-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 12px;
}

.knowledge-tag {
  flex-shrink: 0;
}

.knowledge-title {
  font-size: 18px;
  font-weight: 600;
  color: #333;
  margin: 0;
  line-height: 1.5;
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.knowledge-item:hover .knowledge-title {
  color: #1d3557;
}

.knowledge-desc {
  font-size: 14px;
  color: #666;
  line-height: 1.8;
  margin: 0 0 16px 0;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

/* 底部元数据 */
.knowledge-meta {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-top: 12px;
  border-top: 1px solid #f0f0f0;
}

.meta-info {
  display: flex;
  gap: 20px;
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
  font-size: 14px;
}

.view-btn {
  font-size: 14px;
  color: #1d3557;
  display: flex;
  align-items: center;
  gap: 4px;
}

.knowledge-item:hover .view-btn {
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
  .knowledge-container {
    width: 95%;
  }
}

@media (max-width: 768px) {
  .knowledge-container {
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
  
  .category-section {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .knowledge-item {
    flex-direction: column;
    padding: 20px;
  }
  
  .knowledge-cover {
    width: 100%;
    height: 180px;
  }
  
  .knowledge-meta {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }
}
</style>



