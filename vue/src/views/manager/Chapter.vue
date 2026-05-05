<template>
  <div>
    <!-- 搜索区域 -->
    <div style="margin: 10px 0">
      <el-input v-model="title" placeholder="请输入章节标题" style="width: 200px" clearable></el-input>
      <el-select v-model="status" placeholder="请选择状态" style="width: 150px; margin-left: 5px" clearable>
        <el-option label="已发布" value="已发布"></el-option>
        <el-option label="草稿" value="草稿"></el-option>
      </el-select>
      <el-button type="primary" style="margin-left: 5px" @click="load(1)">查询</el-button>
      <el-button type="warning" style="margin-left: 5px" @click="reset">重置</el-button>
    </div>

    <!-- 操作按钮 -->
    <div style="margin: 10px 0">
      <el-button type="primary" @click="handleAdd">新增 <i class="el-icon-circle-plus-outline"></i></el-button>
      <el-button type="danger" @click="delBatch">批量删除 <i class="el-icon-remove-outline"></i></el-button>
    </div>

    <!-- 数据表格 -->
    <el-table :data="tableData" stripe @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="ID" width="60"></el-table-column>
      <el-table-column prop="title" label="章节标题" min-width="200"></el-table-column>
      <el-table-column prop="descr" label="简介" min-width="250" show-overflow-tooltip></el-table-column>
      <el-table-column prop="sortOrder" label="排序" width="80" sortable></el-table-column>
      <el-table-column prop="createTime" label="创建时间" width="150"></el-table-column>
      <el-table-column prop="status" label="状态" width="100">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.status === '已发布'" type="success" size="small">{{ scope.row.status }}</el-tag>
          <el-tag v-else type="info" size="small">{{ scope.row.status }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="200" align="center">
        <template slot-scope="scope">
          <el-button size="mini" type="primary" @click="handleEdit(scope.row)">编辑</el-button>
          <el-button size="mini" type="danger" @click="del(scope.row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <div style="margin: 10px 0">
      <el-pagination
        @current-change="handleCurrentChange"
        :current-page="pageNum"
        :page-sizes="[5, 10, 20]"
        :page-size="pageSize"
        layout="total, prev, pager, next"
        :total="total">
      </el-pagination>
    </div>

    <!-- 新增/编辑弹窗 -->
    <el-dialog title="课堂章节" :visible.sync="dialogVisible" width="60%" :close-on-click-modal="false">
      <el-form :model="form" label-width="100px" :rules="rules" ref="formRef">
        <el-form-item label="章节标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入章节标题"></el-input>
        </el-form-item>
        <el-form-item label="章节简介" prop="descr">
          <el-input type="textarea" v-model="form.descr" :rows="3" placeholder="请输入章节简介"></el-input>
        </el-form-item>
        <el-form-item label="封面图">
          <el-upload
            :action="$baseUrl + '/files/upload'"
            :headers="{token: user.token}"
            list-type="picture"
            :on-success="handleImgSuccess"
          >
            <el-button size="small" type="primary">点击上传</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item label="排序">
          <el-input-number v-model="form.sortOrder" :min="0" :max="999" placeholder="排序"></el-input-number>
          <span style="color: #909399; margin-left: 10px; font-size: 12px">数字越小越靠前</span>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="已发布">已发布</el-radio>
            <el-radio label="草稿">草稿</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: 'ManagerChapter',
  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      title: '',
      status: '',
      tableData: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
      dialogVisible: false,
      form: {},
      rules: {
        title: [
          { required: true, message: '请输入章节标题', trigger: 'blur' }
        ],
        descr: [
          { required: true, message: '请输入章节简介', trigger: 'blur' }
        ],
        status: [
          { required: true, message: '请选择状态', trigger: 'change' }
        ]
      },
      ids: []
    }
  },
  created() {
    this.load(1)
  },
  methods: {
    load(pageNum) {
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/chapter/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          title: this.title,
          status: this.status
        }
      }).then(res => {
        if (res.code === '200') {
          this.tableData = res.data?.list || []
          this.total = res.data?.total || 0
        }
      })
    },
    reset() {
      this.title = ''
      this.status = ''
      this.load(1)
    },
    handleAdd() {
      this.form = { sortOrder: 0, status: '已发布' }
      this.dialogVisible = true
      this.$nextTick(() => {
        if (this.$refs.formRef) {
          this.$refs.formRef.clearValidate()
        }
      })
    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogVisible = true
      this.$nextTick(() => {
        if (this.$refs.formRef) {
          this.$refs.formRef.clearValidate()
        }
      })
    },
    save() {
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.$request({
            url: this.form.id ? '/chapter/update' : '/chapter/add',
            method: this.form.id ? 'PUT' : 'POST',
            data: this.form
          }).then(res => {
            if (res.code === '200') {
              this.$message.success('保存成功')
              this.dialogVisible = false
              this.load(1)
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    },
    del(id) {
      this.$confirm('确认删除该章节吗？', '提示', { type: 'warning' }).then(() => {
        this.$request.delete('/chapter/delete/' + id).then(res => {
          if (res.code === '200') {
            this.$message.success('删除成功')
            this.load(1)
          } else {
            this.$message.error(res.msg)
          }
        })
      }).catch(() => {})
    },
    handleSelectionChange(rows) {
      this.ids = rows.map(v => v.id)
    },
    delBatch() {
      if (!this.ids.length) {
        this.$message.warning('请选择要删除的数据')
        return
      }
      this.$confirm('确认批量删除这些章节吗？', '提示', { type: 'warning' }).then(() => {
        this.$request.delete('/chapter/delete/batch', { data: this.ids }).then(res => {
          if (res.code === '200') {
            this.$message.success('批量删除成功')
            this.load(1)
          } else {
            this.$message.error(res.msg)
          }
        })
      }).catch(() => {})
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
    handleImgSuccess(res) {
      if (res.code === '200') {
        this.form.cover = res.data
        this.$message.success('上传成功')
      }
    }
  }
}
</script>

<style scoped>
</style>








