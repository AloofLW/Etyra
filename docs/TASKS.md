# 任务清单

## GOAL-01：产品目标确认

- [x] 明确 Etyra 的一句话目标、核心用户和用户问题。
- [x] 明确 v0.1 必须解决的问题与暂不解决的问题。
- [x] 明确“理解词根 → 关联单词 → 主动回忆 → 后续复习”的核心学习闭环。
- [x] 明确首版成功标准和内容可信度原则。
- [x] 由项目管理对话确认目标基线。

## DESIGN-01：功能与设计详细规划

- [x] 拆分 v0.1 功能范围和非目标。
- [x] 定义页面信息架构、核心学习流程和页面状态。
- [x] 定义视觉方向、设计层级、组件边界和可访问性要求。
- [x] 定义跨功能验收标准。
- [x] 确认产品目标与功能/设计规划无冲突。

## ET-01（当前）

详细实施蓝图见 `docs/IMPLEMENTATION_PLAN.md`。执行顺序为 ET-01A 至 ET-01G；平台、系统外观、v0.1 共享契约和 Riverpod/Drift 依赖版本均已确认并解析。

- [x] 记录当前 Flutter/Dart/Xcode 工具链事实：Flutter 3.47.1、Dart 3.13.1、Xcode 16.2。
- [x] 确认最低 iOS 部署版本为 iOS 17.0；指定 iPhone 12 Pro（iOS 17.6）为真机验收设备；支持并验收浅色/深色外观、动态字体和 VoiceOver。
- [x] 将 Riverpod、Drift/SQLite 和代码生成工具加入 `pubspec.yaml`，成功解析并生成有效的 `pubspec.lock`。
- [x] 创建 feature-first 目录、App/Database 组装入口和共享 Riverpod provider 装配点。
- [ ] 定义 Drift 数据库版本、迁移入口、种子导入入口和内容/用户数据分区。
- [ ] 定义 domain 实体、Repository 接口及前端消费用例。
- [x] 冻结 v0.1 领域模型、分页 cursor、错误类型、学习会话命令和返回值；详见 `docs/CONTRACTS_V0_1.md`。
- [x] 冻结 v0.1 构词、可信度、学习阶段、学习模式、反馈和 Session 状态枚举；定义来源许可与署名字段。
- [x] 按官方包资料核对依赖和 Dart SDK 下限，并由 `pubspec.lock` 锁定解析结果。
- [x] 创建 Flutter iOS-only 空工程骨架，记录 SDK 和最低 iOS 部署目标。
- [x] 初始化 Git 主分支（`main`）并创建工程基线提交。
- [x] 建立 feature-first app/database 目录和共享依赖装配点。
- [ ] 按 ADR-025 与 `docs/CONTENT_SOURCE_AUDIT.md` 建立候选审核清单；50 个 root/stem 候选已形成初步来源表（`docs/ROOT_CANDIDATES_V0_1.csv`，均为 candidate_only），已建立 120 个关联单词关系候选（`docs/WORD_CANDIDATES_V0_1.csv`）；继续扩充至 300–500 个，并逐条补齐版本、许可、署名、释义/词源证据和审校状态。候选词根表不等同产品 seed；不得臆造词源。
- [x] 约定测试层：模型/映射/迁移/Repository 单测，关键页面 widget 测试，核心学习流程集成测试。
- [x] 约定分支、worktree、文件所有权和合并检查。

## 并行任务

GOAL-01 确认后，前端可在契约冻结后做静态页面、状态空壳和交互测试；后端可先做实体、表、迁移、Repository 假实现和种子校验。两者都不得改变共享契约而不更新文档。

## 后续数据管理任务（计划）

### ET-10D 高中词库扩充（5000+）

交付关卡、当前候选基线及对话 01/02/03 的具体分工见 `docs/VOCABULARY_DELIVERY_PLAN.md`。候选数量不等于已审核正式词条数。

- [x] 联网获取并本地保存有公开再分发许可的通用英语候选及学术英语补充清单；两者精确文本并集 5342 项，来源、版本、校验值和已知限制见 `docs/reference/wordlists/README.md`。
- [x] 合并两份开放许可词表，生成有来源和可重复生成候选 ID 的 `docs/VOCABULARY_CANDIDATES.csv`；词义、词性、课标适用性和词源均待审核。
- [x] 为 5342 个主候选生成 `docs/VOCABULARY_REVIEW_QUEUE.csv`，汇总已有英文义项、中文线索、编辑草稿和部分词源页面定位；队列只用于分诊，所有词项仍待审。
- [x] 将课标缺口、复杂词形、关联词和 2020 历史对照共 425 个补充候选纳入 `docs/SUPPLEMENT_REVIEW_QUEUE.csv`，检查与主清单的候选 ID 不重复；词形和词义仍须审核。
- [ ] 逐项处理补充候选的不同来源及词形归并问题，特别是 85 行复杂课标镜像原文、缩写及大小写歧义。
- [ ] 对两版简单拼写试算发现的 264 个星号差异及双方未匹配项逐页复核；2025 镜像尚未认证，不得将差异直接当作现行课标调整或词条增删。
- [ ] 审查 `docs/HISTORICAL_2020_GAP_CANDIDATES.csv` 的 39 个历史对照候选、110 条英文义项、82 条 COW 中文线索，以及 `docs/CURATED_HISTORICAL_2020_PILOT.csv` 的 5 条编辑中文草稿；核对原页、现行版本、国籍/族群歧义、词形和词义，不能视为正式词库。
- [ ] 复核 `docs/CURATED_HISTORICAL_COW_PILOT.csv` 的 34 条序数词、地名和名词草稿，尤其区分顺序义、分数义、地名范围和其他词性；`Britain`、`Indian` 的义项歧义、词源与课程适用性仍未确认。
- [x] 对 85 行复杂镜像提取做整行精确匹配分诊，定位 2 条主候选、12 条补充候选；其余 71 行及全部课程等级和语义仍待逐行审核，统计不代表正式覆盖。
- [ ] 审查 `docs/INFLECTION_REVIEW_PILOT.csv` 四条 `be`/`have` 动词形式关系，决定词条展示与稳定 ID 策略；不得自动合并学习记录或忽视其他词性。
- [ ] 审查 `docs/SPELLING_REVIEW_PILOT.csv` 四组英美拼写线索及对应词性、专名、展示与稳定 ID 策略，不自动合并学习记录。
- [x] 以 OEWN 2024 建立候选拼写的词典入口索引，记录词条 ID、候选词性和义项数量；具体义项和内容许可仍须逐项审校。
- [ ] 审查 77 个未匹配 OEWN 词头的候选：已从同版词典的 Form 找到 `criteria`、`media` 两条待审词形线索，其余 75 项继续查找有许可的来源；不要据词形匹配自动归并词义或学习记录。
- [ ] 审查 Wiktextract/Kaikki 对 77 个 OEWN 未匹配候选提供的英文义项线索：五类虚词 64 个候选、450 条义项，另外 13 个候选的单词页提供 101 条义项；核对来源、词性、变形和许可，勿将 `multi`、`trans` 的单词义项当作词缀义项。
- [ ] 审查 Kaikki 为 27 个补充候选提供的 120 条英文义项线索，尤其核对后 7 个候选的词性、短语、标点变体和真实语境。
- [ ] 审查 `docs/CURATED_SUPPLEMENT_FUNCTION_PILOT.csv` 的 17 条补充虚词义项草稿，尤其复核代词的指代范围、语境、翻译及许可。
- [ ] 审查 `docs/KAIKKI_TRANSLATION_CANDIDATES.csv` 中 33 个候选的 118 条中文翻译线索，逐条核对来源义项、繁简、上下文及许可；不可将翻译框标签当作经过确认的义项 ID。
- [ ] 审查 `docs/KAIKKI_COMMON_GAP_TRANSLATIONS.csv` 中 26 个候选的 154 条中文线索；4 个快照未提取到中文，后续需核对来源、词性与语境。
- [ ] 复核 `docs/CURATED_COMMON_GAP_PILOT.csv` 的 30 条常用词义草稿；其中 6 条为基于英文义项的编辑中文，`upon` 的具体搭配及原始翻译线索的语言标签也需检查。
- [ ] 审查镜像标星且原先缺中文线索的 53 个候选：47 个取得 138 条翻译线索，6 个在快照中未找到中文翻译；全部须核对义项、课标和许可。
- [ ] 复核 `docs/CURATED_UNTRANSLATED_PILOT.csv` 中 6 条依据英文义项自主编写的中文草稿，尤其检查 `bacteria` 复数词形和 `statistic` 的语境。
- [ ] 复核 `docs/CURATED_GAP_TRANSLATION_PILOT.csv` 中 45 条根据英文 gloss 和中文翻译线索编辑的草稿；语义对应为编辑判断，不可自动视为来源确认，另核查 `somehow`、`prior` 的线索歧义。
- [ ] 审查 `docs/CURATED_MAIN_GAP_PILOT.csv` 中 15 个词的 19 条义项草稿；来源无 sense ID，按词性、原 gloss 和标签联合定位，特别核对 `while` 的时间、让步和对比语境及 `website`、`poem` 的定义范围。
- [ ] 复核 `docs/CURATED_FUNCTION_WORD_PILOT.csv` 中 28 条虚词义项的选义、编辑中文草稿和用法范围；选取的义项不代表完整用法，未通过复核不得进入产品词库。
- [ ] 审查 `docs/COW_CASE_REVIEW.csv` 中 62 个包含大小写不同 COW 关联的候选（其中 6 个全部不同）；化学元素和字母义不能直接用于虚词，已补充 7 个高频词的词性线索。
- [ ] 复核 `docs/CURATED_COMMON_FUNCTION_PILOT.csv` 的 7 条高频虚词草稿，包括词性、语境、中文表达和许可。
- [x] 提取 OEWN 英文义项至 `docs/OEWN_SENSE_CANDIDATES.csv`，保留原始词形和义项出处；按高中语境选义、中文释义与内容入库仍待完成。
- [ ] 审查 `docs/SINGLE_OEWN_REVIEW_BATCH.csv` 的 521 个单条 OEWN 索引候选；逐项核对词性、遗漏用法、英文定义、中文线索、课程范围与许可，不能把单一索引误作唯一词义。
- [ ] 复核 `docs/CURATED_SINGLE_OEWN_PILOT.csv` 的 267 条选义草稿，检查词性、中文语境、时效性、其他常用义和许可；`salary` 已增加独立草稿，`classmate` 已找到同班用法参考，两者原 OEWN 对齐仍需复核，草稿不代表审核通过。
- [ ] 审查 `docs/CURATED_SALARY_KAIKKI_PILOT.csv` 的独立薪金义草稿及 Kaikki 快照、词性和许可；不要把替代来源当成原 OEWN 义项已获确认。
- [x] 为现有 120 条词根—单词关系候选记录 Wiktionary 页面固定修订；词源章节存在性仅为定位检查，关系与许可仍须逐项审校。
- [ ] 为主清单 5342 个候选定位词源来源：`docs/WIKTIONARY_BULK_SOURCE_INDEX.csv` 已记录前 2200 个候选的页面固定修订及词源标题检测状态（2191 个有标题、9 个未检测到），尚余 3142 个；后续依照来源站点要求分批低速续采。标题只提供定位线索，不证明词源关系。
- [ ] 对 `docs/WIKTIONARY_MORPHOLOGY_CLUES.csv` 的 349 条显式构词模板线索逐条复核原页面语境、词根/词缀边界、语义与许可；模板及现代分析不自动形成词根关系。
- [ ] 审查 `docs/CURATED_WORD_PILOT.csv` 的 95 条编辑草稿，核对课标适用性、释义语境、词根边界和再分发义务；复核 `portable`、`supporter` 跨词网义项疑似错位，以及新增五条的词义范围和间接词源。
- [ ] 复核 `submission` 的 COW 线索：OEWN `1.26.00` 表示屈从控制的状态，不能直接按中文词项“提交”当成文件递交义；按目标义项另找来源。
- [ ] 复核 `docs/CURATED_SUBMISSION_KAIKKI_PILOT.csv` 的独立递交行为义草稿、词源关系、课标适用性和来源许可；该替代草稿不更改原有 COW 对齐。
- [ ] 复核 `docs/CURATED_ADDITIONAL_ROOT_OEWN_PILOT.csv` 中 10 条基于 OEWN 的独立编辑中文草稿，逐条验证选义、用法范围、词根间接关联、课标适用性与许可；不可仅凭固定修订存在即批准关系。
- [ ] 审查 `docs/CURATED_PORT_KAIKKI_PILOT.csv` 的 `supporter`、`portfolio` 两条替代来源草稿，核对义项、翻译及对应词源；不覆盖原 COW 线索。
- [ ] 审查 `docs/CURATED_PORTABLE_PILOT.csv` 的一般携带义草稿及其词源关联、课标适用性和许可；另保留 COW 船外发动机义项对照疑点，不自动认定原因。
- [ ] 复核 `docs/CURATED_STRUCT_OEWN_PILOT.csv` 三条编辑中文草稿，区分普通重建活动与历史专名；核查 OEWN 义项、词源及许可。
- [ ] 复核 `docs/CURATED_ACT_OEWN_PILOT.csv` 的 `actively` 编辑中文草稿、词源关联及许可；“积极地”等译法须结合上下文。
- [ ] 审查 `docs/CURATED_TRACT_KAIKKI_PILOT.csv` 的 `distract`“使分心”草稿，核对使动语境、词源和许可；不覆盖原 COW 义项。
- [ ] 审查 `docs/CURATED_SPECT_KAIKKI_PILOT.csv` 的 `respective`、`spectacular` 两条替代来源草稿，核对语义、历史关联与许可。
- [x] 为 11 个此前不在候选词表内的词根关联词补充 OEWN 词头和英文义项；其中 5 个词找到 COW 中文义项线索，所有词条仍待审。
- [x] 以 CILI 将 OEWN 义项与 Chinese Open Wordnet 1.1 对照，形成 `docs/COW_SENSE_CANDIDATES.csv` 中文词项候选；人工选义、翻译准确性和最终词库导入仍待完成。
- [x] 为 348 个 OEWN 补充候选提取英文义项，并为其中 272 个候选建立中文词项线索；大小写、词性、课标适用性和中文表达均待审。
- [ ] 获得适用的 2025 版高中课标权威原文及完整附录，核实版本、实施范围与可使用权限；安康学院公开 PDF 与既有第三方镜像摘要一致，但转载链与官方原件一致性仍待验证，第三方整理词表存在可见差异；2020 版作为历史对照。详见 `docs/reference/wordlists/README.md`。
- [ ] 依据课标逐项比对候选词表，保存精确匹配、待复核、缺失和歧义结果；解决所有必学项的覆盖及词形映射。
- [ ] 审查 `docs/CURRICULUM_GAP_CANDIDATES.csv` 中 274 个 OEWN 缺口候选、`docs/WIKTIONARY_GAP_CANDIDATES.csv` 中 18 个 Wiktionary 候选、`docs/COMPLEX_FORM_CANDIDATES.csv` 中 74 个 OEWN 复杂片段候选及 `docs/COMPLEX_WIKTIONARY_CANDIDATES.csv` 中 9 个 Wiktionary 复杂片段候选；核查 BCE 展开形式，逐行核对全部 85 个复杂形式、权威原件和各版本等级。
- [ ] 使用 `docs/COMPLEX_CURRICULUM_REVIEW_INDEX.csv` 逐行审查 85 条镜像复杂形式的页码、提取、候选匹配、大小写、词义及课程等级；该索引只提供定位，不是覆盖或许可证明。
- [ ] 筛选并审核至少 5000 个正式词条的词形、词性、释义、来源和许可；词源关系单独验证，不强制为每词虚构词根。
- [ ] 生成正式离线词库包并验证词条数量、课标覆盖、数据来源及导入后可学习；词库更新保留用户进度。

### ET-09B 学习进度导出/导入（v0.2）

- [ ] 列出备份包含/排除字段：学习状态、学习 Session/事件、FSRS 复习记录与参数版本、用户偏好；明确不包含词库正文、缓存音频和日志。
- [ ] 冻结备份格式版本、应用/schema 兼容规则、内容包依赖标识、校验值算法及未来升级/降级行为。
- [ ] 定义只合并恢复契约：新增记录、重复相同记录、同 ID 不同载荷冲突、缺少对应词库内容、未知字段和不支持版本的结果。
- [ ] 定义 application/domain 预检结果、导出命令、导入命令及稳定错误类别；前端不依赖文件字节解析或 Drift 类型。
- [ ] 后端实现 DTO/mapper、事务导入、幂等收据和失败回滚；确认恢复事件与派生 LearningState/FSRS 状态的一致性策略。
- [ ] 前端实现系统文件选择/导出、导入预览、确认/取消、进度/错误/完成摘要和隐私说明。
- [ ] 验收空包、损坏包、不支持版本、重复导入、冲突、缺失内容、导入中断/回滚、应用重启后恢复；真机验证文件访问权限与流程。

**验收标准：** 全程离线；用户可将文件保存到 Files 并从文件恢复；预检失败不写库；成功导入为单一事务；同一文件重复导入不重复计数/记录；失败后库状态与导入前一致；进度不依赖备份内含词库正文。

### ET-10C 手动词库导入/更新（v1.0）

- [ ] 定义 `.etyra` 包容器、manifest/content schema、格式版本和兼容范围；载荷不含程序代码。
- [ ] 冻结稳定 ID、package/version/修订关系、同版本冲突、增量/完整包语义和退役策略。
- [ ] 建立来源与许可审核清单；每个可分发条目、构词关系、释义及例句均能追溯，未知内容标记待校验。
- [ ] 设计导入预检/差异摘要、文件校验、引用完整性检查、事务 upsert、导入收据和失败回滚。
- [ ] 定义 application/domain 导入预检与应用契约，以及前端文件选择、包信息、差异预览、确认、进度和结果状态。
- [ ] 验收新增/更新/退役、重复包、同版本不同载荷、非法来源许可、坏校验值、断裂引用、未知格式、数据库失败回滚；验证任何词库变更均不修改学习/复习状态。

**验收标准：** 词库数据不依赖网络；同一包可重复导入且结果稳定；所有校验在事务提交前完成；失败不产生部分更新；变更摘要与实际变化一致；稳定 ID 关联的学习记录保留。

## 下一执行批次

1. **对话 01 / ET-01G 人工验收**：自动验收已完成：文件 SQLite 空库创建/关闭/重开/schema 版本保持、真实 Drift provider 空态且不混入 fixture；全套 70 项测试和静态分析通过。新版已部署并启动于 iPhone 12 Pro（iOS 17.6.1）。待用户检查真机交互、深浅色、动态字体和 VoiceOver。`lib/main.dart`、`lib/app/**` 和根 `ProviderScope` 仍由对话 01 独占维护（ADR-018）。
2. **单词浏览 / 详情（已实现，待真机体验）**：当前分支实现了 `WordDetail(word, roots, affixes, components, examples)`、`WordRepository.getWordDetail(id)`、application 用例、Drift 显式关系查询和 provider 装配；单词 Tab 接入真实列表/详情页面，支持 loading/empty/error retry/cursor pagination、稳定 ID 导航、来源/构词关系/例句。无来源依据时不推断词源、不伪造发音；正式空数据库不混入 fixture。全套 70 项测试、`flutter analyze --no-pub` 通过；待 iPhone 12 Pro 人工体验。
3. **对话 03 / ET-01E 后续**：DriftStudyRepository 已实现真实会话/答题/跳过/结束/放弃事务，并有重启、并发重复提交和回滚测试；当前没有按 Session ID 恢复未完成界面的 application 查询契约，跨重启恢复需求先由对话 01 决策后再扩展。
4. **对话 01 / 内容来源**：许可策略和选材基线已由用户确认并记录为 ADR-025。初始 root 表与词缀候选表分别见 `docs/ROOT_CANDIDATES_V0_1.csv`、`docs/AFFIX_CANDIDATES_V0_1.csv`；完成初始候选清理：20 项重分类为词缀、1 项重复合并；新增 21 项有词源页面线索的 root/stem 候选，约 50 项有效候选池已建立。所有记录仍为 candidate_only，不是产品内容；下一阶段逐词核验高中范围、释义、构词关系和许可。继续逐项核实高中适用性、词源证据及许可；OEWN/Princeton WordNet 仅辅助词义，Wiktionary 逐条核验并落实许可/署名义务，Oxford API 无单独许可不用于离线包。未通过审核的候选不进入产品 seed。

## ET-01 验收标准

- 新开发者能仅凭文档知道三个对话的边界和启动顺序。
- 工程能在锁定的本地版本上创建、分析和运行测试；本阶段不要求完整产品页面。
- 数据库能从空库迁移到当前版本，内容导入可重复执行且不重置用户状态。
- 前端只消费稳定的 domain/application 接口；后端没有 UI 依赖。
- 词源数据有来源、校验状态和审计记录；未知内容不会被当作确定事实。
- 关键决策写入 `docs/DECISIONS.md`，遗留问题有负责人和下一步。

## 2026-11-01 ET-01 执行状态

- 当前集成分支 `feat/app-composition`：ET-01G 自动验收和单词浏览/详情实现已集成；`flutter test --no-pub` 70 项通过，`flutter analyze --no-pub` 无问题。新版已重新部署并启动于 iPhone 12 Pro（iOS 17.6.1）；核心交互、外观和无障碍仍待用户真机体验。本分支尚未合入 `main`。
- 用户已确认 Bundle ID `com.lovmus.etyra`；应用当前已安装并启动于 iPhone 12 Pro（iOS 17.6.1），待人工体验核心学习流程。
- 新应用图标已生成并替换 iOS AppIcon 全部尺寸；从已部署真机取回图标确认生效。图标母图位于 `assets/branding/etyra-app-icon-1024.png`。
- 前端首屏已重设计为学习者入口；状态模拟和故障注入移至“预览工具”，演示数据及不保存记录均有明确说明。列表/详情减少重复面板，学习卡片增加进度层级。2026-11-01 用户已确认首屏视觉与底部导航基线（ADR-023）；词根、单词 Tab 已接入真实 provider，真机核心交互与无障碍设备验收仍待完成。
- ET-01F App composition 已建立：`lib/app/composition/providers.dart` 提供单一惰性 `AppDatabase` 生命周期、Root/Word 共享内容 Repository、Study/LearningState Repository 及对应 application 用例 providers；首页仍为明确标注的 fixture，词根 Tab 使用真实 provider。
- 词根与单词列表/详情均已接真实 provider；首页/学习演示路径继续使用 fixture。词根和单词的正式 SQLite 内容目前为空，尚无经来源/许可审核的产品词库。
- `DriftStudyRepository` 已持久化学习 session 与事件，关键事务/重启行为通过 SQLite 测试；没有 schema 变更。全套测试输出存在 Drift “同一 QueryExecutor 多个数据库实例”诊断警告，但测试通过；须在稳定 app composition 阶段核对数据库实例生命周期，避免生产环境重复构造。
- 首轮学习转换、Session 关闭、未知枚举、内容包更新和共享入口所有权由 ADR-014..018 收口。
