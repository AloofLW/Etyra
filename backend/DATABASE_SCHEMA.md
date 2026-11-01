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
