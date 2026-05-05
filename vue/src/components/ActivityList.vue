<template>
  <div class="activity-container">
    <el-row :gutter="24" v-if="total" class="activity-grid">
      <el-col :span="8" v-for="item in tableData" :key="item.id">
        <div class="activity-card" @click="goDetail(item.id)">
          <div class="activity-cover">
            <img :src="item.cover" alt="">
            <div class="activity-status" v-if="item.isEnd">已结束</div>
            <div class="activity-status signed" v-else-if="item.isSign">已报名</div>
          </div>
          <div class="activity-content">
            <div class="activity-title">{{ item.name }}</div>
            <div class="activity-footer">
              <div class="activity-time">
                <i class="el-icon-time"></i>
                <span>{{ item.start }}</span>
              </div>
              <el-button 
                class="activity-btn" 
                :class="{ 'btn-disabled': item.isEnd || item.isSign }"
                size="small" 
                type="primary" 
                :disabled="item.isEnd || item.isSign">
                {{ item.isEnd ? '已结束' : item.isSign ? '已报名' : '立即报名' }}
              </el-button>
            </div>
          </div>
        </div>
      </el-col>
    </el-row>

    <div class="empty-state" v-if="total === 0">
      <i class="el-icon-document-delete"></i>
      <p>暂无活动数据</p>
    </div>

    <div class="pagination-wrapper" v-if="total">
      <el-pagination
          background
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-size="pageSize"
          layout="total, prev, pager, next"
          :total="total">
      </el-pagination>
    </div>

    <Footer />
  </div>
</template>

<script>

export default {
  name: "ActivityList",
  props: {
    type: null,
    span: null
  },
  data() {
    return {
      tableData: [],  // 所有的数据
      pageNum: 1,   // 当前的页码
      pageSize: 8,  // 每页显示的个数
      total: 0,
      name: null,
    }
  },
  created() {
    this.load(1)
  },
  methods: {
    goDetail(id) {
      window.open('/front/activityDetail?activityId=' + id)
    },
    load(pageNum) {  // 分页查询
      if (pageNum) this.pageNum = pageNum
      let url
      switch (this.type) {
        case 'user': url = '/activity/selectUser'; break;
        case 'like': url = '/activity/selectLike'; break;
        case 'collect': url = '/activity/selectCollect'; break;
        case 'comment': url = '/activity/selectComment'; break;
        default: url = '/activity/selectPage'
      }
      this.$request.get(url, {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          name: this.name,
        }
      }).then(res => {
        this.tableData = res.data?.list
        this.total = res.data?.total
      })
    },
    reset() {
      this.name = null
      this.load(1)
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
  }
}
</script>

<style scoped>
.activity-container {
  width: 90%;
  max-width: 1400px;
  margin: 20px auto;
  padding: 0 20px;
}

.activity-grid {
  margin-bottom: 30px;
}

/* 活动卡片 */
.activity-card {
  background: #fff;
  border-radius: 4px;
  overflow: hidden;
  margin-bottom: 24px;
  cursor: pointer;
  transition: box-shadow 0.2s;
  border: 1px solid #e8e8e8;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
  height: 100%;
  display: flex;
  flex-direction: column;
}

.activity-card:hover {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.12);
  border-color: #c0c4cc;
}

/* 封面图 */
.activity-cover {
  position: relative;
  width: 100%;
  height: 220px;
  overflow: hidden;
  background: #f5f5f5;
  flex-shrink: 0;
}

.activity-cover img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

/* 活动状态标签 */
.activity-status {
  position: absolute;
  top: 10px;
  right: 10px;
  padding: 4px 10px;
  background: rgba(0, 0, 0, 0.65);
  color: #fff;
  font-size: 12px;
}

.activity-status.signed {
  background: rgba(29, 53, 87, 0.85);
}

/* 活动内容 */
.activity-content {
  padding: 18px;
  flex: 1;
  display: flex;
  flex-direction: column;
}

.activity-title {
  font-size: 16px;
  font-weight: 600;
  color: #333;
  margin-bottom: 14px;
  line-height: 1.6;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  height: 51px;
  flex-shrink: 0;
}

/* 活动底部 */
.activity-footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-top: 14px;
  border-top: 1px solid #f0f0f0;
  margin-top: auto;
}

.activity-time {
  display: flex;
  align-items: center;
  color: #999;
  font-size: 13px;
}

.activity-time i {
  margin-right: 6px;
  font-size: 14px;
}

/* 报名按钮 */
.activity-btn {
  padding: 6px 16px;
  font-size: 13px;
  font-weight: 500;
}

.activity-btn.btn-disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

/* 空状态 */
.empty-state {
  background: #fff;
  border-radius: 4px;
  padding: 50px 20px;
  text-align: center;
  margin-bottom: 20px;
  border: 1px solid #e8e8e8;
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

/* 分页 */
.pagination-wrapper {
  background: #fff;
  border-radius: 4px;
  padding: 20px;
  text-align: center;
  margin-bottom: 30px;
  border: 1px solid #e8e8e8;
}

/* 响应式优化 */
@media (max-width: 1200px) {
  .activity-container {
    width: 95%;
  }
}

@media (max-width: 768px) {
  .activity-container {
    width: 100%;
    padding: 0 10px;
  }
  
  .activity-cover {
    height: 180px;
  }
  
  .activity-content {
    padding: 16px;
  }
}
</style>
