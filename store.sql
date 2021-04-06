/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : localhost:3306
 Source Schema         : shopping

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 06/04/2021 09:33:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_address
-- ----------------------------
DROP TABLE IF EXISTS `t_address`;
CREATE TABLE `t_address`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `u_id` bigint(11) NULL DEFAULT NULL COMMENT '用户id',
  `detail_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `con_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `con_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人电话',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '收货地址表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_address
-- ----------------------------
INSERT INTO `t_address` VALUES (3, 1, '厦门1233', '胡作非', '17000000000');
INSERT INTO `t_address` VALUES (4, 1, '福州13323', '胡作非', '17000000000');
INSERT INTO `t_address` VALUES (5, 1, '福州13323', '胡作非332', '17000000000');

-- ----------------------------
-- Table structure for t_admin
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `a_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理员姓名',
  `a_acc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账号',
  `a_pwd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `a_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '号码',
  `a_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `is_super` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '超级管理员标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `t_admin` VALUES (1, '张三丰', 'zhangsanfeng.a', '123456', '17000000000', '17000000000@qq.com', '1');
INSERT INTO `t_admin` VALUES (4, '张无忌', 'zhangwuji.a', '123456', '19000000000', '19000000000@qq.com', '1');

-- ----------------------------
-- Table structure for t_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `t_admin_role`;
CREATE TABLE `t_admin_role`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `a_id` bigint(11) NULL DEFAULT NULL,
  `r_id` bigint(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_admin_role
-- ----------------------------
INSERT INTO `t_admin_role` VALUES (2, 1, 1);
INSERT INTO `t_admin_role` VALUES (3, 1, 2);
INSERT INTO `t_admin_role` VALUES (5, 4, 2);

-- ----------------------------
-- Table structure for t_dict
-- ----------------------------
DROP TABLE IF EXISTS `t_dict`;
CREATE TABLE `t_dict`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `d_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `d_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `d_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_dict
-- ----------------------------
INSERT INTO `t_dict` VALUES (1, 'merchant_audit', '10', '已提交');
INSERT INTO `t_dict` VALUES (2, 'merchant_audit', '30', '待审核');
INSERT INTO `t_dict` VALUES (3, 'merchant_audit', '50', '审核通过');
INSERT INTO `t_dict` VALUES (4, 'merchant_audit', '60', '审核不通过');
INSERT INTO `t_dict` VALUES (5, 'merchant_audit', '40', '加入黑名单');
INSERT INTO `t_dict` VALUES (6, 'goods', '10', '已提交');
INSERT INTO `t_dict` VALUES (7, 'goods', '30', '待审核');
INSERT INTO `t_dict` VALUES (8, 'goods', '50', '审核通过');
INSERT INTO `t_dict` VALUES (9, 'goods', '60', '审核不通过');
INSERT INTO `t_dict` VALUES (10, 'goods', '70', '上架');
INSERT INTO `t_dict` VALUES (11, 'goods', '80', '下架');
INSERT INTO `t_dict` VALUES (12, 'goods', '90', '强制下架');
INSERT INTO `t_dict` VALUES (13, 'order', '10', '待支付');
INSERT INTO `t_dict` VALUES (14, 'order', '30', '已支付');
INSERT INTO `t_dict` VALUES (15, 'order', '50', '已发货');
INSERT INTO `t_dict` VALUES (16, 'order', '60', '已签收');

-- ----------------------------
-- Table structure for t_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_goods`;
CREATE TABLE `t_goods`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `m_id` bigint(11) NULL DEFAULT NULL COMMENT '商户id',
  `g_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `g_detail` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '详情',
  `g_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '单价',
  `g_inventory` int(8) NULL DEFAULT NULL COMMENT '库存',
  `status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  `g_author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作者',
  `g_press` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出版社',
  `g_type` bigint(11) NULL DEFAULT NULL COMMENT '类别',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_goods
-- ----------------------------
INSERT INTO `t_goods` VALUES (7, 4, '三味书屋', '三位书屋书屋书屋', 28.00, 999, '90', '鲁迅', '人民出版社', 1);
INSERT INTO `t_goods` VALUES (8, 6, '三味书屋', '2223333333333', 28.00, 999, '50', '鲁迅', '人民出版社', 1);
INSERT INTO `t_goods` VALUES (9, 4, '三味书屋', '1', 28.00, 999, '70', '鲁迅', '人民出版社', 1);
INSERT INTO `t_goods` VALUES (10, 4, '三味书屋233', '《从百草园到三味书屋》是鲁迅于1926年写的一篇童年妙趣生活的回忆性散文，此文被收入《朝花夕拾》。全文描述了色调不同，情韵各异的两大景片：百草园和三味书屋。作者写百草园，以“乐”为中心，以简约生动的文字，描绘了一个奇趣无穷的儿童乐园，其间穿插“美女蛇”的传说和冬天雪地捕鸟的故事，动静结合，详略得当，趣味无穷。三味书屋则是一个完全不同的世界，作者逼真地写出了三味书屋的陈腐味，说它是“全城中称为最严厉的书塾”，儿童在那里受到规矩的束缚。但作者并未将三味书屋写得死气沉沉，而是通过课间学生溜到后园嬉耍，', 28.00, 999, '70', '鲁迅', '人民出版社', 1);
INSERT INTO `t_goods` VALUES (11, 4, '三味书屋455', '《从百草园到三味书屋》是鲁迅于1926年写的一篇童年妙趣生活的回忆性散文，此文被收入《朝花夕拾》。全文描述了色调不同，情韵各异的两大景片：百草园和三味书屋。作者写百草园，以“乐”为中心，以简约生动的文字，描绘了一个奇趣无穷的儿童乐园，其间穿插“美女蛇”的传说和冬天雪地捕鸟的故事，动静结合，详略得当，趣味无穷。三味书屋则是一个完全不同的世界，作者逼真地写出了三味书屋的陈腐味，说它是“全城中称为最严厉的书塾”，儿童在那里受到规矩的束缚。但作者并未将三味书屋写得死气沉沉，而是通过课间学生溜到后园嬉耍，', 28.00, 989, '70', '鲁迅', '人民出版社', 1);
INSERT INTO `t_goods` VALUES (12, 4, '三味书屋5435', '《从百草园到三味书屋》是鲁迅于1926年写的一篇童年妙趣生活的回忆性散文，此文被收入《朝花夕拾》。全文描述了色调不同，情韵各异的两大景片：百草园和三味书屋。作者写百草园，以“乐”为中心，以简约生动的文字，描绘了一个奇趣无穷的儿童乐园，其间穿插“美女蛇”的传说和冬天雪地捕鸟的故事，动静结合，详略得当，趣味无穷。三味书屋则是一个完全不同的世界，作者逼真地写出了三味书屋的陈腐味，说它是“全城中称为最严厉的书塾”，儿童在那里受到规矩的束缚。但作者并未将三味书屋写得死气沉沉，而是通过课间学生溜到后园嬉耍，', 28.00, 999, '70', '鲁迅', '人民出版社', 1);
INSERT INTO `t_goods` VALUES (13, 4, '12312313', '3213313', 28.00, 999, '50', '鲁迅', '人民出版社', 2);

-- ----------------------------
-- Table structure for t_goods_audit_progress
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_audit_progress`;
CREATE TABLE `t_goods_audit_progress`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `g_id` bigint(11) NULL DEFAULT NULL COMMENT '商品id',
  `status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  `audit_opinion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审批意见',
  `operate_time` datetime(20) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品审核表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_goods_audit_progress
-- ----------------------------
INSERT INTO `t_goods_audit_progress` VALUES (1, 6, '30', '材料提交成功,等待审核', '2021-03-27 07:42:12');
INSERT INTO `t_goods_audit_progress` VALUES (2, 7, '30', '材料提交成功,等待审核', '2021-03-27 07:51:04');
INSERT INTO `t_goods_audit_progress` VALUES (3, 8, '30', '材料提交成功,等待审核', '2021-03-27 16:20:27');
INSERT INTO `t_goods_audit_progress` VALUES (4, 7, '50', '同意', '2021-03-28 10:59:25');
INSERT INTO `t_goods_audit_progress` VALUES (5, 8, '60', '不通过', '2021-03-28 05:06:47');
INSERT INTO `t_goods_audit_progress` VALUES (6, 8, '30', '材料提交成功,等待审核', '2021-03-28 05:35:45');
INSERT INTO `t_goods_audit_progress` VALUES (7, 9, '30', '材料提交成功,等待审核', '2021-03-28 12:42:56');
INSERT INTO `t_goods_audit_progress` VALUES (8, 10, '30', '材料提交成功,等待审核', '2021-03-29 03:10:03');
INSERT INTO `t_goods_audit_progress` VALUES (9, 11, '30', '材料提交成功,等待审核', '2021-03-29 03:10:21');
INSERT INTO `t_goods_audit_progress` VALUES (10, 12, '30', '材料提交成功,等待审核', '2021-03-29 03:10:32');
INSERT INTO `t_goods_audit_progress` VALUES (11, 8, '50', '1', '2021-03-29 03:11:13');
INSERT INTO `t_goods_audit_progress` VALUES (12, 9, '50', '1', '2021-03-29 03:11:20');
INSERT INTO `t_goods_audit_progress` VALUES (13, 10, '50', '1', '2021-03-29 03:11:25');
INSERT INTO `t_goods_audit_progress` VALUES (14, 11, '50', '1', '2021-03-29 03:11:30');
INSERT INTO `t_goods_audit_progress` VALUES (15, 12, '50', '1', '2021-03-29 03:11:35');
INSERT INTO `t_goods_audit_progress` VALUES (16, 9, '30', '材料提交成功,等待审核', '2021-03-29 09:21:03');
INSERT INTO `t_goods_audit_progress` VALUES (17, 9, '50', '1', '2021-03-29 09:35:53');
INSERT INTO `t_goods_audit_progress` VALUES (18, 13, '30', '材料提交成功,等待审核', '2021-04-03 15:18:18');
INSERT INTO `t_goods_audit_progress` VALUES (19, 13, '50', '3213213', '2021-04-03 15:22:42');

-- ----------------------------
-- Table structure for t_goods_img
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_img`;
CREATE TABLE `t_goods_img`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `g_id` bigint(11) NULL DEFAULT NULL COMMENT '商品id',
  `img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `img_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片标题',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_goods_img
-- ----------------------------
INSERT INTO `t_goods_img` VALUES (2, 2, '/newloading/img/a15fd277-392f-45df-9f70-d5799b42eb5d.jpg', '三味书屋');
INSERT INTO `t_goods_img` VALUES (6, 6, '/newloading/img/75e9942f-344a-4913-ae5a-717d08256c21.jpg', '1.jpg');
INSERT INTO `t_goods_img` VALUES (7, 6, '/newloading/img/164b8dbb-26b6-40ec-84a1-b3a841f89606.jpg', '2.jpg');
INSERT INTO `t_goods_img` VALUES (8, 7, '/newloading/img/8e96576a-7f05-470e-a4b0-986efa51e1b9.jpg', '1.jpg');
INSERT INTO `t_goods_img` VALUES (9, 7, '/newloading/img/04f3cf4f-ef09-4e20-b724-1aec9f27e008.jpg', '2.jpg');
INSERT INTO `t_goods_img` VALUES (12, 8, '/newloading/img/e4557c0e-5c30-43ee-8793-719c54e3926d.jpg', '1.jpg');
INSERT INTO `t_goods_img` VALUES (13, 8, '/newloading/img/56a127c0-b8ce-4243-a00e-86b7cd5f2910.jpg', '2.jpg');
INSERT INTO `t_goods_img` VALUES (15, 10, '/newloading/img/2ede2dd4-3121-4bfc-a5dd-7818fb517c5f.jpg', '1.jpg');
INSERT INTO `t_goods_img` VALUES (16, 10, '/newloading/img/9060057b-89a1-437b-b2e3-658c3207c977.jpg', '2.jpg');
INSERT INTO `t_goods_img` VALUES (17, 11, '/newloading/img/9114a35a-29f7-47c6-8855-28bbf0f998cd.jpg', '2.jpg');
INSERT INTO `t_goods_img` VALUES (18, 12, '/newloading/img/5e9653a5-6186-45f4-a829-27da9ea1a1b7.jpg', '2.jpg');
INSERT INTO `t_goods_img` VALUES (19, 9, '/newloading/img/5d27c9fd-d59b-40d3-b3e2-2ca4c93e2019.jpg', '1.jpg');
INSERT INTO `t_goods_img` VALUES (20, 9, '/newloading/img/feb916ef-ea8d-4932-8bcb-68a341eb60ca.jpg', '2.jpg');
INSERT INTO `t_goods_img` VALUES (21, 13, '/newloading/img/e8a482ce-976f-402c-9835-58bab349a5af.jpg', '2.jpg');

-- ----------------------------
-- Table structure for t_goods_type
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_type`;
CREATE TABLE `t_goods_type`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `t_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_goods_type
-- ----------------------------
INSERT INTO `t_goods_type` VALUES (1, '文学');
INSERT INTO `t_goods_type` VALUES (2, '科技');
INSERT INTO `t_goods_type` VALUES (3, '少儿');

-- ----------------------------
-- Table structure for t_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_menu`;
CREATE TABLE `t_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menuName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名',
  `createTime` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `serialNumber` int(11) NULL DEFAULT NULL COMMENT '序号',
  `pid` int(11) NULL DEFAULT NULL COMMENT '父id',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路径',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 111 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_menu
-- ----------------------------
INSERT INTO `t_menu` VALUES (1, '基础配置', NULL, NULL, NULL, 0, NULL);
INSERT INTO `t_menu` VALUES (2, '员工管理', NULL, NULL, NULL, 1, '/admin/manage');
INSERT INTO `t_menu` VALUES (4, '角色管理', NULL, NULL, NULL, 1, '/role/manage');
INSERT INTO `t_menu` VALUES (5, '商物监督', NULL, NULL, NULL, 0, NULL);
INSERT INTO `t_menu` VALUES (6, '商户管理', NULL, NULL, NULL, 5, '/merchant/manage');
INSERT INTO `t_menu` VALUES (7, '商品管理', NULL, NULL, NULL, 5, '/goods/manage');
INSERT INTO `t_menu` VALUES (8, '统计查询', NULL, NULL, NULL, 0, NULL);
INSERT INTO `t_menu` VALUES (9, '订单查询', NULL, NULL, NULL, 8, '/order/list');

-- ----------------------------
-- Table structure for t_merchant
-- ----------------------------
DROP TABLE IF EXISTS `t_merchant`;
CREATE TABLE `t_merchant`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `m_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户名',
  `m_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户编号',
  `m_acc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户账号',
  `m_pwd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品密码',
  `m_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户地址',
  `m_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户邮箱',
  `m_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户号码',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户状态',
  `m_boss_identity` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户老板身份证号',
  `m_boss_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户老板',
  `m_boss_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '老板电话',
  `m_boss_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '老板邮箱',
  `m_wallet` decimal(10, 2) NULL DEFAULT NULL COMMENT '钱包',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_merchant
-- ----------------------------
INSERT INTO `t_merchant` VALUES (1, '三只松鼠', 'XLUFGQ1349924393', 'sanzhisongshu.m', '123456', '厦门', '18000000000@qq.com', '18000000000', '30', '123456789098765432', '许松许', '18000000000', '18000000000@qq.com', 0.00);
INSERT INTO `t_merchant` VALUES (2, '三只松鼠2', 'DOZRPE4736627617', 'sanzhisongshu2.m', '123456', '厦门', '18000000000@qq.com', '18000000000', '30', '123456789098765432', '许松许', '18000000000', '18000000000@qq.com', 0.00);
INSERT INTO `t_merchant` VALUES (3, '三只松鼠3', 'SXHOKD8139457854', 'sanzhisongshu3.m', '123456', '厦门', '18000000000@qq.com', '18000000000', '40', '123456789098765432', '许松许', '18000000000', '18000000000@qq.com', 0.00);
INSERT INTO `t_merchant` VALUES (4, '三只松鼠4', 'YIUQQY6048047281', 'sanzhisongshu4.m', '123456', '厦门', '18000000000@qq.com', '18000000000', '50', '123456789098765432', '许松许', '18000000000', '18000000000@qq.com', 180.00);
INSERT INTO `t_merchant` VALUES (5, '三只松鼠5', 'BOTCMW9954078264', 'sanzhisongshu5.m', '123456', '厦门', '18000000000@qq.com', '18000000000', '30', '123456789098765432', '许松许', '18000000000', '18000000000@qq.com', 0.00);
INSERT INTO `t_merchant` VALUES (6, '三只松鼠6', 'ESRVGX0337357511', 'sanzhisongshu6.m', '123456', '厦门', '18000000000@qq.com', '18000000000', '50', '123456789098765432', '许松许', '18000000000', '18000000000@qq.com', 0.00);
INSERT INTO `t_merchant` VALUES (7, '三只松鼠7', 'DYYUGT4543329965', 'sanzhisongshu7.m', '123456', '厦门', '18000000000@qq.com', '18000000000', '30', '123456789098765432', '许松许', '18000000000', '18000000000@qq.com', 0.00);
INSERT INTO `t_merchant` VALUES (8, '三只松鼠8', 'HJGUHR0872730510', 'sanzhisongshu8.m', '123456', '厦门', '18000000000@qq.com', '18000000000', '30', '123456789098765432', '许松许', '18000000000', '18000000000@qq.com', 0.00);
INSERT INTO `t_merchant` VALUES (9, '三只松鼠9', 'FWZHFC7308787448', 'sanzhisongshu9.m', '123456', '厦门', '18000000000@qq.com', '18000000000', '60', '123456789098765432', '许松许', '18000000000', '18000000000@qq.com', 0.00);

-- ----------------------------
-- Table structure for t_merchant_audit_progress
-- ----------------------------
DROP TABLE IF EXISTS `t_merchant_audit_progress`;
CREATE TABLE `t_merchant_audit_progress`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `m_id` bigint(11) NULL DEFAULT NULL COMMENT '商户id',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '进度状态',
  `audit_opinion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审批意见',
  `operate_time` datetime(20) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商户审批进度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_merchant_audit_progress
-- ----------------------------
INSERT INTO `t_merchant_audit_progress` VALUES (1, 1, '30', '材料提交成功', '2021-03-23 08:00:00');
INSERT INTO `t_merchant_audit_progress` VALUES (2, 2, '30', '材料提交成功', '2021-03-23 08:02:59');
INSERT INTO `t_merchant_audit_progress` VALUES (3, 3, '30', '材料提交成功', '2021-03-23 08:03:30');
INSERT INTO `t_merchant_audit_progress` VALUES (4, 4, '30', '材料提交成功', '2021-03-23 08:14:14');
INSERT INTO `t_merchant_audit_progress` VALUES (5, 5, '30', '材料提交成功', '2021-03-23 08:15:37');
INSERT INTO `t_merchant_audit_progress` VALUES (6, 6, '30', '材料提交成功', '2021-03-23 08:16:16');
INSERT INTO `t_merchant_audit_progress` VALUES (7, 7, '30', '材料提交成功', '2021-03-23 08:28:32');
INSERT INTO `t_merchant_audit_progress` VALUES (8, 8, '30', '材料提交成功', '2021-03-23 08:34:48');
INSERT INTO `t_merchant_audit_progress` VALUES (9, 9, '30', '材料提交成功', '2021-03-23 08:37:14');
INSERT INTO `t_merchant_audit_progress` VALUES (10, 3, '50', '同意', '2021-03-25 02:25:40');
INSERT INTO `t_merchant_audit_progress` VALUES (11, 4, '60', '不同意', '2021-03-25 02:30:26');
INSERT INTO `t_merchant_audit_progress` VALUES (12, 4, '40', '该商户已拉进黑名单', '2021-03-25 02:32:13');
INSERT INTO `t_merchant_audit_progress` VALUES (13, 4, '50', '该商户已拉出黑名单', '2021-03-25 02:32:17');
INSERT INTO `t_merchant_audit_progress` VALUES (14, 3, '40', '该商户已拉进黑名单', '2021-03-25 02:33:38');
INSERT INTO `t_merchant_audit_progress` VALUES (15, 5, '60', '不同意', '2021-03-25 02:37:54');
INSERT INTO `t_merchant_audit_progress` VALUES (16, 5, '30', '材料提交成功,等待审核', '2021-03-25 02:40:59');
INSERT INTO `t_merchant_audit_progress` VALUES (17, 6, '40', '该商户已拉进黑名单', '2021-03-25 15:06:50');
INSERT INTO `t_merchant_audit_progress` VALUES (18, 6, '50', '该商户已拉出黑名单', '2021-03-25 15:07:17');
INSERT INTO `t_merchant_audit_progress` VALUES (19, 6, '40', '该商户已拉进黑名单', '2021-03-25 15:07:37');
INSERT INTO `t_merchant_audit_progress` VALUES (20, 6, '50', '该商户已拉出黑名单', '2021-03-25 15:07:45');
INSERT INTO `t_merchant_audit_progress` VALUES (21, 9, '60', '0', '2021-03-25 15:13:21');

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `u_id` bigint(11) NULL DEFAULT NULL COMMENT '用户id',
  `m_id` bigint(20) NULL DEFAULT NULL COMMENT '商户id',
  `g_id` bigint(11) NULL DEFAULT NULL COMMENT '商品id',
  `o_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `con_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `con_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `con_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货地址',
  `count` int(10) NULL DEFAULT NULL COMMENT '购买数量',
  `pay_money` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付金额',
  `o_remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  `c_time` datetime(20) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES (1, 1, 4, 12, '20210330174337956', '胡作非', '17000000000', '厦门', 1, '28.0', '', '50', '2021-03-30 09:43:38');
INSERT INTO `t_order` VALUES (2, 1, 4, 12, '20210330175001656', '大张伟', '18000000000', '福州', 1, '28.0', '哇哇哇', '60', '2021-03-30 09:50:02');
INSERT INTO `t_order` VALUES (3, 1, 4, 12, '20210331224956794', '胡作非332', '17000000000', '福州13323', 1, '28.0', '', '10', '2021-03-31 14:49:57');
INSERT INTO `t_order` VALUES (4, 1, 4, 11, '20210331225720941', '胡作非332', '17000000000', '福州13323', 10, '280.0', '', '10', '2021-03-31 14:57:21');
INSERT INTO `t_order` VALUES (5, 1, 4, 11, '20210401233904346', '胡作非', '17000000000', '厦门1233', 10, '280.0', '', '60', '2021-05-01 15:39:04');
INSERT INTO `t_order` VALUES (6, 1, 4, 11, '20210403104602427', '胡作非', '17000000000', '福州13323', 10, '280.0', '', '30', '2021-04-03 02:46:02');

-- ----------------------------
-- Table structure for t_order_progress
-- ----------------------------
DROP TABLE IF EXISTS `t_order_progress`;
CREATE TABLE `t_order_progress`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `o_id` bigint(20) NULL DEFAULT NULL COMMENT '订单id',
  `status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  `op_remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '说明',
  `operate_time` datetime(20) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '订单进度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_order_progress
-- ----------------------------
INSERT INTO `t_order_progress` VALUES (1, 1, '10', '下单成功，待付款', '2021-03-30 09:43:38');
INSERT INTO `t_order_progress` VALUES (2, 1, '30', '支付成功，等待发货', '2021-03-30 09:44:25');
INSERT INTO `t_order_progress` VALUES (4, 2, '10', '下单成功，待付款', '2021-03-30 09:50:02');
INSERT INTO `t_order_progress` VALUES (5, 2, '30', '支付成功，等待发货', '2021-03-30 09:50:51');
INSERT INTO `t_order_progress` VALUES (6, 3, '10', '下单成功，待付款', '2021-03-31 14:49:57');
INSERT INTO `t_order_progress` VALUES (7, 4, '10', '下单成功，待付款', '2021-03-31 14:57:21');
INSERT INTO `t_order_progress` VALUES (8, 2, '50', '商家已发货', '2021-04-01 07:47:39');
INSERT INTO `t_order_progress` VALUES (9, 1, '50', '商家已发货', '2021-04-01 07:47:44');
INSERT INTO `t_order_progress` VALUES (10, 2, '60', '该商品已签收', '2021-04-01 07:49:08');
INSERT INTO `t_order_progress` VALUES (11, 5, '10', '下单成功，待付款', '2021-04-01 15:39:04');
INSERT INTO `t_order_progress` VALUES (12, 5, '30', '支付成功，等待发货', '2021-04-01 15:39:39');
INSERT INTO `t_order_progress` VALUES (13, 5, '50', '商家已发货', '2021-04-01 15:39:55');
INSERT INTO `t_order_progress` VALUES (14, 5, '60', '该商品已签收', '2021-04-01 15:40:31');
INSERT INTO `t_order_progress` VALUES (15, 6, '10', '下单成功，待付款', '2021-04-03 02:46:02');
INSERT INTO `t_order_progress` VALUES (16, 6, '30', '支付成功，等待发货', '2021-04-03 02:47:03');

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `r_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色名',
  `r_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES (1, '超级管理员', 'CJGLY');
INSERT INTO `t_role` VALUES (2, '普通管理员', 'PTGLY');

-- ----------------------------
-- Table structure for t_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_role_menu`;
CREATE TABLE `t_role_menu`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `r_id` bigint(11) NULL DEFAULT NULL,
  `m_id` bigint(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色菜单关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role_menu
-- ----------------------------
INSERT INTO `t_role_menu` VALUES (27, 2, 5);
INSERT INTO `t_role_menu` VALUES (28, 2, 6);
INSERT INTO `t_role_menu` VALUES (29, 2, 7);
INSERT INTO `t_role_menu` VALUES (30, 1, 1);
INSERT INTO `t_role_menu` VALUES (31, 1, 2);
INSERT INTO `t_role_menu` VALUES (32, 1, 4);
INSERT INTO `t_role_menu` VALUES (33, 1, 5);
INSERT INTO `t_role_menu` VALUES (34, 1, 6);
INSERT INTO `t_role_menu` VALUES (35, 1, 7);
INSERT INTO `t_role_menu` VALUES (36, 1, 8);
INSERT INTO `t_role_menu` VALUES (37, 1, 9);

-- ----------------------------
-- Table structure for t_shopping_car
-- ----------------------------
DROP TABLE IF EXISTS `t_shopping_car`;
CREATE TABLE `t_shopping_car`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `u_id` bigint(11) NULL DEFAULT NULL COMMENT '用户id',
  `g_id` bigint(11) NULL DEFAULT NULL COMMENT '商品id',
  `count` int(10) NULL DEFAULT NULL COMMENT '购买数量',
  `payMoney` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_shopping_car
-- ----------------------------
INSERT INTO `t_shopping_car` VALUES (9, 1, 12, 1, '28.0');
INSERT INTO `t_shopping_car` VALUES (10, 1, 9, 1, '28.0');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `u_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `u_pwd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `u_acc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账号',
  `u_identify` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `u_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电话',
  `u_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, '胡作非rew', '123456', 'huzuofei.u', '123456789098765432', '17000000222', '17000000000@qq.com');
INSERT INTO `t_user` VALUES (2, '胡作非', '123456', 'huzuofei.zh', '123456789098765432', '17000000000', '17000000000@qq.com');

-- ----------------------------
-- Table structure for withdraw_deposit_record
-- ----------------------------
DROP TABLE IF EXISTS `withdraw_deposit_record`;
CREATE TABLE `withdraw_deposit_record`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `m_id` bigint(11) NULL DEFAULT NULL COMMENT '商户id',
  `money` decimal(8, 2) NULL DEFAULT NULL COMMENT '金额',
  `card_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行卡号',
  `operate_time` datetime(20) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '提现记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of withdraw_deposit_record
-- ----------------------------
INSERT INTO `withdraw_deposit_record` VALUES (1, 4, 100.00, '3213132313123', '2021-04-01 15:51:30');

SET FOREIGN_KEY_CHECKS = 1;
