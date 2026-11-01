# Repository 与前端消费契约

Repository 是 domain 定义的抽象，返回领域模型或不可变结果，不返回 Drift 行、SQL 或数据库连接。

## 最小接口意图

- `RootRepository`: `listRoots(query, cursor)`、`getRoot(id)`、`getRelatedWords(rootId)`。
- `WordRepository`: `getWord(id)`、`listWords(filter, cursor)`、`getExamples(wordId)`。
- `StudyRepository`: `createSession(mode)`、`nextItem(sessionId)`、`recordAnswer(input)`、`skipItem(sessionId, itemId)`、`finishSession(sessionId)`、`abandonSession(sessionId)`。
- `LearningStateRepository`: `getState(contentId)`、`upsertState(state)`、`listDueStates(asOf)`。
- `SettingsRepository`: `read(key)`、`write(key, value)`、`exportData()`、`importData(payload)`。

## v0.1 消费契约冻结条件

实际 Dart 类型落地前，统一遵守以下边界：

- 内容 ID 使用稳定、不可变的字符串；用户生成记录 ID 由数据层生成。
- 分页使用不透明的可空 `cursor` 与正整数 `limit`；无更多数据返回 `nextCursor = null`。
- 查询结果包含不可变 `items`、`nextCursor` 和必要的 `isFromCache` 信息；UI 不依赖数据库分页细节。
- 异步命令统一返回成功结果或领域错误；错误至少区分 `NotFound`、`Validation`、`Storage`、`Conflict`、`Unsupported`。
- `startStudySession` 返回 session 标识和首个学习项；`submitAnswer` 返回本次答题结果及下一项或结束标记；`finishSession` 返回只读总结。
- 跳过属于学习事件但不计为答对；退出结束当前 session 但不删除已记录事件；重复提交由 session/item 状态拒绝并返回 `Conflict`。
- `skipItem` 记录跳过事件并返回下一项或 session 完成状态；跳过不能映射成“答对”或 FSRS 评分。
- `abandonSession` 将 session 标记为已放弃并返回总结；已写入的学习事件保留。
- `unverified` 是内容可信度的显式状态，前端可以展示提示但不得当作已验证词源。

接口命名和参数以实际 Dart 类型落地时再冻结；错误统一为 `NotFound`、`Validation`、`Storage`、`Conflict`、`Unsupported` 等可处理类别。分页使用 cursor/limit，不用 UI 依赖的 SQL offset。

前端允许依赖的内容：加载状态、不可变模型、领域错误、命令结果和事件；禁止依赖表名、SQL、DTO、迁移版本和 FSRS 内部字段。
