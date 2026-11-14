# Etyra 词库制作与审校交接书

基线日期：2026-11-14；接收方：Muse；项目管理与最终验收：Etyra 对话 01。

## 任务目标

为 Etyra 制作可核验、可合法使用的英语词库：覆盖适用的中国高中阶段必学词及常见词，目标不少于 **5,000 个去重后的正式单词词条**；以词根和词缀学习为特色。数字统计以独立的规范词条为单位，不把同一单词的多个义项、词形变体或词根关系当作多个单词。词汇覆盖须以实际适用的权威课程标准原文与地方要求为基准，不要凭词数宣称覆盖完成。

请先交付可核查的样本和来源方案，再分批扩展。v0.1 首批目标约 50 个经核验的词根及 300–500 个关联单词；完整 5,000+ 词库是后续扩充目标，两者不是同一个验收节点。尚未找到可靠来源的词项可以标记待核，但不得伪装为已审核、不得臆造词源、释义、例句或许可。

## 当前基础与边界

- 主候选 `docs/VOCABULARY_CANDIDATES.csv` / `docs/VOCABULARY_REVIEW_QUEUE.csv`：5,342 项，均为 `candidate_only`；其中 1,049 项至少有一条待审编辑草稿，4,293 项没有草稿。这是 2026-11-14 的快照，继续工作前重新统计。
- `docs/SUPPLEMENT_REVIEW_QUEUE.csv`：425 项补充候选；ID 不重复不代表词义、大小写或词形已去重，不能直接与主候选相加当作正式词数。
- `docs/ROOT_CANDIDATES_V0_1.csv`：71 条原始记录，包含重分类及合并记录，不等于 71 个正式词根；`docs/WORD_CANDIDATES_V0_1.csv`：120 条词根关联候选。均未批准用于产品。
- 已定位 2020 高中课标官方历史对照及 2022 义务教育课标官方原件；2025 高中课标目前只有未认证镜像与辅助线索，完整性、适用性及许可尚未核实。义务教育词表不能替代高中课标。见 `docs/reference/wordlists/README.md` 与 `docs/CONTENT_SOURCE_AUDIT.md`。
- 2026-11-14 从[安康学院公开页面](https://dfl.aku.edu.cn/info/1565/10089.htm)的嵌入 PDF 取得与原第三方镜像 SHA-256 一致的文件；同一字节内容不证明来源相互独立或文件已获官方认证，权利仍待核。详见来源说明。
- 存在义务教育英语课标 2022 年版的 2025 修订版线索；[凤溪中学页面](https://fxzx.qpedu.cn/jhzx/kcjs/kcbz/511602.htm)提供标为该修订版的 PDF，尚未与教育部/出版方原件核对。已观察一页与 2022 原版相符，不能据此推断全表一致；先核实适用版本。详见来源说明。
- 课标修订组成员的[高中英语课标修订解读](https://www.xxgc.edu.cn/fll/info/1088/5317.htm)可辅助理解高中阶段与义务教育的衔接；解释文章不是逐词清单或复用授权，详见来源说明。
- 2022 官方扫描件部分页面已人工做拼写抽样，见 `docs/COMPULSORY_CURRICULUM_PAGE_SAMPLE.csv`；该样本不代表完整词表、义项或高中课标覆盖。
- 已有英文义项、中文线索、词源索引及编辑草稿只是审校材料，不代表准确、来源许可合规或可直接导入。工作簿中有简化显示和多义项候选，请以 CSV 来源与具体义项为准。

## 工作任务与交付

### 1. 确认覆盖标准与内容权利

1. 获取项目目标地区及适用版本的高中课标权威原文，记录发布机构、版次、原始 URL、获取日期、完整性摘要、适用学段和附录位置；同时确认地方/教材增补的适用范围。不确定须说明，不以第三方镜像冒充官方原件。
2. 为每一数据来源建立来源台账：标题、发布者、版本、可访问链接、条目或页面定位、许可名称及许可原文链接、署名/修改说明、分发条件和人工核验结论。核对词表、英文定义、中文翻译、词源、例句、音频各自的权利，不能因来源公开可访问就假定可离线再分发。
3. 明确哪些来源仅供查证，哪些内容可用于离线产品；版权未明的材料只作候选，不进入可发布数据。Wiktionary 等有署名及共享条款的数据，须按具体版本与使用方式检查义务；OEWN/WordNet 是义项线索，不是词源证据。

### 2. 课标覆盖与去重

1. 形成逐项映射报告：课标原条目定位、类别、候选 ID、匹配类型（精确、可能、缺失、歧义）、处理说明和审校状态。保留拼写差异、缩写、专名、斜杠并列、词组与屈折形式；不要把 OCR 输出直接视为权威原文。
2. 审核所有缺失和歧义，区分必须补充的词条、不同义项、英美拼写、派生词及仅供显示的屈折形式；记录保留/归并理由，不擅自更改已有稳定 ID。
3. 给出按必修、选择性必修、基础教育衔接、常用扩展等来源/范围分组的统计；没有权威依据的分类标记待核。提供可复现的去重口径、已覆盖清单、缺口/歧义清单、未完成原因与版本差异。

### 3. 单词与释义

1. 优先处理必学缺口、v0.1 词根关联词，再扩充常见词；逐词保留稳定候选 ID、规范拼写、词性、中文释义、来源定位、审核状态和适用范围。
2. 按具体义项写中文释义，记录义项 ID 和语境；一词多义分行，避免把同义词/机器翻译线索直接当成准确释义。数字、专名、大写、动词与名词及同形异义单独核验。
3. 例句和发音仅在来源、准确性及使用许可核验通过后提供；暂无可靠材料可留空，绝不虚构来源或伪造审核人。

### 4. 词根、词缀与关联

1. 区分历史词根、词干、前缀、后缀、连接形式、表层拆分与复合词；为每个组件及单词关联记录来源、具体词义、证据与审校状态。
2. 区分历史借词路径与现代可分析形式，处理不同同形词源章节、历史语义变化和不确定解释；不能根据拼写相似自动断言关联。若证据不足，标 `unverified` 或不建立关联。
3. 首批优先交付可溯源的约 50 个根/干及 300–500 个关联词；数量以有效、去重并符合审核口径的对象计算，不以已有候选数量充数。

### 5. 内容交付物与报告

推荐提交 UTF-8 CSV（或单一工作簿多个工作表，并另导出 CSV），按下面字段交接；字段是**审校交换格式**，不是已冻结的应用导入 schema。可增加列，但不得删除来源和状态字段：

- `words.csv`：`candidate_id,headword,display_form,part_of_speech,scope,review_status,reviewer,reviewed_at,notes`
- `senses.csv`：`sense_id,candidate_id,part_of_speech,meaning_zh,usage_note,source_id,source_locator,review_status,reviewer,reviewed_at`
- `components.csv`：`component_id,form,component_type,meaning_zh,source_id,source_locator,verification_status,reviewer,reviewed_at,notes`
- `word_components.csv`：`candidate_id,component_id,component_role,position,relation_type,evidence,source_id,source_locator,verification_status,reviewer,reviewed_at`
- `sources.csv`：`source_id,title,publisher,version,url,locator,license_name,license_url,attribution,modification_notice,accessed_at,redistribution_decision,decision_basis`
- `coverage.csv`：`curriculum_version,source_locator,original_entry_or_permitted_reference,scope,candidate_id,match_type,decision,review_status,notes`；如果不能分发原文，使用定位或经授权的标识，不强制复制正文。
- `issues.csv`：`issue_id,category,affected_ids,description,severity,next_action,status`。
- `REPORT.md`：来源和许可、版本及区域假设、数量和去重口径、各层覆盖/缺口/歧义、词根证据、分批状态、未决问题和可复现核验方法。

`candidate_only`、`unverified` 或草稿与 `approved` 分开；审核人/日期只能填写真实信息。适用时同一词允许多个 senses 和 sources，关系及例句各自独立核验。若某字段不适用则留空并解释，不要编造。

对话 01 收到七张 CSV 后，可运行 `python3 tools/content/check_muse_delivery.py /path/to/delivery` 执行结构初检。该检查要求引用在本次交付的文件之间可解析；标记为 approved 的词项、义项和关系必须有对应内容、审核字段和来源定位，引用来源需有版本、许可链接与再分发决定依据等字段；本次交付标记 approved 的单词还需至少一个已批准义项，已批准关联需引用本次交付中已批准的单词和组件；空表和待审状态会提示警告。通过结构检查不等于完成审核、覆盖验收或获得许可，也不会验证审核者身份或实际来源内容。

### 6. 分批交付与验收

- **第一批样本**：先交 10 个词根/词干、50 个关联词、覆盖与来源/许可台账样本；足以核验格式、词义、历史路径和权利。未达数量时按实际交付并说明。
- **首版内容**：经修订后扩充到约 50 个可核验词根和 300–500 个关联单词，附逐项来源和审核状态。
- **完整词库**：完成适用课标的逐项覆盖、异常处理及至少 5,000 个正式去重词条；交付可重算的统计、未解决清单与使用许可材料。
- 交付物须校验唯一 ID、引用完整性、可复现计数、来源/许可完整性、简繁和中英文编码、拼写及数据格式。对不确定项目保留未通过状态；不虚报审核完成。

## 与 Etyra 工程的交接

Muse 负责词库研究、内容编辑、证据与审校材料；对话 01 审核来源、覆盖、决策和验收；对话 03 负责数据库、导入器、迁移、稳定 ID 映射与测试；对话 02 负责展示和交互。任何模型或导入格式变更先由对话 01 / 03 协调。不得直接写 SQLite、替换仓库源文件、修改用户进度或把本包 CSV 当产品 seed。离线词库更新与学习进度备份分开，更新不得重置进度。

## 包内文件导航

- `README_MUSE.md`：转交提示词与文件导航。
- `docs/MUSE_VOCABULARY_HANDOFF.md`：本交接书；`docs/VOCABULARY_DELIVERY_PLAN.md`、`docs/CONTENT_SOURCE_AUDIT.md` 和 `docs/reference/wordlists/README.md` 提供完整背景与许可细节。
- `docs/*.csv`：当前候选、释义草稿、来源索引、词根关系及审核队列；内容状态以各行标记为准。
- `Etyra_词汇候选总表.xlsx`：当前单表汇总，方便筛选；以 CSV 与来源证据为审核依据。
- `backend/`：数据模型、数据库及 Repository 边界；`tools/content/`：部分可复现工具。部分脚本依赖未随包提供的原始数据、额外工具或固定快照，不能假设开箱即跑。

本包用于受控审校交接，含第三方来源派生线索和未审核资料。实际上传外部服务、再次分发或用于商业产品前，应由使用方结合来源许可、服务条款和项目权限判断；本交接书不替代版权授权。
