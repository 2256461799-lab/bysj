import Vue from 'vue'
import nprogress from 'nprogress'
import VueRouter from 'vue-router'
import 'nprogress/nprogress.css'

Vue.use(VueRouter)

const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push (location) {
  return originalPush.call(this, location).catch(err => err)
}

const routes = [
  {
    path: '/',
    name: 'Manager',
    component: () => import('../views/Manager.vue'),
    children: [
      { path: '403', name: 'NoAuth', meta: { name: '无权限' }, component: () => import('../views/manager/403') },
      { path: 'home', name: 'Home', meta: { name: '系统首页' }, component: () => import('../views/manager/Home') },
      { path: 'admin', name: 'Admin', meta: { name: '管理员信息' }, component: () => import('../views/manager/Admin') },
      { path: 'adminPerson', name: 'AdminPerson', meta: { name: '个人信息' }, component: () => import('../views/manager/AdminPerson') },
      { path: 'password', name: 'Password', meta: { name: '修改密码' }, component: () => import('../views/manager/Password') },
      { path: 'user', name: 'User', meta: { name: '网格员/群众信息' }, component: () => import('../views/manager/User') },
      { path: 'category', name: 'Category', meta: { name: '事件分类' }, component: () => import('../views/manager/Category') },
      { path: 'blog', name: 'Blog', meta: { name: '工作交流' }, component: () => import('../views/manager/Blog') },
      { path: 'activity', name: 'Activity', meta: { name: '治理任务' }, component: () => import('../views/manager/Activity') },
      { path: 'comment', name: 'Comment', meta: { name: '评论信息' }, component: () => import('../views/manager/Comment') },
      { path: 'activitySign', name: 'ActivitySign', meta: { name: '签到信息' }, component: () => import('../views/manager/ActivitySign') },
      { path: 'law', name: 'Law', meta: { name: '法律法规' }, component: () => import('../views/manager/Law') },
      { path: 'knowledge', name: 'Knowledge', meta: { name: '治理案例库' }, component: () => import('../views/manager/Knowledge') },
      { path: 'report', name: 'Report', meta: { name: '事件上报管理' }, component: () => import('../views/manager/Report') },
      { path: 'chapter', name: 'Chapter', meta: { name: '培训章节管理' }, component: () => import('../views/manager/Chapter') },
      { path: 'lesson', name: 'Lesson', meta: { name: '课时管理' }, component: () => import('../views/manager/Lesson') },
    ]
  },
  {
    path: '/front',
    name: 'Front',
    component: () => import('../views/Front.vue'),
    children: [
      { path: 'home', name: 'FrontHome', meta: { name: '平台首页' }, component: () => import('../views/front/Home.vue') },
      { path: 'blog', name: 'FrontBlog', meta: { name: '工作交流' }, component: () => import('../views/front/Blog.vue') },
      { path: 'publishblog', name: 'FrontPublishBlog', meta: { name: '发布日志' }, component: () => import('../views/front/PublishBlog.vue') },
      { path: 'person', name: 'FrontPerson', meta: { name: '个人信息' }, component: () => import('../views/front/Person') },
      { path: 'blogDetail', name: 'FrontBlogDetail', meta: { name: '日志详情' }, component: () => import('../views/front/BlogDetail') },
      { path: 'activity', name: 'FrontActivity', meta: { name: '任务中心' }, component: () => import('../views/front/Activity') },
      { path: 'search', name: 'FrontSearch', meta: { name: '搜索' }, component: () => import('../views/front/Search.vue') },
      { path: 'activityDetail', name: 'FrontActivityDetail', meta: { name: '任务详情' }, component: () => import('../views/front/ActivityDetail') },
      { path: 'law', name: 'Frontlaw', meta: { name: '法律法规' }, component: () => import('../views/front/Law.vue') },
      { path: 'lawDetail', name: 'FrontLawDetail', meta: { name: '法规详情' }, component: () => import('../views/front/LawDetail.vue') },
      { path: 'knowledge', name: 'FrontKnowledge', meta: { name: '治理案例库' }, component: () => import('../views/front/Knowledge.vue') },
      { path: 'knowledgeDetail', name: 'FrontKnowledgeDetail', meta: { name: '案例详情' }, component: () => import('../views/front/KnowledgeDetail.vue') },
      { path: 'report', name: 'FrontReport', meta: { name: '事件上报' }, component: () => import('../views/front/Report.vue') },
      { path: 'learningClass', name: 'FrontLearningClass', meta: { name: '法治培训' }, component: () => import('../views/front/LearningClass.vue') },
    ]
  },
  { path: '/login', name: 'Login', meta: { name: '登录' }, component: () => import('../views/Login.vue') },
  { path: '/register', name: 'Register', meta: { name: '注册' }, component: () => import('../views/Register.vue') },
  { path: '*', name: 'NotFound', meta: { name: '无法访问' }, component: () => import('../views/404.vue') },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes,
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return { x: 0, y: 0 }
    }
  }
})

router.beforeEach((to, from, next) => {
  nprogress.start()
  let user = JSON.parse(localStorage.getItem("xm-user") || '{}')
  if (to.path === '/') {
    if (user.role) {
      nprogress.done()
      // ✅ 登录后跳 /front/home
      user.role === 'USER' ? next('/front/Home') : next('/Home')
    } else {
      nprogress.done()
      next('/login')
    }
  } else {
    nprogress.done()
    next()
  }
})

router.afterEach(() => {
  nprogress.done()
})

export default router