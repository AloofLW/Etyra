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

这一轮也暴露出：初始 50 个 root brainstorm 中 8 项移出 root 计数，目前只有 42 项保留为 root 候选（其中 4 项已做首轮词源分诊，仍未完成高中适用性审核）。后续需补充真正的 root 候选，才能恢复“约 50 个词根”的候选池目标；不应为了维持数字把词缀留在词根表。

## 第二批词根页面分诊

2026-11-01 对 `act`、`aud`、`cred`、`fac`、`fer`、`fin`、`form` 做页面分诊，详情见 root CSV：

- [action](https://en.wiktionary.org/wiki/action) 支持 `act` 候选并提及 Latin āctus/agere；不能据此批量推断其他相似拼写词。
- [audible](https://en.wiktionary.org/wiki/audible) 追溯到 Latin audire（hear），支持 `aud` 候选。
- [credit](https://en.wiktionary.org/wiki/credit) 追溯到 Latin crēdere（believe），支持 `cred` 候选。
- [transfer](https://en.wiktionary.org/wiki/transfer) 追溯到 Latin trānsferō（bear across），支持继续审核 `fer` 词干，但尚未批准其英语词组或 morpheme 切分。
- [final](https://en.wiktionary.org/wiki/final) 追溯到 Latin fīnis（end/limit），支持 `fin` 候选。
- [formation](https://en.wiktionary.org/wiki/formation) 明确给出 `form` + `-ation`，并追溯到 Latin fōrmō，支持 `form` 候选。
- [factory](https://en.wiktionary.org/wiki/factory) 对来源有保留措辞：词可能由 factor + -y 构成，而制造场所义受 Latin fact- 影响。故不能把 factory 当成 `fac` 的已证关联词；`fac/fact` 候选仍需更清晰的词例。

这 7 项仍全部是待审核候选；本次只审了词源页面，尚未完成高中词汇范围、使用频率、词义编辑、逐词构词关系以及复核人审阅。

## 第三批词根页面分诊

2026-11-01 对 `cap`、`ced`、`duc`、`mit`、`mot`、`rupt`、`script`、`tract` 做页面分诊，记录了潜在词干变体：

- [capture](https://en.wiktionary.org/wiki/capture) 经 Middle French 回溯到 Latin captūra/captus/capiō，支持 `cap/capt` 候选，但英语词形关系仍须逐项核验。
- [precede](https://en.wiktionary.org/wiki/precede) 明确来自 Latin `prae-` + `cēdō`，支持 `ced` 候选；`cess` 变体暂存待核。
- [conduct](https://en.wiktionary.org/wiki/conduct) 与 [conduce](https://en.wiktionary.org/wiki/conduce) 追溯到 condūcō/condūcere 和 dūcō，支持 `duc/duct` 候选家族。
- [submit](https://en.wiktionary.org/wiki/submit) 明确来自 Latin submittere，即 `sub-` + `mitto`；[submission](https://en.wiktionary.org/wiki/submission) 追溯到 submissio/submitto，支持继续审核 `mit/miss` 变体。
- [motion](https://en.wiktionary.org/wiki/motion) 追溯到 Latin mōtiō、movēre；[movement](https://en.wiktionary.org/wiki/movement) 也经 movoir 回溯到 movēre，支持 `mot/mov` 家族候选，但字面切分须逐词证明。
- [interrupt](https://en.wiktionary.org/wiki/interrupt) 来自 Latin interrumpere（`inter-` + `rumpere`），支持 `rump/rupt` 候选。
- [description](https://en.wiktionary.org/wiki/description) 来自 Latin dēscrībō；[scribe](https://en.wiktionary.org/wiki/scribe) 来自 scrībere，支持 `scrib/script` 候选家族。
- [contract](https://en.wiktionary.org/wiki/contract) 将 contrahere 分析为 `con-` + `trahere`；[tract](https://en.wiktionary.org/wiki/tract) 也追溯到 trahere/tractus，支持 `trah/tract` 候选家族。

这些结果只支持候选词根/词干家族继续审核，不意味着这些形式可以在 UI 中互换或自动生成关联。8 项仍待高中范围、词频、具体关联词、释义与来源许可审核。


## 第四批词根/词缀边界分诊

2026-11-01 对 `ject`、`leg`、`morph`、`mort`、`path`、`ped`、`scop` 做了初步页面核对：

- [reject](https://en.wiktionary.org/wiki/reject) 经 Latin `reiectus`/`reicere` 回溯到 `re-` + `iacere`（throw），支持 `ject` 作为受限词干候选；英语派生词仍须逐条审核。
- [legible](https://en.wiktionary.org/wiki/legible) 回溯到 Latin `legō`（read），支持 `leg` 候选继续评估。
- [morphology](https://en.wiktionary.org/wiki/morphology) 表层分析为 `morpho-` + `-logy`，且英语 `morph` 属于从 `morpheme` 反向构成的词形；将 `morph` 移出 root 计数，并在词缀表新增 `morpho-` combining-form 候选。
- [mortal](https://en.wiktionary.org/wiki/mortal) 回溯到 Latin `mors` 经 `mortalis`，支持 `mort` 候选继续评估；`mort/mors` 变体须逐词核验。
- [pathology](https://en.wiktionary.org/wiki/pathology) 提供 `path-` + `-ology` 或 `patho-` + `-logy` 的表层分析；将其移出 root 计数，在词缀表新增 `patho-` combining-form 候选。不可仅凭拼写把 `empathy` 归入同一构词关系。
- [pedestrian](https://en.wiktionary.org/wiki/pedestrian) 追溯至 Latin `pedester`/`pes`（foot），支持拉丁语“足”义的 `ped` 候选；须与希腊语“儿童”义的 `pedi-/paedo-` 区分。
- [telescope](https://en.wiktionary.org/wiki/telescope) 使用 `tele-` + `-scope`；`scop` 移出 root 计数并并入既有 AC-008 `-scope` 候选，不重复登记。

截至本批，共 23 个 root 候选做过来源页面分诊；11 个原 root 条目已移出 root 计数或并入词缀候选。root 候选池约剩 39 项，需补充约 11 个候选以回到约 50 项。上述均为来源层初筛，未完成高中范围、词频、释义、逐词关系和独立编辑审核；全部仍为 `candidate_only`。


## 第五批词根/词缀页面分诊

2026-11-01 对 `tact`、`therm`、`vid`、`voc`、`migr` 做来源页面初筛：

- [tact](https://en.wiktionary.org/wiki/tact) 的英语词条区分经法语借入、发生语义发展的“机敏/得体”义，与直接借自 Latin `tāctus` 的“触觉”义。保留为暂定候选，但不能把不同词源路径或拼写相近词批量并族。
- [thermo-](https://en.wiktionary.org/wiki/thermo-) 明确列为源自 Greek `thermós`（warm/hot）的前缀，并列 `therm-` 为元音前形式；`therm` 同时也是热量单位名称。将其从 root 候选移入词缀表，逐词核验表层形式。
- [visible](https://en.wiktionary.org/wiki/visible) 经 Late Latin `visibilis` 追溯至 Latin `videre`（see）及分词 `visus`，支持暂存 `vid/vis` 词干家族候选；形式不可直接互换。
- [vocal](https://en.wiktionary.org/wiki/vocal) 来自 Latin `vōcālis`，由 `vōx`（voice/sound）+ `-ālis` 构成；支持 `voc` 词干候选，仍需逐词核对。
- [migrate](https://en.wiktionary.org/wiki/migrate) 来自 Latin `migrātus`（`migrō` 的分词），支持 `migr/migrat` 暂定词干家族。

本批保留 4 个 root 候选并将 `therm` 转为 `thermo-` 词缀候选。目前共 27 个 root 候选经页面初筛，12 项从 root 计数移出或并入词缀；root 候选池约 38 项，需补约 12 项达到约 50 项目标。来源初筛未覆盖高中适用性、词频、释义和每条具体构词关系；全部仍为候选，不可导入产品。


## 第六批词根池清理与补充

本批先清理剩余 11 个未处置的初始候选：`bene`、`log`、`man`、`ten`、`chron`、`cosm`、`demo`、`gram`、`hydr`、`psych`、`vis`。其中 `manus/manu` 与 `ten/tenē` 各保留为待审词干家族；`vis` 是 RC-040 `vid` 家族的重复记录，合并并保留 ID 作审计；其余 8 项转入词缀候选：`bene-`、`-logy`、`chrono-`、`cosmo-`、`demo-`、`-gram`、`hydro-`、`psycho-`。`bene-` 的英文页面证据有限，目前依据 Wiktionary English prefixes appendix 登记，仍需英语具体词例验证。

为恢复约 50 个真实 root 候选的池规模，补入 7 个有初步词源页面支持的候选：`pend`、`press`、`solv`、`tend`、`vert`、`pon`、`gen`。分别以 `depend`、`pressure`、`solution`/`attend`、`convert`、`position`、`generation`/`generate` 页面作初筛。每项的分词及异形关系仍需逐词审核；这些证据不构成英语词族的批量批准。

至此，初始 50 条记录中有 20 条转入词缀候选，另有 1 条重复 root 候选合并；新增 7 条 root 候选后，root 候选池约 36 项，仍需补约 14 项。当前 root CSV 共 57 行，affix CSV 共 19 行。均为候选记录，未批准为产品词库。来源访问日、候选处置和许可复核提示见两个 CSV。


## 第七批：补齐 50 个有效 root 候选

本批新增 14 个初步有英语词源页面支持的 root/stem 候选：`grad`、`loc`、`memor`、`oper`、`sign`、`civ`、`sens`、`numer`、`reg`、`mar`、`nomin`、`curr`、`terr`、`mater`。证据和页面 URL 已写入 root CSV；本批按可见英语词例记录来源路径，标明了 `memor-`、`numer-`、`nomin-`、`curr/curs` 等潜在变体，以及 `territory` 不能单独证明 `terra` 的边界限制。

当前候选池计算为：初始 50 行 − 20 项转词缀 − 1 项重复合并 + 7 项前批新增 + 14 项本批新增 = 50 项有效 root/stem 候选。CSV 共 71 行，其中 20 行以 reclass 决策保留审计轨迹、1 行为已合并重复、其余 50 行是 root 候选。所有行仍为 `candidate_only`；这只是达到候选池规模，不表示词根释义、英语关联词、释义/例句、许可和高中范围已获批，也不能直接生成产品 seed。

## 首批关联单词候选

建立 `docs/WORD_CANDIDATES_V0_1.csv`，按冻结模型中的 `Word` + 显式 `WordComponent(root)` 关系记账；截至本轮登记 68 个词根—单词关系候选，覆盖 50 个有效 root/stem 候选中的 45 个方向。每行有独立单词来源 URL、初步证据摘要、候选构词形式和待审核状态；没有填写释义、词性或例句，避免未经编辑核验的内容进入产品字段。候选行全部为 `candidate_only` 和 `pending_word_level_review`，不得由 CSV 自动生成产品 Word/WordComponent。

本轮新增 9 条候选，集中在 `port`、`spect` 和 `struct` 词根组。证据分别来自 Wiktionary 的 [transport](https://en.wiktionary.org/wiki/transport)、[import](https://en.wiktionary.org/wiki/import)、[export](https://en.wiktionary.org/wiki/export)、[spectator](https://en.wiktionary.org/wiki/spectator)、[prospect](https://en.wiktionary.org/wiki/prospect)、[prospectus](https://en.wiktionary.org/wiki/prospectus)、[construct](https://en.wiktionary.org/wiki/construct)、[instruct](https://en.wiktionary.org/wiki/instruct) 和 [instruction](https://en.wiktionary.org/wiki/instruction)。对 `import` 的多义/异源、`prospect` 的多种词源、`prospectus` 的双词源关系及 `instruct/instruction` 的词干边界均保留待审提示；来源页面出现某词根并不自动批准教学关系。

这 68 项只是内容审核队列的起步，不等于 300–500 个关联词目标已完成。接下来须逐页固定 revision ID/版本定位，复核词形/词义/词性/高中适用性、关系类型、内容许可与署名；对多词源、多义或有异形的词，必要时拆分词义候选或排除。例句须另行审核版权，不得由模型自行造句后伪装成来源材料。

## 已定位的词源页面修订

2026-11-01 通过 English Wiktionary 的 MediaWiki API 查询当前 68 个关联单词候选，固定页面标题、修订 ID、时间、修订摘要和永久链接，结果见 `docs/WORD_ETYM_SOURCE_REVISIONS.csv`。机器在每个页面的英语章节中识别到至少一个词源标题；表内全部为 `source_located_relation_unreviewed`。章节存在不证明其支持候选词根、切分边界或特定义项，尤其是多词源词必须选择对应章节；正式审核仍须逐条查阅固定版本与其引用资料，并审查页面文本复用许可和署名。

固定版本索引由 `tools/content/index_etymology_revisions.py` 生成，输入是包含页面修订正文的 MediaWiki API 响应，输出仅为定位元数据，不包含正文，不能替代内容审校。原响应未提交仓库；永久链接可用于定位对应来源。为保持候选表既有的 `component_role_candidate` 约定，将 WC-063 `spectator` 的非标准 `suffixal_root` 标记改为 `root`，具体英文构词切分依然待审核，不因此批准任何关系。

## 第一批词义与词源编辑草稿

2026-11-01 由 Codex 根据固定 Wiktionary 词源修订、OEWN 英文义项和 COW 中文词项整理了 8 条编辑草稿，见 `docs/CURATED_WORD_PILOT.csv`。涉及 `action`、`precede`、`final`、`formation`、`submit`、`inspect`、`visible`、`generate`；每行关联候选关系、OEWN 义项、CILI、COW synset、所选中文词项和词源修订 URL。草稿由 Codex 初步审阅，状态为 `editorial_draft_pending_final_review`，尚需核对课标适用性、中文上下文、词根/词缀在模型中的表示方式、来源授权义务和最终入库格式；不能直接视为已验收产品数据。

第二批新增 19 条，总计 27 条编辑草稿：`interrupt`、`respect`、`structure`、`contract`、`solution`、`attention`、`position`、`generation`、`location`、`memory`、`operation`、`sign`、`significant`、`civil`、`sensation`、`marine`、`nominate`、`nomination`、`construct`。每条选定一个特定义项，例如 `contract` 选合同名词义、`operation` 选操作义，其他常见或专业义项仍需单独选取；词干形态变化与历史借词路径保留在备注中。所有条目仍为 Codex 编辑草稿，课标适用性和入库许可尚未最终验收。

第三批新增 19 条，累计 46 条编辑草稿：`credit`、`conduct`、`transfer`、`reject`、`motion`、`movement`、`vocal`、`migrate`、`depend`、`pressure`、`attend`、`number`、`regular`、`rule`、`current`、`transport`、`import`、`spectator`、`prospect`。每行只选择一个与来源中英文义项对应的中文词项，不代表收齐该词全部义项。例如 `pressure` 选物理学压强义，`current` 选当前时间的形容词义；`conduct`、`transfer`、`depend` 和 `regular` 的词干边界仍需进一步核查。词条与词根关系仍为待最终审核的草稿。

在补齐关联词遗漏的 OEWN 候选与 COW 义项后，第四批增加 4 条草稿，总计 50 条：`conduce`、`pedestrian`、`civic`、`numeral`。其中 `numeral` 选择形容词“数字的”，名词义项与来源路径需另行处理；`conduce` 的高中适用性仍待确认。所有条目仍待最终内容与许可验收。

对构词模板线索与既有 root/stem 候选作精确组件对照并查看原文后，新增 `actor` → `act` 关系候选 `WC-069` 和一条选择“演员”义项的编辑草稿，候选关系累计 69 条、编辑草稿累计 51 条。固定 [actor 页面修订](https://en.wiktionary.org/w/index.php?title=actor&oldid=93738073)记录从拉丁语 āctor、agō 经法语进入英语的历史路径，并另给出现代英语 act + -or 的等价分析；不得把现代分析误写为实际历史派生顺序，关系与译文仍待最终审核。

同一组件对照还出现 `airport` 的 `port`，但其[固定来源修订](https://en.wiktionary.org/w/index.php?title=airport&oldid=94579816)明确标记港口义 `portus`；当前 `RC-027` 仅表示“搬运”义的 port 候选，因此不建立 `airport` → `RC-027` 关系。此反例说明同形和词典构词模板不能独立证明词根义项相同。

词源摘要是对固定 Wiktionary 页面来源路径的改写；英文义项定位来自 OEWN/Princeton WordNet，所选中文词项来自 COW 1.1。相关来源、版权声明和许可详见 `docs/reference/wordlists/README.md`，再分发需同时保留相应署名、许可证与适用的修改说明。历史词源与现代英语表层拆分分别记录；未根据拼写推断其他关联。

审阅还发现 `portable` 的自动中文候选目前只关联 `oewn-portable__5.00.00.outboard.00`（CILI `i7039`，COW `cow-01291589-a`）：OEWN 英文定义是涉及船外发动机的特殊义，而中文候选含“便携式的”。该跨词网关联可能存在语义范围错位，不能据此给一般 `portable` 用法选译；在核验跨词网标识和该词正常义项来源前保留待审。此问题不应自动推广为其他义项均有问题，也不应被数量统计掩盖。

## 待决事项

- 词源条目的编辑复核流程、审核人和来源快照/修订标识如何归档？
- 应用或内容包公开/商业分发前，应根据最终纳入内容复核许可组合与发布声明。

## 本地开发任务影响

- 许可方向及高中选词基线已确认；ET-01 可开始建立候选审核表，但具体条目必须逐条完成来源、许可、释义和词源校验后才能进入产品 seed。
- 首批 50 个待评估词形已登记在 `docs/ROOT_CANDIDATES_V0_1.csv`。该文件只用于排序和逐项审核，所有行仍为 `candidate_only`；任何 `decision` 值都只是候选处置，不代表产品批准。词形不代表已确认的词根定义、来源、构词关系或高中范围适配性。审核完成前不得导入应用、seed 或展示为已验证内容。
- 已对 `port`、`spect`、`struct`、`dict` 做首轮来源页面分诊；候选处置与关键歧义已写入 CSV。它们仍待高中适用性和逐词关联审查，`dict` 的候选形式需继续核验。
- 已对 `act`、`aud`、`cred`、`fac`、`fer`、`fin`、`form` 做第二批页面分诊；其中 `factory` 作为 `fac` 关联词证据不足，不能纳入已验证关系。
- 已对 `cap`、`ced`、`duc`、`mit`、`mot`、`rupt`、`script`、`tract` 做第三批页面分诊，并将潜在 allomorph 记录为待核，不据拼写自动建立关系。
- 第四批核对 `ject`、`leg`、`mort`、`ped`，并将 `morph`、`path`、`scop` 重分类/并入词缀候选；来源证据与形态边界说明见本文件和 CSV。
- 第五批核对 `tact`、`vid`、`voc`、`migr`，并将 `therm` 重分类为 `thermo-` 词缀候选。
- 第六批完成初始候选尾项清理，新增 7 个 root 候选；具体证据、重复处理和词缀重分类见本文件“第六批”及 CSV。
- 第七批新增 14 个 root/stem 候选，候选池规模达到约 50；仍非产品数据，待逐词编辑审校。
- 初始候选中 20 条转入词缀、1 条重复合并；随后新增 21 个 root 候选，当前候选池约 50 项，所有条目仍待编辑审核。
- 后续 ET-10C 词库包必须携带来源/许可/署名/修改信息；导入校验只检查元数据完整性，不宣称来源内容真实或发布者身份已认证。
- 本文记录的是来源策略和候选，不是具体数据集版本或词条批准清单。具体数据集/页面版本及条目批准结果必须另行审计。
