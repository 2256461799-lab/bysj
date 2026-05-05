<template>
  <div>
    <div class="main-content" style="width: 90%; max-width: 1400px">
      <!-- 页面标题 -->
      <div class="page-header">
        <h1>
          <i class="el-icon-video-camera"></i> 法治培训课堂
        </h1>
        <p>系统学习法治知识，提升依法治理能力</p>
      </div>

      <!-- 主体内容区域：左侧章节列表 + 右侧视频播放 -->
      <div class="learning-container">
        <!-- 左侧：章节和课时列表 -->
        <div class="left-sidebar">
          <div class="sidebar-header">
            <i class="el-icon-menu"></i> 课程目录
          </div>
          <div class="chapter-list">
            <div v-for="chapter in chapterList" :key="chapter.id" class="chapter-item">
              <div class="chapter-header" @click="toggleChapter(chapter.id)">
                <i :class="expandedChapters.includes(chapter.id) ? 'el-icon-arrow-down' : 'el-icon-arrow-right'"></i>
                <span class="chapter-title">{{ chapter.title }}</span>
                <span class="chapter-count">({{ getLessonCount(chapter.id) }})</span>
              </div>
              <div v-show="expandedChapters.includes(chapter.id)" class="lesson-list">
                <div
                  v-for="(lesson, index) in lessonMap[chapter.id]"
                  :key="lesson.id"
                  class="lesson-item"
                  :class="{ active: currentLesson.id === lesson.id }"
                  @click="playLesson(lesson)"
                >
                  <div class="lesson-number">{{ index + 1 }}</div>
                  <div class="lesson-info">
                    <div class="lesson-title">{{ lesson.title }}</div>
                    <div class="lesson-duration">
                      <i class="el-icon-video-play"></i> {{ lesson.duration }}
                    </div>
                  </div>
                </div>
                <div v-if="!lessonMap[chapter.id] || lessonMap[chapter.id].length === 0" class="no-lesson">
                  暂无课时
                </div>
              </div>
            </div>
            <div v-if="chapterList.length === 0" class="no-chapter">
              <i class="el-icon-folder-opened"></i>
              <p>暂无课程内容</p>
            </div>
          </div>
        </div>

        <!-- 右侧：视频播放区域 -->
        <div class="right-content">
          <div v-if="currentLesson.id" class="video-container">
            <!-- 视频标题 -->
            <div class="video-header">
              <h2>{{ currentLesson.title }}</h2>
              <div class="video-meta">
                <span><i class="el-icon-time"></i> {{ currentLesson.duration }}</span>
              </div>
            </div>

            <!-- 视频播放器 -->
            <div class="video-player">
              <video
                v-if="currentLesson.videoUrl"
                :src="currentLesson.videoUrl"
                :key="currentLesson.id"
                controls
                controlslist="nodownload"
                style="width: 100%; height: 100%; object-fit: contain; background: #000"
              ></video>
              <div v-else class="no-video">
                <i class="el-icon-video-camera-solid"></i>
                <p>暂无视频</p>
              </div>
            </div>

            <!-- 课时简介 -->
            <div class="lesson-description">
              <h3><i class="el-icon-info"></i> 课时简介</h3>
              <p>{{ currentLesson.descr || '暂无简介' }}</p>
            </div>
          </div>

          <!-- 未选择课时的提示 -->
          <div v-else class="empty-state">
            <i class="el-icon-video-camera"></i>
            <h3>请从左侧选择课时开始学习</h3>
            <p>系统学习法治知识，提升依法治理能力</p>
          </div>
        </div>
      </div>
    </div>

    <Footer />
  </div>
</template>

<script>
import Footer from "@/components/Footer";

export default {
  name: "FrontLearningClass",
  components: {
    Footer
  },
  data() {
    return {
      chapterList: [],
      lessonMap: {},  // { chapterId: [lessons] }
      expandedChapters: [],  // 展开的章节ID列表
      currentLesson: {}  // 当前播放的课时
    }
  },
  created() {
    this.loadChapters()
  },
  methods: {
    // 加载章节列表
    loadChapters() {
      this.$request.get('/chapter/selectPublished').then(res => {
        if (res.code === '200') {
          this.chapterList = res.data || []
          // 加载每个章节的课时
          this.chapterList.forEach(chapter => {
            this.loadLessons(chapter.id)
          })
          // 默认展开第一个章节
          if (this.chapterList.length > 0) {
            this.expandedChapters.push(this.chapterList[0].id)
          }
        }
      })
    },
    // 加载章节的课时列表
    loadLessons(chapterId) {
      this.$request.get(`/lesson/selectByChapterId/${chapterId}`).then(res => {
        if (res.code === '200') {
          this.$set(this.lessonMap, chapterId, res.data || [])
          // 如果是第一个章节且有课时，自动播放第一个课时
          if (chapterId === this.chapterList[0]?.id && res.data && res.data.length > 0 && !this.currentLesson.id) {
            this.currentLesson = res.data[0]
          }
        }
      })
    },
    // 切换章节展开/收起
    toggleChapter(chapterId) {
      const index = this.expandedChapters.indexOf(chapterId)
      if (index > -1) {
        this.expandedChapters.splice(index, 1)
      } else {
        this.expandedChapters.push(chapterId)
      }
    },
    // 获取章节的课时数量
    getLessonCount(chapterId) {
      return this.lessonMap[chapterId] ? this.lessonMap[chapterId].length : 0
    },
    // 播放课时
    playLesson(lesson) {
      this.currentLesson = lesson
    }
  }
}
</script>

<style scoped>
/* 页面标题 */
.page-header {
  background: #fff;
  border: 1px solid #e8e8e8;
  border-radius: 4px;
  padding: 30px;
  text-align: center;
  margin-bottom: 20px;
  box-shadow: 0 1px 4px rgba(0,0,0,0.08);
}

.page-header h1 {
  margin: 0 0 10px 0;
  font-size: 28px;
  font-weight: 600;
  color: #1d3557;
}

.page-header h1 i {
  margin-right: 8px;
}

.page-header p {
  margin: 0;
  font-size: 15px;
  color: #666;
}

/* 主容器：左右布局 */
.learning-container {
  display: flex;
  gap: 0;
  min-height: 600px;
  background: white;
  border-radius: 4px;
  overflow: hidden;
  box-shadow: 0 1px 4px rgba(0,0,0,0.08);
  border: 1px solid #e8e8e8;
}

/* 左侧边栏 */
.left-sidebar {
  width: 350px;
  background: #f9f9f9;
  border-right: 1px solid #e8e8e8;
  display: flex;
  flex-direction: column;
}

.sidebar-header {
  padding: 18px 20px;
  background: #fff;
  border-bottom: 1px solid #e8e8e8;
  font-size: 16px;
  font-weight: 600;
  color: #333;
}

.sidebar-header i {
  margin-right: 6px;
  color: #666;
}

.chapter-list {
  flex: 1;
  overflow-y: auto;
  padding: 8px 0;
}

/* 章节项 */
.chapter-item {
  margin-bottom: 2px;
}

.chapter-header {
  padding: 12px 18px;
  background: white;
  cursor: pointer;
  display: flex;
  align-items: center;
  transition: background-color 0.2s;
  border-left: 2px solid transparent;
}

.chapter-header:hover {
  background: #f5f5f5;
  border-left-color: #1d3557;
}

.chapter-header i {
  margin-right: 6px;
  color: #999;
}

.chapter-title {
  flex: 1;
  font-size: 14px;
  font-weight: 500;
  color: #333;
}

.chapter-count {
  font-size: 12px;
  color: #999;
}

/* 课时列表 */
.lesson-list {
  background: #fafafa;
  padding: 4px 0;
}

.lesson-item {
  padding: 10px 18px 10px 38px;
  display: flex;
  align-items: center;
  cursor: pointer;
  transition: background-color 0.2s;
  border-left: 2px solid transparent;
}

.lesson-item:hover {
  background: #f0f0f0;
  border-left-color: #1d3557;
}

.lesson-item.active {
  background: #e8f0f8;
  border-left-color: #1d3557;
}

.lesson-number {
  width: 24px;
  height: 24px;
  background: #e8e8e8;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  color: #666;
  margin-right: 10px;
  flex-shrink: 0;
}

.lesson-item.active .lesson-number {
  background: #1d3557;
  color: white;
}

.lesson-info {
  flex: 1;
  min-width: 0;
}

.lesson-title {
  font-size: 13px;
  color: #333;
  margin-bottom: 3px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.lesson-item.active .lesson-title {
  color: #1d3557;
  font-weight: 500;
}

.lesson-duration {
  font-size: 12px;
  color: #999;
}

.lesson-duration i {
  margin-right: 3px;
}

.no-lesson {
  padding: 18px;
  text-align: center;
  color: #999;
  font-size: 13px;
}

.no-chapter {
  padding: 50px 20px;
  text-align: center;
  color: #999;
}

.no-chapter i {
  font-size: 48px;
  margin-bottom: 10px;
  color: #ddd;
}

/* 右侧内容区 */
.right-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  min-width: 0;
}

.video-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  padding: 20px;
}

/* 视频标题 */
.video-header {
  margin-bottom: 18px;
  padding-bottom: 15px;
  border-bottom: 1px solid #f0f0f0;
}

.video-header h2 {
  margin: 0 0 8px 0;
  font-size: 22px;
  color: #333;
  font-weight: 600;
}

.video-meta {
  display: flex;
  align-items: center;
  font-size: 13px;
  color: #999;
}

.video-meta i {
  margin-right: 4px;
}

/* 视频播放器 */
.video-player {
  width: 100%;
  height: 500px;
  background: #000;
  overflow: hidden;
  margin-bottom: 18px;
}

.no-video {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #999;
}

.no-video i {
  font-size: 72px;
  margin-bottom: 16px;
  color: #ddd;
}

.no-video p {
  font-size: 14px;
}

/* 课时简介 */
.lesson-description {
  background: #f9f9f9;
  padding: 18px;
  border-left: 3px solid #1d3557;
}

.lesson-description h3 {
  margin: 0 0 12px 0;
  font-size: 15px;
  color: #333;
  font-weight: 600;
}

.lesson-description h3 i {
  display: none;
}

.lesson-description p {
  margin: 0;
  font-size: 14px;
  color: #666;
  line-height: 1.8;
}

/* 空状态 */
.empty-state {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #999;
  padding: 50px;
}

.empty-state i {
  font-size: 96px;
  margin-bottom: 24px;
  color: #ddd;
}

.empty-state h3 {
  margin: 0 0 8px 0;
  font-size: 18px;
  color: #666;
  font-weight: 500;
}

.empty-state p {
  margin: 0;
  font-size: 14px;
  color: #999;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .learning-container {
    flex-direction: column;
  }

  .left-sidebar {
    width: 100%;
    max-height: 400px;
  }

  .video-player {
    height: 300px;
  }
}
</style>

