# 离线词库来源与许可审查（第一版）

审查日期：2026-11-01  
状态：用户已确认许可策略与候选方向（2026-11-01）；尚未批准任何具体词条或数据集版本。

## 范围

本审查为 Etyra 离线分发的首批约 50 个词根和 300–500 个关联单词提供来源选择依据。此次只审查来源、许可及内容适配性，不导入词条、不生成 seed 数据，也不构成法律意见。词条和构词关系仍须逐条核对。

## 来源候选

| 来源 | 可支持的内容 | 分发与归属要求 | 对 Etyra 的判断 |
| --- | --- | --- | --- |
| English Wiktionary（人工逐页审阅或 Wiktextract 提取） | 词条、词性、释义、例句及部分词源信息；覆盖和质量随词条而异 | Wikimedia 说明文本通常依 CC BY-SA 4.0 和/或 GFDL 提供，但具体页面可能有不同来源、许可或额外署名要求。须检查页面、历史及导入内容；署名来源、标记修改，并按适用许可提供改编内容。Wiktextract 的 MIT 许可只适用于提取器代码，不替代提取数据的来源许可。 | 可作为逐条审核的词源候选；纳入每条数据前仍须核实许可适用范围、具体页面来源和包内归属声明。 |
| Open English WordNet（OEWN） | 英语词项、词性、词义/同义集及语义关系 | OEWN 声明采用 CC BY 4.0；其许可文件说明数据基于 Princeton WordNet，并要求同时归属 Princeton WordNet 与 OEWN 团队，且底层 Princeton 许可条件仍适用。 | 可作为词义、词性等辅助来源；不提供足够的词根词源依据，不能单独证明构词关系。正式选定版本后必须随包保存其许可证、归属和来源版本。 |
| Princeton WordNet 3.0 | 英语词义、词性及同义集/语义关系 | 允许使用、复制、修改、分发且不收费，但要求版权声明和免责声明出现在所有副本及修改版本中；不得用 Princeton 名称做分发宣传。 | 可辅助释义和语义关联；不是词源数据库。若使用，应随分发包提供完整许可声明。 |
| Oxford Dictionaries API | 词典查询内容 | API 条款限制系统性抓取、离线本地缓存和再分发；离线缓存需相应企业许可，词典应用另有审批要求。 | 未取得明确书面许可前，不用于内置或手动导入的离线词库。 |

## 已核对的第一手资料

- [Wikimedia Foundation Terms of Use](https://foundation.wikimedia.org/wiki/Policy:Terms_of_Use)：贡献者文本许可、署名、修改标记、分享相同许可，以及逐页检查来源的要求。
- [Wikimedia 内容复用指引](https://www.mediawiki.org/wiki/Wikimedia_APIs/Content_reuse)：复用时核实具体内容许可与署名方式。
- [Wiktextract 项目说明](https://github.com/tatuylonen/wiktextract) 与 [项目 LICENSE](https://github.com/tatuylonen/wiktextract/blob/master/LICENSE)：提取器代码许可和提取内容许可是不同问题。
- [Open English WordNet 官方仓库](https://github.com/globalwordnet/english-wordnet) 与 [许可文件](https://github.com/globalwordnet/english-wordnet/blob/main/LICENSE.md)：CC BY 4.0、双重来源归属及底层 WordNet 许可说明。
- [Princeton WordNet 许可说明](https://wordnet.princeton.edu/license-and-commercial-use)：WordNet 3.0 版权声明和免责声明要求。
- [Oxford Dictionaries API 条款](https://developer.oxforddictionaries.com/api-terms-and-conditions) 与 [FAQ](https://developer.oxforddictionaries.com/faq)：缓存和离线使用限制。

## 建议的内容流程

1. 不整包复制大型词典数据。先冻结目标词根及选词标准，再只获取和审核候选条目。
2. 来源许可未确认前，不把 Wiktionary/WordNet 派生文本纳入应用、测试 fixture 或发布包。测试样例使用明确标注的虚构占位内容，不能被当作产品词库。
3. 每条 Root、Affix、Word、ExampleSentence 和每条构词关系分别留存 `SourceRef`：来源标题/发布者、版本或页面修订标识、URL/定位、许可名称及链接、署名文本、访问日期、修改说明、审阅人和校验状态。具体字段以 `docs/CONTRACTS_V0_1.md` 为准；若缺少修订标识承载位置，应先扩展契约再导入正式数据。
4. 构词关系须有针对该词条的词源证据并经人工审核。释义或相似拼写不能推出词根关系；无法证实时标记 `unverified`，不写成确定词源。
5. 建立独立的内容包/第三方声明文件，保存数据集版本、许可文本/链接、署名与修改声明。内容包许可和应用源代码许可分开说明；不得在未审查义务前把 CC BY-SA 内容混入无法满足相应条件的分发方式。
6. 发布前逐条核对来源可访问性、许可适用范围、释义准确性、词性、词根关系及例句权利；记录审阅结果和被排除条目。

## 第一版建议

按用户确认的策略，允许在满足逐条来源核验、署名、修改标记及适用分享相同许可条件后，采用 CC BY-SA 兼容的 Wiktionary 派生词源/构词内容；OEWN 作为词性和词义的辅助候选，Princeton WordNet 3.0 可作为遵守其声明要求时的辅助候选。它们均不能单独证明词源。Oxford API 当前不符合无单独许可的离线打包目标。具体数据集/页面版本仍须在候选条目审核时记录，来源策略确认不等于任何数据已自动获批。

不得以“改写”规避许可或来源归属。词库内容与应用代码在发布材料中分开标注；每个词库包提供适用许可和归属声明。公开/商业发布前，按实际包内内容再次核对许可条件。

## 首批高中词库选择基线

- 范围按中国普通高中英语学习与常见高考词汇需求设计，不绑定单一省份、某一套教材或某一年真题；覆盖基础核心词汇，并优先选择可解释多个常用派生词/关联词的高产词根。
- 词根优先级：高中核心词覆盖度、可核验的历史/形态构词证据、关联常用词数量、学习解释价值。优先纳入能形成清晰学习组的词根；不为凑足约 50 个而纳入冷僻或争议词根。
- 关联单词优先级：高中学习与常见考试中的实用性、现代常用程度、构词关系证据清晰、词性/释义可由来源核验。先覆盖常见且关系明确的词，不要求每个词根机械配相同数量。
- 暂不纳入：专名、罕见历史词、仅靠拼写相似判断的关系、争议词源未标注、来源许可不明、释义/例句权利不清的条目。若条目对学习仍有价值但关系证据不足，可独立作为单词候选，不声明词根关系。
- 词频/考试范围用于排序而非词源证明。任何参考词表须记录名称、发布者、版次、许可和定位；不得整表复制或将考试出现等同于构词事实。

## 首轮词源页面分诊

2026-11-01 对四个高优先级候选做了第一轮页面核对。以下仅证明候选形式值得继续审查，不代表释义、关联词表或高中适用性已通过编辑审核；所有候选仍不可导入产品：

- `port`：Wiktionary 的 [portable](https://en.wiktionary.org/wiki/portable) 页面明确给出表层分析 `port`（carry）+ `-able`；[port](https://en.wiktionary.org/wiki/port) 同时列出其他历史词源/义项。必须将“搬运”这一候选义与“港口”等同形来源分开。
- `spect`：Wiktionary 的 [inspect](https://en.wiktionary.org/wiki/inspect) 将其分析为 `in-` + `-spect`，并指向拉丁语 `specere`；[respect](https://en.wiktionary.org/wiki/respect) 追溯到 `speciō` 经 `respiciō`/`respectus` 的路径。作为 bound form 候选保留；关联词需要各自核验。
- `struct`：Wiktionary 的 [structure](https://en.wiktionary.org/wiki/structure) 将词源追至拉丁语 `struere` 与分词 `structus`。保留为词干/异形候选，需确认模型中如何清楚表达其形态边界。
- `dict`：Wiktionary 的 [predict](https://en.wiktionary.org/wiki/predict) 分析为拉丁语 `prae-` + `dīcō`，并提及 `praedictus`。不能据此仅按拼写把 `predict` 关联到 `dict`；候选已调整为暂存 `dic/dict` 词干家族，待继续查核英文派生形态。

详细 URL、访问日、许可复核提醒和候选处置见 `docs/ROOT_CANDIDATES_V0_1.csv`。Wiktionary 当前页面由社群维护，后续正式收录仍须保留来源页面/修订定位、满足署名和许可要求，并由内容审校者确认。

## 词根与词缀边界复核

第二轮页面核验发现，初始 root brainstorm 中有 8 项实际更适合先放入词缀候选表：`bio-`、`geo-`、`-graph`、`photo-`、`micro-`、`tele-`、`-phone`、`-scope`。Wiktionary 对这些形式提供了明确的前缀/后缀条目或组合分析。已将它们登记到 `docs/AFFIX_CANDIDATES_V0_1.csv`，并在 root 表标记重分类。`phon` 对应形式暂记为 `-phone`；`scope` 改记为 `-scope`。这些仍是未批准候选，需逐词核实形态边界及高中适用性。

这一轮也暴露出：初始 50 个 root brainstorm 中 8 项移出 root 计数，目前只有 42 项保留为 root 候选（其中 4 项已做首轮词源分诊，仍未完成高中适用性审核）。后续需补充 8 个真正的 root 候选，才能恢复“约 50 个词根”的候选池目标；不应为了维持数字把词缀留在词根表。

## 待决事项

- 词源条目的编辑复核流程、审核人和来源快照/修订标识如何归档？
- 应用或内容包公开/商业分发前，应根据最终纳入内容复核许可组合与发布声明。

## 本地开发任务影响

- 许可方向及高中选词基线已确认；ET-01 可开始建立候选审核表，但具体条目必须逐条完成来源、许可、释义和词源校验后才能进入产品 seed。
- 首批 50 个待评估词形已登记在 `docs/ROOT_CANDIDATES_V0_1.csv`。该文件只用于排序和逐项审核，所有行仍为 `candidate_only`；任何 `decision` 值都只是候选处置，不代表产品批准。词形不代表已确认的词根定义、来源、构词关系或高中范围适配性。审核完成前不得导入应用、seed 或展示为已验证内容。
- 已对 `port`、`spect`、`struct`、`dict` 做首轮来源页面分诊；候选处置与关键歧义已写入 CSV。它们仍待高中适用性和逐词关联审查，`dict` 的候选形式需继续核验。
- 另将 8 个前缀/后缀形式转入 `docs/AFFIX_CANDIDATES_V0_1.csv`，避免计入 50 个 root 候选；root 候选池当前需补 8 项。
- 后续 ET-10C 词库包必须携带来源/许可/署名/修改信息；导入校验只检查元数据完整性，不宣称来源内容真实或发布者身份已认证。
- 本文记录的是来源策略和候选，不是具体数据集版本或词条批准清单。具体数据集/页面版本及条目批准结果必须另行审计。
