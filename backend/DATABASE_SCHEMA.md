# 数据库 Schema 规划

## 内容表（相对稳定）

- `roots`：`id`、`lemma`、`display_form`、`language`、`meaning`、`origin_note`、`verification_status`、`source_refs`、`created_at`、`updated_at`。
- `affixes`：`id`、`form`、`kind`、`meaning`、`verification_status`、`source_refs`。
- `words`：`id`、`word`、`normalized_word`、`part_of_speech`、`definition`、`translation`、`pronunciation_ref`、`source_refs`。
- `word_components`：`word_id`、`component_type`、`component_id`、`role`、`confidence`、`source_refs`。
- `examples`：`id`、`word_id`、`sentence`、`translation`、`source_refs`。

`source_refs` 以可迁移 JSON 或规范化关联表保存完整 `SourceRef`：ID、标题、发布者、版次、URL、定位信息、许可名称/链接、署名文本、访问时间。选定存储形式时须保证来源能关联到具体词条及构词/例句关系。

## 用户表（可变）

- `learning_states`：`content_type`、`content_id`、`stage`、`last_studied_at`、`study_count`。`due_at` 和 FSRS 状态由 v0.2 调度引入。
- `study_logs`：v0.1 学习事件；`id`、`content_type`、`content_id`、`session_id`、`outcome`（recalled/needsPractice/skipped）、`answered_at`、`response_ms`。
- `study_sessions`：`id`、`started_at`、`finished_at`、`mode`、`status`（active/completed/abandoned）、`item_count`、`completed_count`、`skipped_count`。
- `review_logs`：v0.2 引入 FSRS 后记录评分和调度快照，不把 v0.1 普通学习事件误称为 FSRS 复习。
- `daily_plans` / `daily_stats`：v0.2 使用，保存日期、目标、完成量、复习量和统计快照。
- `user_settings`：`key`、`value`、`value_type`、`updated_at`；设置键需有白名单。

## 迁移原则

数据库版本单调递增；迁移只增量、不删除用户数据；破坏性变更先备份并提供回滚/恢复策略。内容导入使用稳定 ID 和 upsert，禁止用词库刷新覆盖学习状态。每次迁移有空库、旧库、重复执行和失败恢复测试。

## ET-01E v1 实现骨架（已生成并做空库烟测）

- 入口为 `lib/database/app_database.dart`，`schemaVersion = 1`；连接由 app 组装方传入，本模块不在 import 时打开数据库。
- `onCreate` 使用 Drift `createAll`；不存在已发布旧版本，`onUpgrade` 对未实现路径明确拒绝，后续必须添加并验证增量步骤。`beforeOpen` 启用外键。
- 内容表：`roots`、`affixes`、`words`、`word_components`、`examples`。完整 `SourceRef` 以 JSON 存储在对应记录的 `source_refs`，保留许可和署名字段。
- 用户表：`learning_states`、`study_sessions`、`study_session_items`、`study_logs`。`study_session_items` 保存队列顺序和卡片文本快照，避免内容升级改变已启动会话；`study_logs` 对 session/content 设置唯一约束以支持重复提交拒绝。
- `learning_states` 主键为 `(content_type, content_id)`；不同内容类型允许相同字符串 ID。v1 仅预留 nullable `due_at`、`fsrs_state_json`、`fsrs_due_at`、`fsrs_version`，v0.1 不写排程。
- 所有数据库时间列采用 UTC Unix 毫秒整数，映射到领域层时显式使用 UTC。枚举存储字符串，不用限制未来枚举值的 SQL CHECK。
- `word_components` 的多态目标由导入器校验；`word_id` 和例句关联使用外键。学习状态不对内容做级联删除。
- 审计表 `seed_imports`：包 ID、正整数版本、规范载荷、审核人、审核依据、审核时间、导入时间、条目数；主键为 `(package_id, version)`。成功收据与内容在同一事务提交。
- 本轮导入只允许新增或同值复用；同版本载荷变化、降级、已有 ID 内容变化返回 `Conflict`。完整的内容变更 upsert 策略尚待确认，骨架不会覆盖用户进度或删除内容。
- 导入包必须自包含，校验稳定 ID、重复记录、来源/许可、人工再分发审核依据、关系目标、confidence 范围；不提供词库资产或默认词条。失败返回领域错误并回滚，失败尝试的持久审计尚未实现。

迁移依据：[Drift migrations](https://drift.simonbinder.eu/migrations/)、[migrator API](https://drift.simonbinder.eu/migrations/api/)。2026-11-01 已生成 `app_database.g.dart`，并以内存 SQLite 验证 v1 空库建表和外键开启；这不覆盖持久库 reopen、迁移升级、迁移失败恢复、种子事务回滚或持久学习写入，v1 尚未完整验收。
