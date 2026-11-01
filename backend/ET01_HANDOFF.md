# ET-01D/E 后端交接与验证边界

日期：2026-11-01。基线提交 `6fc2fcc`；工作分支 `feat/backend-et01-de`。

## 已实现范围

- domain：冻结的内容/学习模型、SourceRef、不可变 Page、Result 与稳定错误；Repository 抽象。
- application：查询词根/详情/单词/例句/学习状态，开始、答题、跳过、结束与放弃会话。
- data：无内置词条的内容/学习内存 fake，来源 JSON 和行映射，绑定 query/collection 的 keyset cursor；SQLite 内容查询与学习状态读取骨架。
- database：单一 AppDatabase、10 张 v1 表、显式创建/迁移入口、外键/唯一约束和 nullable 调度预留位。
- content_import：版本化自包含内容包、人工许可审核字段、校验、事务写入、成功审计收据和幂等拒绝覆盖机制。
- test：新增 `test/unit/backend/in_memory_repositories_test.dart` 与 `content_mapper_test.dart`；仅使用 TEST_ONLY 哨兵，不是产品词条/词源。

未改 main.dart、app/、presentation、pubspec、lockfile、平台配置或 docs/ 管理文档。没有创建默认 seed 资产，没有执行 FSRS 算法。

## 已由对话 01 收口的语义

- ADR-014 已同步到 InMemoryStudyRepository：首次 recalled → learned；needsPractice 使 new → learning 且不降级 learned；skip 不改状态；session 完成不参与阶段转换。测试源码覆盖直接 recalled、learning → learned、learned 不降级、跳过已有 learning/learned 以及 session 完成不改变阶段；尚未运行测试。
- ADR-015 已接受 fake 当前实现的会话关闭语义。
- ADR-016 已定义未知枚举安全策略；ADR-017 已接受导入只新增/复用、不覆盖现有内容。

## 交给对话 01 的后续问题

1. 明确 Word、WordComponent、ExampleSentence 的逐条校验状态表达方式；冻结模型只有 Root/Affix 有 `verificationStatus`。当前不添加字段，导入强制有来源和人工许可审核；真实词库接入前仍须定义关系可信度的呈现与审核规则。
2. 确认稳定 ID 命名空间。当前 root/word 用户状态采用复合身份；内容 ID 由内容包稳定提供。

后续问题由对话 01 维护 `docs/DECISIONS.md` 与共享契约。

## 验证及当前限制

- 已执行格式化、`dart run build_runner build`、`flutter analyze --no-pub` 和 `flutter test test/unit/backend`；分析无问题，17 项测试通过。
- 新增 AppDatabase 测试在内存 SQLite 验证 v1 表创建和外键开启；SeedImporter 测试验证同包幂等回执及同版本变更冲突。
- `app_database.g.dart` 已生成；data 仍依赖 Drift 的 GeneratedDatabase 查询边界，由后续 composition 注入 AppDatabase。未执行 iOS 构建或真机验证。
- DriftStudyRepository 为显式 Unsupported 骨架，尚不持久化会话/答题；内存 fake 只用于前端交互开发。不得向用户承诺进度保存。
- SeedImporter 的事务性、SQL/约束、幂等与失败回滚尚未在真实 SQLite 上验证；成功收据审计已设计，失败导入尝试的持久审计和内容更新策略留待后续。
- v1 尚无已发布前序库；不把“旧版升级已覆盖”当成当前事实。

## 后续获准后的验证清单

| 范围 | 必须验证的行为 |
| --- | --- |
| domain/fake | 空内容不创建会话；并发重复提交仅一次；跳过不改变学习状态；退出保留事件；顺序与计数；不可变集合；UTC |
| mapper | 完整来源/许可 JSON 往返；未知枚举安全处理；损坏数据转 Storage，不能变为可信内容 |
| schema | 已生成 Drift 代码并验证内存空库创建、外键开启；仍需导出 v1 schema、复合主键/唯一约束、持久库重复打开验证 |
| seed | 已验证同包两次导入幂等和同版本变更拒绝；仍需乱序规范化、旧版本拒绝、悬空关系/重复 ID/来源/许可缺失验证 |
| 事务隔离 | 仍需注入中途异常验证无部分内容/成功收据、同 ID 冲突全包回滚，以及导入前后学习状态与日志保持不变 |
| 持久化学习 | 队列/日志/状态/计数同事务；重启恢复；并发重复提交；已结束会话拒绝写入；FSRS 字段保持 null |
| 后续迁移 | 从导出的历史版本增量升级；保留学习数据与来源；失败恢复；未知版本拒绝且不清库 |

下一步顺序：前端使用已落地 application/domain 和 fake → 获准生成及测试 → 实现并验收真实学习写入 → 再完成 app 持久化装配。实际词库接入前另行收口逐条可信度与稳定 ID 命名空间。
