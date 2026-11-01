# 数据模型边界

领域实体：`Root`、`Affix`、`Word`、`WordComponent`、`ExampleSentence`、`LearningState`、`ReviewRecord`、`StudySession`、`DailyPlan`、`DailyStats`、`UserSettings`。

内容实体描述“学什么”；学习实体描述“用户学到哪里”；复习实体描述“何时、以什么结果学习过”。三者通过稳定 ID 关联，不能把用户状态写入词条内容字段。

v0.1 必需：词条标识、可展示文本、释义/翻译、构词关联、例句、来源出处与许可/署名信息、校验状态、学习阶段（new/learning/learned）、最后学习时间、次数和最小日志。`learned` 只代表完成首轮学习，不等同长期掌握。后续：音频元数据、FSRS 参数/状态、每日计划统计、通知设置、备份元数据。

所有时间使用带时区的 UTC 存储并在展示层转换；ID 由数据层生成或由内容包稳定提供。枚举未知值必须可向前兼容。
