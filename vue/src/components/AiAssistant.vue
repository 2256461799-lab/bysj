<template>
  <div class="ai-assistant" v-if="showAiAssistant">
    <!-- 自由拖拽悬浮球 -->
    <div
      ref="floatBall"
      class="float-ball"
      :class="{ shake: isShaking }"
      :style="{ left: `${ballLeft}px`, top: `${ballTop}px` }"
      @mousedown="startDrag"
      @touchstart="startDrag"
      @mouseup="stopDrag"
      @touchend="stopDrag"
      @mouseleave="stopDrag"
      @click="handleClick"
      @mouseenter="isShaking = false"
    >
      <div class="ball-icon">
        <i class="el-icon-chat-dot-round"></i>
      </div>
      <div class="ball-text">治理助手</div>
    </div>

    <!-- 对话窗口 -->
    <el-dialog
      title="AI智能问答"
      :visible.sync="dialogVisible"
      width="40%"
      :close-on-click-modal="false"
      custom-class="ai-dialog"
      :append-to-body="true"
    >
      <div class="chat-container">
        <div class="chat-header">
          <el-button @click="clearChat" size="small" icon="el-icon-delete">清空</el-button>
        </div>

        <div class="message-list" ref="messageList">
          <div v-for="(msg, index) in messages" :key="index" :class="['message-item', msg.role]">
            <div class="message-avatar">
              <img v-if="msg.role === 'user' && user.avatar" :src="user.avatar" class="avatar-img" />
              <i v-else-if="msg.role === 'user'" class="el-icon-user-solid"></i>
              <i v-else class="el-icon-service"></i>
            </div>
            <div class="message-content">
              <div class="message-text">{{ msg.content }}</div>
              <div class="message-time">{{ msg.time }}</div>
            </div>
          </div>
          <div v-if="isTyping" class="message-item assistant">
            <div class="message-avatar">
              <i class="el-icon-service"></i>
            </div>
            <div class="message-content">
              <div class="typing-indicator">
                <span></span>
                <span></span>
                <span></span>
              </div>
            </div>
          </div>
        </div>

        <div class="input-area">
          <el-input
            v-model="userInput"
            placeholder="输入消息..."
            @keyup.enter.native="sendMessage"
            :disabled="isTyping"
          >
            <el-button
              slot="append"
              icon="el-icon-s-promotion"
              @click="sendMessage"
              :disabled="isTyping || !userInput.trim()"
            ></el-button>
          </el-input>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: 'AiAssistant',
  data() {
    return {
      // ====== 控制开关：false=隐藏(当前)，true=显示 ======
      showAiAssistant: false,

      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      dialogVisible: false,
      messages: [],
      userInput: '',
      isTyping: false,
      isShaking: false,
      chatSessionId: null,

      // 拖拽
      isDragging: false,
      hasMoved: false,
      ballLeft: 0,
      ballTop: 0,
      startX: 0,
      startY: 0,
      ballWidth: 64,
      ballHeight: 64
    }
  },
  mounted() {
    // 初始位置：右下角
    this.ballLeft = window.innerWidth - this.ballWidth - 20
    this.ballTop = window.innerHeight - this.ballHeight - 20

    setTimeout(() => {
      this.isShaking = true
    }, 5000)

    window.addEventListener('mousemove', this.onDragMove)
    window.addEventListener('touchmove', this.onDragMove)
  },
  beforeDestroy() {
    window.removeEventListener('mousemove', this.onDragMove)
    window.removeEventListener('touchmove', this.onDragMove)
  },
  methods: {
    generateSessionId(prefix = 'session') {
      return prefix + '_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9)
    },
    openDialog() {
      this.dialogVisible = true
      this.isShaking = false
      if (!this.chatSessionId) {
        this.chatSessionId = this.generateSessionId('chat')
        this.addSystemMessage('您好！我是AI治理助手，您可以向我咨询任何基层治理相关的问题。')
      }
    },
    addSystemMessage(content) {
      this.messages.push({
        role: 'system',
        content: content,
        time: this.getCurrentTime()
      })
      this.$nextTick(() => this.scrollToBottom())
    },
    sendMessage() {
      if (!this.userInput.trim() || this.isTyping) return
      const userMessage = this.userInput.trim()
      this.messages.push({
        role: 'user',
        content: userMessage,
        time: this.getCurrentTime()
      })
      this.userInput = ''
      this.isTyping = true
      this.$nextTick(() => this.scrollToBottom())
      this.callChatAPI(userMessage)
    },
    callChatAPI(message) {
      const url = `${this.$baseUrl}/ai/chat?sessionId=${this.chatSessionId}&message=${encodeURIComponent(message)}`
      this.handleSSE(url)
    },
    handleSSE(url) {
      const eventSource = new EventSource(url)
      let aiMessage = ''
      eventSource.onmessage = (event) => {
        const data = event.data
        if (data === '[START]') return
        if (data === '[DONE]') {
          eventSource.close()
          this.isTyping = false
          return
        }
        aiMessage += data
        const last = this.messages[this.messages.length - 1]
        if (last && last.role === 'assistant') {
          last.content = aiMessage
        } else {
          this.messages.push({
            role: 'assistant',
            content: aiMessage,
            time: this.getCurrentTime()
          })
        }
        this.$nextTick(() => this.scrollToBottom())
      }
      eventSource.onerror = (err) => {
        console.error('SSE 异常', err)
        eventSource.close()
        this.isTyping = false
        this.$message.error('连接出错，请重试')
      }
    },
    clearChat() {
      this.$confirm('确定清空对话？', '提示', { type: 'warning' }).then(() => {
        this.messages = []
        this.$request.delete('/ai/clear', { params: { sessionId: this.chatSessionId } })
        this.addSystemMessage('对话已清空，您可以重新开始提问。')
      }).catch(() => {})
    },
    scrollToBottom() {
      if (this.$refs.messageList) {
        this.$refs.messageList.scrollTop = this.$refs.messageList.scrollHeight
      }
    },
    getCurrentTime() {
      const now = new Date()
      return `${now.getHours().toString().padStart(2, '0')}:${now.getMinutes().toString().padStart(2, '0')}`
    },

    // 开始拖拽
    startDrag(e) {
      this.isDragging = true
      this.hasMoved = false
      this.isShaking = false

      const touch = e.touches ? e.touches[0] : e
      this.startX = touch.clientX - this.ballLeft
      this.startY = touch.clientY - this.ballTop

      this.$refs.floatBall.style.transition = 'none'
    },

    // 拖拽中
    onDragMove(e) {
      if (!this.isDragging) return
      this.hasMoved = true
      e.preventDefault()

      const touch = e.touches ? e.touches[0] : e
      let x = touch.clientX - this.startX
      let y = touch.clientY - this.startY

      // 边界限制
      const maxX = window.innerWidth - this.ballWidth
      const maxY = window.innerHeight - this.ballHeight
      x = Math.max(0, Math.min(x, maxX))
      y = Math.max(0, Math.min(y, maxY))

      this.ballLeft = x
      this.ballTop = y
    },

    // 结束拖拽
    stopDrag() {
      this.isDragging = false
      this.$refs.floatBall.style.transition = 'all 0.1s ease'
    },

    // 点击：只有没拖动时才触发打开弹窗
    handleClick() {
      if (!this.hasMoved) {
        this.openDialog()
      }
      this.hasMoved = false
    }
  }
}
</script>

<style scoped>
.float-ball {
  position: fixed;
  width: 64px;
  height: 64px;
  background: #1d3557;
  border-radius: 50%;
  box-shadow: 0 2px 12px rgba(29, 53, 87, 0.4);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  z-index: 999999;
  cursor: move;
  user-select: none;
  transition: all 0.1s ease;
}
.float-ball:hover {
  background: #264e78;
}
.float-ball.shake {
  animation: shake 0.5s infinite;
}
@keyframes shake {
  0%,100%{transform:rotate(0deg);}25%{transform:rotate(-8deg);}75%{transform:rotate(8deg);}
}
.ball-icon {
  font-size: 28px;
  color: #fff;
}
.ball-text {
  font-size: 11px;
  color: #fff;
  margin-top: 2px;
}

::v-deep .ai-dialog {
  border-radius: 8px;
  overflow: hidden;
}
::v-deep .ai-dialog .el-dialog__header {
  background: #1d3557;
  padding: 16px 20px;
}
::v-deep .ai-dialog .el-dialog__title {
  color: #fff;
  font-weight: 600;
}
::v-deep .ai-dialog .el-dialog__headerbtn .el-dialog__close {
  color: #fff;
}
::v-deep .ai-dialog .el-dialog__body {
  padding: 0;
}

.chat-container {
  display: flex;
  flex-direction: column;
  height: 500px;
}
.chat-header {
  padding: 12px 16px;
  background: #fafafa;
  border-bottom: 1px solid #e8e8e8;
  display: flex;
  justify-content: flex-end;
}
.message-list {
  flex: 1;
  overflow-y: auto;
  padding: 16px;
  background: #f8f8f8;
}
.message-item {
  display: flex;
  margin-bottom: 16px;
}
.message-item.user {
  flex-direction: row-reverse;
}
.message-avatar {
  width: 34px;
  height: 34px;
  border-radius: 50%;
  background: #1d3557;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  flex-shrink: 0;
}
.avatar-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 50%;
}
.message-item.user .message-avatar {
  background: #67c23a;
}
.message-item.system .message-avatar {
  background: #e6a23c;
}
.message-content {
  max-width: 70%;
  margin: 0 10px;
}
.message-text {
  padding: 10px 14px;
  background: white;
  border: 1px solid #e8e8e8;
  border-radius: 4px;
  font-size: 14px;
}
.message-item.user .message-text {
  background: #1d3557;
  color: white;
}
.message-item.system .message-text {
  background: #fffbe6;
  border-left: 2px solid #e6a23c;
}
.message-time {
  font-size: 11px;
  color: #999;
  text-align: center;
  margin-top: 4px;
}
.typing-indicator {
  padding: 10px 14px;
  background: white;
  border: 1px solid #e8e8e8;
  display: inline-flex;
  gap: 5px;
}
.typing-indicator span {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: #1d3557;
  animation: typing 1.2s infinite;
}
.typing-indicator span:nth-child(2) {
  animation-delay: 0.2s;
}
.typing-indicator span:nth-child(3) {
  animation-delay: 0.4s;
}
@keyframes typing {
  0%,60%,100%{transform:translateY(0);opacity:.5;}30%{transform:translateY(-6px);opacity:1;}
}
.input-area {
  padding: 16px;
  background: white;
  border-top: 1px solid #e8e8e8;
}
::v-deep .input-area .el-input-group__append {
  background: #1d3557;
  border-color: #1d3557;
  color: white;
}
</style>