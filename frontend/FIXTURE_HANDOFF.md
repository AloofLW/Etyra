# 词根学习 presentation 预览交接

## 范围与入口

本批次为隔离的静态 UI 与交互状态准备，不接生产数据、不保存学习记录。
入口为 `RootLearningFixturePreview`，位于
`lib/features/roots/presentation/root_learning_fixture_preview.dart`。
由共享 App owner 在后续获准阶段挂载到已有的 `CupertinoApp` / `Navigator` 下。
本批次未注册路由，未改动 `main.dart`、`app/`、依赖或任何后端文件。

所有词根、单词、释义和答案均明确显示为占位；没有生成真实词源、释义或例句。
`RootLearningFixture` 和 `FixtureSessionController` 仅为 presentation 测试桩，不能作为共享领域契约导出。
当前使用局部 `State` / `ChangeNotifier`；接入 application 后再由 presentation provider 消费真实命令。

## 已表达的状态

- 列表/详情：initial、loading、data、empty、error。预览入口可分别进入，重试后恢复正常占位数据。
- 加载态在 650ms 后结束；无永久 loading。列表预览仅两项，不模拟分页协议。
- 详情：无来源/待核验、无已审核构词关系、有关联单词/关联单词为空。
- 学习：说明、提示、显示答案、提交中、反馈成功、提交失败重试、下一项、跳过、退出确认。
- 提交中的写操作、退出按钮禁用；单项成功后锁定反馈，防止重复计数。
- 模拟首次提交失败只消耗一次，失败不推进队列、不更改计数。
- 总结：正常完成/提前退出，数量、完成数、跳过数、尚未完成数，返回详情/再预览一组。
- 全部数据仅在内存保留；退出后的正式持久化和恢复不在本预览中。

## 后端对接点

以 `docs/CONTRACTS_V0_1.md` 为语义基线，等待实际 Dart 入口冻结后适配：

1. `listRoots` → 只读列表状态；绑定真实 cursor 与加载更多、防重入和加载更多错误。
2. `getRootDetail` → 详情、关联词缀/单词/构词关系/例句；替换占位并展示完整来源、许可、署名。来源为空须保留待核验提示；disputed/未知值需安全降级。
3. `startStudySession(mode: roots, contentIds)` → 当前词根范围和首卡；空队列不创建可提交会话。预览固定 2 张卡仅用于走通交互。
4. `submitAnswer` / `skipItem` → 用服务返回的计数、下一张和结束标记替换本地计数；提交前保存稳定 session/item 标识，失败重试不能自行生成新身份。
5. `finishSession` / `abandonSession` → 等待命令成功后展示真实总结；需补充结束失败、退出失败和 Conflict 恢复状态，不能提前宣称已保存。
6. `StudyCard` 暂无来源/可信度字段，真实内容适配时须通过详情或经后端确认的只读状态提供内容可信度，不能默认 verified。
7. `SessionSummary` 无 recalled 分项计数；当前仅展示完成与跳过，不推算正确率。

以上是现有契约的适配清单，不新增/修改共享类型或命令。
App owner 仍需决定生产入口、Tab/路由注册、全局 provider 装配以及最终“返回学习首页”的目标。

## 后续验证清单（本批次未执行）

- Widget：列表/详情各状态、来源提示和关联单词空态；提示→答案→反馈→下一张→总结。
- Widget：快速重复点击、首次提交失败后重试、跳过计数、退出取消/确认、完成后返回。
- 运行验收：浅/深色、最大动态字体、VoiceOver 阅读顺序/按钮标签、Reduce Motion、窄屏滚动。
- 使用系统语义色、可换行和可滚动布局，操作目标至少 44pt；无自定义动效，Reduce Motion 下禁用预览导航过渡和加载旋转。
- 完成代码格式化与差异检查不代表通过分析、编译、widget 测试或真机验收。
