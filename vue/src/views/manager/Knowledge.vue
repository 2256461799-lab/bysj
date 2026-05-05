<template>
  <div>
    <!-- 搜索区域 -->
    <div style="margin: 10px 0">
      <el-input v-model="title" placeholder="请输入标题" style="width: 200px" clearable></el-input>
      <el-select v-model="type" placeholder="请选择类型" style="width: 150px; margin-left: 5px" clearable>
        <el-option label="治理指南" value="治理指南"></el-option>
        <el-option label="典型案例" value="典型案例"></el-option>
      </el-select>
      <el-select v-model="category" placeholder="请选择分类" style="width: 150px; margin-left: 5px" clearable>
        <el-option label="矛盾调解" value="矛盾调解"></el-option>
        <el-option label="安全管理" value="安全管理"></el-option>
        <el-option label="环境治理" value="环境治理"></el-option>
      </el-select>
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
      <el-table-column prop="title" label="标题" min-width="200"></el-table-column>
      <el-table-column prop="type" label="类型" width="120">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.type === '治理指南'" type="primary" size="small">{{ scope.row.type }}</el-tag>
          <el-tag v-else type="warning" size="small">{{ scope.row.type }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="category" label="分类" width="120"></el-table-column>
      <el-table-column prop="author" label="发布人" width="120"></el-table-column>
      <el-table-column prop="publishTime" label="发布时间" width="120"></el-table-column>
      <el-table-column prop="readCount" label="浏览量" width="100"></el-table-column>
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
    <el-dialog title="治理案例库" :visible.sync="dialogVisible" width="70%" :close-on-click-modal="false">
      <el-form :model="form" label-width="100px" :rules="rules" ref="formRef">
        <el-form-item label="标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入标题"></el-input>
        </el-form-item>
        <el-form-item label="类型" prop="type">
          <el-select v-model="form.type" placeholder="请选择类型" style="width: 100%" @change="typeChange">
            <el-option label="治理指南" value="治理指南"></el-option>
            <el-option label="典型案例" value="典型案例"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="分类" v-if="form.type === '治理指南'">
          <el-select v-model="form.category" placeholder="请选择分类" style="width: 100%">
            <el-option label="矛盾调解" value="矛盾调解"></el-option>
            <el-option label="安全管理" value="安全管理"></el-option>
            <el-option label="环境治理" value="环境治理"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="案例类别" v-if="form.type === '典型案例'">
          <el-input v-model="form.category" placeholder="请输入案例类别，如：矛盾纠纷、安全隐患等"></el-input>
        </el-form-item>
        <el-form-item label="简介" prop="descr">
          <el-input type="textarea" v-model="form.descr" :rows="3" placeholder="请输入简介"></el-input>
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
        <el-form-item label="正文内容" prop="content">
          <div id="editor"></div>
        </el-form-item>
        <el-form-item label="标签">
          <el-tag
            v-for="tag in dynamicTags"
            :key="tag"
            closable
            :disable-transitions="false"
            @close="handleClose(tag)"
            style="margin-right: 10px"
          >
            {{ tag }}
          </el-tag>
          <el-input
            v-if="inputVisible"
            ref="saveTagInput"
            v-model="inputValue"
            size="small"
            style="width: 100px"
            @keyup.enter.native="handleInputConfirm"
            @blur="handleInputConfirm"
          ></el-input>
          <el-button v-else size="small" @click="showInput">+ 添加标签</el-button>
        </el-form-item>
        <el-form-item label="发布人" prop="author">
          <el-input v-model="form.author" placeholder="请输入发布人"></el-input>
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
import E from 'wangeditor'

export default {
  name: "ManagerKnowledge",
  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      title: '',
      type: '',
      category: '',
      status: '',
      tableData: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
      dialogVisible: false,
      form: {},
      rules: {
        title: [{ required: true, message: '请输入标题', trigger: 'blur' }],
        type: [{ required: true, message: '请选择类型', trigger: 'change' }],
        content: [{ required: true, message: '请输入正文内容', trigger: 'blur' }],
        author: [{ required: true, message: '请输入发布人', trigger: 'blur' }],
      },
      ids: [],
      editor: null,
      dynamicTags: [],
      inputVisible: false,
      inputValue: ''
    }
  },
  mounted() {
    this.load(1)
  },
  methods: {
    typeChange() {
      this.form.category = ''
    },
    handleAdd() {
      this.form = { status: '已发布', type: '治理指南' }
      this.dynamicTags = []
      this.dialogVisible = true
      this.$nextTick(() => {
        if (this.$refs.formRef) {
          this.$refs.formRef.clearValidate()
        }
        if (this.editor) {
          this.editor.destroy()
          this.editor = null
        }
        this.editor = new E('#editor')
        this.editor.config.uploadImgServer = this.$baseUrl + '/files/upload'
        this.editor.config.uploadImgHeaders = { token: this.user.token }
        this.editor.config.uploadFileName = 'file'
        this.editor.config.uploadImgHooks = {
          customInsert: (insertImgFn, result) => { insertImgFn(result.data) }
        }
        this.editor.config.uploadVideoServer = this.$baseUrl + '/files/upload'
        this.editor.config.uploadVideoHeaders = { token: this.user.token }
        this.editor.config.uploadVideoName = 'file'
        this.editor.config.uploadVideoHooks = {
          customInsert: (insertVideoFn, result) => { insertVideoFn(result.data) }
        }
        this.editor.config.menus = [
          'head', 'bold', 'fontSize', 'italic', 'underline', 'strikeThrough', 'indent', 'lineHeight',
          'foreColor', 'backColor', 'link', 'list', 'justify', 'quote', 'image', 'video', 'table',
          'code', 'splitLine', 'undo', 'redo'
        ]
        this.editor.create()
        this.editor.txt.html('')
      })
    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogVisible = true
      this.dynamicTags = row.tags ? JSON.parse(row.tags) : []
      this.$nextTick(() => {
        if (this.editor) {
          this.editor.destroy()
          this.editor = null
        }
        this.editor = new E('#editor')
        this.editor.config.uploadImgServer = this.$baseUrl + '/files/upload'
        this.editor.config.uploadImgHeaders = { token: this.user.token }
        this.editor.config.uploadFileName = 'file'
        this.editor.config.uploadImgHooks = {
          customInsert: (insertImgFn, result) => { insertImgFn(result.data) }
        }
        this.editor.config.uploadVideoServer = this.$baseUrl + '/files/upload'
        this.editor.config.uploadVideoHeaders = { token: this.user.token }
        this.editor.config.uploadVideoName = 'file'
        this.editor.config.uploadVideoHooks = {
          customInsert: (insertVideoFn, result) => { insertVideoFn(result.data) }
        }
        this.editor.config.menus = [
          'head', 'bold', 'fontSize', 'italic', 'underline', 'strikeThrough', 'indent', 'lineHeight',
          'foreColor', 'backColor', 'link', 'list', 'justify', 'quote', 'image', 'video', 'table',
          'code', 'splitLine', 'undo', 'redo'
        ]
        this.editor.create()
        this.editor.txt.html(this.form.content || '')
      })
    },
    save() {
      // 先获取编辑器内容，再进行表单验证
      this.form.content = this.editor.txt.html()
      this.form.tags = JSON.stringify(this.dynamicTags)
      
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          let request = this.form.id ? this.$request.put('/knowledge/update', this.form) : this.$request.post('/knowledge/add', this.form)
          request.then(res => {
            if (res.code === '200') {
              this.$message.success('操作成功')
              this.load(1)
              this.dialogVisible = false
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    },
    del(id) {
      this.$confirm('确认删除？', '提示', { type: 'warning' }).then(() => {
        this.$request.delete('/knowledge/delete/' + id).then(res => {
          if (res.code === '200') {
            this.$message.success('删除成功')
            this.load(1)
          } else {
            this.$message.error(res.msg)
          }
        })
      }).catch(() => {})
    },
    handleSelectionChange(val) {
      this.ids = val.map(v => v.id)
    },
    delBatch() {
      if (!this.ids.length) {
        this.$message.warning('请选择数据')
        return
      }
      this.$confirm('确认批量删除？', '提示', { type: 'warning' }).then(() => {
        this.$request.delete('/knowledge/delete/batch', { data: this.ids }).then(res => {
          if (res.code === '200') {
            this.$message.success('删除成功')
            this.load(1)
          } else {
            this.$message.error(res.msg)
          }
        })
      }).catch(() => {})
    },
    load(pageNum) {
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/knowledge/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          title: this.title || null,
          type: this.type || null,
          category: this.category || null,
          status: this.status || null
        }
      }).then(res => {
        this.tableData = res.data?.list || []
        this.total = res.data?.total || 0
      })
    },
    reset() {
      this.title = ''
      this.type = ''
      this.category = ''
      this.status = ''
      this.load(1)
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
    handleImgSuccess(response) {
      this.form.cover = response.data
    },
    handleClose(tag) {
      this.dynamicTags.splice(this.dynamicTags.indexOf(tag), 1)
    },
    showInput() {
      this.inputVisible = true
      this.$nextTick(() => {
        this.$refs.saveTagInput.$refs.input.focus()
      })
    },
    handleInputConfirm() {
      let inputValue = this.inputValue
      if (inputValue) {
        this.dynamicTags.push(inputValue)
      }
      this.inputVisible = false
      this.inputValue = ''
    }
  }
}
</script>

<style scoped>
</style>










