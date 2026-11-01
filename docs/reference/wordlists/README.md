# Etyra 高中词库：词表来源与覆盖计划

更新日期：2026-11-01。用户目标为覆盖中国高中阶段必学及常见英语词汇，正式词库不少于 5000 个经处理的词条。词表候选数量不等于产品词条数量，也不证明高中课标覆盖完整。

## 已获取：通用英语候选词表

- 文件：[NGSL-GR-1.0-rank.csv](NGSL-GR-1.0-rank.csv)，来自作者项目的[原始下载地址](https://www.newgeneralservicelist.com/s/NGSL-GR_rank.csv)，2026-11-01 获取；文件原样保存，未编辑。
- 名称：New General Service List – Graded Reader (NGSL-GR) 1.0；作者 Charles Browne、Brent Culligan，2024。项目[官方说明](https://www.newgeneralservicelist.com/ngsl-graded-reader)介绍其为面向分级阅读的通用英语扩展词表，并注明 CC BY-SA 4.0。
- 许可：[CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)。署名：Browne, C. and Culligan, B. (2024), *The New General Service List – Graded Reader Edition*, https://www.newgeneralservicelist.com/ngsl-graded-reader。原始文件未修改；后续改编时须记录修改、保留署名和许可链接并遵守相应共享条件。该许可针对内容，应用代码许可单独管理。
- SHA-256：`5c4f7bb84b5d74d7481d43483b811f1591bd667b86a6131f1566fdf07cade91e`。
- 实际文件包含表头和 5050 行，`WordID` 为 1–5050，去除首尾空格并忽略大小写后为 5050 个不同文本；项目网页将该清单描述为 5000 词。文件前 50 行是星期、月份和数字等词项；未核实其与作者说明的频次排名的关系，暂不把 `WordID` 直接解释为全表词频排名。部分项具有大小写和同形歧义，如 `august`，须审校。
- 本文件是研究和选材用候选，不含中文释义、例句、词源关系和课标标签。词项必须经过词形、词义、课程相关性、来源、许可和教学审查后才能进入产品内容包。英语常用度不能代替中国高中课标覆盖证明。

## 已获取：学术英语补充候选

- 文件：[NAWL-1.2-alphabetized.txt](NAWL-1.2-alphabetized.txt)，来自作者项目的[原始下载地址](https://www.newgeneralservicelist.com/s/NAWL_12_alphabetized_description.txt)，2026-11-01 获取；文件原样保存，未编辑。
- 名称：New Academic Word List (NAWL) 1.2；作者 Charles Browne、Brent Culligan、Joseph Phillips。[官方页面](https://www.newgeneralservicelist.com/new-academic-word-list)说明这是面向学术英语学习的 957 词清单，以 CC BY-SA 4.0 提供。署名：Browne, C., Culligan, B. and Phillips, J., *The New Academic Word List*, https://www.newgeneralservicelist.com/new-academic-word-list；许可和修改标记要求同上。
- SHA-256：`88a99099e10010ea40992cca4a5119102d05a0f2888ee5d43d4c8b4afd597fef`。原文件前 6 行为介绍、空行及参考文献，之后是 957 个不同词项。按去除首尾空格、忽略大小写的精确文本比对，与 NGSL-GR 重合 665 项、NAWL 独有 292 项、两表并集 5342 项；未处理英美拼写、词形、词义或课程适用性。此结果只描述候选文本并集，不代表独立产品词条数或高中覆盖率，学术性过强的词须筛除。

## 合并候选清单

[`docs/VOCABULARY_CANDIDATES.csv`](../../VOCABULARY_CANDIDATES.csv) 是上述两份词表的改编整理，按去除首尾空格并执行 Unicode casefold 后的拼写合并、排序。每行保留来源标识、NGSL 原始 `WordID`（不是已确认的词频排名）和 `candidate_only` 状态；两个来源同时出现时同时保留标识。候选 ID 是规范化拼写 SHA-256 的前 20 个十六进制字符，仅用于这份审核清单，不是产品稳定 ID。合并会遮蔽同拼写词项的词义、词性或大小写差异，必须在产品入库前单独审查。文件不含释义、课标标签或词源关系。

合并清单基于 Browne、Culligan 的 NGSL-GR 1.0 与 Browne、Culligan、Phillips 的 NAWL 1.2 改编，采用 [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)；各来源名称、链接和署名见本页对应章节。改动包括提取单词、大小写归并、排序、记录来源及生成候选 ID；原始来源文件保持不变。复现：`python3 tools/content/build_candidate_inventory.py /tmp/etyra-candidates.csv`；脚本校验两个来源的 SHA-256，拒绝覆盖已存在输出。

[`docs/VOCABULARY_REVIEW_QUEUE.csv`](../../VOCABULARY_REVIEW_QUEUE.csv) 对主清单的 5342 个候选按 ID 汇总现有 OEWN 英文义项数、COW 中文线索数、Kaikki 虚词义项数、OEWN Form 线索数、两类编辑草稿数和部分 Wiktionary 定位状态，供逐项分诊；数据仍是 `candidate_only`。当前 13 个候选缺少直接英文义项线索、497 个缺少中文线索、4609 个存在多个英文义项待选择；以上数字反映本仓库已收集的数据，并不等于词典真实缺项，也不保证现有线索正确。所有项均需课程和许可审核；`not_indexed` 仅表示未纳入此前那批词源页面索引，不代表没有词源资料。数量按义项行统计，不等同正式词条数，COW 对齐和中文草稿均非已验收释义。

复现：`python3 tools/content/build_vocabulary_review_queue.py /tmp/etyra-review-queue.csv`，从当前仓库对应候选表生成，拒绝覆盖输出并检查主要外键及重复 ID。该表只涵盖主清单；课标缺口、复杂词形和关联词补充表须另行纳入审核，不能据此声称全部候选已经处理。

## OEWN 词义候选索引

[`docs/OEWN_CANDIDATE_INDEX.csv`](../../OEWN_CANDIDATE_INDEX.csv) 将 5342 个合并候选的规范化拼写与 [Open English WordNet 2024 发行版](https://github.com/globalwordnet/english-wordnet/releases/tag/2024-edition)的 `Lemma.writtenForm` 以去首尾空格、Unicode casefold 方式比对。5265 个候选至少匹配一个 OEWN 词条，77 个未匹配；每行记录候选 ID、OEWN 词条 ID、词性代码和不同义项 ID 数量，状态仍为 `candidate_only`。小写归并会合并不同大小写含义，例如 `a` 可能匹配 `A`；相同拼写也可能有大量不同词义。匹配结果不能自动选择义项、释义、课标等级或词根，未匹配也不代表不是单词。

对于未匹配词头的 77 个候选，另以同版 OEWN 的显式 `Form.writtenForm` 检查，找到 2 个候选、2 条词形—词典条目线索：`criteria` → `criterion`，`media` → `medium`，见 [`docs/OEWN_FORM_CANDIDATES.csv`](../../OEWN_FORM_CANDIDATES.csv)。结果只记录词典给出的词形关联，大小写、词性、具体义项和中文翻译仍需审核；例如 `media` 的常见用法不能直接套用 `medium` 的任一义项。其余 75 个候选没有找到精确匹配的显式 Form；其中有大量介词、连词和代词，不能据此认定无效或没有释义。此处没有合并候选 ID，也未自动生成词根关系。

复现：`python3 tools/content/index_oewn_form_candidates.py /path/to/english-wordnet-2024.xml.gz /tmp/etyra-oewn-forms.csv`，脚本校验与此前 OEWN 索引相同的归档摘要并拒绝覆盖输出。OEWN 词条来源及许可要求见下文，任何释义或翻译入库前须独立审核。

### 补充虚词的英文义项线索

2026-11-01 获取 [Kaikki English](https://kaikki.org/dictionary/English/index.html) 的五份按词性分类的 Wiktextract 后处理数据，以忽略大小写的拼写键匹配上述 77 个 OEWN 词头未命中候选，提取有英文 gloss 的义项至 [`docs/KAIKKI_FUNCTION_SENSE_CANDIDATES.csv`](../../KAIKKI_FUNCTION_SENSE_CANDIDATES.csv)：64 个候选、450 条义项，包括介词 202、代词 116、连词 90、限定词 28、冠词 14 条。保留来源拼写、词性、来源 sense ID、英文 gloss、标签和对应 Wiktionary 页面；未提取例句、发音、中文翻译或词源。结果是未经人工审校的全部匹配义项，不代表高中语境、现代常用义、中文释义或关系已核实。词典可能包含古旧、地区和变体义项，必须连同标签和原始页面检查；忽略大小写也可能错误关联。

剩余 13 个未获本批候选的词是 `café`、`could`、`criteria`、`founded`、`goods`、`hey`、`media`、`multi`、`shall`、`should`、`trans`、`whereby`、`would`；这里只检查五种词性，不表示原词典缺少这些词或该词没有其他词性，前述 `criteria`、`media` 已有 OEWN Form 线索。

来源文件依次为 [article](https://kaikki.org/dictionary/English/pos-article/kaikki.org-dictionary-English-by-pos-article.jsonl.gz)、[conj](https://kaikki.org/dictionary/English/pos-conj/kaikki.org-dictionary-English-by-pos-conj.jsonl.gz)、[det](https://kaikki.org/dictionary/English/pos-det/kaikki.org-dictionary-English-by-pos-det.jsonl.gz)、[prep](https://kaikki.org/dictionary/English/pos-prep/kaikki.org-dictionary-English-by-pos-prep.jsonl.gz)、[pron](https://kaikki.org/dictionary/English/pos-pron/kaikki.org-dictionary-English-by-pos-pron.jsonl.gz)；快照 SHA-256 分别为 `d42ba9fce9ec018bdc606dd1948eb2d4ce7209af5205967f60188ff758a54d92`、`90417a911907ff580f588c7a41846647fc055c930ead96638cb40bb00a29fe11`、`1950b79784a27d931e62bddabe7a5111d86df57af72a22bc3a0b2fc77b9b8a1b`、`a995558554ea0b3e59003925f6aa8ea8a50089da05d3bfff0daaab2f266dddc6`、`38d5dcad952274fa2d3284cb0580f25fdea461007e76980e362dbea475ca9ac2`。站点文件会更新，这些固定摘要是本次依据，源文件未提交仓库。复现：将上述文件分别命名 `etyra-kaikki-词性.jsonl.gz` 并放入同一目录，执行 `python3 tools/content/extract_kaikki_function_candidates.py /path/to/directory /tmp/etyra-function-senses.csv`；脚本检查全部摘要并拒绝覆盖已有输出。

来源为 Wiktionary contributors 经 Tatu Ylonen 的 Wiktextract/Kaikki 处理的数据；本表筛选候选并保留原始 gloss 与标签，是其改编。Kaikki [许可说明](https://kaikki.org/dictionary/index.html)指出数据依据 Wiktionary 的 CC BY-SA 与 GFDL 许可发布；使用须遵守 [Wiktionary 版权和署名条款](https://en.wiktionary.org/wiki/Wiktionary:Copyrights)、[CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) 及所选许可的适用要求，保留页面及其历史、版权归属、许可链接和修改说明。Kaikki 后处理还可能合并其他来源；最终分发前应逐项确认附加来源和许可，不能仅凭本表标记内容可用于产品。学术引用参见 Tatu Ylonen, *Wiktextract: Wiktionary as Machine-Readable Structured Data* (LREC 2022)。

[`docs/CURATED_FUNCTION_WORD_PILOT.csv`](../../CURATED_FUNCTION_WORD_PILOT.csv) 从上述候选中选取 27 条常用义项，附上编辑编写的中文释义草稿和用法范围；每条保留原始英文 gloss、sense ID 和来源页面。中文文字是编辑草稿，不是来源词典提供或人工专家验收的译文；选义、中文表达、课标适用性及来源许可均须复核后才可用于产品。所选义项不能当作该词全部用法。

来源数据的 sense ID 并非总能唯一标识义项：本批 `en-of-en-prep-en:possession1` 对应两个不同 gloss。检索或引用时须同时核对词头、词性和原始 gloss，不能单靠 sense ID 合并或覆盖记录；当前 27 条编辑草稿均未使用该重复 ID。

本索引基于 Open English WordNet 2024 和 Princeton WordNet 改编：提取词条标识、词性与义项数量，关联 Etyra 候选拼写，不含 OEWN 释义正文。OEWN 团队与 Princeton WordNet 均须署名；OEWN 为 CC BY 4.0，底层 Princeton WordNet 条款及免责声明同时适用。保留发布版本的原始 [OEWN 许可](OEWN-2024-LICENSE.md) 和 [WordNet 条款](OEWN-2024-WNDB-license.txt)。合并候选本身还受上节所述 CC BY-SA 4.0 条件约束；内容与应用代码分别管理。

输入文件为发行版 XML gzip，下载地址 `https://github.com/globalwordnet/english-wordnet/releases/download/2024-edition/english-wordnet-2024.xml.gz`，SHA-256 `e1f633b0a93758cae34ea27c44c4dad310a8af2467b155f99dd6673af697e875`。运行 `python3 tools/content/index_oewn_candidates.py /path/to/english-wordnet-2024.xml.gz /tmp/etyra-oewn-index.csv` 可复现；脚本校验摘要且拒绝覆盖输出，需要 Python 3.11 及以上。原始词典体积较大，未放入项目；后续正式内容包须再次保留适用许可和署名。

[`docs/OEWN_SENSE_CANDIDATES.csv`](../../OEWN_SENSE_CANDIDATES.csv) 是同一固定版本进一步提取的英文释义审核材料：5265 个候选词关联 28696 行 OEWN 义项。每行保留候选 ID、OEWN 原始拼写、词条 ID、词性、义项 ID、同义词集 ID、原始英文定义的 JSON 数组和 `candidate_only` 状态；不包含例句或中文释义。该表保留多义词的全部匹配义项和不同大小写的原始词形；排序仅用于稳定生成，不能作为常用程度或默认释义排序。审核须选择合适义项并区分词性、大小写和语境；OEWN 不用于证明词源。

本表根据 OEWN 2024 与 Princeton WordNet 的定义内容改编：按候选拼写筛选并关联候选 ID，保留原定义及出处；使用范围须遵守上一节的 OEWN、Princeton WordNet 与候选词表许可和署名要求。复现命令：`python3 tools/content/extract_oewn_sense_candidates.py /path/to/english-wordnet-2024.xml.gz /tmp/etyra-oewn-senses.csv`。脚本校验源文件摘要、词项/义项标识和同义词集定义完整性，并拒绝覆盖已有文件。

## 中文词义候选：Chinese Open Wordnet

[`docs/COW_SENSE_CANDIDATES.csv`](../../COW_SENSE_CANDIDATES.csv) 以已保存的 OEWN 英文义项为基础，通过英文与中文词网各自明确给出的 CILI 标识连接 [Chinese Open Wordnet 1.1](https://bond-lab.github.io/cow/) 词义集合，提取该集合的中文词项。得到 15135 行候选义项，涉及 4819 个英文候选键。每行保留 OEWN 词条原始大小写、词性、sense/synset ID、CILI、COW synset ID 和中文词项数组；没有提取拼音或例句。一个义项可能对应多个中文表达，排列不代表优先级。

同一个 CILI 标识是跨词网的关联线索，不保证两种语言用法、搭配或语域完全一致。COW 发布方说明其内容仍可能有错误；COW 1.1 也包含经过模型辅助筛查的数据，不能视作逐项人工认证。该表全部为 `candidate_only`，选义、简体展示、词性、中文表达和高中适用性必须审核；部分不适合直译，部分候选词没有对应项。OEWN 本身没有词源证据，不能从此表推导词根关系。

来源：[COW 1.1 发行包](https://github.com/bond-lab/cow/releases/tag/v1.1)，SHA-256 `93e9357dda50a38ce626904c2229479afa177df74d9c504aebfeba06ff2f241e`；许可证全文为 [COW-1.1-LICENSE.txt](COW-1.1-LICENSE.txt)，要求保留版权声明及免责声明。署名 Chinese Open Wordnet 的 Francis Bond、Shan Wang、Luís Morgado da Costa 及相应版权年度，完整内容见许可证；同时保留 OEWN 与 Princeton WordNet 的来源和许可，以及原词表的 CC BY-SA 4.0 要求。本表是基于这些来源的筛选与跨词网关联；未修改原始中文词形。原始大型词典包不随仓库提交。

复现：`python3 tools/content/align_cow_sense_candidates.py /path/to/english-wordnet-2024.xml.gz /path/to/cow-1.1.tar.xz /tmp/etyra-cow-senses.csv`，需要 Python 3.11+。脚本验证两个原始包摘要、OEWN 义项及同义词集引用，仅按非空有效 CILI 匹配并拒绝覆盖已有输出。正式词库须逐义项复核并重新保存许可、署名和修改说明。

## 课标镜像补充词的义项候选

将 OEWN 支持的两份补充候选（`CURRICULUM_GAP_CANDIDATES.csv` 和 `COMPLEX_FORM_CANDIDATES.csv`）同样连接到固定词典版本，得到 [`docs/OEWN_SUPPLEMENT_SENSE_CANDIDATES.csv`](../../OEWN_SUPPLEMENT_SENSE_CANDIDATES.csv)：348 个候选键、1065 条英文义项；其中 [`docs/COW_SUPPLEMENT_SENSE_CANDIDATES.csv`](../../COW_SUPPLEMENT_SENSE_CANDIDATES.csv) 含 272 个候选键、530 条通过 CILI 对照的中文词项候选。两表只包含尚待审核的 `candidate_only` 行，来源、署名、许可和模型辅助筛查限制与上述 OEWN、COW 两节相同。

补充表的 `headword` 是匹配键而非最终展示形式，`oewn_written_form` 保留词典原始拼写。课标镜像本身未经认证，大小写合并或词性歧义可能产生错误义项：例如 `an` 匹配到大写 `AN`、`are` 可匹配名词，这些连接不得视作课标所需义项的证据。每项仍须核对原始词形、词性、语境与权威课标；候选键、义项行或中文关联均不等同正式单词数量。Wiktionary 两份候选未包含在这两张 OEWN 补充表中。

复现：`python3 tools/content/extract_oewn_sense_candidates.py /path/to/english-wordnet-2024.xml.gz /tmp/etyra-supplement-senses.csv --candidate-file docs/CURRICULUM_GAP_CANDIDATES.csv --candidate-file docs/COMPLEX_FORM_CANDIDATES.csv`，然后运行 `python3 tools/content/align_cow_sense_candidates.py /path/to/english-wordnet-2024.xml.gz /path/to/cow-1.1.tar.xz /tmp/etyra-supplement-cow.csv --sense-csv /tmp/etyra-supplement-senses.csv`。输入需为固定摘要版本；两个脚本均拒绝覆盖已存在的输出文件。

## 词根关系候选中的词表遗漏

交叉核对现有词根—单词关系与五份候选清单，发现 11 个关联词尚无候选词头。以固定版本 OEWN 2024 查找后，11 个均找到词典词条，记录在 [`docs/RELATION_WORD_CANDIDATES.csv`](../../RELATION_WORD_CANDIDATES.csv)，并保留原词根关系候选 ID。它们在 [`docs/OEWN_RELATION_SENSE_CANDIDATES.csv`](../../OEWN_RELATION_SENSE_CANDIDATES.csv) 有 25 条英文义项，其中 5 个词的 7 条义项可在 [`docs/COW_RELATION_SENSE_CANDIDATES.csv`](../../COW_RELATION_SENSE_CANDIDATES.csv) 找到中文词项候选。匹配按忽略大小写的拼写键进行，`scribe` 同时出现大小写不同的词典词头，必须区分；以上均为 `candidate_only`，不证明高中适用性或词源关系已验收。

英文定义、中文词项和 OEWN 词头来源及许可分别适用上面的 OEWN、Princeton WordNet 和 COW 条件；词源关系须继续按固定 Wiktionary 版本单独核验。复现：先运行 `python3 tools/content/build_relation_word_candidates.py /path/to/english-wordnet-2024.xml.gz /tmp/etyra-relation-words.csv`；随后对该 CSV 使用 `extract_oewn_sense_candidates.py --candidate-file`，并以生成的义项表作为 `align_cow_sense_candidates.py --sense-csv` 输入。三个脚本验证固定来源摘要并拒绝覆盖已有输出。

## 高中课标覆盖基准

- [教育部制定的《普通高中英语课程标准（2017 年版 2020 年修订）》](https://www.ictr.edu.cn/Uploads/File/2025/02/07/4.%E6%99%AE%E9%80%9A%E9%AB%98%E4%B8%AD%E8%8B%B1%E8%AF%AD%E8%AF%BE%E7%A8%8B%E6%A0%87%E5%87%86%EF%BC%882017%E5%B9%B4%E7%89%882020%E5%B9%B4%E4%BF%AE%E8%AE%A2%EF%BC%89.20250207211247.pdf)由教育部课程教材研究所网站提供，附录 2 称列 3000 词，其中包含义务教育 1500 词、高中必修新增 500 词、选择性必修新增 1000 词；正文不含词性和中文释义。作为已定位的官方历史对照来源，不能据此声称已满足最新版。
- 2025 年日常修订版已经出现：课程教材研究所[刊物目录](https://www.ictr.edu.cn/Uploads/File/2025/12/01/2025%E5%B9%B412%E6%9C%88%E7%9B%AE%E5%BD%95.20251201190727.pdf)列有该版解读，高等教育出版社的[图书信息](https://xuanshu.hep.com.cn/front/h5Mobile/bookDetails?bookId=6a5a6320e119ac972986fa53)确认由课程教材研究所组织编写的解读书。尚未取得并核验 2025 版原文的权威可用文件及附录清单，故其词目、标星、地方实施及出版许可仍待核实；不得以 2020 版取代新版验收。
- 2026-11-01 找到一份[题为 2025 年修订版的第三方 PDF 镜像](https://forum.freemdict.com/uploads/short-url/doVmJXenSoIbcg8t5HA0hkWcccm.pdf)，附录 2 标注从印刷页 73 开始，包含星号等级。该次下载文件 SHA-256 为 `4d2d0f33e511dc0d239d2cdc53fe16f38a107afde9bd1ae557cec9ce7bb1bba0`；仅供研究定位，出版来源、内容完整性、与权威原件一致性和使用许可均尚未核实，不能用作最终覆盖验收。镜像文件未提交仓库。
- 另找到[木里藏族自治县中学网站上的同名 PDF 索引](https://www.scmlzx.net/uploadfile/2025/1110/%EF%BC%884%EF%BC%89%E6%99%AE%E9%80%9A%E9%AB%98%E4%B8%AD%E8%8B%B1%E8%AF%AD%E8%AF%BE%E7%A8%8B%E6%A0%87%E5%87%86%E6%97%A5%E5%B8%B8%E4%BF%AE%E8%AE%A2%E7%89%88%EF%BC%882017%E5%B9%B4%E7%89%882025%E5%B9%B4%E4%BF%AE%E8%AE%A2%EF%BC%89.pdf)。2026-11-01 搜索缓存可读，其附录开头的 `abnormal**`、`accommodation**`、`addict*` 与此前镜像相同；但直接下载返回 404，无法比较完整文件摘要，也不能判断二者是否独立来源或与官方原件完全一致。它是辅助核验线索，不改变此前镜像未认证、许可未决的状态。
- 上述学校网站的缓存文本将词汇表描述为共 3100 词：含义务教育阶段 1600 词、高中必修新增 500 词（一个星号）、选择性必修新增 1000 词（两个星号），地方可另增 200 词；采用英式拼写，其他常见拼写加注，且词表不提供词性或中文释义。此信息仅作为设计课程等级字段及后续核验的依据，不意味着已完成词项抽取或覆盖；学校缓存不是教育部发布渠道，最终以可验证的权威原件和当地实施要求为准。
- 初步比较发现[第三方整理页面](https://wangjunjian.com/posts/2026-06-07-general-high-school-vocabulary-2025/)虽然自称完整课标表，但与上述 PDF 镜像开头的词项有明显差异：镜像列有 `accommodation**`、`addict*`，整理页开头列为 `addicted` 且全文文本搜索未找到 `accommodation`；整理页还列出 `abortion`，镜像相应字母顺序区域未见该项。两者都不是已认证原件，这些差异只说明整理页不宜直接作为完整课标依据；网页中文释义亦非课标原文释义。进一步比对时须保留原页与原始词形、等级及审核结论。
- [新乡工程学院外国语学院页面](https://www.xxgc.edu.cn/fll/info/1061/5288.htm)列出题为 2025 修订版的 PDF 附件，但当前下载要求验证码，附件内容及与正式版本的一致性尚未核验；可作为后续寻找可靠原文的线索。
- 课标原文和整表的再分发许可尚未确认。当前仅记录来源链接和事实，不将课标全文或其整表复制入仓库/产品。必要时取得有权使用的版本或许可，再固定来源版本、页码、文件摘要和覆盖对照。

## 小样本覆盖试算

从上述未认证 PDF 镜像印刷页 73–75 人工抽取 27 个单词或名称，以去首尾空格、忽略大小写的精确文本与两份已保存词表的并集比较：24 项精确匹配，3 项未匹配：`abnormal`、`adorable`、`Antarctica`。这 3 项在镜像中均带有两个星号，仍需对照权威原件和适用范围复核；`Antarctica` 属于专名，最终词库如何计数须单独决定。对照没有尝试词形还原、英美拼写映射、同形异义或分类判定。

该试算不是随机样本，也不是完整附录的覆盖率，不能将 24/27 外推为整体覆盖。它说明两份通用词表即便有 5342 个不同文本，也存在需要补充的课标候选；不得根据词表并集大小声称已覆盖所有高中必学词。正式对照前应取得可验证的课标原件并逐页检查文本提取和标星，尤其要处理双栏、斜杠及括号形式。

## 2025 镜像整表探索性提取

使用固定摘要的第三方 PDF 镜像及 `tools/content/compare_curriculum_pilot.py`，按 PDF 页码 76–132 的双栏位置提取，再只将纯字母加可选星号的行作为简单词项，按小写形式与两份候选词表做精确文本对照。一次运行得到 3098 条提取行，其中 3013 条为简单词项行（3011 个不同的小写拼写），2720 行精确匹配、293 行未匹配；其余 85 行包含缩写、括号、斜线、连字符或其他需人工处理的形式，被排除在匹配统计外。统计单位是提取行，包含同形条目，不能等同课标词条数；镜像未认证、提取结果也未逐页校对，以上结果不能作为官方覆盖率。

复现方式：准备摘要与上节记录完全相同的 PDF 镜像，使用已提供 `pdfplumber` 的 Python 环境运行 `python3 tools/content/compare_curriculum_pilot.py /path/to/mirror.pdf`。默认只打印汇总；可用 `--review-csv /tmp/etyra-review.csv` 在本地新建含页码、原始词行与匹配分类的待审清单，现有文件不会被覆盖。镜像来源和整理内容的再分发权利未核实，该清单只用于本地审核；摘要不符则拒绝运行。下一步逐页核对布局、重名项和复杂项，并通过权威原件确认附录后才可计算正式覆盖率。

## 课标镜像缺口补充候选

上述 293 个未匹配的简单词项行按忽略大小写去重后为 292 个拼写；通过 OEWN 2024 的 `Lemma.writtenForm` 比对，有 274 个拼写找到词典入口。已将这些 OEWN 词头、词条 ID、词性和镜像 PDF 页码写入 [`docs/CURRICULUM_GAP_CANDIDATES.csv`](../../CURRICULUM_GAP_CANDIDATES.csv)，每条仍为 `candidate_only`。其余 18 个拼写尚未匹配到 OEWN，包括代词和部分词形，需要其他来源或词形审核；85 行复杂形式也尚未处理。

这 274 条是以第三方课标镜像探索性比对结果筛选出的 OEWN 词条候选，并非经核验的课标词表或产品词条。表中原始词形取自 OEWN，PDF 页码用于定位线索；相同规范化拼写可能对应不同大小写或词义，专名是否纳入词库仍需审查。其候选 ID 与主清单采用同一规则；按当前拼写键计算，与主清单没有重复，合计 5616 个待审候选键，但不能推断正式词条数或课标覆盖率。词典词项和词性仅作为审核线索，不证明词源关系。

补充候选表取自 Open English WordNet 2024 和 Princeton WordNet，筛选与课标镜像比较后未精确匹配的词头，保留词典标识及页码；适用前述 OEWN/Princeton 许可及署名要求，产品分发前须核对实际使用内容。复现：在有 `pdfplumber` 的 Python 3.11+ 环境中运行 `python3 tools/content/build_curriculum_gap_candidates.py /path/to/mirror.pdf /path/to/english-wordnet-2024.xml.gz /tmp/etyra-gap-candidates.csv`；脚本验证两个输入摘要并拒绝覆盖输出。课标原文及整表没有放入仓库。

### 词典未匹配的 18 个简单词形

2026-11-01 对剩余 18 个拼写查询 English Wiktionary，均找到包含英语章节和相关词性标题的页面，结果写入 [`docs/WIKTIONARY_GAP_CANDIDATES.csv`](../../WIKTIONARY_GAP_CANDIDATES.csv)。其中多为代词或限定词，`chopsticks` 页面包含名词标题；表内记录固定页面修订 ID、该修订时间、英语章节中机器识别到的词性标题及课标镜像页码。机器识别整个英语章节的标题，不代表每个标题的所有义项都适合该词的高中语境；每个词仍须人工选义并核验课标原件。不得把未在 WordNet 找到视为无效单词，也不应强制构造词根关系。

这些页面为 Wiktionary 社群内容，页面修订链接见 CSV；文字复用须核对修订内容的来源、许可、署名、修改标记和适用的 CC BY-SA 4.0 条件，具体参见 `docs/CONTENT_SOURCE_AUDIT.md`。表内只记录词头、词性标题和定位元数据，不收录释义；未来纳入释义或词源前须逐页核查。生成时对 `/tmp` 中的 MediaWiki API 修订内容响应检查了英语章节及标题，脚本为 `tools/content/build_wiktionary_gap_candidates.py`，输入为本地镜像试算 CSV 和 API 修订响应，现有输出不会被覆盖。页面可能变化，正式审校应使用记录的修订 ID。

以规范化拼写计，原始 5342 个候选加 OEWN 补充 274 个、Wiktionary 补充 18 个，共 5634 个不同候选键。数字只代表待审工作量；85 个复杂词形、课标原件一致性、词义、翻译和词源关系仍未完成，也未证明高中必学词已全部覆盖。

### 复杂行的词典候选

对 PDF 镜像中的 85 行复杂形式进行初步拆分：只取斜线、括号和逗号分隔的原样片段，忽略大小写与已有 5634 个候选键比较，得到 84 个尚未出现的片段，其中 74 个与 OEWN 2024 词典词头匹配。结果见 [`docs/COMPLEX_FORM_CANDIDATES.csv`](../../COMPLEX_FORM_CANDIDATES.csv)，表中保留 OEWN 原始词形、词条 ID、词性、是否有大小写完全一致的词形、PDF 页码和待审状态；这不代表原始行的所有词形都已处理。匹配并不证明同义或课标词义一致：例如 `an` 只匹配到大写 `AN`，`are` 找到的 OEWN 名词不能证明课标中的动词形式，`PE` 与 `pe` 的含义也须区别。含缩写、词性变换和短语的行必须逐项核验，不能把表内候选直接导入产品。

剩余 10 个未匹配片段包含 `Wi-Fi`、`app`、`has`、`is`、`o’clock`、`towards` 及若干短语或展开形式；还需独立来源、词形映射和权威课标核验。按键计算，现有四份候选表增加 74 个独立键，但涉及缩写、专名、短语、词形及同形异义，**不能**将其总数当作正式单词量或覆盖率。课标镜像未认证与原始双栏提取尚未逐页核对的限制继续适用。

该表从 OEWN 2024 与 Princeton WordNet 提取词头和词条定位，适用前述许可及署名要求；筛选依据是未认证镜像的复杂行，所有条目仍为 `candidate_only`。复现命令：`python3 tools/content/build_complex_gap_candidates.py /path/to/mirror.pdf /path/to/english-wordnet-2024.xml.gz /tmp/etyra-complex.csv`，需要 `pdfplumber` 和 Python 3.11+；脚本校验两个输入摘要并拒绝覆盖已有文件。切分只是查找线索，不作词形、词义或词源判断。

### 剩余复杂片段的来源线索

2026-11-01 对上节 10 个未匹配片段查询 English Wiktionary：9 个找到含英语章节和相关词性标题的词典页面，记录在 [`docs/COMPLEX_WIKTIONARY_CANDIDATES.csv`](../../COMPLEX_WIKTIONARY_CANDIDATES.csv)，保留镜像片段、实际词条标题、固定修订、词性标题和 PDF 页码。`o’clock` 的查询通过词典重定向到 `o'clock`，两个形式均保留；尚需确认词义与展示形式。`has`、`is` 等可能是已有动词的屈折形式，`due to`、`ought to`、`per cent` 是多词片段，不能仅据候选 ID 把它们认定为独立产品单词。英语章节词性标题可能涵盖多种含义，仍需逐条人工选义。

剩余 `Before the Common Era` 未找到独立的同名词典页面；镜像中它是 `BCE` 的括号展开说明。Wiktionary 的 [BCE 固定修订](https://en.wiktionary.org/w/index.php?title=BCE&oldid=93568235)也列出这一展开形式，现仅作为缩写与展开关系的审查线索，不额外计作独立单词。上述 9 条均为 `candidate_only`；词典修订的来源、许可和署名按本页 Wiktionary 候选要求逐项核查。原始课标镜像、API 响应和完整课标表不包含在仓库中。

复现需固定摘要的课标镜像及包含指定页面修订正文的 MediaWiki API 响应，使用 `python3 tools/content/build_complex_wiktionary_candidates.py /path/to/mirror.pdf /path/to/api-response.json /tmp/etyra-complex-wiktionary.csv`，需要 Python 3.11+ 和 `pdfplumber`；脚本检查镜像摘要、页面英语章节及词性标题，并拒绝覆盖输出。检查不会证明词义、课标真伪或权利。85 行复杂形式仍须逐行对照权威原件和审核词形关系，不能因九个入口已找到就视为全部覆盖。

## 工作顺序与验收口径

1. 获得并核实适用的 2025 版课标附录、实施范围及使用权限，保留基准版本；先处理必修、选择性必修，再处理相关地方增补和常用扩展词。
2. 针对每个课标词项记录原始拼写、词条/变体归并规则、课程类别、来源定位及审核状态；显式保留英美拼写、专名、短语、多词性和同形异义的例外，不把不同来源统计口径混为一谈。
3. 将 NGSL-GR 与课标基准做可复现对照，产出已匹配、候选匹配、缺失、歧义四类清单，并逐项复核；补充课标缺口，再为常见扩展词标明来源和选用理由。
4. 制作不少于 5000 个去重后的正式 `Word` 词条，定义词条计数与拼写变体口径；来源、词性、释义、许可和状态各自可追溯。学习进度稳定 ID 不能依赖外部排名。
5. 词源关系仅在独立证据支持时建立，词条可以没有已证实词根；不靠词形相似推导关系，也不为凑数量把未审核关系写为事实。审核词源时固定来源页面版本并记录依据。
6. 验收应提供最新适用课标逐项覆盖报告、未匹配/歧义清单及处理结论、5000+ 正式词条的去重报告、来源和许可材料，以及真实离线内容包导入和学习流程的证据。当前全部未完成。

## 主候选词表的词源来源定位（进行中）

2026-11-01 查询 English Wiktionary 页面固定修订，主候选清单前 400 项的定位元数据见 [`docs/WIKTIONARY_BULK_SOURCE_INDEX.csv`](../../WIKTIONARY_BULK_SOURCE_INDEX.csv)；这 400 项均检测到英语词源章节标题。其余 4942 项尚未查询：来源服务返回 HTTP 429 后已停止请求，不能把未查询解释为没有来源。此表仅定位页面版本，并不包含或确认词源、词义、词根关系及高中适用性；缺少标题也不等于没有词源。许可与后续文字复用条件见 `docs/CONTENT_SOURCE_AUDIT.md`。

工具 `tools/content/index_vocabulary_etymology.py` 将原始 API 响应分批暂存于仓库外的指定目录，并校验输入清单摘要和批次以支持中断续采；输出只含定位元数据，且拒绝覆盖已有文件。限流时应停止并等待服务允许，遵循其访问政策；续采时使用保留的缓存目录和新输出路径，复核完整性后再更新索引。缓存位于临时目录时可能被系统清理，不作为永久归档。已有缓存可离线复现当前前缀：`python3 tools/content/index_vocabulary_etymology.py /tmp/etyra-wiki-bulk /tmp/etyra-index.csv --cached-only`；页面修订 URL 是持久追溯依据，远端内容可用性无法保证。

## 镜像星号分层试算

对既有未认证镜像的探索性提取结果，仅对简单单词行按去星号、忽略大小写的拼写键分类：无星号行中 1427 行匹配主清单、111 行匹配缺口补充候选；一个星号分别为 437、58 行；两个星号分别为 856、124 行；85 行复杂形式排除。当前没有简单行落入这两类之外。统计单位为提取行而非去重单词，补充候选包括 OEWN 缺口和 Wiktionary 缺口；匹配只是字符串相同，不证明词形、大小写、词义、星号识别或课程等级已核准。复杂行、地区增补、来源真伪和授权仍未解决，不可用作完整覆盖率或正式入库依据。

复现：先按照本文件“2025 镜像整表探索性提取”使用 `compare_curriculum_pilot.py` 生成本地 review CSV，再运行 `python3 tools/content/summarize_curriculum_levels.py /path/to/review.csv`。本次 review CSV 的 SHA-256 为 `d898a899415c2dc1a275d87e20f71f4a2848047dc0c310dfdc15b8f45cb3849a`，脚本校验该值；原 PDF 和提取整表不提交。若提取环境导致输出字节不同，应重新核查输入及结果，而不是直接修改校验值。
