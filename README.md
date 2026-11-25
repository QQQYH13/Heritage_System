# 非遗文化管理系统（Heritage System）

基于 **SpringBoot3 + Vue3** 前后端分离架构的非遗文化展示与管理平台。系统分为「管理员端」和「普通用户端」，涵盖非遗文化遗产展示、宣传视频、资讯、活动报名、收藏、评论、意见反馈等完整功能。

---

## 一、技术栈

| 层 | 技术 |
|------|------|
| 后端 | SpringBoot 3、MyBatis、Hutool、JWT、MySQL |
| 前端 | Vue 3、Element-Plus、Vue-Router、Axios、Vite |
| 数据库 | MySQL 5.7 / 8.0 |

---

## 二、环境要求（组员务必逐项检查）

| 工具 | 版本要求 | 说明 / 下载地址 |
|------|---------|----------------|
| JDK | **≥ 17**（推荐 21） | [Oracle JDK](https://www.oracle.com/java/technologies/downloads/) 或 [Adoptium](https://adoptium.net/) |
| Maven | **≥ 3.8** | [Apache Maven](https://maven.apache.org/download.cgi) |
| MySQL | **5.7 或 8.0** | [MySQL Installer](https://dev.mysql.com/downloads/installer/) |
| Node.js | **≥ 18**（推荐 LTS） | [Node.js](https://nodejs.org/) |
| Navicat | **≥ 16** | [Navicat](https://www.navicat.com.cn/)（付费，可试用） |
| Git | 最新版 | [Git](https://git-scm.com/) |
| IDE | 后端 IDEA / 前端 VS Code | [IntelliJ IDEA](https://www.jetbrains.com/idea/) / [VS Code](https://code.visualstudio.com/) |

> **安装后验证**（终端执行）：
> ```bash
> java -version      # 应显示 17 或更高
> mvn -version       # 应显示 3.8 或更高
> node -v            # 应显示 18 或更高
> mysql --version    # 应显示 5.7 或 8.x
> ```

---

## 三、项目结构

```
Heritage_System/
├── backend/                         # SpringBoot3 后端
│   ├── pom.xml                      # Maven 依赖
│   └── src/main/
│       ├── java/com/heritage/
│       │   ├── HeritageApplication.java   # 启动类
│       │   ├── annotation/          # 权限注解（@RequireLogin / @RequireAdmin）
│       │   ├── common/              # 统一返回 Result / 异常处理
│       │   ├── config/              # 跨域 / 拦截器配置
│       │   ├── interceptor/         # JWT 登录拦截器
│       │   ├── util/                # JwtUtil / UserContext
│       │   ├── entity/              # 实体类（13 张表）
│       │   ├── mapper/              # MyBatis Mapper
│       │   ├── service/             # 业务接口 + 实现
│       │   └── controller/          # 控制器（admin / user）
│       └── resources/
│           ├── application.yml      # 配置文件
│           └── mapper/              # MyBatis XML
├── frontend/                        # Vue3 前端（待搭建）
├── sql/
│   └── heritage_system.sql          # 数据库脚本（13 张表 + 初始数据）
├── docs/                            # 接口文档 / 设计文档
└── README.md
```

---

## 四、快速开始

### 1. 克隆仓库

```bash
git clone <仓库地址>
cd Heritage_System
```

### 2. 初始化数据库

**方式一：Navicat（推荐）**
1. 打开 Navicat，新建 MySQL 连接（localhost:3306，root）。
2. 新建数据库 `heritage_system`（字符集 `utf8mb4`）。
3. 右键该库 → 运行 SQL 文件 → 选择 `sql/heritage_system.sql` → 执行。

**方式二：命令行**
```bash
mysql -u root -p < sql/heritage_system.sql
```

> 初始账号：管理员 `admin / 123456`，测试用户 `user / 123456`。

### 3. 启动后端

1. 修改 `backend/src/main/resources/application.yml` 中的数据库密码：
   ```yaml
   spring:
     datasource:
       username: root
       password: "改成你的MySQL密码"
   ```
2. 用 IDEA 打开 `backend` 目录（或项目根目录），等待 Maven 依赖下载完成。
3. 运行 `HeritageApplication` 启动类。
4. 启动成功后访问：`http://localhost:8080`

> 命令行方式：`cd backend && mvn spring-boot:run`

### 4. 启动前端（待前端搭建后补充）

```bash
cd frontend
npm install
npm run dev
```

---

## 五、数据库设计（13 张表）

| # | 表名 | 说明 | 关键字段 |
|---|------|------|---------|
| 1 | `admin` | 管理员 | username, password, role, status |
| 2 | `user` | 普通用户 | username, password, nickname, sex |
| 3 | `category` | 非遗分类 | name, description, sort |
| 4 | `heritage` | 文化遗产 | category_id, name, cover, content, level, region |
| 5 | `banner` | 轮播图 | heritage_id, image, sort |
| 6 | `video` | 宣传视频 | title, cover, url |
| 7 | `notice` | 通知公告 | title, content, status |
| 8 | `news` | 资讯 | title, cover, content, author |
| 9 | `activity` | 活动 | title, start/end_time, capacity, signup_count |
| 10 | `signup` | 活动报名 | activity_id, user_id, status(审核) |
| 11 | `favorite` | 收藏 | user_id, heritage_id |
| 12 | `comment` | 评论 | user_id, heritage_id, content |
| 13 | `feedback` | 意见反馈 | user_id, content, reply |

完整字段见 `sql/heritage_system.sql`。

---

## 六、开发规范（重要，保证协作与留痕）

### Git 分支规范

| 分支 | 用途 | 说明 |
|------|------|------|
| `main` | 稳定版本 | 只从 `develop` 合并，**禁止直接 push** |
| `develop` | 开发主线 | 日常开发基础分支 |
| `feature/xxx` | 功能分支 | 从 `develop` 拉，完成合并回 `develop` |
| `bugfix/xxx` | 修复分支 | 修 bug |

### 提交信息规范

```
<type>: <简短描述>

feat:     新功能
fix:      修复 bug
docs:     文档修改
refactor: 重构（不改变功能）
style:    代码格式
chore:    构建/工具/杂项
```

示例：`feat: 完成文化遗产列表接口`、`fix: 修复登录 token 过期判断`。

### 代码规范

- 后端统一返回 `Result`，禁止直接返回裸对象。
- 需要登录的接口标注 `@RequireLogin`，管理员接口标注 `@RequireAdmin`。
- 接口按模块划分：`/api/admin/**`（管理端）、`/api/user/**`（用户端）、公开查询接口无需登录。
- 前端统一在 `utils/request.js` 封装 Axios（拦截 token 与统一错误处理）。
- 涉及改动数据库结构，必须同步更新 `sql/heritage_system.sql`。

---

## 七、团队分工

| 成员 | 职责 |
|------|------|
| 成员 A（后端） | SpringBoot 接口：实体 → Mapper → Service → Controller，JWT 登录，13 个模块 |
| 成员 B（前端） | Vue3 + Element Plus：用户端 + 管理端页面、Axios 封装、路由守卫 |
| 成员 C（数据库/联调） | 13 张表设计维护、Navicat 建库、接口联调、统计图表、部署 |

---

## 八、开发进度

- [x] 数据库脚本（13 张表 + 初始数据）
- [x] 后端骨架（启动类、统一返回、全局异常、JWT、跨域、权限注解）
- [ ] 后端业务代码（实体/Mapper/Service/Controller，13 个模块）
- [ ] 前端骨架（Vite + Vue3 + Element Plus + Router + Axios）
- [ ] 前端页面（用户端 + 管理端）
- [ ] 数据统计图表、文件上传、联调部署
