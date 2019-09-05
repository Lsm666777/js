/*
 Navicat Premium Data Transfer

 Source Server         : 80
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3305
 Source Schema         : azh_community

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 05/08/2019 13:00:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for label_category
-- ----------------------------
DROP TABLE IF EXISTS `label_category`;
CREATE TABLE `label_category`  (
  `id` int(11) NOT NULL,
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `remark` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for labels
-- ----------------------------
DROP TABLE IF EXISTS `labels`;
CREATE TABLE `labels`  (
  `id` int(11) NOT NULL,
  `category_id` int(11) NULL DEFAULT NULL COMMENT '分类编号',
  `value` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签文本',
  `seq` int(11) NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_labels_label_category1_idx`(`category_id`) USING BTREE,
  CONSTRAINT `labels_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `label_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for member_action_statistic
-- ----------------------------
DROP TABLE IF EXISTS `member_action_statistic`;
CREATE TABLE `member_action_statistic`  (
  `member_id` int(11) NOT NULL COMMENT '会员号',
  `current_level` int(11) NULL DEFAULT 0 COMMENT '当前会员级别',
  `current_source` int(11) NULL DEFAULT 0 COMMENT '当前会员积分',
  `fans_count` int(11) NULL DEFAULT 0 COMMENT '会员粉丝数量',
  `caring_member_count` int(11) NULL DEFAULT 0 COMMENT '我关注的会员数量',
  `favorite_note_count` int(11) NULL DEFAULT 0 COMMENT '我收藏的日记数量',
  `publish_note_count` int(11) NULL DEFAULT 0 COMMENT '我发布的日记数量',
  `achieved_favorite` int(11) NULL DEFAULT 0 COMMENT '我的日记获得的收藏数量',
  `achieved_praise` int(11) NULL DEFAULT 0 COMMENT '我的日记获得的点赞数量',
  PRIMARY KEY (`member_id`) USING BTREE,
  INDEX `fk_member_action_statistic_member1_idx`(`member_id`) USING BTREE,
  CONSTRAINT `member_action_statistic_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员行为统计' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for member_comment_praise
-- ----------------------------
DROP TABLE IF EXISTS `member_comment_praise`;
CREATE TABLE `member_comment_praise`  (
  `member_id` int(11) NOT NULL COMMENT '会员编号',
  `comment_id` bigint(16) NOT NULL COMMENT '评论编号',
  `note_id` bigint(16) NOT NULL COMMENT '日记编号',
  `added_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  PRIMARY KEY (`member_id`, `comment_id`) USING BTREE,
  INDEX `fk_member_comment_praise_note_comment1_idx`(`comment_id`) USING BTREE,
  INDEX `fk_member_comment_praise_notes1_idx`(`note_id`) USING BTREE,
  CONSTRAINT `member_comment_praise_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `member_comment_praise_ibfk_2` FOREIGN KEY (`note_id`) REFERENCES `notes` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员评论点赞记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for member_fans
-- ----------------------------
DROP TABLE IF EXISTS `member_fans`;
CREATE TABLE `member_fans`  (
  `member_id` int(11) NOT NULL COMMENT '会员编号',
  `fans_id` int(11) NOT NULL COMMENT '粉丝编号',
  `added_times` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态1 有效 0无效',
  PRIMARY KEY (`fans_id`, `member_id`) USING BTREE,
  INDEX `fk_member_ fans_member_idx`(`member_id`) USING BTREE,
  CONSTRAINT `member_fans_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员粉丝' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for member_level
-- ----------------------------
DROP TABLE IF EXISTS `member_level`;
CREATE TABLE `member_level`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `levels` int(11) NULL DEFAULT NULL COMMENT '会员到达级别',
  `added_times` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '达到时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_member_level_member1_idx`(`member_id`) USING BTREE,
  CONSTRAINT `member_level_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员级别' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for member_note_favorite
-- ----------------------------
DROP TABLE IF EXISTS `member_note_favorite`;
CREATE TABLE `member_note_favorite`  (
  `member_id` int(11) NOT NULL COMMENT '会员编号',
  `note_id` bigint(16) NOT NULL COMMENT '日记编号',
  `note_member_id` int(11) NULL DEFAULT NULL COMMENT '发布日记的会员编号',
  `added_times` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  PRIMARY KEY (`member_id`, `note_id`) USING BTREE,
  INDEX `fk_member_note_favorite_member1_idx`(`member_id`) USING BTREE,
  INDEX `fk_member_note_favorite_notes1_idx`(`note_id`) USING BTREE,
  INDEX `idx_mnf_note_member_id`(`note_member_id`) USING BTREE,
  CONSTRAINT `member_note_favorite_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `member_note_favorite_ibfk_2` FOREIGN KEY (`note_id`) REFERENCES `notes` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员日记收藏' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for member_note_praise
-- ----------------------------
DROP TABLE IF EXISTS `member_note_praise`;
CREATE TABLE `member_note_praise`  (
  `member_id` int(11) NOT NULL COMMENT '会员编号',
  `note_id` bigint(16) NOT NULL COMMENT '日记编号',
  `added_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  PRIMARY KEY (`note_id`, `member_id`) USING BTREE,
  INDEX `fk_note_praise_members1_idx`(`member_id`) USING BTREE,
  INDEX `fk_member_note_praise_notes1_idx`(`note_id`) USING BTREE,
  CONSTRAINT `member_note_praise_ibfk_1` FOREIGN KEY (`note_id`) REFERENCES `notes` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `member_note_praise_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员日志点赞记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for member_source
-- ----------------------------
DROP TABLE IF EXISTS `member_source`;
CREATE TABLE `member_source`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL COMMENT '会员编号',
  `source` int(11) NULL DEFAULT NULL COMMENT '获得分数',
  `types` int(11) NULL DEFAULT NULL COMMENT '获取类别：1增加粉丝 2日记被收藏 3日记获得评论 4日记获得点赞 5日记获得浏览',
  `added_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  `remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_member_source_member1_idx`(`member_id`) USING BTREE,
  CONSTRAINT `member_source_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3888 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员成长积分明细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for member_title
-- ----------------------------
DROP TABLE IF EXISTS `member_title`;
CREATE TABLE `member_title`  (
  `member_id` int(11) NOT NULL COMMENT '会员编号',
  `title_id` int(11) NOT NULL COMMENT '称号标签编号',
  `title_icon_uri` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `added_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  `operator` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '添加人',
  PRIMARY KEY (`member_id`, `title_id`) USING BTREE,
  INDEX `fk_member_tag_member1_idx`(`member_id`) USING BTREE,
  CONSTRAINT `member_title_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员称号' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for members
-- ----------------------------
DROP TABLE IF EXISTS `members`;
CREATE TABLE `members`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `net_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '网名',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `remak` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户介结',
  `added_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gender` int(11) NULL DEFAULT NULL COMMENT '性别 1.男2.女',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `net_name_UNIQUE`(`net_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10036976 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for note_comment
-- ----------------------------
DROP TABLE IF EXISTS `note_comment`;
CREATE TABLE `note_comment`  (
  `id` bigint(16) NOT NULL AUTO_INCREMENT,
  `note_id` bigint(16) NOT NULL COMMENT '日记编号',
  `member_id` int(11) NOT NULL COMMENT '评论会员编号',
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '上级评论编号',
  `content` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '评论内容',
  `response` int(11) NULL DEFAULT NULL COMMENT '回复对象（会员）编号',
  `added_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  `praise_count` int(11) NULL DEFAULT 0 COMMENT '被点赞数量',
  `status` int(11) NULL DEFAULT 1 COMMENT '0未1删',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_note_comment_notes1_idx`(`note_id`) USING BTREE,
  INDEX `fk_note_comment_members1_idx`(`member_id`) USING BTREE,
  CONSTRAINT `note_comment_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `note_comment_ibfk_2` FOREIGN KEY (`note_id`) REFERENCES `notes` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 174 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '日记评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for note_img
-- ----------------------------
DROP TABLE IF EXISTS `note_img`;
CREATE TABLE `note_img`  (
  `proportion` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '比例',
  `height` double(16, 0) NULL DEFAULT NULL,
  `width` double(16, 0) NULL DEFAULT NULL,
  `id` bigint(16) NOT NULL AUTO_INCREMENT,
  `note_id` bigint(16) NOT NULL COMMENT '日记编号',
  `url` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图片地址',
  `seq` int(11) NULL DEFAULT 0 COMMENT '排序值',
  `types` int(11) NULL DEFAULT NULL COMMENT '1.原图2.缩放图',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_note_img_notes1_idx`(`note_id`) USING BTREE,
  CONSTRAINT `note_img_ibfk_1` FOREIGN KEY (`note_id`) REFERENCES `notes` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 203 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日记图片表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for note_label
-- ----------------------------
DROP TABLE IF EXISTS `note_label`;
CREATE TABLE `note_label`  (
  `note_id` bigint(16) NOT NULL COMMENT '日记编号',
  `label_category_id` int(11) NOT NULL COMMENT '标签分类',
  `label_id` int(11) NOT NULL COMMENT '标签编号',
  `label_value` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签值',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`note_id`, `label_category_id`, `label_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for note_share
-- ----------------------------
DROP TABLE IF EXISTS `note_share`;
CREATE TABLE `note_share`  (
  `id` bigint(16) NOT NULL AUTO_INCREMENT,
  `note_id` bigint(16) NOT NULL COMMENT '日记编号',
  `added_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '分享时间',
  `share_channel` int(11) NULL DEFAULT NULL COMMENT '分享渠道：1微信朋友圈 2微信好友',
  `view_count` int(11) NULL DEFAULT NULL COMMENT '分享被查看次数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_note_share_notes1_idx`(`note_id`) USING BTREE,
  CONSTRAINT `note_share_ibfk_1` FOREIGN KEY (`note_id`) REFERENCES `notes` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日记分享记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for note_video
-- ----------------------------
DROP TABLE IF EXISTS `note_video`;
CREATE TABLE `note_video`  (
  `id` bigint(16) NOT NULL AUTO_INCREMENT,
  `notes_id` bigint(16) NOT NULL COMMENT '日记编号',
  `url` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '视频地址',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_note_video_notes1_idx`(`notes_id`) USING BTREE,
  CONSTRAINT `note_video_ibfk_1` FOREIGN KEY (`notes_id`) REFERENCES `notes` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日记视频表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for note_views
-- ----------------------------
DROP TABLE IF EXISTS `note_views`;
CREATE TABLE `note_views`  (
  `id` bigint(16) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NULL DEFAULT 0 COMMENT '发布日记的会员编号',
  `note_id` bigint(16) NULL DEFAULT NULL COMMENT '日记编号',
  `added_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  `ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户IP',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 477 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日记浏览记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for notes
-- ----------------------------
DROP TABLE IF EXISTS `notes`;
CREATE TABLE `notes`  (
  `id` bigint(16) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL COMMENT '会员编号',
  `types` int(11) NOT NULL COMMENT '内容类型：1图文 2视频',
  `titele` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标题',
  `content` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '内容',
  `topic_id` int(11) NULL DEFAULT NULL COMMENT '话题编号',
  `location_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地点名称',
  `location` point NULL COMMENT '地点坐标',
  `published_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '发布时间',
  `favorite_count` int(11) NULL DEFAULT 0 COMMENT '被收藏次数',
  `praise_count` int(11) NULL DEFAULT 0 COMMENT '被点赞数量',
  `comment_count` int(11) NULL DEFAULT 0 COMMENT '被评论数量',
  `view_count` int(11) NULL DEFAULT 0 COMMENT '浏览数量',
  `status` int(11) NULL DEFAULT 1 COMMENT '1发布',
  `region` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区域',
  `delete_or_not` int(11) NULL DEFAULT NULL COMMENT '1未0删',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_notes_members1_idx`(`member_id`) USING BTREE,
  CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 145 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员日记表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for popular
-- ----------------------------
DROP TABLE IF EXISTS `popular`;
CREATE TABLE `popular`  (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `host_word` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '热门名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_message
-- ----------------------------
DROP TABLE IF EXISTS `sys_message`;
CREATE TABLE `sys_message`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `action` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `published_time` datetime(0) NULL DEFAULT NULL,
  `publisher` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_message_sendee
-- ----------------------------
DROP TABLE IF EXISTS `sys_message_sendee`;
CREATE TABLE `sys_message_sendee`  (
  `message_id` int(11) NOT NULL,
  `sendee` int(11) NOT NULL,
  `read_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`message_id`, `sendee`) USING BTREE,
  CONSTRAINT `sys_message_sendee_ibfk_1` FOREIGN KEY (`message_id`) REFERENCES `sys_message` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for topic_category
-- ----------------------------
DROP TABLE IF EXISTS `topic_category`;
CREATE TABLE `topic_category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  `img_uri` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类图标',
  `remark` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for topics
-- ----------------------------
DROP TABLE IF EXISTS `topics`;
CREATE TABLE `topics`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL COMMENT '话题分类',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '话题名称',
  `remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '结束时间',
  `note_count` int(11) NULL DEFAULT 0 COMMENT '话题日记数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_topics_topic_category1_idx`(`category_id`) USING BTREE,
  CONSTRAINT `topics_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `topic_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
