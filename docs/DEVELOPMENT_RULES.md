# 开发规则

## 代码与目录

- 采用 feature-first：功能优先，其次按 `presentation / application / domain / data` 分层。
- 页面不直接依赖数据库表；页面依赖 Riverpod provider、用例和只读视图模型。
- 领域层不依赖 Flutter、Drift 生成类或具体存储实现。
- 数据层负责 DTO、Drift 表、映射、迁移和 Repository 实现。
- 共享接口先定契约再实现；避免为了方便把数据库实体暴露给 UI。

## 数据与内容

- 词根、词缀、单词、例句和关联关系都必须可追溯到来源。
- 词源是历史语言学事实，不得根据词形相似臆造；不确定时使用 `unverified`，不展示为确定结论。
- 内容导入必须幂等、可审计、可重复执行，并拒绝破坏性覆盖。
- 用户学习状态与内容数据分离，便于词库升级不重置学习进度。

## 依赖与版本

- 当前 Flutter 工程已建立；依赖选择和解析记录在 `docs/IMPLEMENTATION_PLAN.md` 与 `pubspec.lock`。
- 当前候选：`flutter_riverpod`、`drift`、`drift_flutter`、`drift_dev`、`build_runner`，最终组合以工程实际依赖解析为准。
- 不默认加入 `sqlite3_flutter_libs`、`path_provider`、Freezed/JSON 生成工具或 Riverpod generator；先确认具体需求及 Drift 当前官方方案。
- FSRS 库只在 v0.2 选定有版本、许可证、测试和文档依据的实现；不以“最新”为理由盲目升级。
- `pubspec.yaml` 记录受控版本约束；应用工程提交 `pubspec.lock`；升级一次一个主题并记录原因。

## Git、worktree 与所有权

- 建议分支：`main`、`chore/baseline`、`feat/frontend-<name>`、`feat/backend-<name>`、`docs/<name>`。
- 项目管理对话拥有 `docs/` 与 `AGENTS.md`；前端对话拥有 `lib/features/*/presentation/` 和 `frontend/`；后端对话拥有 `lib/features/*/domain/`、`data/`、`database/` 和 `backend/`。
- 共享文件（路由注册、provider 汇总、公共模型、导入索引）一次只由一个对话编辑；其他对话通过契约提出变更。
- 合并前检查：格式、静态分析、相关测试、迁移可执行性和文档同步。
