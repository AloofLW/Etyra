# 数据模型边界

领域实体：`Root`、`Affix`、`Word`、`WordComponent`、`ExampleSentence`、`LearningState`、`ReviewRecord`、`StudySession`、`DailyPlan`、`DailyStats`、`UserSettings`。

内容实体描述“学什么”；学习实体描述“用户学到哪里”；复习实体描述“何时、以什么结果学习过”。三者通过稳定 ID 关联，不能把用户状态写入词条内容字段。

v0.1 必需：词条标识、可展示文本、释义/翻译、构词关联、例句、来源出处与许可/署名信息、校验状态、学习阶段（new/learning/learned）、最后学习时间、次数和最小日志。`learned` 只代表完成首轮学习，不等同长期掌握。后续：音频元数据、FSRS 参数/状态、每日计划统计、通知设置、备份元数据。

所有时间使用带时区的 UTC 存储并在展示层转换；ID 由数据层生成或由内容包稳定提供。枚举未知值必须可向前兼容。

## ET-01D 落地说明

- 内容类型位于 roots/words 的 domain，来源与错误/分页位于 `features/shared/domain/`；所有模型只依赖 Dart SDK 或其他 domain 类型，集合做防御性复制，时间在构造时转换为 UTC。
- 学习类型位于 `features/study/domain/study_models.dart`，覆盖共享契约的 LearningState、StudyCard、AnswerInput/Result、StudySession/Start、SessionSummary。`LearningStage.newItem` 对应持久值 `new`（Dart 关键字不能作为枚举成员）。
- `Root`/`Affix` 无来源时强制为 `unverified`；读取未来未知校验状态降级为 unverified，未知 affix kind/component role 降级为 unknown，未知 component type 省略对应关系。未来未知学习阶段返回稳定 Unsupported，不覆写数据库原值。
- `RootDetail` 的 root、affixes、words、components、examples 均只读。未加共享契约以外的 UI 字段或 FSRS 类型；没有创建 ReviewRecord、DailyPlan、DailyStats 或 UserSettings 的空壳承诺。
- 按 ADR-014，fake 的首次 recalled 将条目转为 learned；needsPractice 使 new 转为 learning，不降级 learned；skip 不改状态，session 完成不改变阶段。dueAt 始终为 null，不产生 FSRS 状态。
