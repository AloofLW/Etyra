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

## ET-01D 实际 Dart 入口

以上“最小接口意图”为早期规划；本轮以 `docs/CONTRACTS_V0_1.md` 的命令命名为准，不为旧命名增加重复接口。

- `features/roots/domain/root_repository.dart`：`listRoots({query, cursor, limit = 30})`、`getRootDetail(rootId)`。
- `features/words/domain/word_repository.dart`：`getWord(id)`、`listWords({query, cursor, limit = 30})`、`getExamples(wordId)`。
- `features/study/domain/study_repository.dart`：`startStudySession(mode, {contentIds})`、`submitAnswer(input)`、`skipItem(sessionId, itemId)`、`finishSession(sessionId)`、`abandonSession(sessionId)`；只读 `LearningStateRepository.getState(contentType, contentId)` 使用复合身份避免 root/word ID 冲突。
- 所有异步返回 `Future<Result<T>>`。`Success<T>.value` 表示成功；`Failure<T>.error` 包含 `FailureKind` 和稳定 `messageKey`，不包含 SQL 文本或原始异常。错误类别采用 Dart lowerCamelCase：`notFound/validation/storage/conflict/unsupported`。
- `features/shared/domain/page.dart`：`items` 防御性复制并不可修改，`nextCursor` 不透明；`isFromCache` 在本地事实来源和 fake 中均为 false。
- `application/` 提供 `ListRoots`、`GetRootDetail`、`GetWord`、`ListWords`、`GetExamples`、`StartStudySession`、`SubmitAnswer`、`SkipItem`、`FinishSession`、`AbandonSession`、`GetLearningState`，通过 `call` 调用。
- 前端开发可注入 `InMemoryContentRepository` 和 `InMemoryStudyRepository`。它们不含默认词条，数据重启即丢失；不得当作真实持久化。fake 对不存在的显式 ID 返回 NotFound，对重复/非当前卡片提交返回 Conflict；跳过不增加 studyCount。
- fake 在最后一次处理卡片时结束 session；`finishSession` 可重复读取已完成总结，未完成时返回 Conflict；重复 abandon 保留首次结束时间，已完成 session 不能再 abandon。此行为已由 ADR-015 接受。
- `DriftContentRepository` 提供读取实现骨架；`DriftLearningStateRepository` 提供只读状态映射。`DriftStudyRepository` 的写操作明确返回 `Unsupported/study.persistence_not_ready`，等待数据库验证与后续持久化实现，不能接入真实学习保存流程。
- 本轮未开放任意 `upsertState`、设置、备份、FSRS 调度和到期列表接口；这些不属于冻结的 v0.1 前端命令。
