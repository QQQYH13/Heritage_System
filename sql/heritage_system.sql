-- =============================================================
-- 非遗文化管理系统 数据库初始化脚本
-- 数据库：heritage_system   共 13 张表
-- MySQL 8.0 / 5.7  字符集 utf8mb4
-- =============================================================

DROP DATABASE IF EXISTS heritage_system;
CREATE DATABASE heritage_system DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE heritage_system;

-- ---------------------------------------------------------------
-- 1. 管理员表 admin
-- ---------------------------------------------------------------
CREATE TABLE admin (
    id          INT          NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
    username    VARCHAR(50)  NOT NULL COMMENT '登录账号',
    password    VARCHAR(100) NOT NULL COMMENT '登录密码(MD5)',
    name        VARCHAR(50)  DEFAULT NULL COMMENT '姓名',
    avatar      VARCHAR(255) DEFAULT NULL COMMENT '头像',
    phone       VARCHAR(20)  DEFAULT NULL COMMENT '手机号',
    email       VARCHAR(100) DEFAULT NULL COMMENT '邮箱',
    role        VARCHAR(20)  DEFAULT 'admin' COMMENT '角色',
    status      TINYINT      DEFAULT 1 COMMENT '状态 1正常 0禁用',
    create_time DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uk_admin_username (username)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='管理员表';

-- ---------------------------------------------------------------
-- 2. 用户表 user
-- ---------------------------------------------------------------
CREATE TABLE `user` (
    id          INT          NOT NULL AUTO_INCREMENT COMMENT '用户ID',
    username    VARCHAR(50)  NOT NULL COMMENT '登录账号',
    password    VARCHAR(100) NOT NULL COMMENT '登录密码(MD5)',
    nickname    VARCHAR(50)  DEFAULT NULL COMMENT '昵称',
    avatar      VARCHAR(255) DEFAULT NULL COMMENT '头像',
    phone       VARCHAR(20)  DEFAULT NULL COMMENT '手机号',
    email       VARCHAR(100) DEFAULT NULL COMMENT '邮箱',
    sex         TINYINT      DEFAULT 0 COMMENT '性别 0未知 1男 2女',
    status      TINYINT      DEFAULT 1 COMMENT '状态 1正常 0禁用',
    create_time DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    PRIMARY KEY (id),
    UNIQUE KEY uk_user_username (username)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ---------------------------------------------------------------
-- 3. 非遗分类表 category
-- ---------------------------------------------------------------
CREATE TABLE category (
    id          INT          NOT NULL AUTO_INCREMENT COMMENT '分类ID',
    name        VARCHAR(50)  NOT NULL COMMENT '分类名称',
    description VARCHAR(255) DEFAULT NULL COMMENT '分类描述',
    sort        INT          DEFAULT 0 COMMENT '排序(越小越靠前)',
    create_time DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='非遗分类表';

-- ---------------------------------------------------------------
-- 4. 文化遗产表 heritage
-- ---------------------------------------------------------------
CREATE TABLE heritage (
    id           INT          NOT NULL AUTO_INCREMENT COMMENT '文化遗产ID',
    category_id  INT          NOT NULL COMMENT '分类ID',
    name         VARCHAR(100) NOT NULL COMMENT '名称',
    cover        VARCHAR(255) DEFAULT NULL COMMENT '封面图',
    images       TEXT         COMMENT '图片集(多个用逗号分隔)',
    description  VARCHAR(500) DEFAULT NULL COMMENT '简介',
    content      LONGTEXT     COMMENT '详细介绍(富文本)',
    level        VARCHAR(20)  DEFAULT NULL COMMENT '保护级别(国家级/省级/市级)',
    region       VARCHAR(100) DEFAULT NULL COMMENT '所属地区',
    year         VARCHAR(20)  DEFAULT NULL COMMENT '申报/列入年份',
    views        INT          DEFAULT 0 COMMENT '浏览量',
    status       TINYINT      DEFAULT 1 COMMENT '状态 1上架 0下架',
    create_time  DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time  DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_heritage_category (category_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='文化遗产表';

-- ---------------------------------------------------------------
-- 5. 轮播图表 banner
-- ---------------------------------------------------------------
CREATE TABLE banner (
    id          INT          NOT NULL AUTO_INCREMENT COMMENT '轮播图ID',
    heritage_id INT          DEFAULT NULL COMMENT '关联的文化遗产ID',
    title       VARCHAR(100) DEFAULT NULL COMMENT '标题',
    image       VARCHAR(255) NOT NULL COMMENT '图片地址',
    sort        INT          DEFAULT 0 COMMENT '排序(越小越靠前)',
    status      TINYINT      DEFAULT 1 COMMENT '状态 1启用 0停用',
    create_time DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (id),
    KEY idx_banner_heritage (heritage_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='轮播图表';

-- ---------------------------------------------------------------
-- 6. 非遗宣传视频表 video
-- ---------------------------------------------------------------
CREATE TABLE video (
    id          INT          NOT NULL AUTO_INCREMENT COMMENT '视频ID',
    title       VARCHAR(100) NOT NULL COMMENT '视频标题',
    cover       VARCHAR(255) DEFAULT NULL COMMENT '视频封面',
    url         VARCHAR(500) NOT NULL COMMENT '视频地址',
    description VARCHAR(500) DEFAULT NULL COMMENT '视频描述',
    status      TINYINT      DEFAULT 1 COMMENT '状态 1上架 0下架',
    create_time DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='非遗宣传视频表';

-- ---------------------------------------------------------------
-- 7. 通知公告表 notice
-- ---------------------------------------------------------------
CREATE TABLE notice (
    id          INT          NOT NULL AUTO_INCREMENT COMMENT '公告ID',
    title       VARCHAR(100) NOT NULL COMMENT '公告标题',
    content     LONGTEXT     COMMENT '公告内容',
    cover       VARCHAR(255) DEFAULT NULL COMMENT '封面图',
    status      TINYINT      DEFAULT 1 COMMENT '状态 1发布 0下架',
    create_time DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
    PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='通知公告表';

-- ---------------------------------------------------------------
-- 8. 资讯表 news
-- ---------------------------------------------------------------
CREATE TABLE news (
    id          INT          NOT NULL AUTO_INCREMENT COMMENT '资讯ID',
    title       VARCHAR(100) NOT NULL COMMENT '资讯标题',
    cover       VARCHAR(255) DEFAULT NULL COMMENT '封面图',
    summary     VARCHAR(500) DEFAULT NULL COMMENT '摘要',
    content     LONGTEXT     COMMENT '资讯内容',
    author      VARCHAR(50)  DEFAULT NULL COMMENT '作者/来源',
    views       INT          DEFAULT 0 COMMENT '浏览量',
    status      TINYINT      DEFAULT 1 COMMENT '状态 1发布 0下架',
    create_time DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
    PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='资讯表';

-- ---------------------------------------------------------------
-- 9. 活动表 activity
-- ---------------------------------------------------------------
CREATE TABLE activity (
    id            INT          NOT NULL AUTO_INCREMENT COMMENT '活动ID',
    title         VARCHAR(100) NOT NULL COMMENT '活动标题',
    cover         VARCHAR(255) DEFAULT NULL COMMENT '活动封面图',
    content       LONGTEXT     COMMENT '活动内容',
    start_time    DATETIME     DEFAULT NULL COMMENT '活动开始时间',
    end_time      DATETIME     DEFAULT NULL COMMENT '活动结束时间',
    signup_start  DATETIME     DEFAULT NULL COMMENT '报名开始时间',
    signup_end    DATETIME     DEFAULT NULL COMMENT '报名截止时间',
    location      VARCHAR(200) DEFAULT NULL COMMENT '活动地点',
    capacity      INT          DEFAULT 0 COMMENT '名额上限(0不限)',
    signup_count  INT          DEFAULT 0 COMMENT '已报名人数',
    status        TINYINT      DEFAULT 1 COMMENT '状态 1上架 0下架',
    create_time   DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='活动表';

-- ---------------------------------------------------------------
-- 10. 活动报名表 signup
-- ---------------------------------------------------------------
CREATE TABLE signup (
    id          INT          NOT NULL AUTO_INCREMENT COMMENT '报名ID',
    activity_id INT          NOT NULL COMMENT '活动ID',
    user_id     INT          NOT NULL COMMENT '报名用户ID',
    name        VARCHAR(50)  DEFAULT NULL COMMENT '报名人姓名',
    phone       VARCHAR(20)  DEFAULT NULL COMMENT '联系电话',
    remark      VARCHAR(255) DEFAULT NULL COMMENT '备注',
    status      TINYINT      DEFAULT 0 COMMENT '审核状态 0待审核 1通过 2拒绝',
    create_time DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '报名时间',
    PRIMARY KEY (id),
    KEY idx_signup_activity (activity_id),
    KEY idx_signup_user (user_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='活动报名表';

-- ---------------------------------------------------------------
-- 11. 收藏表 favorite
-- ---------------------------------------------------------------
CREATE TABLE favorite (
    id          INT      NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
    user_id     INT      NOT NULL COMMENT '用户ID',
    heritage_id INT      NOT NULL COMMENT '文化遗产ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
    PRIMARY KEY (id),
    UNIQUE KEY uk_favorite (user_id, heritage_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='收藏表';

-- ---------------------------------------------------------------
-- 12. 评论表 comment
-- ---------------------------------------------------------------
CREATE TABLE `comment` (
    id          INT      NOT NULL AUTO_INCREMENT COMMENT '评论ID',
    user_id     INT      NOT NULL COMMENT '用户ID',
    heritage_id INT      NOT NULL COMMENT '文化遗产ID',
    content     VARCHAR(1000) NOT NULL COMMENT '评论内容',
    status      TINYINT  DEFAULT 1 COMMENT '状态 1正常 0删除',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
    PRIMARY KEY (id),
    KEY idx_comment_heritage (heritage_id),
    KEY idx_comment_user (user_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='评论表';

-- ---------------------------------------------------------------
-- 13. 意见反馈表 feedback
-- ---------------------------------------------------------------
CREATE TABLE feedback (
    id          INT          NOT NULL AUTO_INCREMENT COMMENT '反馈ID',
    user_id     INT          NOT NULL COMMENT '用户ID',
    content     VARCHAR(1000) NOT NULL COMMENT '反馈内容',
    reply       VARCHAR(1000) DEFAULT NULL COMMENT '管理员回复',
    reply_time  DATETIME     DEFAULT NULL COMMENT '回复时间',
    status      TINYINT      DEFAULT 0 COMMENT '状态 0未回复 1已回复',
    create_time DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '反馈时间',
    PRIMARY KEY (id),
    KEY idx_feedback_user (user_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='意见反馈表';

-- =============================================================
-- 初始数据
-- =============================================================

-- 管理员（账号 admin / 密码 123456，MD5加密）
INSERT INTO admin (username, password, name, role, status) VALUES
('admin', 'e10adc3949ba59abbe56e057f20f883e', '系统管理员', 'admin', 1);

-- 测试用户（账号 user / 密码 123456）
INSERT INTO `user` (username, password, nickname, sex, status) VALUES
('user', 'e10adc3949ba59abbe56e057f20f883e', '演示用户', 1, 1);

-- 非遗十大分类
INSERT INTO category (name, description, sort) VALUES
('民间文学', '口头传统、神话传说、民间故事等', 1),
('传统音乐', '民歌、器乐、民间音乐等', 2),
('传统舞蹈', '民族民间舞蹈', 3),
('传统戏剧', '地方戏曲、傩戏等', 4),
('曲艺', '相声、评书、弹词等', 5),
('传统体育、游艺与杂技', '武术、杂技、棋类等', 6),
('传统美术', '剪纸、刺绣、年画等', 7),
('传统技艺', '陶瓷、织造、酿造等手工技艺', 8),
('传统医药', '中医、民族医药等', 9),
('民俗', '节日、庙会、婚俗等', 10);
