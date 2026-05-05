<template>
  <div class="footer-container">
    <div class="footer-content">
      <div class="footer-section">
        <h3 class="section-title">关于平台</h3>
        <p class="section-text">网格化依法治理平台致力于推进基层社会治理现代化，提升网格员法治素养，构建和谐社区。</p>
      </div>
      
      <div class="footer-section">
        <h3 class="section-title">快速链接</h3>
        <div class="link-list">
          <a href="/#/front/home" class="footer-link">首页</a>
          <a href="/#/front/knowledge" class="footer-link">治理案例</a>
          <a href="/#/front/activity" class="footer-link">任务中心</a>
          <a href="/#/front/person" class="footer-link">个人中心</a>
        </div>
      </div>
      
      <div class="footer-section">
        <h3 class="section-title">紧急联系</h3>
        <div class="contact-list">
          <p class="contact-item">
            <i class="el-icon-phone"></i>
            <span>综治热线：12345</span>
          </p>
          <p class="contact-item">
            <i class="el-icon-service"></i>
            <span>网格服务：123456</span>
          </p>
        </div>
      </div>
    </div>
    
    <div class="footer-bottom">
      <p class="copyright">
        <i class="el-icon-info"></i>
        Copyright © 2025 网格化依法治理平台 All Rights Reserved
      </p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Footer'
}
</script>

<style scoped>
.footer-container {
  background: #1d3557;
  color: #ecf0f1;
  margin-top: 0;
  padding: 36px 0 0 0;
}

.footer-content {
  width: 80%;
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 40px;
  padding-bottom: 30px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.footer-section {
  padding: 0 20px;
}

.section-title {
  font-size: 18px;
  font-weight: 600;
  color: #fff;
  margin: 0 0 20px 0;
  padding-bottom: 10px;
  border-bottom: 2px solid #457b9d;
  display: inline-block;
}

.section-text {
  color: #bdc3c7;
  line-height: 1.8;
  font-size: 14px;
  margin: 0;
}

.link-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.footer-link {
  color: #bdc3c7;
  text-decoration: none;
  font-size: 14px;
  transition: all 0.3s;
  display: inline-block;
}

.footer-link:hover {
  color: #a8dadc;
  transform: translateX(5px);
}

.contact-list {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.contact-item {
  display: flex;
  align-items: center;
  gap: 10px;
  color: #bdc3c7;
  font-size: 14px;
  margin: 0;
}

.contact-item i {
  font-size: 16px;
  color: #a8dadc;
}

.footer-bottom {
  padding: 20px 0;
  text-align: center;
  background: rgba(0, 0, 0, 0.2);
}

.copyright {
  color: #95a5a6;
  font-size: 13px;
  margin: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.copyright i {
  font-size: 14px;
}

/* 响应式设计 */
@media (max-width: 1024px) {
  .footer-content {
    width: 90%;
    grid-template-columns: repeat(2, 1fr);
  }
  
  .footer-section:last-child {
    grid-column: span 2;
  }
}

@media (max-width: 768px) {
  .footer-container {
    padding: 30px 0 0 0;
  }
  
  .footer-content {
    width: 100%;
    grid-template-columns: 1fr;
    gap: 30px;
    padding: 0 20px 20px 20px;
  }
  
  .footer-section {
    padding: 0;
  }
  
  .footer-section:last-child {
    grid-column: span 1;
  }
  
  .section-title {
    font-size: 16px;
  }
}
</style>
