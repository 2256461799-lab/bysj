<template>
  <div>
    <!-- 搜索区域 -->
    <div style="margin: 10px 0">
      <el-input v-model="type" placeholder="请输入上报类型" style="width: 200px" clearable></el-input>
      <el-input v-model="title" placeholder="请输入标题" style="width: 200px; margin-left: 5px" clearable></el-input>
      <el-select v-model="status" placeholder="请选择状态" style="width: 150px; margin-left: 5px" clearable>
        <el-option label="待处理" value="待处理"></el-option>
        <el-option label="处理中" value="处理中"></el-option>
        <el-option label="已处理" value="已处理"></el-option>
        <el-option label="已关闭" value="已关闭"></el-option>
      </el-select>
      <el-button type="primary" style="margin-left: 5px" @click="load(1)">查询</el-button>
      <el-button type="warning" style="margin-left: 5px" @click="reset">重置</el-button>
    </div>

    <!-- 操作按钮区域 -->
    <div style="margin: 10px 0">
      <el-button type="danger" @click="delBatch">批量删除</el-button>
    </div>

    <!-- 表格区域 -->
    <el-table :data="tableData" stripe @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="ID" width="60"></el-table-column>
      <el-table-column prop="type" label="上报类型" width="100">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.type === '安全隐患'" type="info">{{ scope.row.type }}</el-tag>
          <el-tag v-else type="warning">{{ scope.row.type }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="title" label="标题" width="200" show-overflow-tooltip></el-table-column>
      <el-table-column prop="contactName" label="联系人" width="100"></el-table-column>
      <el-table-column prop="contactPhone" label="联系电话" width="120"></el-table-column>
      <el-table-column prop="address" label="详细地址" width="200" show-overflow-tooltip></el-table-column>
      <el-table-column prop="amount" label="涉及人数" width="100">
        <template slot-scope="scope">
          <span v-if="scope.row.amount" style="color: #F56C6C">{{ scope.row.amount }}人</span>
          <span v-else>-</span>
        </template>
      </el-table-column>
      <el-table-column prop="reportTime" label="上报时间" width="160"></el-table-column>
      <el-table-column prop="status" label="状态" width="100">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.status === '待处理'" type="danger">{{ scope.row.status }}</el-tag>
          <el-tag v-else-if="scope.row.status === '处理中'" type="warning">{{ scope.row.status }}</el-tag>
          <el-tag v-else-if="scope.row.status === '已处理'" type="success">{{ scope.row.status }}</el-tag>
          <el-tag v-else type="info">{{ scope.row.status }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="280" fixed="right">
        <template slot-scope="scope">
          <el-button size="mini" type="primary" @click="handleView(scope.row)">查看</el-button>
          <el-button size="mini" type="success" @click="handleProcess(scope.row)">处理</el-button>
          <el-button size="mini" type="danger" @click="del(scope.row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <div style="margin: 10px 0">
      <el-pagination
        @current-change="handleCurrentChange"
        :current-page="pageNum"
        :page-size="pageSize"
        layout="total, prev, pager, next"
        :total="total">
      </el-pagination>
    </div>

    <!-- 查看详情对话框 -->
    <el-dialog title="上报详情" :visible.sync="viewDialogVisible" width="60%" :close-on-click-modal="false">
      <el-descriptions :column="2" border>
        <el-descriptions-item label="上报类型">
          <el-tag v-if="form.type === '安全隐患'" type="info">{{ form.type }}</el-tag>
          <el-tag v-else type="warning">{{ form.type }}</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="状态">
          <el-tag v-if="form.status === '待处理'" type="danger">{{ form.status }}</el-tag>
          <el-tag v-else-if="form.status === '处理中'" type="warning">{{ form.status }}</el-tag>
          <el-tag v-else-if="form.status === '已处理'" type="success">{{ form.status }}</el-tag>
          <el-tag v-else type="info">{{ form.status }}</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="上报标题" :span="2">{{ form.title }}</el-descriptions-item>
        <el-descriptions-item label="详细内容" :span="2">
          <div v-html="form.content" style="max-height: 300px; overflow-y: auto"></div>
        </el-descriptions-item>
        <el-descriptions-item label="联系人">{{ form.contactName }}</el-descriptions-item>
        <el-descriptions-item label="联系电话">{{ form.contactPhone }}</el-descriptions-item>
        <el-descriptions-item label="详细地址" :span="2">{{ form.address || '-' }}</el-descriptions-item>
        <el-descriptions-item label="涉及地点" :span="2">{{ form.suspectPhone || '-' }}</el-descriptions-item>
        <el-descriptions-item label="所属网格" :span="2">{{ form.suspectAccount || '-' }}</el-descriptions-item>
        <el-descriptions-item label="关联信息" :span="2">{{ form.suspectLink || '-' }}</el-descriptions-item>
        <el-descriptions-item label="涉及人数" :span="2">
          <span v-if="form.amount" style="color: #F56C6C; font-weight: bold">{{ form.amount }} 人</span>
          <span v-else>-</span>
        </el-descriptions-item>
        <el-descriptions-item label="证据材料" :span="2">
          <div v-if="form.evidence">
            <img v-for="(img, index) in form.evidence.split(',')" :key="index"
                 :src="img" style="width: 100px; height: 100px; margin-right: 10px; cursor: pointer"
                 @click="previewImage(img)">
          </div>
          <span v-else>-</span>
        </el-descriptions-item>
        <el-descriptions-item label="上报时间" :span="2">{{ form.reportTime }}</el-descriptions-item>
        <el-descriptions-item label="处理人">{{ form.handler || '-' }}</el-descriptions-item>
        <el-descriptions-item label="处理时间">{{ form.handleTime || '-' }}</el-descriptions-item>
        <el-descriptions-item label="处理结果" :span="2">
          <div v-html="form.handleResult || '-'" style="max-height: 200px; overflow-y: auto"></div>
        </el-descriptions-item>
      </el-descriptions>
      <div slot="footer">
        <el-button @click="viewDialogVisible = false">关闭</el-button>
      </div>
    </el-dialog>

    <!-- 处理对话框（4状态完整支持） -->
    <el-dialog title="处理上报" :visible.sync="processDialogVisible" width="50%" :close-on-click-modal="false">
      <el-form :model="form" label-width="100px">
        <el-form-item label="上报标题">
          <span>{{ form.title }}</span>
        </el-form-item>
        <el-form-item label="处理状态">
          <el-select v-model="form.status" placeholder="请选择状态" style="width: 100%">
            <el-option label="待处理" value="待处理"></el-option>
            <el-option label="处理中" value="处理中"></el-option>
            <el-option label="已处理" value="已处理"></el-option>
            <el-option label="已关闭" value="已关闭"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="处理人">
          <el-input v-model="form.handler" placeholder="请输入处理人姓名"></el-input>
        </el-form-item>
        <el-form-item label="处理结果">
          <el-input type="textarea" v-model="form.handleResult" :rows="6"
                    placeholder="请输入处理结果和反馈意见"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer">
        <el-button @click="processDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="saveProcess">保存</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "ManagerReport",
  data() {
    return {
      type: '',
      title: '',
      status: '',
      tableData: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
      form: {},
      viewDialogVisible: false,
      processDialogVisible: false,
      ids: []
    }
  },
  created() {
    this.load(1)
  },
  methods: {
    load(pageNum) {
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/report/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          type: this.type || null,
          title: this.title || null,
          status: this.status || null
        }
      }).then(res => {
        this.tableData = res.data?.list || []
        this.total = res.data?.total || 0
      })
    },
    reset() {
      this.type = ''
      this.title = ''
      this.status = ''
      this.load(1)
    },
    handleView(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.viewDialogVisible = true
    },
    // 打开弹窗：保留原始状态，不强制覆盖
    handleProcess(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.form.handler = this.form.handler || ''
      this.form.handleResult = this.form.handleResult || ''
      this.processDialogVisible = true
    },
    // 提交：4个状态全部生效，无硬编码
    saveProcess() {
      if (!this.form.status) return this.$message.warning('请选择处理状态')
      if (!this.form.handler) return this.$message.warning('请输入处理人')
      if (!this.form.handleResult) return this.$message.warning('请输入处理结果')

      // 标准时间格式化
      const now = new Date()
      const handleTime = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-${String(now.getDate()).padStart(2, '0')} ${String(now.getHours()).padStart(2, '0')}:${String(now.getMinutes()).padStart(2, '0')}:${String(now.getSeconds()).padStart(2, '0')}`

      // 提交数据（完全跟随下拉框选择）
      const submitData = {
        id: this.form.id,
        status: this.form.status,
        handler: this.form.handler,
        handleResult: this.form.handleResult,
        handleTime: handleTime
      }

      this.$request.put('/report/update', submitData).then(res => {
        if (res.code === '200') {
          this.$message.success('处理成功')
          this.processDialogVisible = false
          this.load(this.pageNum)
        } else {
          this.$message.error(res.msg || '处理失败')
        }
      })
    },
    del(id) {
      this.$confirm('您确定删除吗？', '确认删除', {type: "warning"}).then(() => {
        this.$request.delete('/report/delete/' + id).then(res => {
          if (res.code === '200') {
            this.$message.success('删除成功')
            this.load(1)
          }
        })
      }).catch(() => {})
    },
    handleSelectionChange(rows) {
      this.ids = rows.map(v => v.id)
    },
    delBatch() {
      if (!this.ids.length) return this.$message.warning('请选择数据')
      this.$confirm('您确定批量删除吗？', '提示', {type: "warning"}).then(() => {
        this.$request.delete('/report/delete/batch', {data: this.ids}).then(res => {
          if (res.code === '200') {
            this.$message.success('批量删除成功')
            this.load(1)
          }
        })
      }).catch(() => {})
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
    previewImage(url) {
      window.open(url)
    }
  }
}
</script>

<style scoped>
</style>