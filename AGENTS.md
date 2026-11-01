# Etyra 协作工程基线

## 项目定位

Etyra 是 Flutter + Dart 的 iOS 词根词缀学习应用，采用离线优先、本地 Drift/SQLite、Riverpod 和 Cupertino 风格。首要目标是可验证、可维护的学习闭环，而不是一次性堆叠功能。

## 文档入口

- 总览与版本边界：`docs/PROJECT_OVERVIEW.md`
- 产品目标：`docs/PRODUCT_GOAL.md`
- 开发规则：`docs/DEVELOPMENT_RULES.md`
- 架构：`docs/ARCHITECTURE.md`
- 路线图：`docs/ROADMAP.md`
- 任务清单：`docs/TASKS.md`
- 决策记录：`docs/DECISIONS.md`
- v0.1 共享契约：`docs/CONTRACTS_V0_1.md`
- 前端规范：`frontend/UI_GUIDELINES.md`、`frontend/INTERACTION_SPEC.md`
- 功能与设计规划：`docs/FEATURE_PLAN.md`、`frontend/DESIGN_SPEC.md`
- ET-01 实施蓝图：`docs/IMPLEMENTATION_PLAN.md`
- 后端规范：`backend/DATABASE_SCHEMA.md`、`backend/DATA_MODELS.md`、`backend/REPOSITORY_CONTRACTS.md`、`backend/FSRS_SPEC.md`

## 三个 Codex 对话的职责边界

1. **项目管理对话**：维护规范、路线图、任务、决策、验收标准和跨对话协调；不直接实现业务功能。
2. **前端对话**：只负责 `presentation/` 及 UI/交互相关代码；通过 application/domain 契约消费状态和命令，不直接访问 Drift/SQLite。
3. **后端对话**：负责 `application/`、`domain/`、`data/`、`database/`、repositories、services、FSRS 适配；不改动页面布局和交互细节。

如需跨边界修改，先在 `docs/DECISIONS.md` 记录原因、影响和验收方式，再修改共享契约。

### 共享 App 入口所有者

根据 ADR-018，项目管理对话是 `lib/main.dart`、`lib/app/**`、根 `ProviderScope`、全局路由注册和 application provider 装配的唯一 owner。当前只接入本地 fixture 预览；真实持久化装配须等后端学习写入实现并验证后进行。

## 工作方式

- 先读文档和当前状态，再编辑；保留用户已有修改，不覆盖未知内容。
- 一个任务一个分支或 worktree；不要让多个对话同时编辑同一文件。
- 任何数据模型、Repository 方法或 UI 状态变化，都要同步更新对应契约文档。
- 不执行会改变项目状态的构建、依赖安装、数据库迁移或代码生成命令，除非任务明确授权。
- 不凭空补充词源、释义或例句；每条词源数据必须有可追溯来源或标记为待校验。
- 完成任务必须报告：改动文件、验证结果、未决问题、下一步。

## 当前基线

Flutter iOS 工程和 Git `main` 已初始化；当前工具链为 Flutter 3.47.1 stable、Dart 3.13.1、Xcode 16.2，最低 iOS 部署版本 17.0。Riverpod/Drift 依赖已解析并记录在 `pubspec.lock`。Bundle ID 暂为 `com.example.etyra`，真机签名前需换成用户确认的唯一标识。
