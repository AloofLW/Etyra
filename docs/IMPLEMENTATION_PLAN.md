# ET-01 工程实施蓝图

## 目标

把已确认的产品目标、功能规划、视觉规划和 v0.1 消费契约转化为可运行、可协作、可测试的 Flutter 工程基础。ET-01 的产出是可靠的工程骨架，不要求完成所有产品页面。

## 冻结边界

### 已确定

- Flutter + Dart，iOS 优先，本地 Xcode 构建和真机调试。
- 最低 iOS 部署版本为 iOS 17.0；指定真机验收设备为 iPhone 12 Pro（目标 iOS 17.6；当前已配对设备为 17.6.1），通过 Xcode 部署。
- 验收模拟器至少覆盖 iOS 17.5 和 18.3；真机验收在 iPhone 12 Pro（目标 iOS 17.6；当前实际为 17.6.1）完成。
- v0.1 支持并验收浅色与深色系统外观；采用语义化颜色并跟随系统外观。
- 动态字体和 VoiceOver 纳入 v0.1 基础验收。
- feature-first，功能内采用 `presentation / application / domain / data` 分层；数据库作为共享基础设施。
- Riverpod 负责依赖注入和呈现状态；Drift/SQLite 是本地持久化方案。
- v0.1 只实现词根/单词学习闭环和最小本地学习状态；不实现 FSRS 调度、账号、同步、通知或复杂统计。
- v0.1 公共语义以 `docs/CONTRACTS_V0_1.md` 为准。
- 内容与用户学习状态分离；词源内容有来源和校验状态。

### 初始化前要确认

- 首批词库来源、许可和稳定 ID 规则。

### 工程初始化记录

- 2026-11-01 复核：Flutter 3.47.1 stable、Dart 3.13.1、Xcode 16.2。
- Flutter 工程通过 `flutter create --no-pub --empty --platforms=ios` 建立；最低 iOS Deployment Target 已设置为 17.0。
- 工程 Bundle ID 为用户确认的 `com.lovmus.etyra`；真机签名仍需由当前 Xcode Apple Developer Team 成功生成/选择 provisioning profile。
- 初始 `--no-pub` 阶段未执行依赖解析或构建；ET-01C 随后加入 Riverpod/Drift 并成功解析，现已生成有效 `pubspec.lock`。

## 依赖选择原则

| 能力 | 候选 | 纳入条件 |
|---|---|---|
| 状态/依赖注入 | `flutter_riverpod ^3.4.3` | 官方包页列出 Dart 最低版本 3.12；无需代码生成即可先启动 |
| SQLite ORM | `drift ^2.35.3` | 当前稳定版；支持 SQLite、迁移和类型安全查询 |
| Drift Flutter 集成 | `drift_flutter ^0.3.1` | 官方 setup 使用此包打开 Flutter 数据库 |
| SQLite 原生支持 | 不直接添加 `sqlite3_flutter_libs` 或 `sqlcipher_flutter_libs` | `drift_flutter` 间接依赖其 EOL no-op 版本；这些占位包用于阻止旧 Flutter 构建脚本介入 |
| 路径/文件 | 暂不单独添加 `path_provider` | `drift_flutter` 默认使用应用文档目录；备份时再评估文件能力 |
| 路由 | Flutter `Navigator` / Cupertino 导航优先 | 页面数量和路由需求无法简洁满足时再评估路由包 |
| 模型生成 | Freezed / JSON 生成工具为可选项 | 先评估维护成本；不得为少量模型引入不必要生成链 |
| 测试 | `flutter_test`、Dart `test` | Flutter 工程自带基础测试；额外包按需要加入 |
| Drift 代码生成 | `drift_dev ^2.35.2`、`build_runner ^2.17.1` | 当前稳定组合；作为 dev dependency |

截至 2026-11-01，已在 Flutter 3.47.1 / Dart 3.13.1 下完成依赖解析，锁定版本记录于 `pubspec.lock`。`drift_flutter` 间接引入 `sqlite3_flutter_libs 0.6.0+eol` 和 `sqlcipher_flutter_libs 0.7.0+eol`；两个上游包说明这些版本为空操作包，用来确保旧 Flutter 原生构建脚本不参与，故保留传递依赖，不声明直接依赖。Drift 2.32.0 起原生 SQLite 由 sqlite3 3.x build hooks 提供。包信息见 [pub.dev flutter_riverpod](https://pub.dev/packages/flutter_riverpod)、[pub.dev drift](https://pub.dev/packages/drift)、[pub.dev drift_flutter](https://pub.dev/packages/drift_flutter)、[pub.dev drift_dev](https://pub.dev/packages/drift_dev)、[pub.dev build_runner](https://pub.dev/packages/build_runner)；原生平台和旧库说明见 [Drift supported platforms](https://drift.simonbinder.eu/platforms/)、[sqlite3_flutter_libs](https://pub.dev/packages/sqlite3_flutter_libs)、[sqlcipher_flutter_libs](https://pub.dev/packages/sqlcipher_flutter_libs)。

## 目标目录

```text
lib/
  main.dart
  app/
    app.dart
    router/
    theme/
    composition/              # provider 绑定和依赖装配，共享集成所有者维护
  core/
    errors/
    result/
    ids/
    time/
  database/
    app_database.dart
    tables/
    migrations/
  features/
    roots/
      presentation/
      application/
      domain/
      data/
    words/                     # 同层结构
    study/
    settings/
test/
  unit/
  widget/
  integration/
assets/
  seed/
```

依赖方向：`presentation -> application -> domain`；`data -> domain`，由 `app/composition` 绑定接口与实现。共享数据库仅由 data 层访问；presentation 不引用 Drift 生成类。

## 数据库落地边界

- 建立单一 `AppDatabase` 和显式 schema version / migration entrypoint。
- 内容表与用户状态表独立；稳定内容 ID 作为关联键。
- v0.1 建立 roots、affixes、words、word_components、examples、learning_states、study_sessions、study_logs 的必要子集。
- v0.2 的 daily_plans、daily_stats、设置扩展通过后续增量迁移加入；备份能力后续单独规划。
- 种子导入使用内容包版本和稳定 ID，允许重复运行；只更新内容数据，不覆盖学习状态。
- 迁移测试覆盖空库升级、前一版本升级、重复打开/导入、失败回滚或恢复。

## 协作所有权

| 范围 | 主要所有者 | 协作规则 |
|---|---|---|
| `AGENTS.md`、`docs/` | 对话 01 项目管理 | 其他对话提出变更建议，由对话 01 更新基线 |
| `frontend/`、`lib/features/*/presentation/` | 对话 02 前端 | 不编辑 domain/data/database |
| `backend/`、`lib/features/*/application/`、`domain/`、`data/`、`database/` | 对话 03 后端 | application use case 遵循已冻结消费契约 |
| `lib/app/`、`lib/main.dart`、共享测试配置 | 对话 01 指派的一次性集成所有者 | 开工前指定唯一 owner；其他对话通过变更提案协作 |
| `pubspec.yaml`、`pubspec.lock`、平台配置 | 工程初始化任务指定 owner | 依赖统一从该 owner 的分支变更，避免并行锁文件冲突 |

## 推荐执行顺序

1. **ET-01A 决策收口**：完成平台、外观、共享枚举和来源记录原则；依赖候选已按官方资料初核。
2. **ET-01B 仓库与工程骨架**：已建立 Git `main` 和 Flutter iOS 空工程；记录 SDK 与部署目标。
3. **ET-01C 依赖与质量门**：已加入并解析 Riverpod/Drift 依赖，生成 lockfile；静态分析、测试和运行验收待后续阶段。
4. **ET-01D domain/application 契约实现**：按共享契约实现不可变模型、错误结果和最小用例接口；先用内存 fake 解耦 UI 与数据库。
5. **ET-01E database/data 骨架**：建立 Drift schema、迁移、Repository 实现和种子导入边界。
6. **ET-01F UI/App 组装**：装配 Cupertino app、导航、主题和 fixture provider，完成空/错/加载/数据状态骨架。
7. **ET-01G 验收**：模拟器启动、静态分析、单测/Widget 测试、空库迁移和重复种子导入验证，记录结果。

前端可在 ET-01D 的模型与 fake provider 可用后并行；后端可在 ET-01B 工程路径确认后建立 domain/data/database。`app/`、锁文件和公共路由不允许多个对话同时改。

## Git 与 worktree 约定

- 初始 `main` 保存已验收基线；每个独立工作流从最新 `main` 建立短期分支。
- 分支示例：`docs/goal-plan`、`chore/et01-foundation`、`feat/frontend-roots`、`feat/backend-database`。
- 需要同时进行前端和后端时使用独立 worktree；共享契约先合入基线，再各自分支。
- 不直接在 `main` 上并行开发；不让两个 Codex 对话共享同一个未提交工作区。
- 合并至少确认文档/契约同步、分析与相关测试结果、数据库迁移影响。

## ET-01 完成定义

- 在 iOS 17.5/18.3 模拟器可启动应用，并通过 Xcode 部署到 iPhone 12 Pro（iOS 17.6 系列）完成核心流程。当前 Simulator 与设备架构构建通过，且已签名安装/启动；核心学习流程、外观和无障碍仍需人工真机验收。
- 依赖清单与 lockfile 一致，关键依赖选择有依据。
- 前后端能通过 domain/application 契约独立工作，UI 不访问数据库。
- 数据库有版本化迁移入口，内容导入幂等且不改写学习状态。
- 静态分析和基础测试能运行；核心页面状态有可复用结构。
- 项目管理对话确认文件所有权、任务拆分和验收记录。
