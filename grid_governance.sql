/*
 Navicat Premium Data Transfer

 Source Server         : mysql8.0
 Source Server Type    : MySQL
 Source Server Version : 80035
 Source Host           : localhost:3306
 Source Schema         : grid_governance

 Target Server Type    : MySQL
 Target Server Version : 80035
 File Encoding         : 65001

 Date: 13/03/2026 16:04:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '任务名称',
  `descr` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '任务简介',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '任务内容',
  `start` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '开始时间',
  `end` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '结束时间',
  `form` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '任务形式',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '任务地点',
  `host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '负责单位',
  `read_count` int(0) NULL DEFAULT 0 COMMENT '浏览量',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '治理任务' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of activity
-- ----------------------------
INSERT INTO `activity` VALUES (2, '社区网格安全隐患排查', '组织网格员对辖区内安全隐患进行全面排查，重点检查消防通道、电动车充电、高空坠物等问题。', '<h2>任务简介</h2><p>为进一步加强社区安全管理，消除各类安全隐患，组织全体网格员开展辖区安全隐患大排查行动。</p><h2>排查重点</h2><ul><li>消防通道是否畅通</li><li>电动车是否违规充电</li><li>高空坠物隐患排查</li><li>老旧建筑安全检查</li></ul><h2>工作要求</h2><p>每位网格员负责本网格区域，逐栋逐户排查，发现问题及时上报并拍照留证。</p>', '2025-10-15', '2025-10-20', '实地排查', '各社区网格区域', '街道综治办、社区居委会', 156, 'http://localhost:9090/files/1773379083622-bec546fe71b52dcbd4d3784a18752977.jpeg');
INSERT INTO `activity` VALUES (3, '法治宣传进社区活动', '走进社区，面对面为居民讲解法律知识，发放法治宣传手册，提供法律咨询服务。', '<h2>活动背景</h2><p>为深入推进基层法治建设，提高居民法律意识，组织法律工作者深入社区开展法治宣传活动。</p><h2>活动安排</h2><p><strong>10月15日：</strong>阳光社区<br/><strong>10月16日：</strong>幸福家园社区<br/><strong>10月17日：</strong>和谐社区<br/><strong>10月18日：</strong>锦绣社区<br/><strong>10月19日：</strong>花园社区<br/><strong>10月20日：</strong>绿洲社区</p><h2>活动内容</h2><ul><li>律师现场讲解民法典相关知识</li><li>发放法治宣传手册和资料</li><li>提供一对一法律咨询</li><li>帮助居民了解维权途径</li></ul><h2>参与对象</h2><p>社区全体居民，特别欢迎老年朋友参加。</p>', '2025-10-15', '2025-10-20', '线下宣传', '各社区活动中心', '司法所、各街道办事处', 243, 'http://localhost:9090/files/1773379077658-181f05520fb233434dcb8c071263c01d.jpeg');
INSERT INTO `activity` VALUES (4, '网格员入户走访专项行动', '针对辖区重点人群，组织网格员开展入户走访，了解居民需求，排查矛盾纠纷。', '<h2>行动目的</h2><p>深入了解辖区居民生活状况，及时发现和化解矛盾纠纷，做到\"小事不出网格，大事不出社区\"。</p><h2>走访安排</h2><table border=\"1\" style=\"width:100%;border-collapse:collapse;\"><tbody><tr><th>日期</th><th>时间</th><th>区域</th><th>负责人</th></tr><tr><td>10月15日</td><td>9:00-11:30</td><td>第一网格</td><td>张网格员</td></tr><tr><td>10月17日</td><td>9:00-11:30</td><td>第二网格</td><td>李网格员</td></tr><tr><td>10月19日</td><td>9:00-11:30</td><td>第三网格</td><td>王网格员</td></tr></tbody></table><h2>走访重点</h2><ul><li>独居老人、残疾人等特殊群体</li><li>矛盾纠纷排查</li><li>居民诉求收集</li><li>政策法规宣传</li><li>安全隐患排查</li></ul><h2>工作要求</h2><p>做好走访记录，建立台账，对发现的问题及时上报处理。</p>', '2025-10-15', '2025-10-26', '入户走访', '各网格区域', '街道综治办、社区居委会', 190, 'http://localhost:9090/files/1773379072767-ade2bade70ed8e077c796f2b6c241722.jpg');
INSERT INTO `activity` VALUES (5, '矛盾纠纷调解专项行动', '通过网格化管理，及时发现和调解辖区内各类矛盾纠纷，维护社区和谐稳定。', '<h2>行动简介</h2><p>为有效化解基层矛盾纠纷，维护社会和谐稳定，开展矛盾纠纷排查调解专项行动。</p><h2>调解范围</h2><ul><li>邻里纠纷</li><li>物业管理纠纷</li><li>家庭矛盾</li><li>劳动争议</li></ul><h2>工作流程</h2><p><strong>第一步：</strong>网格员日常巡查发现矛盾线索<br/><strong>第二步：</strong>初步了解情况，登记备案<br/><strong>第三步：</strong>组织调解，邀请相关方参与<br/><strong>第四步：</strong>达成调解协议，跟踪回访</p><h2>调解原则</h2><ul><li>依法调解，公平公正</li><li>自愿平等，尊重当事人意愿</li><li>及时高效，就地化解</li></ul>', '2025-10-15', '2025-10-28', '现场调解', '各社区调解室', '司法所、人民调解委员会', 324, 'http://localhost:9090/files/1773379066452-181f05520fb233434dcb8c071263c01d.jpeg');
INSERT INTO `activity` VALUES (6, '网格员法治业务培训', '针对网格员开展法治业务培训，提升网格员依法治理能力和服务水平。', '<h2>培训背景</h2><p>网格员是基层治理的重要力量，为提升网格员的法治素养和业务能力，特组织本次专项培训。</p><h2>培训对象</h2><ul><li>社区网格员</li><li>网格长</li><li>社区工作者</li><li>志愿者骨干</li></ul><h2>培训内容</h2><h3>第一部分：法律基础知识</h3><ul><li>民法典常用条款</li><li>治安管理处罚法</li><li>人民调解法</li><li>信访条例</li></ul><h3>第二部分：网格化管理实务</h3><ul><li>网格巡查规范</li><li>事件上报流程</li><li>矛盾纠纷调解技巧</li><li>群众工作方法</li></ul><h3>第三部分：案例分析</h3><p>结合真实案例，深入剖析基层治理中的典型问题和处理方法。</p><h2>培训安排</h2><p>每场培训时长2小时，小班授课，每班限40人。<br/>培训地点：街道综治中心<br/>培训时间：10月15日-20日，每天上午9:00-11:00，下午14:00-16:00</p>', '2025-10-15', '2025-10-30', '集中培训', '街道综治中心', '司法所、街道综治办', 170, 'http://localhost:9090/files/1773379061636-5f73fc278bfe8e3ecaef2a7fbf8b9064.jpeg');
INSERT INTO `activity` VALUES (7, '平安社区创建评比活动', '开展平安社区创建评比，评选优秀网格、优秀网格员，推动基层治理水平提升。', '<h2>活动介绍</h2><p>为推动网格化治理工作深入开展，激发网格员工作积极性，开展平安社区创建评比活动。</p><h2>评比内容</h2><ul><li>网格巡查覆盖率</li><li>事件上报及时率</li><li>矛盾纠纷化解率</li><li>居民满意度</li><li>创新工作举措</li></ul><h2>评比标准</h2><ul><li>网格管理规范化（30%）</li><li>事件处置及时性（30%）</li><li>居民满意度（25%）</li><li>创新工作亮点（15%）</li></ul><h2>时间安排</h2><p><strong>10月15-18日：</strong>自查自评阶段<br/><strong>10月19日：</strong>检查评审<br/><strong>10月20日：</strong>公布结果并表彰</p><h2>奖项设置</h2><ul><li>优秀网格3个：奖金5000元+锦旗</li><li>优秀网格员5名：奖金3000元+证书</li><li>先进个人10名：奖金1000元+证书</li></ul>', '2025-10-15', '2025-10-25', '评比活动', '各社区', '街道党工委、综治办', 318, 'http://localhost:9090/files/1773379056624-0ba1b38e066b98526d56f62b99ee9341.jpg');

-- ----------------------------
-- Table structure for activity_sign
-- ----------------------------
DROP TABLE IF EXISTS `activity_sign`;
CREATE TABLE `activity_sign`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `activity_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `activity_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sign_time` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of activity_sign
-- ----------------------------
INSERT INTO `activity_sign` VALUES (1, '2', '社区网格安全隐患排查', '1', 'll123', '2025-10-11 20:43:44');
INSERT INTO `activity_sign` VALUES (2, '5', '矛盾纠纷调解专项行动', '1', 'll123', '2025-10-21 13:25:31');
INSERT INTO `activity_sign` VALUES (3, '6', '网格员法治业务培训', '1', 'll123', '2025-10-21 13:40:31');

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', '管理员', 'http://localhost:9090/files/1761016897715-39ffedd5332ce668fc6efd98a0d707cd.jpeg', 'ADMIN', '18744525412', '4545454@qq.com');

-- ----------------------------
-- Table structure for law
-- ----------------------------
DROP TABLE IF EXISTS `law`;
CREATE TABLE `law`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '内容',
  `descr` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '简介',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面图',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型：政策解读、法规动态、治理经验',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标签',
  `author` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布人',
  `publish_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布时间',
  `read_count` int(0) NULL DEFAULT 0 COMMENT '浏览量',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '已发布' COMMENT '状态：已发布、草稿',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '法律法规' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of law
-- ----------------------------
INSERT INTO `law` VALUES (3, '《民法典》物权编解读：业主权利与物业管理', '<h2>政策背景</h2><p>《民法典》物权编对业主的建筑物区分所有权作出了详细规定，明确了业主在物业管理中的权利和义务。</p><h2>核心要点</h2><p><strong>第一，业主共有权</strong></p><p>建筑区划内的道路、绿地、公共场所等属于业主共有，物业公司无权擅自改变用途。</p><p><strong>第二，业主大会决议</strong></p><p>涉及业主共同利益的重大事项，应当由业主大会依法表决决定。</p><p><strong>第三，物业服务合同</strong></p><p>业主有权依法更换物业服务企业，物业公司不得以任何理由拒绝移交。</p><h2>实务指引</h2><p>✓ 业主应积极参与业主大会，行使表决权</p><p>✓ 对物业服务不满意可依法维权</p><p>✓ 保留相关证据，通过合法途径解决纠纷</p><p>✓ 遇到侵权行为可向住建部门投诉</p>', '深度解读《民法典》物权编中关于业主权利与物业管理的规定，帮助居民依法维护自身权益。', 'http://localhost:9090/files/1760977045494-39ffedd5332ce668fc6efd98a0d707cd.jpeg', '政策解读', '[\"民法典\",\"物权\",\"物业管理\"]', '法律顾问', '2025-10-12', 423, '已发布');
INSERT INTO `law` VALUES (4, '新修订《治安管理处罚法》要点解读', '<h2>修订背景</h2><p>新修订的《治安管理处罚法》进一步完善了治安管理处罚的种类和适用规则，加大了对违法行为的惩处力度。</p><h2>主要修订内容</h2><p><strong>要点一：扩大处罚范围</strong></p><p>将高空抛物、抢夺方向盘等危害公共安全的行为纳入治安管理处罚范围。</p><p><strong>要点二：加大处罚力度</strong></p><p>对多次违反治安管理的行为人，可以从重处罚。</p><p><strong>要点三：完善程序规定</strong></p><p>进一步规范执法程序，保障当事人合法权益。</p><h2>与网格治理的关系</h2><p>• 网格员发现治安隐患应及时上报</p><p>• 配合公安机关做好治安防控</p><p>• 引导居民依法解决纠纷</p><p>• 做好法治宣传教育工作</p>', '新修订《治安管理处罚法》正式实施，多项新规与基层治理密切相关，网格员需重点学习。', 'http://localhost:9090/files/1760977063480-e0bd883fde02799d2490449ce9e07203_thumb.jpg', '法规动态', '[\"治安管理\",\"处罚法\",\"基层治理\"]', '司法局', '2025-10-18', 567, '已发布');
INSERT INTO `law` VALUES (5, '某街道网格化治理经验：矛盾纠纷化解率达98%', '<h2>经验介绍</h2><p>某街道通过推行\"网格+调解\"模式，建立三级矛盾纠纷化解机制，实现矛盾纠纷化解率98%，群众满意度95%以上。</p><h2>主要做法</h2><p><strong>1. 建立三级调解网络</strong></p><p>网格员初调→社区调委会复调→街道调解中心终调，层层化解矛盾。</p><p><strong>2. 推行\"网格吹哨、部门报到\"</strong></p><p>网格员发现问题后，相关职能部门必须在规定时间内响应处置。</p><p><strong>3. 建立矛盾纠纷台账</strong></p><p>对每一起矛盾纠纷建立台账，跟踪处理进度，确保件件有回音。</p><p><strong>4. 定期回访制度</strong></p><p>调解完成后定期回访当事人，防止矛盾反弹。</p><h2>成效展示</h2><p>• 矛盾纠纷化解率从85%提升至98%</p><p>• 信访量同比下降40%</p><p>• 群众满意度提升至95%以上</p><p>• 获评\"全市平安建设先进街道\"</p>', '某街道推行\"网格+调解\"模式，矛盾纠纷化解率达98%，为基层治理提供了可复制的经验。', 'http://localhost:9090/files/1760977035619-0fad79baf4bea5d59149a6857644d3ef.jpg', '治理经验', '[\"矛盾调解\",\"网格治理\",\"经验推广\"]', '综治办', '2025-10-16', 892, '已发布');
INSERT INTO `law` VALUES (6, '《社区矫正法》实施细则发布，网格员职责明确', '<h2>政策要点</h2><p>《社区矫正法》实施细则正式发布，进一步明确了社区矫正工作中各方的职责分工，网格员在社区矫正中的协助职责得到明确。</p><h2>网格员相关职责</h2><p><strong>信息报告</strong></p><p>发现社区矫正对象异常情况及时向司法所报告。</p><p><strong>日常监督</strong></p><p>协助做好社区矫正对象的日常监管工作。</p><p><strong>帮扶教育</strong></p><p>参与社区矫正对象的教育帮扶活动。</p><p><strong>风险评估</strong></p><p>配合开展社区矫正对象的风险评估工作。</p><h2>工作建议</h2><p>1. 加强与司法所的沟通协作</p><p>2. 做好信息保密工作</p><p>3. 注意工作方式方法</p><p>4. 定期参加业务培训</p>', '《社区矫正法》实施细则发布，明确网格员在社区矫正中的协助职责，推动基层法治建设。', 'http://localhost:9090/files/1760977026723-f5975857b591dad0dd5c3e7f501edf34.png', '法规动态', '[\"社区矫正\",\"网格员职责\",\"法治建设\"]', '司法局', '2025-10-14', 1234, '已发布');
INSERT INTO `law` VALUES (7, '网格化治理典型案例：老旧小区改造中的依法治理', '<h2>案例背景</h2><p>某社区老旧小区改造项目涉及200余户居民，因改造方案分歧，部分居民反对施工，矛盾一度激化。</p><h2>治理过程</h2><p><strong>第一步：网格摸排</strong></p><p>网格员逐户走访，了解居民诉求，建立问题台账。</p><p><strong>第二步：分类施策</strong></p><p>将居民诉求分为合理诉求、部分合理诉求和不合理诉求三类，分别制定应对方案。</p><p><strong>第三步：依法协商</strong></p><p>组织居民代表、施工方、社区三方协商，依据相关法律法规寻求解决方案。</p><p><strong>第四步：跟踪落实</strong></p><p>达成协议后，网格员持续跟踪落实情况，确保各方履行承诺。</p><h2>经验总结</h2><p>• 充分尊重居民知情权和参与权</p><p>• 依法依规推进改造工作</p><p>• 网格员发挥桥梁纽带作用</p><p>• 建立长效沟通机制</p>', '老旧小区改造中的依法治理典型案例，展示网格化管理在化解群体性矛盾中的重要作用。', 'http://localhost:9090/files/1760977011106-a59dfa23fa56942298c73b21b3d351cc.jpeg', '治理经验', '[\"老旧小区\",\"依法治理\",\"矛盾化解\"]', '综治办', '2025-10-13', 678, '已发布');
INSERT INTO `law` VALUES (8, '《人民调解法》要点解读：网格员调解工作指南', '<h2>法律要点</h2><p>《人民调解法》是指导基层调解工作的重要法律，网格员在日常工作中经常需要参与矛盾纠纷调解。</p><h2>调解原则</h2><p><strong>1. 自愿原则</strong></p><p>调解必须在当事人自愿的基础上进行，不得强迫调解。</p><p><strong>2. 合法原则</strong></p><p>调解协议不得违反法律法规和国家政策。</p><p><strong>3. 公平原则</strong></p><p>调解人应当公正中立，不偏袒任何一方。</p><h2>调解程序</h2><p>• 受理申请或主动介入</p><p>• 调查了解情况</p><p>• 组织调解</p><p>• 达成调解协议</p><p>• 制作调解协议书</p><p>• 跟踪回访</p><h2>注意事项</h2><p>1. 做好调解记录</p><p>2. 调解协议书应当由双方签字</p><p>3. 涉及人身安全的纠纷应及时报警</p><p>4. 超出调解范围的应引导当事人通过法律途径解决</p>', '详细解读《人民调解法》核心要点，为网格员开展调解工作提供法律指引和操作规范。', 'http://localhost:9090/files/1760976940244-cb074c6fbd3dc31e33c263e001c8b3bf.jpeg', '政策解读', '[\"人民调解\",\"调解程序\",\"网格员\"]', '司法局', '2025-10-17', 447, '已发布');
INSERT INTO `law` VALUES (9, '基层治理经验：如何做好特殊人群服务管理', '<h2>工作背景</h2><p>特殊人群（独居老人、残疾人、精神障碍患者、刑满释放人员等）的服务管理是网格化治理的重要内容。</p><h2>工作方法</h2><p><strong>一、建立信息台账</strong></p><p>对辖区特殊人群进行全面摸排，建立详细的信息台账，做到底数清、情况明。</p><p><strong>二、分类管理服务</strong></p><p>根据不同类型的特殊人群，制定差异化的服务管理方案。</p><p><strong>三、定期走访关怀</strong></p><p>网格员定期上门走访，了解生活状况，提供必要帮助。</p><p><strong>四、联动帮扶机制</strong></p><p>建立网格员+社工+志愿者的联动帮扶机制，形成工作合力。</p><h2>典型做法</h2><p>• 为独居老人建立\"一人一档\"</p><p>• 定期开展安全检查和健康关怀</p><p>• 协助办理各类救助和补贴</p><p>• 组织社区互助活动</p>', '分享特殊人群服务管理的基层治理经验，帮助网格员做好精细化服务管理工作。', 'http://localhost:9090/files/1773379114367-bb45840327d943050d494b601c166d14.jpg', '治理经验', '[\"特殊人群\",\"服务管理\",\"网格治理\"]', '民政局', '2025-10-11', 524, '已发布');
INSERT INTO `law` VALUES (10, '2025年基层治理重点工作部署：网格化管理全覆盖', '<h2>工作部署</h2><p>2025年，全面推进网格化管理全覆盖，实现\"人在格中走、事在格中办\"的治理目标。</p><h2>重点任务一：网格优化调整</h2><p><strong>要求：</strong>按照300-500户标准划分网格，确保全域覆盖、不留死角。</p><h2>重点任务二：网格员队伍建设</h2><p><strong>要求：</strong>每个网格配备1名专职网格员，加强培训考核。</p><h2>重点任务三：信息化平台建设</h2><p><strong>要求：</strong>建设网格化治理信息平台，实现事件上报、流转、处置全流程信息化。</p><h2>重点任务四：矛盾纠纷化解</h2><p><strong>要求：</strong>建立\"网格发现、社区吹哨、部门报到\"工作机制。</p><h2>重点任务五：平安创建</h2><p><strong>要求：</strong>深入开展平安社区创建活动，提升群众安全感和满意度。</p><h2>考核指标</h2><p>1. 网格覆盖率100%</p><p>2. 事件处置及时率≥95%</p><p>3. 矛盾纠纷化解率≥90%</p><p>4. 群众满意度≥90%</p>', '2025年基层治理重点工作部署发布，全面推进网格化管理全覆盖，明确五大重点任务和考核指标。', 'http://localhost:9090/files/1773379100932-bec546fe71b52dcbd4d3784a18752977.jpeg', '法规动态', '[\"工作部署\",\"网格化管理\",\"基层治理\"]', '综治办', '2025-10-20', 1568, '已发布');
INSERT INTO `law` VALUES (11, '《信访工作条例》学习要点', '<p>《信访工作条例》明确了信访工作的基本原则、工作体制和信访事项的提出、受理、办理程序，网格员应当熟悉相关规定，引导群众依法信访。</p>', '《信访工作条例》核心要点学习，帮助网格员引导群众依法依规反映诉求。', 'http://localhost:9090/files/1773379092416-f866a0116d57c507f3e4864d364f5aab.png', '政策解读', '[\"信访\",\"条例\",\"依法信访\"]', '信访局', '2025-10-21', 0, '已发布');

-- ----------------------------
-- Table structure for blog
-- ----------------------------
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '内容',
  `descr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '简介',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标签',
  `user_id` int(0) NULL DEFAULT NULL COMMENT '发布人ID',
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布日期',
  `read_count` int(0) NULL DEFAULT 0 COMMENT '浏览量',
  `category_id` int(0) NULL DEFAULT NULL COMMENT '分类ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '工作日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of blog
-- ----------------------------
INSERT INTO `blog` VALUES (1, '第一网格10月巡查日志：发现消防通道堵塞问题', '<h2>巡查情况</h2><p>今日对第一网格辖区进行例行巡查，重点检查了阳光小区、幸福家园两个居民区。</p><h2>发现问题</h2><p>1. 阳光小区3号楼消防通道被私家车占用，已拍照取证<br/>2. 幸福家园B栋楼道内堆放杂物，存在消防隐患<br/>3. 阳光小区垃圾分类投放点需要维护</p><h2>处理措施</h2><p>• 已联系物业要求清理消防通道<br/>• 已通知相关住户限期清理楼道杂物<br/>• 已上报社区申请垃圾分类设施维修</p>', '第一网格日常巡查，发现消防通道堵塞等安全隐患，已及时上报处理。', 'http://localhost:9090/files/1761014201522-d0c6c592a3d8e10d70d79d6498e21071.png', '[\"巡查日志\",\"消防安全\",\"隐患排查\"]', 4, '2025-10-18', 240, 1);
INSERT INTO `blog` VALUES (2, '成功调解邻里噪音纠纷，双方握手言和', '<h2>事件经过</h2><p>接到阳光小区5号楼302室张大爷投诉，楼上402室装修噪音严重影响其休息，双方多次发生口角。</p><h2>调解过程</h2><p>我第一时间上门了解情况，分别与双方当事人沟通。了解到402室确实在进行装修，但施工时间有时超出规定时段。</p><p>经过耐心调解，双方达成以下协议：</p><p>1. 装修施工严格控制在8:00-12:00、14:00-18:00</p><p>2. 周末及节假日不进行噪音较大的施工</p><p>3. 402室向302室表示歉意</p><h2>调解结果</h2><p>双方签署调解协议书，握手言和。后续将持续跟踪回访。</p>', '成功调解邻里装修噪音纠纷，双方达成协议，社区和谐得到维护。', 'http://localhost:9090/files/1761014210153-4ad5efcc37e7f69145e7f1e5a9f08212.png', '[\"矛盾调解\",\"邻里纠纷\",\"工作记录\"]', 5, '2025-10-17', 456, 4);
INSERT INTO `blog` VALUES (3, '辖区内发现违规搭建，已上报处理', '<h2>问题描述</h2><p>今日巡查发现和谐社区12号楼顶层有居民违规搭建阳光房，面积约20平方米，存在安全隐患。</p><h2>处理过程</h2><p><strong>@网格长张三：</strong>已拍照取证并上报城管执法部门。</p><p><strong>@社区主任李四：</strong>已联系当事人进行劝导，告知违规搭建的法律后果。</p><p><strong>@城管执法王五：</strong>正确的做法是：<br/>1. 网格员发现后及时上报<br/>2. 社区进行初步劝导<br/>3. 城管部门依法处理<br/>4. 网格员跟踪落实</p><h2>处理进展</h2><p>城管部门已下达限期拆除通知书，当事人表示配合。</p>', '巡查发现违规搭建问题，已按流程上报并协调处理，当事人表示配合整改。', 'http://localhost:9090/files/1761014121913-59ac3bbb6adf0a3a75989af9aaddd410.jpeg', '[\"违规搭建\",\"巡查发现\",\"依法处理\"]', 1, '2025-10-16', 189, 5);
INSERT INTO `blog` VALUES (4, '网格员工作经验分享：如何做好入户走访', '<h2>经验一：做好准备工作</h2><p>走访前了解住户基本信息，准备好相关宣传资料。<br/><strong>要点：</strong>带好工作证、走访记录本、宣传材料。</p><h2>经验二：注意沟通技巧</h2><p>态度亲切，语言通俗易懂，耐心倾听居民诉求。<br/><strong>要点：</strong>先拉家常再谈工作，让居民感到亲切。</p><h2>经验三：做好记录</h2><p>走访中发现的问题要详细记录，及时上报。<br/><strong>要点：</strong>记录要准确、完整，包括时间、地点、人物、事件。</p><h2>经验四：及时反馈</h2><p>对居民反映的问题要及时反馈处理结果。<br/><strong>要点：</strong>做到\"件件有回音、事事有着落\"。</p><h2>工作建议</h2><p>• 建立走访台账，定期回顾<br/>• 重点关注特殊群体<br/>• 善于发现安全隐患<br/>• 做好政策宣传</p>', '分享网格员入户走访的实用经验和技巧，帮助新网格员快速上手。', 'http://localhost:9090/files/1761014185797-07cb1a57cdaa145d6c06c209b2faaeea.jpeg', '[\"入户走访\",\"工作经验\",\"网格员技巧\"]', 9, '2025-10-15', 512, 2);
INSERT INTO `blog` VALUES (5, '求助：辖区内电动车充电桩不足，居民私拉电线充电', '<h2>问题情况</h2><p>我负责的第三网格辖区内，由于电动车充电桩严重不足，多名居民私拉电线从楼上给电动车充电，存在严重安全隐患。</p><p>已多次劝导但效果不佳，居民表示充电桩太少，排队时间太长。请问各位同事有什么好的解决办法？</p><h2>同事建议</h2><p><strong>@网格员赵六：</strong>建议向社区申请增设充电桩，同时加强安全宣传。</p><p><strong>@网格长张三：</strong>可以联合物业、消防部门开展联合整治，同时推动充电设施建设。</p><p><strong>@社区主任李四：</strong>已将充电桩增设纳入社区改造计划，预计下月开工。</p><h2>处理进展</h2><p>1. 已上报社区申请增设充电桩<br/>2. 联合消防部门开展安全检查<br/>3. 张贴安全警示标语<br/>4. 对私拉电线住户逐一劝导</p>', '辖区电动车充电桩不足导致居民私拉电线，存在安全隐患，求解决方案。', 'http://localhost:9090/files/1761014174201-4643609be474be3059d1c613fdc67dab.jpeg', '[\"电动车充电\",\"安全隐患\",\"求助\"]', 10, '2025-10-14', 678, 11);
INSERT INTO `blog` VALUES (6, '关爱独居老人：网格员的暖心故事', '<h2>起因</h2><p>上周巡查时发现辖区内82岁的王奶奶已经两天没出门了，敲门无人应答。我立即联系了她的子女和社区，最终破门发现王奶奶因感冒卧床不起。</p><h2>独居老人面临的问题</h2><p>1. 突发疾病无人发现<br/>2. 日常生活不便<br/>3. 精神孤独<br/>4. 容易遭遇诈骗</p><h2>我的做法</h2><p><strong>建立关爱档案：</strong><br/>• 记录独居老人基本信息和紧急联系人<br/>• 了解健康状况和用药情况<br/>• 定期上门走访</p><p><strong>建立邻里互助：</strong><br/>• 发动邻居关注独居老人<br/>• 建立微信联络群<br/>• 定期组织社区活动</p><h2>呼吁</h2><p>关爱独居老人是网格员的重要职责，希望每位网格员都能多一份关心，让老人感受到社区的温暖。</p>', '分享关爱独居老人的工作经历，呼吁网格员加强对特殊群体的关注和服务。', 'http://localhost:9090/files/1761014168186-b98ecf835dca6709946a55aef771787c.jpeg', '[\"独居老人\",\"关爱服务\",\"暖心故事\"]', 4, '2025-10-13', 823, 4);
INSERT INTO `blog` VALUES (7, '第二网格环境整治工作记录', '<h2>整治内容</h2><p><strong>第一项：</strong>对辖区内卫生死角进行全面清理，重点清理了3处垃圾堆放点。</p><p><strong>第二项：</strong>协调物业修复了2处破损路面。</p><p><strong>第三项：</strong>清理了小区内5处小广告。</p><p><strong>第四项：</strong>修剪了遮挡路灯的树枝。</p><h2>整治成效</h2><p>居民反映小区环境明显改善，物业配合度较高。</p><h2>后续计划</h2><p>• 建立环境卫生长效管理机制<br/>• 定期开展环境巡查<br/>• 发动居民参与环境维护<br/>• 推进垃圾分类工作</p>', '第二网格环境整治工作记录，清理卫生死角、修复破损设施，小区环境明显改善。', 'http://localhost:9090/files/1761014159812-a59dfa23fa56942298c73b21b3d351cc.jpeg', '[\"环境整治\",\"网格工作\",\"社区治理\"]', 5, '2025-10-12', 446, 1);
INSERT INTO `blog` VALUES (8, '物业纠纷处理案例：业主与物业的停车位之争', '<h2>问题</h2><p>锦绣社区多名业主反映，物业公司将小区公共停车位私自出租给非业主车辆，导致业主无处停车。双方矛盾激化，部分业主准备集体上访。</p><h2>处理过程</h2><p><strong>@网格员：</strong><br/>1. 第一时间上门了解情况，安抚业主情绪<br/>2. 查阅物业服务合同和小区规划图纸<br/>3. 组织业主代表与物业公司协商<br/>4. 邀请社区法律顾问参与调解</p><h2>处理结果</h2><p><strong>达成协议：</strong><br/>• 物业公司停止向非业主出租停车位<br/>• 已出租的停车位限期收回<br/>• 物业公司向业主公开道歉<br/>• 建立停车位管理公示制度</p><h2>经验总结</h2><p>• 及时介入，防止矛盾升级<br/>• 依法依规，用法律说话<br/>• 多方协调，寻求共赢方案<br/>• 建立长效机制，防止问题反复</p>', '成功调解业主与物业停车位纠纷，依法维护业主权益，避免了集体上访事件。', 'http://localhost:9090/files/1761014148430-cb074c6fbd3dc31e33c263e001c8b3bf.jpeg', '[\"物业纠纷\",\"停车位\",\"依法调解\"]', 9, '2025-10-11', 570, 5);
INSERT INTO `blog` VALUES (9, '网格员安全巡查清单分享：这些要点别遗漏', '<h2>消防安全检查</h2><p>✓ 消防通道是否畅通</p><p>✓ 灭火器是否在有效期内</p><p>✓ 楼道是否堆放杂物</p><p>✓ 电动车是否违规充电</p><p>✓ 消防设施是否完好</p><h2>治安安全检查</h2><p>✓ 门禁系统是否正常</p><p>✓ 监控设备是否运行</p><p>✓ 路灯照明是否正常</p><p>✓ 是否有可疑人员活动</p><p>✓ 是否有安全隐患</p><h2>环境卫生检查</h2><p>✓ 垃圾是否及时清运</p><p>✓ 公共区域是否整洁</p><p>✓ 绿化是否维护到位</p><p>✓ 排水设施是否通畅</p><h2>民生服务检查</h2><p>✓ 独居老人是否安好</p><p>✓ 残疾人是否需要帮助</p><p>✓ 是否有居民反映问题</p><p>✓ 公共设施是否完好</p><h2>巡查建议</h2><p>• 每日巡查不少于2次</p><p>• 做好巡查记录</p><p>• 发现问题及时上报</p><p>• 重点区域重点关注</p>', '分享网格员日常安全巡查清单，涵盖消防、治安、环境、民生四大方面，供同事参考。', 'http://localhost:9090/files/1761014076379-4643609be474be3059d1c613fdc67dab.jpeg', '[\"巡查清单\",\"安全检查\",\"工作规范\"]', 10, '2025-10-10', 935, 2);
INSERT INTO `blog` VALUES (10, '网格化治理让社区更安全：我的工作感悟', '<h2>工作感悟</h2><p>从事网格员工作一年多来，我深刻感受到网格化治理给社区带来的变化。</p><h2>变化一：问题发现更及时</h2><p>以前居民反映问题要跑好几个部门，现在网格员每天巡查，问题在萌芽阶段就能发现和处理。</p><h2>变化二：矛盾化解更高效</h2><p>网格员就在居民身边，矛盾纠纷能第一时间介入调解，避免小事变大事。</p><h2>变化三：服务更贴心</h2><p>独居老人有人关心，残疾人有人帮助，居民办事有人指引，社区服务更加精细化。</p><h2>工作体会</h2><p><strong>用心：</strong>把居民的事当自己的事<br/><strong>用情：</strong>用真心换真情<br/><strong>用法：</strong>依法依规办事<br/><strong>用智：</strong>善于总结创新</p><h2>展望</h2><p>希望通过我们每一位网格员的努力，让社区更安全、更和谐、更美好。</p>', '分享网格员工作一年多的感悟，网格化治理让社区问题发现更及时、矛盾化解更高效。', 'http://localhost:9090/files/1761014056708-66dd1ea3dbd5dea00642b2e304000470.jpeg', '[\"工作感悟\",\"网格治理\",\"社区变化\"]', 4, '2025-10-09', 1175, 4);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '事件分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '安全隐患');
INSERT INTO `category` VALUES (2, '工作经验');
INSERT INTO `category` VALUES (4, '矛盾调解');
INSERT INTO `category` VALUES (5, '问题上报');
INSERT INTO `category` VALUES (11, '求助交流');

-- ----------------------------
-- Table structure for chapter
-- ----------------------------
DROP TABLE IF EXISTS `chapter`;
CREATE TABLE `chapter`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '章节标题',
  `descr` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '章节简介',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '章节封面图',
  `sort_order` int(0) NULL DEFAULT 0 COMMENT '排序',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '已发布' COMMENT '状态：已发布、草稿、下架',
  `create_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '法治培训章节' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chapter
-- ----------------------------
INSERT INTO `chapter` VALUES (1, '第一章：网格化管理基础知识', '了解网格化管理的基本概念、工作职责和管理规范', 'http://localhost:9090/files/1760977158984-7ead0a5fc5a1a7aa0a8a1647429c5b94.jpg', 1, '已发布', '2025-10-10 10:00:00');
INSERT INTO `chapter` VALUES (2, '第二章：矛盾纠纷调解实务', '深入学习矛盾纠纷调解的方法技巧和法律依据', 'http://localhost:9090/files/1760977170474-4127092eba73509fa8e7f50b911ba0e7.png', 2, '已发布', '2025-10-11 10:00:00');
INSERT INTO `chapter` VALUES (3, '第三章：基层法治建设', '了解基层法治建设的要求和网格员在法治建设中的作用', 'http://localhost:9090/files/1760977185393-4ad5efcc37e7f69145e7f1e5a9f08212.png', 3, '已发布', '2025-10-12 10:00:00');
INSERT INTO `chapter` VALUES (4, '第四章：应急处置与安全管理', '学习突发事件应急处置和社区安全管理知识', 'http://localhost:9090/files/1761025885902-82c63b2bd95b4c7481f703107962d0d0.jpg', 4, '已发布', '2025-10-21 13:51:31');

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `fid` int(0) NULL DEFAULT NULL COMMENT '关联ID',
  `user_id` int(0) NULL DEFAULT NULL COMMENT '收藏人ID',
  `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '模块',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '收藏' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES (24, 9, 1, '博客');
INSERT INTO `collect` VALUES (27, 8, 1, '帖子');
INSERT INTO `collect` VALUES (28, 10, 1, '帖子');
INSERT INTO `collect` VALUES (31, 9, 1, '帖子');
INSERT INTO `collect` VALUES (32, 7, 1, '活动');
INSERT INTO `collect` VALUES (33, 10, 1, '博客');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `user_id` int(0) NULL DEFAULT NULL COMMENT '评论人',
  `pid` int(0) NULL DEFAULT NULL COMMENT '父级ID',
  `root_id` int(0) NULL DEFAULT NULL COMMENT '根节点ID',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论时间',
  `fid` int(0) NULL DEFAULT NULL COMMENT '关联ID',
  `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '模块',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (50, '这个问题我们网格也遇到过', 1, NULL, 50, '2025-10-21 10:44:08', 10, '帖子');
INSERT INTO `comment` VALUES (51, '可以参考我们的做法', 1, 50, 50, '2025-10-21 10:48:59', 10, '帖子');
INSERT INTO `comment` VALUES (52, '处理得很好，学习了', 1, NULL, 52, '2025-10-21 11:24:15', 8, '帖子');
INSERT INTO `comment` VALUES (53, '巡查清单很实用，收藏了', 1, NULL, 53, '2025-10-21 11:30:39', 9, '帖子');
INSERT INTO `comment` VALUES (54, '网格化治理确实让社区变化很大', 1, NULL, 54, '2025-10-21 13:40:19', 10, '帖子');

-- ----------------------------
-- Table structure for knowledge
-- ----------------------------
DROP TABLE IF EXISTS `knowledge`;
CREATE TABLE `knowledge`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '内容',
  `descr` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '简介',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面图',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型：治理指南、典型案例',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类：矛盾调解、安全管理、环境治理等',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标签',
  `author` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布人',
  `publish_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布时间',
  `read_count` int(0) NULL DEFAULT 0 COMMENT '浏览量',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '已发布' COMMENT '状态：已发布、草稿',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '治理案例库' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of knowledge
-- ----------------------------
INSERT INTO `knowledge` VALUES (1, '邻里纠纷调解指南：常见类型与处理方法', '<h2>常见邻里纠纷类型</h2><p><strong>1. 噪音扰民纠纷</strong></p><p>装修噪音、生活噪音、宠物扰民等，是最常见的邻里纠纷类型。</p><p><strong>2. 漏水渗水纠纷</strong></p><p>楼上漏水导致楼下受损，责任认定和赔偿问题容易引发矛盾。</p><p><strong>3. 公共空间占用</strong></p><p>楼道堆物、占用停车位、私搭乱建等问题。</p><h2>调解方法</h2><p>✓ 第一时间上门了解情况，安抚双方情绪</p><p>✓ 分别听取双方诉求，找到矛盾焦点</p><p>✓ 依据相关法律法规进行调解</p><p>✓ 达成书面调解协议，跟踪回访</p>', '详细讲解邻里纠纷的常见类型和调解方法，帮助网格员提高矛盾化解能力。', 'http://localhost:9090/files/1760977538912-7ead0a5fc5a1a7aa0a8a1647429c5b94.jpg', '治理指南', '矛盾调解', '[\"邻里纠纷\",\"调解方法\",\"工作指南\"]', '司法所', '2025-10-15', 90, '已发布');
INSERT INTO `knowledge` VALUES (2, '社区消防安全管理工作指南', '<h2>消防安全管理要点</h2><p><strong>日常巡查</strong></p><p>每日巡查消防通道、消防设施、电动车充电等重点部位。</p><p><strong>隐患排查</strong></p><p>定期开展消防安全隐患排查，建立隐患台账，跟踪整改。</p><h2>常见消防隐患</h2><p>• 消防通道被占用或堵塞</p><p>• 楼道内堆放易燃杂物</p><p>• 电动车违规充电</p><p>• 消防设施损坏或过期</p><h2>处置流程</h2><p>✓ 发现隐患立即拍照取证</p><p>✓ 现场劝导当事人整改</p><p>✓ 上报社区和消防部门</p><p>✓ 跟踪整改落实情况</p>', '社区消防安全管理工作指南，涵盖日常巡查、隐患排查和处置流程。', 'http://localhost:9090/files/1760977521703-76aa991520eb7b2a5bf83dcaecda36ad.jpeg', '治理指南', '安全管理', '[\"消防安全\",\"隐患排查\",\"工作指南\"]', '消防大队', '2025-10-14', 158, '已发布');
INSERT INTO `knowledge` VALUES (3, '典型案例：物业纠纷的依法化解', '<h2>案例背景</h2><p><strong>案情：</strong>某小区业主因物业服务质量差拒交物业费，物业公司以断水断电相威胁，矛盾激化。</p><h2>处理过程</h2><p><strong>第一步：网格员介入</strong></p><p>网格员了解情况后，分别与业主和物业沟通。</p><p><strong>第二步：法律分析</strong></p><p>依据《民法典》和《物业管理条例》，物业公司无权断水断电。</p><p><strong>第三步：组织调解</strong></p><p>邀请社区法律顾问参与，组织三方协商。</p><h2>处理结果</h2><p>✓ 物业公司承诺改善服务质量</p><p>✓ 业主同意补缴物业费</p><p>✓ 建立物业服务监督机制</p><p>✓ 定期召开业主座谈会</p>', '物业纠纷依法化解典型案例，展示网格员在物业矛盾调解中的作用和方法。', 'http://localhost:9090/files/1760977510512-e1fa771a760787e717eb57fbd10df4fd.jpeg', '典型案例', '矛盾调解', '[\"物业纠纷\",\"依法化解\",\"典型案例\"]', '综治办', '2025-10-13', 236, '已发布');
INSERT INTO `knowledge` VALUES (4, '网格巡查工作规范与标准', '<h2>巡查规范</h2><p><strong>巡查频次</strong></p><p>每日巡查不少于2次，重点区域不少于3次。</p><p><strong>巡查内容</strong></p><p>治安安全、消防安全、环境卫生、公共设施、特殊人群等。</p><p><strong>巡查记录</strong></p><p>每次巡查应做好详细记录，包括时间、路线、发现问题及处理情况。</p><p><strong>问题上报</strong></p><p>发现问题应在30分钟内通过平台上报，紧急情况立即电话报告。</p><h2>巡查标准</h2><p>✓ 巡查覆盖率100%</p><p>✓ 问题发现率≥90%</p><p>✓ 上报及时率≥95%</p><p>✓ 处置反馈率100%</p>', '网格巡查工作规范与标准，明确巡查频次、内容、记录和上报要求。', 'http://localhost:9090/files/1760977473629-4ad5efcc37e7f69145e7f1e5a9f08212.png', '治理指南', '工作规范', '[\"巡查规范\",\"工作标准\",\"网格管理\"]', '综治办', '2025-10-12', 314, '已发布');
INSERT INTO `knowledge` VALUES (5, '典型案例：群体性事件的预防与处置', '<h2>案例背景</h2><p>某社区因道路施工影响居民出行，部分居民情绪激动，准备集体堵路抗议。</p><h2>预防措施</h2><p><strong>第一阶段：信息预警</strong></p><p>网格员在日常走访中发现居民不满情绪，及时上报。</p><p><strong>第二阶段：主动介入</strong></p><p>社区组织居民代表座谈，了解诉求，解释施工原因和工期。</p><p><strong>第三阶段：协调解决</strong></p><p>协调施工方调整施工时间，设置临时通道，减少对居民影响。</p><p><strong>第四阶段：跟踪回访</strong></p><p>持续关注居民情绪，及时回应诉求。</p><h2>经验总结</h2><p>✓ 早发现、早介入、早化解</p><p>✓ 充分尊重群众知情权</p><p>✓ 积极协调各方利益</p><p>✓ 建立长效沟通机制</p>', '群体性事件预防与处置典型案例，展示网格化管理在维护社会稳定中的重要作用。', 'http://localhost:9090/files/1760977434160-d0c6c592a3d8e10d70d79d6498e21071.png', '典型案例', '应急处置', '[\"群体性事件\",\"预防处置\",\"维稳\"]', '综治办', '2025-10-11', 459, '已发布');

-- ----------------------------
-- Table structure for lesson
-- ----------------------------
DROP TABLE IF EXISTS `lesson`;
CREATE TABLE `lesson`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `chapter_id` int(0) NULL DEFAULT NULL COMMENT '所属章节ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课时标题',
  `descr` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课时简介',
  `video_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '视频地址',
  `duration` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '视频时长',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面图',
  `sort_order` int(0) NULL DEFAULT 0 COMMENT '排序',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '已发布' COMMENT '状态：已发布/草稿/下架',
  `create_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '法治培训课时' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of lesson
-- ----------------------------
INSERT INTO `lesson` VALUES (1, 1, '1.1 网格化管理的概念与发展', '介绍网格化管理的定义、发展历程和基本原则', 'http://localhost:9090/files/1760976738631-e0bd883fde02799d2490449ce9e07203.mp4', '5:30', 'http://localhost:9090/files/1760976612225-e0bd883fde02799d2490449ce9e07203_thumb.jpg', 1, '已发布', '2025-10-10 10:00:00');
INSERT INTO `lesson` VALUES (2, 1, '1.2 网格员的职责与权限', '详细讲解网格员的工作职责、权限范围和行为规范', 'http://localhost:9090/files/1760976744840-e0bd883fde02799d2490449ce9e07203.mp4', '8:15', 'http://localhost:9090/files/1760976758059-e0bd883fde02799d2490449ce9e07203_thumb.jpg', 2, '已发布', '2025-10-10 11:00:00');
INSERT INTO `lesson` VALUES (3, 1, '1.3 网格巡查与事件上报流程', '学习网格巡查规范和事件上报的标准流程', 'http://localhost:9090/files/1760976751643-e0bd883fde02799d2490449ce9e07203.mp4', '6:45', 'http://localhost:9090/files/1697438073596-avatar.png', 3, '已发布', '2025-10-10 12:00:00');
INSERT INTO `lesson` VALUES (4, 2, '2.1 矛盾纠纷的类型与特点', '了解基层常见矛盾纠纷的类型和特点', 'http://localhost:9090/files/sample-video.mp4', '7:20', 'http://localhost:9090/files/1697438073596-avatar.png', 1, '已发布', '2025-10-11 10:00:00');
INSERT INTO `lesson` VALUES (5, 2, '2.2 调解技巧与法律依据', '学习矛盾纠纷调解的实用技巧和法律依据', 'http://localhost:9090/files/sample-video.mp4', '9:10', 'http://localhost:9090/files/1697438073596-avatar.png', 2, '已发布', '2025-10-11 11:00:00');
INSERT INTO `lesson` VALUES (6, 3, '3.1 基层法治建设的要求', '了解新时代基层法治建设的目标和要求', 'http://localhost:9090/files/sample-video.mp4', '10:30', 'http://localhost:9090/files/1697438073596-avatar.png', 1, '已发布', '2025-10-12 10:00:00');
INSERT INTO `lesson` VALUES (7, 3, '3.2 网格员在法治建设中的作用', '学习网格员如何在日常工作中推进法治建设', 'http://localhost:9090/files/sample-video.mp4', '8:40', 'http://localhost:9090/files/1697438073596-avatar.png', 2, '已发布', '2025-10-12 11:00:00');
INSERT INTO `lesson` VALUES (8, 4, '4.1 突发事件应急处置', '学习突发事件的分类和应急处置流程', 'http://localhost:9090/files/1761025927270-e0bd883fde02799d2490449ce9e07203.mp4', '4:30', 'http://localhost:9090/files/1761025937524-69c2d825dad1b4c4b9b0e64b730c710e.jpeg', 9, '已发布', '2025-10-21 13:52:22');

-- ----------------------------
-- Table structure for likes
-- ----------------------------
DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `fid` int(0) NULL DEFAULT NULL COMMENT '关联ID',
  `user_id` int(0) NULL DEFAULT NULL COMMENT '点赞人ID',
  `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '模块',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '点赞' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of likes
-- ----------------------------
INSERT INTO `likes` VALUES (1, 9, 1, '博客');
INSERT INTO `likes` VALUES (2, 7, 1, '活动');
INSERT INTO `likes` VALUES (3, 8, 1, '帖子');
INSERT INTO `likes` VALUES (8, 10, 1, '博客');


-- ----------------------------
-- Table structure for report
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '事件类型：安全隐患 / 矛盾纠纷 / 环境问题 / 民生诉求',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '事件标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '详细内容',
  `contact_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '上报人姓名',
  `contact_phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '问题发生详细地址',
  `suspect_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '涉事地点 / 涉事人电话',
  `suspect_account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '所属网格 / 涉事账号',
  `suspect_link` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '关联信息',
  `evidence` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '证据文件 URL',
  `amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '涉及人数',
  `report_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '上报时间',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '待处理' COMMENT '处理状态（待处理 / 处理中 / 已处理）',
  `handler` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '处理人 / 处理部门',
  `handle_result` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '处理结果详情',
  `handle_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '处理时间',
  `user_id` int(0) NULL DEFAULT NULL COMMENT '上报人用户 ID（关联sys_user表id）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '网格事件上报' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of report
-- ----------------------------
INSERT INTO `report` VALUES (1, '安全隐患', '阳光小区3号楼消防通道被占用', '<p>阳光小区3号楼消防通道长期被私家车占用，存在严重消防安全隐患。</p><p>已拍照取证，建议联合消防部门和物业进行联合整治。</p>', '张网格员', '13800138001', NULL, '阳光小区3号楼', '第一网格', NULL, 'http://localhost:9090/files/1697438073596-avatar.png', NULL, '2025-10-15 10:30:00', '已处理', '李主任', '已联合消防部门和物业开展整治，清理占用车辆，设置禁停标识，安排专人巡查。', '2025-01-15 14:20:00', 4);
INSERT INTO `report` VALUES (2, '矛盾纠纷', '幸福家园5号楼邻里漏水纠纷', '<p>幸福家园5号楼302室反映楼上402室卫生间漏水，导致其天花板受损。</p><p>双方多次协商未果，302室要求赔偿维修费用5000元，402室认为金额过高。</p><p>矛盾有升级趋势，需要介入调解。</p>', '王网格员', '13900139002', NULL, '幸福家园5号楼', '第二网格', NULL, 'http://localhost:9090/files/1697438073596-avatar.png,http://localhost:9090/files/1697621121476-boy.png', 2.00, '2025-10-14 16:45:00', '处理中', '陈调解员', NULL, NULL, 5);
INSERT INTO `report` VALUES (3, '环境问题', '和谐社区垃圾堆放点卫生问题', '<p>和谐社区东门垃圾堆放点长期无人清理，垃圾溢出，异味严重，居民反映强烈。</p>', '刘网格员', '13700137003', NULL, '和谐社区东门', '第三网格', NULL, NULL, NULL, '2025-10-13 09:15:00', '待处理', NULL, NULL, NULL, 9);
INSERT INTO `report` VALUES (4, '安全隐患', '锦绣社区电动车违规充电', '<p>锦绣社区多栋楼存在居民从楼上私拉电线给电动车充电的情况，存在火灾隐患。</p>', '赵网格员', '15755215425', NULL, '锦绣社区1-5号楼', '第四网格', NULL, '', NULL, '2025-10-11 22:02:06', '已处理', '消防部门', '已联合消防部门开展整治，剪除私拉电线，张贴安全警示，推动增设充电桩。', '2025-10-11 22:03:57', NULL);
INSERT INTO `report` VALUES (5, '民生诉求', '居民反映路灯损坏', '<p>花园社区北路3盏路灯损坏，夜间照明不足，居民出行不便，存在安全隐患。</p>', '孙网格员', '15744251245', NULL, '花园社区北路', '第五网格', NULL, 'http://localhost:9090/files/1760192414177-丝瓜.png', NULL, '2025-10-11 22:20:20', '处理中', '市政部门', '已上报市政部门，预计3个工作日内维修', '2025-10-11 22:20:32', NULL);
INSERT INTO `report` VALUES (6, '矛盾纠纷', '物业与业主停车位纠纷', '<p>绿洲社区物业将公共停车位私自出租给非业主车辆，引发业主集体不满，部分业主准备联名上访。</p>', '周网格员', '15422125421', NULL, '绿洲社区', '第六网格', NULL, 'http://localhost:9090/files/1760193443172-海鲜.png', 50.00, '2025-10-11 22:37:29', '已处理', '王主任', '已组织业主代表与物业协商，物业同意停止向非业主出租停车位，建立停车位管理公示制度。', '2025-10-11 22:38:35', 1);
INSERT INTO `report` VALUES (7, '安全隐患', '老旧楼房外墙脱落', '<p>阳光小区8号楼外墙瓷砖脱落，存在高空坠物隐患，已用警戒带围挡。</p>', 'll123', '15744125412', NULL, '阳光小区8号楼', '第一网格', NULL, '', NULL, '2025-10-20 22:57:58', '待处理', NULL, NULL, NULL, 1);
INSERT INTO `report` VALUES (8, '环境问题', '小区绿化带被破坏', '<p>幸福家园小区南侧绿化带被人为破坏，种植蔬菜，影响小区环境。</p>', 'll123', '18544154251', NULL, '幸福家园南侧', '第二网格', NULL, 'http://localhost:9090/files/1760972450781-seafood.png', NULL, '2025-10-20 23:01:26', '待处理', NULL, NULL, NULL, 1);
INSERT INTO `report` VALUES (9, '民生诉求', '独居老人需要帮助', '<p>和谐社区6号楼独居老人李奶奶（85岁）行动不便，子女不在身边，需要定期关怀和生活帮助。</p>', 'll123', '15422512425', NULL, '和谐社区6号楼', '第三网格', NULL, 'http://localhost:9090/files/1761025343812-69c2d825dad1b4c4b9b0e64b730c710e.jpeg', 1.00, '2025-10-21 13:42:25', '已处理', '社区', '已安排志愿者定期上门服务，建立关爱档案，纳入重点关注对象。', '2025-10-21 13:42:54', 1);
INSERT INTO `report` VALUES (10, '安全隐患', '不住顶顶顶顶顶顶顶顶不住顶顶顶顶顶顶顶顶不住顶顶顶顶顶顶顶顶不住顶顶顶顶顶顶顶顶', '不住顶顶顶顶顶顶顶顶不住顶顶顶顶顶顶顶顶不住顶顶顶顶顶顶顶顶不住顶顶顶顶顶顶顶顶', '22', '15255425121', NULL, '不住顶顶顶顶顶顶顶顶', '不住顶顶顶顶顶顶顶顶', '不住顶顶顶顶顶顶顶顶', '', 1.00, '2026-03-13 14:38:16', '待处理', NULL, NULL, NULL, 11);
INSERT INTO `report` VALUES (11, '安全隐患', '哈哈哈哈哈哈哈哈哈', '哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈', '22', '15255425125', '哈哈哈哈哈哈哈哈哈', '哈哈哈哈哈哈哈哈哈', '哈哈哈哈哈哈哈哈哈', '哈哈哈哈哈哈哈哈哈', '', 1.00, '2026-03-13 14:43:02', '待处理', NULL, NULL, NULL, 11);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色标识',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '网格信息（如网格员 / 网格长）',
  `birth` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '生日',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '网格员信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'll123', '123456', '李磊', 'http://localhost:9090/files/1761016923583-d0c6c592a3d8e10d70d79d6498e21071.png', 'USER', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (4, 'zhangsan', '123456', '张伟', 'http://localhost:9090/files/1761017033347-b98ecf835dca6709946a55aef771787c.jpeg', 'USER', '男', '13800138000', 'zhangwei@example.com', '第一网格网格员', '2000-01-27');
INSERT INTO `user` VALUES (5, 'lisi', '123456', '李芳', 'http://localhost:9090/files/1761017005304-f5975857b591dad0dd5c3e7f501edf34.png', 'USER', '女', '13800138001', 'lifang@example.com', '第二网格网格员', '2000-05-03');
INSERT INTO `user` VALUES (9, 'wangwu', '123456', '王强', 'http://localhost:9090/files/1761016972962-59ac3bbb6adf0a3a75989af9aaddd410.jpeg', 'USER', '男', '13800138002', 'wangqiang@example.com', '第三网格网格长', '1999-10-27');
INSERT INTO `user` VALUES (10, 'zhaoliu', '123456', '赵敏', 'http://localhost:9090/files/1761016963435-65d0e7ad3596aa701a84a8c7ffdff522.jpeg', 'USER', '男', '13800138003', 'zhaomin@example.com', '第四网格网格员', '1998-03-28');
INSERT INTO `user` VALUES (11, '22', '123456', '22', 'https://localhost:9090/files/1720844558824-default.png', 'USER', NULL, NULL, NULL, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;