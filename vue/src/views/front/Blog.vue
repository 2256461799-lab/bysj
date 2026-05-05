<template>
  <div class="blog-container">
    <!-- 顶部分类 -->
    <el-card class="category-card">
      <div class="category-header">
        <div class="category-list">
          <div class="category-item" 
               :class="{ 'category-item-active': item.name === current }"
               v-for="item in categoryList" 
               :key="item.id" 
               @click="selectCategory(item.name)">
            {{ item.name }}
          </div>
        </div>
        <el-button type="primary" icon="el-icon-edit" @click="$router.push('/front/publishblog')">
          发布日志
        </el-button>
      </div>
    </el-card>

    <div class="blog-content">
      <!-- 中间主内容 -->
      <div class="main-area">
        <el-card class="content-card">
          <BlogList :categoryName="current"></BlogList>
        </el-card>
      </div>

      <!-- 右侧信息栏 -->
      <div class="sidebar-right">
        <!-- 文章榜单 -->
        <el-card class="ranking-card">
          <div class="card-header">
            <div class="card-title">热门日志</div>
            <div class="refresh-btn" @click="refreshTop">
              <i class="el-icon-refresh"></i> 更新
            </div>
          </div>
          <div class="ranking-list">
            <div v-for="item in showList" 
                 :key="item.id" 
                 class="ranking-item" 
                 @click="$router.push('/front/blogDetail?blogId=' + item.id)">
              <span class="ranking-number" :class="'rank-' + item.index">
                {{ item.index }}
              </span>
              <span class="ranking-title">{{ item.title }}</span>
            </div>
          </div>
        </el-card>

        <!-- 活动推广 -->
        <div class="activity-section">
          <div v-for="item in topActivityList" :key="item.id" class="activity-item">
            <a :href="'/front/activityDetail?activityId=' + item.id" target="_blank">
              <img :src="item.cover" alt="" class="activity-image">
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Footer from "@/components/Footer.vue";
import BlogList from "@/components/BlogList.vue";

export default {
  components: {
    Footer,
    BlogList
  },
  name: "Blog",
  data() {
    return {
      current: '全部日志',
      categoryList: [],
      tableData: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
      topList: [],
      showList: [],
      lastIndex: 0,
      topActivityList: []
    }
  },
  mounted() {
    this.initData()
  },
  
  beforeRouteEnter(to, from, next) {
    next(vm => {
      vm.initData()
    })
  },

  methods: {
    initData() {
      this.current = '全部日志'
      this.categoryList = []
      this.tableData = []
      this.pageNum = 1
      this.pageSize = 10
      this.total = 0
      this.topList = []
      this.showList = []
      this.lastIndex = 0
      this.topActivityList = []

      this.load()
      this.loadBlogs(1)
      this.refreshTop()
      this.loadTopActivity()
    },

    loadTopActivity() {
      this.$request.get('/activity/selectTop').then(res => {
        this.topActivityList = res.data || []
      })
    },
    refreshTop() {
      this.$request.get('/blog/selectTop').then(res => {
        this.topList = res.data || []
        let i = 1
        this.topList.forEach(item => item.index = i++)
        if (this.lastIndex === 20) {
          this.lastIndex = 0
        }
        this.showList = this.topList.slice(this.lastIndex, this.lastIndex + 5)
        this.lastIndex += 5
      })
    },
    selectCategory(categoryName) {
      this.current = categoryName
      this.loadBlogs(1)
    },
    load() {
      this.$request.get('/category/selectAll').then(res => {
        this.categoryList = res.data || []
        this.categoryList.unshift({name: '全部日志'})
      })
    },
    loadBlogs(pageNum) {
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/blog/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          categoryName: this.current === '全部日志' ? null : this.current,
        }
      }).then(res => {
        this.tableData = res.data?.list
        this.total = res.data?.total
      })
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
  }
}
</script>

<style scoped>
.blog-container {
  width: 80%;
  margin: 15px auto;
}
.category-card {
  margin-bottom: 15px;
}
.category-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 20px;
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
.blog-content {
  display: flex;
  gap: 15px;
  align-items: flex-start;
}
.main-area {
  flex: 1;
  min-width: 0;
}
.sidebar-right {
  width: 280px;
  flex-shrink: 0;
}
.ranking-card {
  margin-bottom: 15px;
}
.card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-bottom: 10px;
  border-bottom: 1px solid #e8e8e8;
  margin-bottom: 8px;
}
.card-title {
  font-size: 16px;
  font-weight: 600;
  color: #333;
}
.refresh-btn {
  font-size: 13px;
  color: #999;
  cursor: pointer;
  user-select: none;
}
.refresh-btn:hover {
  color: #1d3557;
}
.refresh-btn i {
  margin-right: 3px;
}
.ranking-list {
  padding: 5px 0;
}
.ranking-item {
  display: flex;
  align-items: center;
  padding: 10px 5px;
  cursor: pointer;
  margin: 2px 0;
}
.ranking-item:hover {
  background-color: #f9f9f9;
}
.ranking-number {
  width: 20px;
  height: 20px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  font-weight: 600;
  margin-right: 10px;
  flex-shrink: 0;
  background-color: #f5f5f5;
  color: #999;
}
.ranking-number.rank-1 {
  background-color: #ffe0e0;
  color: #c0392b;
}
.ranking-number.rank-2 {
  background-color: #fff3e0;
  color: #e6a23c;
}
.ranking-number.rank-3 {
  background-color: #e8f0f8;
  color: #1d3557;
}
.ranking-title {
  flex: 1;
  color: #666;
  font-size: 14px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.ranking-item:hover .ranking-title {
  color: #1d3557;
}
.activity-section {
  margin-bottom: 15px;
}
.activity-item {
  margin-bottom: 10px;
}
.activity-image {
  width: 100%;
  display: block;
}
a {
  text-decoration: none;
  color: inherit;
}
.el-card {
  border: 1px solid #e8e8e8;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.06);
}
.el-card:hover {
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.1);
}
</style>