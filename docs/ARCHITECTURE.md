# 架构

## 总体分层

```text
presentation  ->  application/use cases  ->  domain contracts
data repositories ----------------------> domain contracts
data repositories ----------------------> database (Drift/SQLite)
app/composition -------- binds application/domain contracts to data implementations
```

依赖方向只能向内：presentation 不认识数据库，domain 不认识 Flutter/Drift，application 编排 domain 契约，data 实现 domain 的抽象。Riverpod 负责依赖注入和呈现状态；`app/composition` 绑定抽象与实现。

## 推荐目录

```text
lib/
  app/                         # App、主题、路由、全局 provider
  core/                        # 错误、结果类型、时间/ID、日志、常量
  features/
    roots/
      presentation/            # 页面、组件、controller/provider、view model
      application/             # 用例和页面可消费的应用状态/命令
      domain/                  # 实体、值对象、用例、repository 抽象
      data/                    # DTO、mapper、repository 实现
    words/                     # 同上
    study/                     # 学习流程与学习状态
    review/                    # v0.2 FSRS、计划、统计
    settings/                  # 设置、学习进度备份/恢复
    content_packages/          # v1.0 手动词库包校验、预览和更新
  database/
    tables/                    # Drift 表定义
    app_database.dart
    migrations.dart
  l10n/                        # 后续国际化
test/
  unit/  widget/  integration/
assets/
  seed/  audio/  icons/
```

具体工程目录、层间依赖和对话所有权见 `docs/IMPLEMENTATION_PLAN.md`。

## 功能边界

- `roots`：词根/词缀及其可信说明。
- `words`：单词、构词成分关联、例句和发音引用。
- `study`：学习队列、卡片呈现、答题结果和学习状态更新。
- `review`：v0.1 仅提供预留接口；v0.2 接入已验证 FSRS。
- `settings`：用户偏好、数据导入导出和版本信息。
- `settings` 的学习备份只序列化用户数据；`content_packages` 只负责词库内容包。两者可共用系统文件访问能力，但必须使用独立的数据格式、预检和写入边界。
- 导入由 application 编排：选取文件 → 解析与预检 → 展示摘要 → 用户确认 → database transaction → 结果摘要。Presentation 仅消费不可变预检结果/命令状态；文件格式、SQL 和 Drift 留在 data/database。
- 所有导入遵循“先验证、后写入、单事务提交”。无法识别的版本或记录冲突应返回稳定领域错误，不能部分导入或静默丢弃。

## 状态与错误

每个异步页面至少区分 `initial/loading/data/empty/error`；错误向上转换为稳定的领域错误，不把 SQL/Drift 异常直接显示给用户。写操作返回成功或可展示的失败原因，并保持幂等。
