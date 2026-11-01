# 前端交互契约

## 核心流程

词根列表 → 词根详情 → 关联单词 → 学习卡片 → 答题结果 → 下一张/结束总结。

## 状态消费

页面只消费 application/domain 提供的只读状态和命令：`loadRoots`、`loadRootDetail`、`startStudySession`、`submitAnswer`、`skipItem`、`finishSession`、`abandonSession`。写入命令按 session/item 幂等或明确返回冲突；UI 负责禁用重复提交和展示反馈。

## 最小页面契约

- 列表：分页/分批加载、空状态、错误重试。
- 详情：词根可信度、释义、构词关系和关联单词；没有来源时明确标记。
- 学习：卡片状态、进度、跳过/退出确认、答题后反馈。
- 总结：本次数量、正确/完成情况和下一步，不提前承诺 FSRS 排程。

后端接口变化必须先更新 `backend/REPOSITORY_CONTRACTS.md` 和对应模型文档。

v0.1 的共享模型、命令和状态语义以 `docs/CONTRACTS_V0_1.md` 为准；本文件只补充页面交互，不重复定义数据结构。
