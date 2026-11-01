# Etyra v0.1 共享消费契约

本文件冻结前端和后端并行开发所需的最小领域模型。它描述 Dart 层应提供的语义，不暴露 Drift、SQLite、DTO 或 FSRS 内部结构。

## 通用约定

- 内容 ID 使用稳定 `String`；用户记录 ID 由数据层生成。
- 时间使用 UTC 存储，在 presentation 层转换为本地时间。
- 可选字段使用 nullable；未知枚举值必须能安全降级。
- 分页使用 `Page<T>(items, nextCursor)`；`nextCursor == null` 表示没有更多数据。
- `limit` 为正整数，cursor 对 UI 不透明。

## 内容模型

```text
Root {
  String id
  String lemma
  String displayForm
  String language
  String meaning
  String? originNote
  VerificationStatus verificationStatus
  List<SourceRef> sources
}

Affix {
  String id
  String form
  AffixKind kind
  String meaning
  VerificationStatus verificationStatus
  List<SourceRef> sources
}

Word {
  String id
  String word
  String normalizedWord
  String? partOfSpeech
  String definition
  String? translation
  String? pronunciationRef
  List<SourceRef> sources
}

WordComponent {
  String wordId
  ComponentType componentType
  String componentId
  ComponentRole role
  double? confidence
  List<SourceRef> sources
}

ExampleSentence {
  String id
  String wordId
  String sentence
  String? translation
  List<SourceRef> sources
}

WordDetail {
  Word word
  List<Root> roots
  List<Affix> affixes
  List<WordComponent> components
  List<ExampleSentence> examples
}

SourceRef {
  String id
  String title
  String? publisher
  String? edition
  String? url
  String? locator
  String? licenseName
  String? licenseUrl
  String? attributionText
  DateTime? accessedAt
}
```

## v0.1 枚举

- `VerificationStatus`: `verified`、`unverified`、`disputed`。
- `AffixKind`: `prefix`、`suffix`、`other`、`unknown`。
- `ComponentType`: `root`、`affix`。
- `ComponentRole`: `root`、`prefix`、`suffix`、`other`、`unknown`。
- `ContentType`: `root`、`word`。
- `LearningStage`: `new`、`learning`、`learned`。`learned` 只表示完成首轮学习，不代表长期掌握。
- `StudyMode`: `roots`、`words`。
- `AnswerRating`: `recalled`、`needsPractice`。这是学习反馈，不是 FSRS 评分。
- `AnswerOutcome`: `recalled`、`needsPractice`、`skipped`。
- `StudySessionStatus`: `active`、`completed`、`abandoned`。

持久化枚举使用稳定字符串值；遇到未来未知值时映射为 `unknown` 或安全降级，不能导致数据库读取失败。未经验证或有争议的词源不能在 UI 中显示为确定事实。

`SourceRef` 保存可追溯出处和许可/署名信息。词条没有来源时必须保持 `unverified`；导入审核需能判断来源是否允许复制内容、改编或再分发。

`WordDetail` 是只读聚合：单词存在但没有构词关系或例句时，相关集合为空；单词 ID 不存在时，`getWordDetail` 返回 `NotFound`。`components` 保留构词关系的类型、角色、置信度和来源，`roots`/`affixes` 提供关联实体。前端不得仅凭词形相似推断构词关系或词源。

## 学习模型

```text
LearningState {
  String contentId
  ContentType contentType
  LearningStage stage
  DateTime? dueAt
  DateTime? lastStudiedAt
  int studyCount
}

StudyCard {
  String itemId
  ContentType contentType
  String prompt
  String answer
  List<String> hints
  int position
  int total
}

AnswerInput {
  String sessionId
  String itemId
  AnswerRating rating
  int? responseMilliseconds
}

AnswerResult {
  String sessionId
  String itemId
  AnswerOutcome outcome
  StudyCard? nextCard
  bool sessionFinished
  int completedCount
  int skippedCount
  int totalCount
}

StudySession {
  String id
  StudyMode mode
  StudySessionStatus status
  DateTime startedAt
  DateTime? finishedAt
}

StudySessionStart {
  StudySession? session
  StudyCard? firstCard
  int totalCount
}

SessionSummary {
  String sessionId
  StudyMode mode
  StudySessionStatus status
  int itemCount
  int completedCount
  int skippedCount
  DateTime startedAt
  DateTime finishedAt
}
```

v0.1 的 `AnswerRating` 只表达本次学习反馈，不声称是 FSRS 调度结果。FSRS 相关状态由后端预留，不进入前端模型。

`completedCount` 统计已提交 `recalled` 或 `needsPractice` 的条目；`skippedCount` 单独统计跳过项。Session 中所有条目都已答题或跳过后，`sessionFinished` 为 true。

`new` 表示从未学习；首次提交 `needsPractice` 后转为 `learning`，首次提交 `recalled` 后转为 `learned`；`needsPractice` 不会将已 `learned` 降级，跳过不改变学习状态。Session 完成与否不改变条目阶段。`learned` 仅表示完成一次主动回忆，不代表长期掌握。v0.1 不提供长期掌握状态或到期排程，`dueAt` 保持 null。详见 ADR-014。

Session 在最后一张卡片被答题或跳过时自动完成。`finishSession` 仅可重复读取已完成总结；尚有未处理卡片或已放弃的 Session 返回 `Conflict`。重复放弃返回首次放弃时生成的总结；已完成 Session 不可放弃。详见 ADR-015。

## Repository / application 命令

```text
listRoots(query, cursor, limit) -> Page<Root>
getRootDetail(rootId) -> RootDetail
getWordDetail(wordId) -> WordDetail
startStudySession(mode, contentIds?) -> StudySessionStart
submitAnswer(input) -> AnswerResult
skipItem(sessionId, itemId) -> AnswerResult
finishSession(sessionId) -> SessionSummary
abandonSession(sessionId) -> SessionSummary
```

`RootDetail` 包含一个 `Root`、关联的 `Affix`、`Word`、`WordComponent` 和 `ExampleSentence` 只读集合。筛选后没有学习项时，`StudySessionStart.session` 与 `firstCard` 均为 null，`totalCount` 为 0；不创建可提交的 session。

`WordDetail` 包含一个 `Word`、关联的 `Root`/`Affix`、`WordComponent` 和 `ExampleSentence` 只读集合；构词关系与例句可为空。v0.1 不提供发音播放能力；`pronunciationRef` 仅为预留引用。

## 状态语义

- **跳过**：调用 `skipItem` 记录事件，不计为答对；返回下一张卡片。
- **退出**：调用 `abandonSession` 将 session 标记为 `abandoned`，不删除已记录事件；后续不能继续提交该 session。
- **重复提交**：同一 session/item 已提交时返回 `Conflict`，不重复写入。
- **无内容**：返回空集合或可展示的空状态，不视为存储错误。
- **内容不存在**：返回 `NotFound`。

## 错误契约

统一错误类别：`NotFound`、`Validation`、`Storage`、`Conflict`、`Unsupported`。前端只依赖类别和用户可处理的消息键，不依赖 SQL/Drift 异常文本。

## 当前仍待确认

- 发音能力的 v0.1 范围。
