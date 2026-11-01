# 数据模型边界

领域实体：`Root`、`Affix`、`Word`、`WordComponent`、`ExampleSentence`、`LearningState`、`ReviewRecord`、`StudySession`、`DailyPlan`、`DailyStats`、`UserSettings`。

内容实体描述“学什么”；学习实体描述“用户学到哪里”；复习实体描述“何时、以什么结果学习过”。三者通过稳定 ID 关联，不能把用户状态写入词条内容字段。

v0.1 必需：词条标识、可展示文本、释义/翻译、构词关联、例句、来源出处与许可/署名信息、校验状态、学习阶段（new/learning/learned）、最后学习时间、次数和最小日志。`learned` 只代表完成首轮学习，不等同长期掌握。后续：音频元数据、FSRS 参数/状态、每日计划统计、通知设置、备份元数据。

所有时间使用带时区的 UTC 存储并在展示层转换；ID 由数据层生成或由内容包稳定提供。枚举未知值必须可向前兼容。

## 离线数据包边界（计划）

- **ProgressBackup**（v0.2）：导出 `LearningState`、`StudySession`/学习事件、后续 `ReviewRecord`/调度版本及所选 `UserSettings`。不包含 `Root`/`Affix`/`Word`/例句正文、音频缓存、崩溃日志。manifest 保存格式版本、导出时间、最低兼容应用版本、来源内容包 ID/版本及记录数量/摘要。
- **VocabularyPackage**（v1.0）：包含内容实体、关系、例句、SourceRef、校验状态和包 manifest；绝不包含用户学习状态、复习历史或个人设置。
- 两类数据以稳定内容 ID/类型互相关联，但独立序列化、独立校验、独立导入命令。恢复时找不到对应内容不得丢弃用户状态；显示缺失引用并保留原始 ID。
- ID 冲突必须能区分“完全相同可幂等跳过”和“同 ID 不同载荷拒绝”；不得用更新时间猜测并静默覆盖学习记录。
- 导入 DTO 是版本化边界，Mapper 负责升级兼容；不将文件字段直接映射为 Drift 行。

## ET-01D 落地说明

- 内容类型位于 roots/words 的 domain，来源与错误/分页位于 `features/shared/domain/`；所有模型只依赖 Dart SDK 或其他 domain 类型，集合做防御性复制，时间在构造时转换为 UTC。
- 学习类型位于 `features/study/domain/study_models.dart`，覆盖共享契约的 LearningState、StudyCard、AnswerInput/Result、StudySession/Start、SessionSummary。`LearningStage.newItem` 对应持久值 `new`（Dart 关键字不能作为枚举成员）。
- `Root`/`Affix` 无来源时强制为 `unverified`；读取未来未知校验状态降级为 unverified，未知 affix kind/component role 降级为 unknown，未知 component type 省略对应关系。未来未知学习阶段返回稳定 Unsupported，不覆写数据库原值。
- `RootDetail` 的 root、affixes、words、components、examples 均只读。未加共享契约以外的 UI 字段或 FSRS 类型；没有创建 ReviewRecord、DailyPlan、DailyStats 或 UserSettings 的空壳承诺。
- v0.1 单词详情使用只读聚合 `WordDetail(word, roots, affixes, components, examples)`；缺少构词关系或例句时返回空集合，缺失单词返回 `NotFound`。关联只从显式 `WordComponent` 关系解析，不按词形相似推断词源。
- 按 ADR-014，fake 的首次 recalled 将条目转为 learned；needsPractice 使 new 转为 learning，不降级 learned；skip 不改状态，session 完成不改变阶段。dueAt 始终为 null，不产生 FSRS 状态。
