<template>
  <div class="publishblog-container">
    <div class="page-header">
      <h1 class="page-title">{{ form.id ? '编辑日志' : '发表新日志' }}</h1>
    </div>

    <div class="form-card">
      <el-form :model="form" label-width="100px" :rules="rules" ref="formRef">
        <el-form-item label="标题" prop="title">
          <el-input v-model="form.title" placeholder="标题"></el-input>
        </el-form-item>
        <el-form-item label="简介" prop="descr">
          <el-input type="textarea" v-model="form.descr" placeholder="简介"></el-input>
        </el-form-item>
        <el-form-item label="封面" prop="cover">
          <el-upload
              :action="$baseUrl + '/files/upload'"
              :headers="{ token: user.token }"
              list-type="picture"
              :on-success="handleCoverSuccess"
          >
            <el-button type="primary">上传封面</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item label="分类" prop="categoryId">
          <el-select v-model="form.categoryId" style="width: 100%">
            <el-option v-for="item in categoryList" :key="item.id" :value="item.id" :label="item.name"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="标签" prop="tags">
          <el-select v-model="tagsArr" multiple filterable allow-create default-first-option style="width: 100%" placeholder="选择或输入标签">
            <el-option value="安全隐患"></el-option>
            <el-option value="矛盾纠纷"></el-option>
            <el-option value="环境问题"></el-option>
            <el-option value="民生诉求"></el-option>
            <el-option value="治理经验"></el-option>
            <el-option value="巡查记录"></el-option>
            <el-option value="政策宣传"></el-option>
            <el-option value="法律咨询"></el-option>
            <el-option value="工作心得"></el-option>
            <el-option value="案例分享"></el-option>
            <el-option value="问题反馈"></el-option>
            <el-option value="治理知识"></el-option>
            <el-option value="工作建议"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <div id="editor"></div>
        </el-form-item>
      </el-form>
      
      <div class="form-actions">
        <el-button @click="$router.back()" size="medium">
          <i class="el-icon-back"></i>
          返回
        </el-button>
        <el-button type="primary" size="medium" @click="save">
          <i class="el-icon-check"></i>
          {{ form.id ? '保存修改' : '确认发布' }}
        </el-button>
      </div>
    </div>
  </div>
</template>

<script>
import E from "wangeditor"
import hljs from 'highlight.js'
export default {
  name: "PublishBlog",
  data() {
    return {
      blogId:this.$route.query.blogId,
      form: {},
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      rules: {},
      categoryList: [],
      tagsArr: [],
      editor: null
    }
  },
  mounted() {
    this.$request.get('/category/selectAll').then(res => {
      this.categoryList = res.data || []
    })
    this.$request.get('/blog/selectById/' + this.blogId).then(res => {
      this.form = res.data || {}
      this.tagsArr = JSON.parse(this.form.tags || '[]')
      if(this.form.id){
        setTimeout(() => {
          this.editor.txt.html(this.form.content)
        }, 0)
      }
    })
    this.setRichText()
  },
  methods: {
    save() {
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.form.tags = JSON.stringify(this.tagsArr)
          this.form.content = this.editor.txt.html()
          this.$request({
            url: this.form.id ? '/blog/update' : '/blog/add',
            method: this.form.id ? 'PUT' : 'POST',
            data: this.form
          }).then(res => {
            if (res.code === '200') {
              this.$message.success('保存成功')
              this.$router.push('/front/blog')
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    },
    handleCoverSuccess(res) {
      this.form.cover = res.data
    },
    setRichText() {
      this.$nextTick(() => {
        this.editor = new E(`#editor`)
        this.editor.highlight = hljs
        this.editor.config.uploadImgServer = this.$baseUrl + '/files/editor/upload'
        this.editor.config.uploadFileName = 'file'
        this.editor.config.uploadImgHeaders = {
          token: this.user.token
        }
        this.editor.config.uploadImgParams = {
          type: 'img',
        }
        this.editor.config.zIndex=0
        this.editor.create()
      })
    },
  }
}
</script>

<style scoped>
.publishblog-container {
  width: 75%;
  max-width: 960px;
  margin: 20px auto;
}
.page-header {
  background: #fff;
  border-radius: 4px;
  padding: 35px 40px;
  margin-bottom: 15px;
  text-align: center;
  border: 1px solid #e8e8e8;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
}
.page-title {
  font-size: 28px;
  font-weight: 600;
  color: #1a1a1a;
  margin: 0;
  line-height: 1.5;
}
.form-card {
  background: #fff;
  border-radius: 4px;
  padding: 35px 40px;
  border: 1px solid #e8e8e8;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
  margin-bottom: 15px;
}
.form-card >>> .el-form-item {
  margin-bottom: 24px;
}
.form-card >>> .el-form-item__label {
  font-weight: 500;
  color: #606266;
  font-size: 14px;
}
.form-card >>> .el-input__inner,
.form-card >>> .el-textarea__inner {
  border-radius: 4px;
  border-color: #dcdfe6;
}
.form-card >>> .el-input__inner:focus,
.form-card >>> .el-textarea__inner:focus {
  border-color: #1d3557;
}
.form-card >>> #editor {
  border: 1px solid #dcdfe6;
  border-radius: 4px;
}
.form-card >>> .w-e-toolbar {
  border-bottom: 1px solid #dcdfe6 !important;
  background: #f5f7fa;
  border-radius: 4px 4px 0 0;
}
.form-card >>> .w-e-text-container {
  border-radius: 0 0 4px 4px;
}
.form-actions {
  display: flex;
  justify-content: center;
  gap: 15px;
  padding-top: 30px;
  border-top: 1px solid #f0f0f0;
  margin-top: 10px;
}
.form-card >>> .el-upload {
  display: inline-block;
}
@media (max-width: 1024px) {
  .publishblog-container {
    width: 90%;
  }
}
@media (max-width: 768px) {
  .publishblog-container {
    width: 100%;
    padding: 0 10px;
    margin: 10px auto;
  }
  .page-header,
  .form-card {
    padding: 24px 20px;
    border-radius: 4px;
    margin-bottom: 15px;
  }
  .page-title {
    font-size: 22px;
  }
  .form-card >>> .el-form-item__label {
    text-align: left;
  }
  .form-actions {
    flex-direction: column;
  }
  .form-actions .el-button {
    width: 100%;
  }
}
</style>