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

[`docs/VOCABULARY_REVIEW_QUEUE.csv`](../../VOCABULARY_REVIEW_QUEUE.csv) 对主清单的 5342 个候选按 ID 汇总现有 OEWN 英文义项数、COW 中文线索数、Kaikki 义项和翻译线索数、OEWN Form 线索数、各类编辑草稿数和部分 Wiktionary 定位状态，供逐项分诊；数据仍是 `candidate_only`。当前每个候选均有英文义项线索、390 个缺少中文线索或编辑草稿、4623 个存在多个英文义项待选择；以上数字反映本仓库已收集的数据，并不保证现有线索正确、适合高中或包含所需的义项。所有项均需课程和许可审核；`not_indexed` 仅表示未纳入此前那批词源页面索引，不代表没有词源资料。数量按义项行统计，不等同正式词条数，COW 对齐、翻译线索和中文草稿均非已验收释义。

复现：`python3 tools/content/build_vocabulary_review_queue.py /tmp/etyra-review-queue.csv`，从当前仓库对应候选表生成，拒绝覆盖输出并检查主要外键及重复 ID。该表只涵盖主清单；补充候选另见下节，不能据此声称全部候选已经审核。

[`docs/SUPPLEMENT_REVIEW_QUEUE.csv`](../../SUPPLEMENT_REVIEW_QUEUE.csv) 对另外 425 个候选 ID 汇总同类审核线索：课标镜像缺口 OEWN 候选 274、Wiktionary 候选 18、复杂形式 OEWN 候选 74、复杂形式 Wiktionary 候选 9、词根关系遗漏候选 11、2020 历史对照候选 39。生成时检查这些 ID 与主清单及彼此不重复；这只是候选 ID 无重复，不代表同义项、屈折词形、大小写及缩写均已正确归并。当前每项均有已提取英文义项线索、85 项无中文线索或编辑草稿、285 项有多个已提取英文义项行；任何线索或草稿均不保证匹配课标、适合教学或已验证。复杂形式队列的 83 个候选是拆分后的词形线索，不对应课标镜像的 85 个原始复杂行。历史来源页码单列，不能误当 2025 镜像页码。

补充队列基于以下来源候选及 OEWN/COW、Wiktionary 元数据整理，许可与对应原表相同；词表镜像未认证，课标适用性和许可均未确认。复现：`python3 tools/content/build_supplement_review_queue.py /tmp/etyra-supplement-queue.csv`，脚本检查来源外键和重复 ID、拒绝覆盖输出。所有记录仍为 `candidate_only`，不应导入产品。

[`docs/CURATED_COMMON_POLYSEMY_PILOT.csv`](../../CURATED_COMMON_POLYSEMY_PILOT.csv) 为 28 个常用多义词选取 57 条 OEWN 2024 英文义项并编写中文及用法草稿；保留候选 ID、来源 sense/synset ID 和英文定义，中文为编辑草稿而非词典原文。每词仅覆盖选定义项，助动词、其他词性与常见用法可能缺失；全部须复核中文、上下文、课程范围及许可，不得直接入库。主审核队列的 `word_drafts` 已纳入该批草稿，数量按义项而非单词计。来源及适用许可同本页 OEWN 说明。

## OEWN 词义候选索引

[`docs/OEWN_CANDIDATE_INDEX.csv`](../../OEWN_CANDIDATE_INDEX.csv) 将 5342 个合并候选的规范化拼写与 [Open English WordNet 2024 发行版](https://github.com/globalwordnet/english-wordnet/releases/tag/2024-edition)的 `Lemma.writtenForm` 以去首尾空格、Unicode casefold 方式比对。5265 个候选至少匹配一个 OEWN 词条，77 个未匹配；每行记录候选 ID、OEWN 词条 ID、词性代码和不同义项 ID 数量，状态仍为 `candidate_only`。小写归并会合并不同大小写含义，例如 `a` 可能匹配 `A`；相同拼写也可能有大量不同词义。匹配结果不能自动选择义项、释义、课标等级或词根，未匹配也不代表不是单词。

对于未匹配词头的 77 个候选，另以同版 OEWN 的显式 `Form.writtenForm` 检查，找到 2 个候选、2 条词形—词典条目线索：`criteria` → `criterion`，`media` → `medium`，见 [`docs/OEWN_FORM_CANDIDATES.csv`](../../OEWN_FORM_CANDIDATES.csv)。结果只记录词典给出的词形关联，大小写、词性、具体义项和中文翻译仍需审核；例如 `media` 的常见用法不能直接套用 `medium` 的任一义项。其余 75 个候选没有找到精确匹配的显式 Form；其中有大量介词、连词和代词，不能据此认定无效或没有释义。此处没有合并候选 ID，也未自动生成词根关系。

复现：`python3 tools/content/index_oewn_form_candidates.py /path/to/english-wordnet-2024.xml.gz /tmp/etyra-oewn-forms.csv`，脚本校验与此前 OEWN 索引相同的归档摘要并拒绝覆盖输出。OEWN 词条来源及许可要求见下文，任何释义或翻译入库前须独立审核。

### 补充虚词的英文义项线索

2026-11-01 获取 [Kaikki English](https://kaikki.org/dictionary/English/index.html) 的五份按词性分类的 Wiktextract 后处理数据，以忽略大小写的拼写键匹配上述 77 个 OEWN 词头未命中候选，提取有英文 gloss 的义项至 [`docs/KAIKKI_FUNCTION_SENSE_CANDIDATES.csv`](../../KAIKKI_FUNCTION_SENSE_CANDIDATES.csv)：64 个候选、450 条义项，包括介词 202、代词 116、连词 90、限定词 28、冠词 14 条。保留来源拼写、词性、来源 sense ID、英文 gloss、标签和对应 Wiktionary 页面；未提取例句、发音、中文翻译或词源。结果是未经人工审校的全部匹配义项，不代表高中语境、现代常用义、中文释义或关系已核实。词典可能包含古旧、地区和变体义项，必须连同标签和原始页面检查；忽略大小写也可能错误关联。

剩余 13 个未获本批候选的词是 `café`、`could`、`criteria`、`founded`、`goods`、`hey`、`media`、`multi`、`shall`、`should`、`trans`、`whereby`、`would`；这里只检查五种词性，不表示原词典缺少这些词或该词没有其他词性，前述 `criteria`、`media` 已有 OEWN Form 线索。

来源文件依次为 [article](https://kaikki.org/dictionary/English/pos-article/kaikki.org-dictionary-English-by-pos-article.jsonl.gz)、[conj](https://kaikki.org/dictionary/English/pos-conj/kaikki.org-dictionary-English-by-pos-conj.jsonl.gz)、[det](https://kaikki.org/dictionary/English/pos-det/kaikki.org-dictionary-English-by-pos-det.jsonl.gz)、[prep](https://kaikki.org/dictionary/English/pos-prep/kaikki.org-dictionary-English-by-pos-prep.jsonl.gz)、[pron](https://kaikki.org/dictionary/English/pos-pron/kaikki.org-dictionary-English-by-pos-pron.jsonl.gz)；快照 SHA-256 分别为 `d42ba9fce9ec018bdc606dd1948eb2d4ce7209af5205967f60188ff758a54d92`、`90417a911907ff580f588c7a41846647fc055c930ead96638cb40bb00a29fe11`、`1950b79784a27d931e62bddabe7a5111d86df57af72a22bc3a0b2fc77b9b8a1b`、`a995558554ea0b3e59003925f6aa8ea8a50089da05d3bfff0daaab2f266dddc6`、`38d5dcad952274fa2d3284cb0580f25fdea461007e76980e362dbea475ca9ac2`。站点文件会更新，这些固定摘要是本次依据，源文件未提交仓库。复现：将上述文件分别命名 `etyra-kaikki-词性.jsonl.gz` 并放入同一目录，执行 `python3 tools/content/extract_kaikki_function_candidates.py /path/to/directory /tmp/etyra-function-senses.csv`；脚本检查全部摘要并拒绝覆盖已有输出。

来源为 Wiktionary contributors 经 Tatu Ylonen 的 Wiktextract/Kaikki 处理的数据；本表筛选候选并保留原始 gloss 与标签，是其改编。Kaikki [许可说明](https://kaikki.org/dictionary/index.html)指出数据依据 Wiktionary 的 CC BY-SA 与 GFDL 许可发布；使用须遵守 [Wiktionary 版权和署名条款](https://en.wiktionary.org/wiki/Wiktionary:Copyrights)、[CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) 及所选许可的适用要求，保留页面及其历史、版权归属、许可链接和修改说明。Kaikki 后处理还可能合并其他来源；最终分发前应逐项确认附加来源和许可，不能仅凭本表标记内容可用于产品。学术引用参见 Tatu Ylonen, *Wiktextract: Wiktionary as Machine-Readable Structured Data* (LREC 2022)。

[`docs/CURATED_FUNCTION_WORD_PILOT.csv`](../../CURATED_FUNCTION_WORD_PILOT.csv) 从上述候选及 `he` 补充来源中选取 28 条常用义项，附上编辑编写的中文释义草稿和用法范围；每条保留原始英文 gloss、sense ID 和来源页面。中文文字是编辑草稿，不是来源词典提供或人工专家验收的译文；选义、中文表达、课标适用性及来源许可均须复核后才可用于产品。所选义项不能当作该词全部用法。

对 27 个缺少 OEWN 义项的补充候选，以相同 Kaikki 五类词性快照及忽略大小写的精确拼写匹配，另提取 [`docs/KAIKKI_SUPPLEMENT_SENSE_CANDIDATES.csv`](../../KAIKKI_SUPPLEMENT_SENSE_CANDIDATES.csv)：20 个候选、96 条英文义项。`chopsticks`、`has`、`app`、`per cent`、`o’clock`、`wi-fi`、`ought to` 未在这五类中得到精确匹配的 gloss，并不代表词典无对应条目；例如 `o’clock` 的弯引号与来源词形 `o'clock` 不同，未自动归并。来源、改编和许可条件同上，全部待审。复现：使用上述相同的固定快照目录运行 `python3 tools/content/extract_kaikki_function_candidates.py /path/to/directory /tmp/etyra-supplement-function.csv --supplement`。

上述最后 7 个候选随后从 Kaikki 各单词的 JSONL 文件获取 24 条英文义项线索，见 [`docs/KAIKKI_COMPLEX_SENSE_CANDIDATES.csv`](../../KAIKKI_COMPLEX_SENSE_CANDIDATES.csv)。其中 `o’clock` → `o'clock` 和 `wi-fi` → `Wi-Fi` 使用此前候选表明确记录的页面标题，而不是通用拼写归并规则；`chopsticks`、`has` 的词形义、`per cent`、`ought to` 的短语及 `app`、`Wi-Fi` 的大小写和不同义项仍待编辑核验。`chopsticks` 的 plural-of 行本身不是筷子的完整释义，应结合其词头条目查验。

七个来源页为 [app](https://kaikki.org/dictionary/English/meaning/a/ap/app.html)、[chopsticks](https://kaikki.org/dictionary/English/meaning/c/ch/chopsticks.html)、[has](https://kaikki.org/dictionary/English/meaning/h/ha/has.html)、[per cent](https://kaikki.org/dictionary/English/meaning/p/pe/per%20cent.html)、[o'clock](https://kaikki.org/dictionary/English/meaning/o/o%27/o%27clock.html)、[Wi-Fi](https://kaikki.org/dictionary/English/meaning/W/Wi/Wi-Fi.html)、[ought to](https://kaikki.org/dictionary/English/meaning/o/ou/ought%20to.html)。每份数据的固定摘要及编号见 `tools/content/extract_kaikki_supplement_words.py` 的 `SNAPSHOTS`；保留原文件于仓库外，并以 `python3 tools/content/extract_kaikki_supplement_words.py /path/to/numbered-snapshots /tmp/etyra-complex-senses.csv` 复现。来源页面及快照可能更新，以上仍是候选，不是释义审定；适用前述 Wiktionary/Kaikki 来源和许可条件。

[`docs/CURATED_SUPPLEMENT_FUNCTION_PILOT.csv`](../../CURATED_SUPPLEMENT_FUNCTION_PILOT.csv) 从补充候选中选出 15 个词的 17 条义项并编写中文及用法草稿，保留原始 gloss、词性、sense ID 和页面；这些是待复核的编辑草稿，不代表包含该词所有用法，也不能当作课标词义或正式译文。后续须复核代词的指代范围、单复数、语境和许可。

来源数据的 sense ID 并非总能唯一标识义项：本批 `en-of-en-prep-en:possession1` 对应两个不同 gloss。检索或引用时须同时核对词头、词性和原始 gloss，不能单靠 sense ID 合并或覆盖记录；当前 28 条编辑草稿均未使用该重复 ID。

从上述已固定的五种词性和 20 个单词 JSONL 快照提取简体/繁体中文及普通话翻译线索，形成 [`docs/KAIKKI_TRANSLATION_CANDIDATES.csv`](../../KAIKKI_TRANSLATION_CANDIDATES.csv)：33 个候选共 118 行，保留原文、来源词性、来源提供的义项说明和快照编号。该表可能包含繁简并列写法、专用或地区用法，原文不自动拆分；来源 `sense` 字段只是翻译框标签，不是已验证的 sense ID，绝不能自动将翻译与任一英文义项配对。译文、来源和许可均须逐条复核。数据来源、署名和许可适用本节 Wiktionary/Kaikki 条件。复现：`python3 tools/content/extract_kaikki_translation_candidates.py /path/to/pos-snapshots /path/to/main-snapshots /path/to/supplement-snapshots /tmp/etyra-translations.csv`；脚本校验此前各节记录的全部快照摘要，拒绝覆盖输出。

从主清单中无中文线索且未认证课标镜像带星号的候选，分批获取 53 个单词页面快照，见 [`docs/KAIKKI_CHINESE_GAP_SNAPSHOTS.csv`](../../KAIKKI_CHINESE_GAP_SNAPSHOTS.csv)，以原始文件摘要锁定本次结果；其中 47 个词找到 138 条中文翻译线索，见 [`docs/KAIKKI_CHINESE_GAP_TRANSLATIONS.csv`](../../KAIKKI_CHINESE_GAP_TRANSLATIONS.csv)。`bacteria`、`beneath`、`elsewhere`、`evolve`、`respective`、`statistic` 的本次页面快照未提取到中文翻译；这不证明没有可用译文。此结果只覆盖镜像简单行匹配到的候选，不证明课标覆盖。翻译表保留原始繁简及翻译框标签，不自动选义；课标版本、译文、许可和来源均须复核。

针对上述 6 个快照未提供中文翻译的词，[`docs/CURATED_UNTRANSLATED_PILOT.csv`](../../CURATED_UNTRANSLATED_PILOT.csv) 依据对应固定英文 gloss 编写中文释义和用法草稿；中文不是来源词典提供的译文，也未经过专家验收，词义对应、中文表达、词形归并及许可仍须复核。例如 `bacteria` 的所选来源义为 `bacterium` 的复数形式，不能在未确定产品词形策略时自动合并学习记录。

复现：按快照清单的 URL 下载并将每份文件命名为 `candidate_id.jsonl`，运行 `python3 tools/content/extract_kaikki_gap_translations.py /path/to/snapshots /tmp/etyra-gap-translations.csv`；脚本核验文件摘要、词条及候选 ID，拒绝覆盖输出。源数据及译文使用适用前述 Wiktionary/Kaikki 署名及许可条件，快照原文不提交仓库。

另从缺少中文线索的候选按 NGSL 原始 `WordID` 顺序选取 30 项进行查询；此前说明仍适用，`WordID` 不视为已验证的频率排名。分批完成 30 个页面，其中 26 个提供 154 条中文翻译线索；`might`、`else`、`itself`、`upon` 的快照未提取到中文，不代表没有对应译文。快照摘要及来源见 [`docs/KAIKKI_COMMON_GAP_SNAPSHOTS.csv`](../../KAIKKI_COMMON_GAP_SNAPSHOTS.csv)，线索见 [`docs/KAIKKI_COMMON_GAP_TRANSLATIONS.csv`](../../KAIKKI_COMMON_GAP_TRANSLATIONS.csv)。词性、具体义项与翻译框标签必须逐条复核，不能自动视为正式释义。使用相同的词项文件命名方式运行 `python3 tools/content/extract_kaikki_gap_translations.py /path/to/snapshots /tmp/etyra-common-translations.csv --manifest KAIKKI_COMMON_GAP_SNAPSHOTS.csv` 可复现，来源和许可适用本节 Wiktionary/Kaikki 条件。

[`docs/CURATED_COMMON_GAP_PILOT.csv`](../../CURATED_COMMON_GAP_PILOT.csv) 为这 30 个候选各选一条英文常用义项并编写中文草稿；其中 24 条同时记录翻译框线索，`the`、`might`、`away`、`else`、`itself`、`upon` 的选定义项由编辑依据英文义项编写中文，不能把其他词性的翻译当作该义项来源。`upon` 的所选来源仅指出它在部分用法中可替代 `on`，具体搭配须再核对。标注为中文的原始翻译线索中还出现非汉字文本（如 `how` 的 `за`），说明来源语言标签需校验，不能仅凭标签自动采用。所有草稿、翻译、词性和许可均待复核。

[`docs/CURATED_GAP_TRANSLATION_PILOT.csv`](../../CURATED_GAP_TRANSLATION_PILOT.csv) 对 45 个候选分别选择一条英文 gloss 和含对应语境说明的中文翻译线索，记录编辑中文草稿及用法范围。选择关联是编辑判断而不是来源提供的 sense ID，仍须复核所选语义、中文措辞、课标及许可；每词只覆盖所选义项。来源单词 JSONL 无可用 sense ID 时保留原 gloss 和标签定位，不能据此生成词根关联。`somehow`、`prior` 的已有中文线索与候选义项存在词义或词性细节差异，暂不加入草稿，须进一步核对。

此前未找到英文 gloss 的 13 个主候选现从 Kaikki 单词页固定快照取得 101 条义项线索，见 [`docs/KAIKKI_MAIN_GAP_SENSE_CANDIDATES.csv`](../../KAIKKI_MAIN_GAP_SENSE_CANDIDATES.csv)。其中 `criteria`、`founded` 等包含词形义，应回到原形及所需语境核对；`multi` 和 `trans` 的单词页面所含词性不等同词缀 `multi-` 和 `trans-`，不能据此为词缀生成释义或词根关系。数据保留词性、标签、英文 gloss、源页面和 sense ID，未收例句；所有义项未审校。适用上述 Kaikki/Wiktionary 来源、署名及许可条件。各单词快照的顺序和 SHA-256 记录在 `tools/content/extract_kaikki_main_gap_words.py`；将快照按 0–12 命名放入目录后，运行 `python3 tools/content/extract_kaikki_main_gap_words.py /path/to/snapshots /tmp/etyra-main-gap-senses.csv` 可复现，源文件不提交仓库。

[`docs/CURATED_MAIN_GAP_PILOT.csv`](../../CURATED_MAIN_GAP_PILOT.csv) 从单词页来源选出 15 个词的 19 条常用义项，附编辑编写的中文和用法草稿。原始单词页 JSONL 中这些义项的 sense ID 为空，故按候选 ID、词性、原始 gloss 和标签共同定位，未虚构来源 ID；选义、译文和许可仍须复核，不能将草稿用于正式词库。新增 `while` 的时间与让步连词义，参考 [Kaikki 页面](https://kaikki.org/dictionary/English/meaning/w/wh/while.html)及 [Cambridge 语法说明](https://dictionary.cambridge.org/grammar/british-grammar/while-and-whilst)；2026-11-07 获取的 `while.jsonl` SHA-256 为 `f4e4a89a7a3f9ce1bda5c69292605a74dd86c6b5dc323c0fec8ede3347c6e65d`，原始快照未提交，词性与原始释义需共同定位。该草稿独立于 OEWN 名词义，不把时间、让步和对比用法混为一义；来源许可按本页 Kaikki/Wiktionary 条件复核，Cambridge 仅作参考。

2026-11-07 另用 Kaikki 单词页为 `why`、`perhaps`、`maybe`、`anywhere` 补充常见副词草稿，避免将 OEWN 中的名词义或“偶然”义误当完整用法。依次下载的 [why](https://kaikki.org/dictionary/English/meaning/w/wh/why.jsonl)、[perhaps](https://kaikki.org/dictionary/English/meaning/p/pe/perhaps.jsonl)、[maybe](https://kaikki.org/dictionary/English/meaning/m/ma/maybe.jsonl)、[anywhere](https://kaikki.org/dictionary/English/meaning/a/an/anywhere.jsonl) JSONL SHA-256 分别为 `a1b285488e6740f4838ad2149938604754694aabb62e641d9d5bba87f1622052`、`d940ddf2fc86fc283ba36f22d7790ecb6773c93f11358ccca77fa5b81d7c42c4`、`2b2d130f1ffb1c1b6c91b3d575c65a37af56ecd8bc64be4c52668c18ad227465`、`fb02e43b0fdf6e3bc19d87eafd307a158d64030aa58f045c024fca8a06705d89`；快照未提交，数据可能更新。所选行均无 sense ID，按词性、原始 gloss 与标签定位；中文为编辑草稿，其他词性、语境、课标及许可均待审核。

另补 `website` 和 `poem` 的独立名词草稿：OEWN 对前者的定义将网站描述为计算机，后者定义涉及格律，均不宜直接当作完整常用义。以 Kaikki 数据提供另一条线索，并参考 [MDN 对网站与服务器的区分](https://developer.mozilla.org/en-US/docs/Learn_web_development/Getting_started/Environment_setup/Browsing_the_web)。2026-11-07 下载的 [website](https://kaikki.org/dictionary/English/meaning/w/we/website.jsonl) 与 [poem](https://kaikki.org/dictionary/English/meaning/p/po/poem.jsonl) JSONL SHA-256 分别为 `903dc849d8ec1a5ab34a04f18432dfc06eb60e3d69913a49b9cd49c857867517`、`fb76493805eb6622ed60d1274b63b69dd108990c8d78b24d52cd478edfb19c21`；快照未提交且可能更新。选取的名词义无 sense ID，须按词性、gloss 和标签共同定位；网站可涉及多个服务器，不能把 Kaikki 对常见部署的表述视为必要条件。译文、词义、许可和课标适用性仍待复核。

本索引基于 Open English WordNet 2024 和 Princeton WordNet 改编：提取词条标识、词性与义项数量，关联 Etyra 候选拼写，不含 OEWN 释义正文。OEWN 团队与 Princeton WordNet 均须署名；OEWN 为 CC BY 4.0，底层 Princeton WordNet 条款及免责声明同时适用。保留发布版本的原始 [OEWN 许可](OEWN-2024-LICENSE.md) 和 [WordNet 条款](OEWN-2024-WNDB-license.txt)。合并候选本身还受上节所述 CC BY-SA 4.0 条件约束；内容与应用代码分别管理。

输入文件为发行版 XML gzip，下载地址 `https://github.com/globalwordnet/english-wordnet/releases/download/2024-edition/english-wordnet-2024.xml.gz`，SHA-256 `e1f633b0a93758cae34ea27c44c4dad310a8af2467b155f99dd6673af697e875`。运行 `python3 tools/content/index_oewn_candidates.py /path/to/english-wordnet-2024.xml.gz /tmp/etyra-oewn-index.csv` 可复现；脚本校验摘要且拒绝覆盖输出，需要 Python 3.11 及以上。原始词典体积较大，未放入项目；后续正式内容包须再次保留适用许可和署名。

[`docs/OEWN_SENSE_CANDIDATES.csv`](../../OEWN_SENSE_CANDIDATES.csv) 是同一固定版本进一步提取的英文释义审核材料：5265 个候选词关联 28696 行 OEWN 义项。每行保留候选 ID、OEWN 原始拼写、词条 ID、词性、义项 ID、同义词集 ID、原始英文定义的 JSON 数组和 `candidate_only` 状态；不包含例句或中文释义。该表保留多义词的全部匹配义项和不同大小写的原始词形；排序仅用于稳定生成，不能作为常用程度或默认释义排序。审核须选择合适义项并区分词性、大小写和语境；OEWN 不用于证明词源。

本表根据 OEWN 2024 与 Princeton WordNet 的定义内容改编：按候选拼写筛选并关联候选 ID，保留原定义及出处；使用范围须遵守上一节的 OEWN、Princeton WordNet 与候选词表许可和署名要求。复现命令：`python3 tools/content/extract_oewn_sense_candidates.py /path/to/english-wordnet-2024.xml.gz /tmp/etyra-oewn-senses.csv`。脚本校验源文件摘要、词项/义项标识和同义词集定义完整性，并拒绝覆盖已有文件。

[`docs/SINGLE_OEWN_REVIEW_BATCH.csv`](../../SINGLE_OEWN_REVIEW_BATCH.csv) 汇总主候选中现有 OEWN 索引仅有一条义项且存在一条 COW 对照记录的 521 个候选，保留英文定义、中文词项数组、词性、源义项、CILI 与 synset；其中 109 项的中文数组只有一个词项。该批只是审核工作表：一个 OEWN 义项或一个中文选项均不证明单词只有一种含义或中文准确，例如 `while` 的 OEWN 线索为名词，不能因此忽视常用连词义。中文项未自动选定，全部仍为 `candidate_only`。词典来源、许可和署名分别同本页 OEWN、Princeton WordNet 和下文 COW 说明；本表对这些内容做筛选与关联，不含课标结论或词源判断。复现：`python3 tools/content/build_single_oewn_review_batch.py /tmp/etyra-single-oewn.csv`，脚本验证来源记录之间的 ID/词性/词形并拒绝覆盖已有文件。

从该批次人工选取 230 个词形成 [`CURATED_SINGLE_OEWN_PILOT.csv`](../../CURATED_SINGLE_OEWN_PILOT.csv) 初步草稿，分别记录 OEWN 义项、CILI、COW 中文词项及编辑语境说明；主审核队列计入相应 `word_drafts`。选择只覆盖所记义项，不证明其他词性或常用义不存在；例如 `download` 的 OEWN 定义可能不涵盖全部现代使用场景，化学元素与其单质或化合物也须区分。`wildlife` 的已选英文义项涉及未驯养的生物，中文草稿选“野生生物”而非只限动物；`salary` 所引英文定义较宽，中文选义须进一步复核。`while` 选名词义，不覆盖常用连词义；`detect` 所引义项仅涉及视觉发现。`classmate` 的 OEWN 定义未明确“同班”，2026-11-07 参考 [Cambridge Dictionary](https://dictionary.cambridge.org/dictionary/english/classmate) 确认存在同班用法；该站仅作独立参考，不复制其定义，也不代表 OEWN/COW 对齐和其他语境已完成复核。部分新选词以未认证 2025 镜像试算作排序线索，不能据此确认课标归属。草稿、中文及语境仍须复核课程范围、来源许可与词源，不能直接导入正式词库。

针对 `salary` 的宽泛 OEWN 义项，另以 [Kaikki 单词数据](https://kaikki.org/dictionary/English/meaning/s/sa/salary.html)的名词义及 [Cambridge Dictionary 条目](https://dictionary.cambridge.org/dictionary/english/salary)交叉核对常见用法，建立 [`CURATED_SALARY_KAIKKI_PILOT.csv`](../../CURATED_SALARY_KAIKKI_PILOT.csv) 的独立编辑草稿；不覆盖原 OEWN/COW 线索。2026-11-07 获取的 Kaikki 单词 JSONL SHA-256 为 `f332e27d4481c85cb61556fb880573a2aad9aadb9a96010769fdf41636d8ddaa`，记录的名词义未提供 sense ID，须以该快照及词性、释义联合定位；原始快照未纳入仓库，来源可能更新。Kaikki/Wiktionary 来源和许可义务同本页相应章节；Cambridge 页面仅作参考，不复制其受版权保护的定义。两份草稿仍需语义、许可与课标适用性审查。

## 中文词义候选：Chinese Open Wordnet

[`docs/COW_SENSE_CANDIDATES.csv`](../../COW_SENSE_CANDIDATES.csv) 以已保存的 OEWN 英文义项为基础，通过英文与中文词网各自明确给出的 CILI 标识连接 [Chinese Open Wordnet 1.1](https://bond-lab.github.io/cow/) 词义集合，提取该集合的中文词项。得到 15135 行候选义项，涉及 4819 个英文候选键。每行保留 OEWN 词条原始大小写、词性、sense/synset ID、CILI、COW synset ID 和中文词项数组；没有提取拼音或例句。一个义项可能对应多个中文表达，排列不代表优先级。

同一个 CILI 标识是跨词网的关联线索，不保证两种语言用法、搭配或语域完全一致。COW 发布方说明其内容仍可能有错误；COW 1.1 也包含经过模型辅助筛查的数据，不能视作逐项人工认证。该表全部为 `candidate_only`，选义、简体展示、词性、中文表达和高中适用性必须审核；部分不适合直译，部分候选词没有对应项。OEWN 本身没有词源证据，不能从此表推导词根关系。

大小写审计发现 62 个候选至少一条 COW 线索来自大小写不同的 OEWN 词形，其中 6 个的线索全部如此；83 条大小写不一致的义项行及对应候选汇总在 [`docs/COW_CASE_REVIEW.csv`](../../COW_CASE_REVIEW.csv)，主审核队列标为 `cow_case_mismatch_review_needed`。其中 `he` 关联的 `He` 是化学元素氦，不是常用主格代词；`a` 的大写 `A` 可表示字母或单位，也不能直接当作冠词释义。`in`/`In`、`as`/`As`、`at`/`At` 等还可能涉及化学元素。`Hell`、`Scripture`、`Reconstruction` 的专有含义，以及 `TRUE`/`FALSE` 与小写形式的关系也须按语境检查；大小写差异本身不证明每条线索错误。复现：`python3 tools/content/audit_cow_case_mismatches.py /tmp/etyra-cow-case-review.csv`。

为补齐 `he` 的代词线索，使用此前固定的 Kaikki 五类词性快照额外提取 [`docs/KAIKKI_HE_SENSE_CANDIDATES.csv`](../../KAIKKI_HE_SENSE_CANDIDATES.csv)；保留原词形、标签和所有匹配义项，并在虚词草稿中加入一条有来源的主格代词义。大小写归并可能同时匹配其他形式，具体词义、标签、翻译及许可仍须审核。复现：`python3 tools/content/extract_kaikki_function_candidates.py /path/to/snapshots /tmp/etyra-he-senses.csv --headword he`。

另外从同一固定快照为高频 `a`、`I`、`in`、`at`、`as`、`it`、`or` 获取 [`docs/KAIKKI_COMMON_CASE_SENSE_CANDIDATES.csv`](../../KAIKKI_COMMON_CASE_SENSE_CANDIDATES.csv) 中 112 条词性线索，以便与 OEWN 中可能出现的字母、化学元素或缩写义区分；不自动选义，大小写、词性、语境和来源许可仍须逐条核验。主队列额外标记 `function_word_sense_review_needed`。复现：`python3 tools/content/extract_kaikki_function_candidates.py /path/to/snapshots /tmp/etyra-common-case.csv --headword a --headword I --headword in --headword at --headword as --headword it --headword or`。

[`docs/CURATED_COMMON_FUNCTION_PILOT.csv`](../../CURATED_COMMON_FUNCTION_PILOT.csv) 从上述 7 个词中各选一条常用义项，附编辑中文及用法草稿，保留原词形、词性、来源 gloss 和标签。选择与翻译均待复核，其他义项未覆盖；例如不定冠词 `a` 在中文语境中并不总需译出。不得将这些草稿直接作为正式词库。

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
- [上海外国语大学中国外语战略研究中心的文章信息](https://infadm.shisu.edu.cn/_s60/22/46/c17661a205382/page.psp)独立列明梅德明、王蔷为普通高中英语课程标准修订组成员，并给出两人 2025 年第 12 期《基础教育课程》解读文章的期刊、页码及摘要。这可核对解读文章的作者和出处；该页面是摘要信息，不含课标附录原表，不能证明第三方 PDF 与权威原件一致或授予词表再分发权利。
- 2026-11-07 补充两份独立研究线索：[《当代外语研究》2026 年第 3 期论文](https://www.qk.sjtu.edu.cn/cfls/CN/10.3969/j.issn.1674-8921.2026.03.009)讨论 2025 年版词汇调整并举例；[《中小学外语教学》2026 年第 7 期目录摘要](https://flts.bnu.edu.cn/node/17157)介绍了对两版词汇增删及等级调整的研究。按前者表中 37 个示例逐个做小写精确文本核对，25 个在主候选、12 个在补充候选，例如 `perspective` 在主表，`empathy`、`drone` 在补充表。这是研究示例与候选拼写的交叉定位，不能证明词义、完整覆盖或正式课标归属，研究文章也不能取代原始附录及再分发许可。页面搜索索引显示表格，直接访问期刊页面时发生超时；需在正式审校前复核完整论文和原始附录。
- 2026-11-01 找到一份[题为 2025 年修订版的第三方 PDF 镜像](https://forum.freemdict.com/uploads/short-url/doVmJXenSoIbcg8t5HA0hkWcccm.pdf)，附录 2 标注从印刷页 73 开始，包含星号等级。该次下载文件 SHA-256 为 `4d2d0f33e511dc0d239d2cdc53fe16f38a107afde9bd1ae557cec9ce7bb1bba0`；仅供研究定位，出版来源、内容完整性、与权威原件一致性和使用许可均尚未核实，不能用作最终覆盖验收。镜像文件未提交仓库。
- 2026-11-07 从[安康学院外语学院同名课程资源页面](https://dfl.aku.edu.cn/info/1565/10089.htm)的页面源码中定位并下载其[嵌入 PDF](https://dfl.aku.edu.cn/__local/7/7E/8F/0D793808E59C18DC89FA5F169D6_3803EAF5_3CB621.pdf)，文件为 3,978,785 字节，SHA-256 同为 `4d2d0f33e511dc0d239d2cdc53fe16f38a107afde9bd1ae557cec9ce7bb1bba0`，与前述论坛镜像逐字节一致；同一提取脚本复现相同统计。高校页面增加了来源佐证，但两处相同文件不证明转载链独立、PDF 与教育部原件一致、全文完整或有权再分发；仍需获取权威原件和确认许可，不能将此结果作为最终验收。文件仅保存在本地临时目录，不提交仓库。
- 另找到[木里藏族自治县中学网站上的同名 PDF 索引](https://www.scmlzx.net/uploadfile/2025/1110/%EF%BC%884%EF%BC%89%E6%99%AE%E9%80%9A%E9%AB%98%E4%B8%AD%E8%8B%B1%E8%AF%AD%E8%AF%BE%E7%A8%8B%E6%A0%87%E5%87%86%E6%97%A5%E5%B8%B8%E4%BF%AE%E8%AE%A2%E7%89%88%EF%BC%882017%E5%B9%B4%E7%89%882025%E5%B9%B4%E4%BF%AE%E8%AE%A2%EF%BC%89.pdf)。2026-11-01 搜索缓存可读，其附录开头的 `abnormal**`、`accommodation**`、`addict*` 与此前镜像相同；但直接下载返回 404，无法比较完整文件摘要，也不能判断二者是否独立来源或与官方原件完全一致。它是辅助核验线索，不改变此前镜像未认证、许可未决的状态。
- 上述学校网站的缓存文本将词汇表描述为共 3100 词：含义务教育阶段 1600 词、高中必修新增 500 词（一个星号）、选择性必修新增 1000 词（两个星号），地方可另增 200 词；采用英式拼写，其他常见拼写加注，且词表不提供词性或中文释义。此信息仅作为设计课程等级字段及后续核验的依据，不意味着已完成词项抽取或覆盖；学校缓存不是教育部发布渠道，最终以可验证的权威原件和当地实施要求为准。
- 初步比较发现[第三方整理页面](https://wangjunjian.com/posts/2026-06-07-general-high-school-vocabulary-2025/)虽然自称完整课标表，但与上述 PDF 镜像开头的词项有明显差异：镜像列有 `accommodation**`、`addict*`，整理页开头列为 `addicted` 且全文文本搜索未找到 `accommodation`；整理页还列出 `abortion`，镜像相应字母顺序区域未见该项。两者都不是已认证原件，这些差异只说明整理页不宜直接作为完整课标依据；网页中文释义亦非课标原文释义。进一步比对时须保留原页与原始词形、等级及审核结论。
- [新乡工程学院外国语学院页面](https://www.xxgc.edu.cn/fll/info/1061/5288.htm)列出题为 2025 修订版的 PDF 附件，但当前下载要求验证码，附件内容及与正式版本的一致性尚未核验；可作为后续寻找可靠原文的线索。
- 课标原文和整表的再分发许可尚未确认。当前仅记录来源链接和事实，不将课标全文或其整表复制入仓库/产品。必要时取得有权使用的版本或许可，再固定来源版本、页码、文件摘要和覆盖对照。

2026-11-08 补充可追溯核验入口（尚未取得并核验完整正文）：

- [高等教育出版社图书信息](https://xuanshu.hep.com.cn/front/h5Mobile/bookDetails?bookId=6a5a6320e119ac972986fa53)：《普通高中英语课程标准日常修订版（2017年版2025年修订）解读》，课程教材研究所组织编写，梅德明、王蔷主编，2026 年 9 月，ISBN 978-7-04-067986-1。出版社页面说明课标修订组核心成员参与编写；该书是解读而非课标原文，目录未能证明包含完整词汇附录，也不意味着授予数据再分发许可。
- [《中小学外语教学》2026 年第 7 期目录及摘要](https://flts.bnu.edu.cn/node/17157)：王生军《2025年版普通高中英语课标词汇变动研究》，第 13–19 页，研究 2020 与 2025 年版词汇增删及调级。当前仅检索到编辑部目录和摘要，尚未核查全文、逐词对照、方法或许可，不能用摘要替代课标或判定某个词的课程等级。

对两版简单拼写试算中的 200 个星号差异，Codex 已按 PDF 原页进行视觉对照，记录在 [`docs/CURRICULUM_STAR_VISUAL_REVIEW.csv`](../../CURRICULUM_STAR_VISUAL_REVIEW.csv)：2020 官方 PDF 与未认证 2025 镜像对应原页上的标记（页码逐行见表）与提取结果一致。记录保留候选 ID、各页面和文件 SHA-256，状态仍为 `candidate_only`；不复制原词表。此检查只证明两个指定文件中这 200 行的视觉标记，不证明 2025 镜像真伪、实施范围、正式课程等级或许可。其余 64 个差异未在该批逐页核对，全部差异仍须用权威原文复核。

### 2020 版历史对照补充候选

2026-11-07 从上列课程教材研究所地址取得 2020 版 PDF，SHA-256 `8ebd6bb12e9eb1c58e422ee01b540a4a71d2e681a4c4a764a36ee3a34b21c1be`。试验按 PDF 页 129–184 的两栏坐标提取，去除说明与国家名称附表后得到 3000 行：2925 行为简单字母词形（2920 个忽略大小写的不同拼写），75 行含其他形式。简单行中 2635 行与主表、251 行与补充表精确匹配，39 行未匹配。抽看过 PDF 第 130 页，但其余页、列边界、星号、同形异义和复杂行尚未逐页审核；即使总行数恰好为 3000，也不能据此认定提取完整或用作正式覆盖率。2020 年历史版本不能替代 2025 年版或地方实施要求。

以既有主表与原 386 项补充候选排除已出现拼写后，按忽略大小写匹配 OEWN 2024 的 `Lemma.writtenForm`，39 个历史缺口均有词典词头候选，且每项均包含与原提取大小写一致的 OEWN 拼写。结果见 [`docs/HISTORICAL_2020_GAP_CANDIDATES.csv`](../../HISTORICAL_2020_GAP_CANDIDATES.csv)：只保存 OEWN 词头、词典 ID、词性及历史页码，不保存课标整表；全部为 `candidate_only`。其中包含国家、国籍、序数词和变形等，不能由相同拼写推定词义或自动并入正式词库。39 项现已纳入补充审核队列，且不代表 2025 版增删情况。OEWN/Princeton 的许可与署名义务见本页上文；课标附录再分发权限仍须核实。

从同一 OEWN 固定版本提取这 39 个候选的 110 条英文定义线索，见 [`docs/OEWN_HISTORICAL_2020_SENSE_CANDIDATES.csv`](../../OEWN_HISTORICAL_2020_SENSE_CANDIDATES.csv)；各行保留词头、词性、义项及 synset，全部待审核，不能把多义项数量当单词数量。复现：`python3 tools/content/extract_oewn_sense_candidates.py /path/to/english-wordnet-2024.xml.gz /tmp/etyra-2020-senses.csv --candidate-file docs/HISTORICAL_2020_GAP_CANDIDATES.csv`。

将这 110 条英文义项按 CILI 与已固定版本 COW 1.1 对照，得到 [`docs/COW_HISTORICAL_2020_SENSE_CANDIDATES.csv`](../../COW_HISTORICAL_2020_SENSE_CANDIDATES.csv) 中 82 条中文词项线索，涉及 36 个候选；`humorous`、`London`、`Olympics` 在本次对照中未找到中文词项，并不代表词典中无适当译法。CILI 对齐不是翻译验收，例如 `Indian` 的现有线索涉及不同含义，国籍、族群与语言必须按源义项和语境区分；大小写、专名和词性也须独立审核。来源、许可与复现条件同本页 COW 章节，命令：`python3 tools/content/align_cow_sense_candidates.py /path/to/english-wordnet-2024.xml.gz /path/to/cow-1.1.tar.xz /tmp/etyra-2020-cow.csv --sense-csv docs/OEWN_HISTORICAL_2020_SENSE_CANDIDATES.csv`。所有内容保持 `candidate_only`。

对 COW 未匹配的上述三个候选，已依据 OEWN 英文义项建立 [`CURATED_HISTORICAL_2020_PILOT.csv`](../../CURATED_HISTORICAL_2020_PILOT.csv) 编辑中文草稿；另对 `Britain` 和 `Indian` 的特定语境编写两条限定义项，合计五条。它们不是 COW 译文，词义、课标适用性及许可仍待复核。`London` 选城市义，不将同名作家义混入；`Olympics` 参考[国际奥委会说明](https://www.olympics.com/ioc/celebrate-olympic-games)，区分夏奥会与冬奥会的四年周期及交错举办。`Britain` 的国家用法与地理用法须按上下文区分；[英国国家统计局说明](https://service-manual.ons.gov.uk/content/language/countries-and-regions)区分大不列颠和联合王国。`Indian` 草稿只选印度相关含义，其他义项另行审核。补充队列的 `word_drafts` 已计入五项，但草稿不等同审核通过的中文释义。

对已有 COW 线索的历史候选，建立 [`CURATED_HISTORICAL_COW_PILOT.csv`](../../CURATED_HISTORICAL_COW_PILOT.csv) 的 34 条草稿：包含序数词、常用名词、地名与居民，以及部分国别形容词。地名要区分英国与英格兰、俄罗斯与苏联等历史政体；`India` 来源定义中的人口排名可能过时，草稿不沿用。`American` 选美国居民义并保留美洲义待审。所选词义、CILI 与中文词项均可追溯至固定 OEWN/COW 数据，但跨词网关联、中文语境、课标版本和来源许可仍需复核；分数、其他词性和其他含义未覆盖，草稿不是正式词条。补充审核队列计入这 34 条草稿；加上五条独立编辑草稿，39 个历史候选均有至少一条待审释义草稿，不代表其他义项已覆盖。

复现：使用支持 `pdfplumber` 的 Python，先运行 `python3 tools/content/compare_2020_curriculum.py /path/to/2020.pdf`；如需本地逐页检查，可加 `--review-csv /tmp/etyra-2020-review.csv`，不要公开未经许可的课标整表。再运行 `python3 tools/content/build_2020_gap_candidates.py /path/to/2020.pdf /path/to/english-wordnet-2024.xml.gz /tmp/etyra-2020-gaps.csv`。两个脚本核对输入摘要并拒绝覆盖已有输出；精确拼写统计是发现待审项的辅助，不是审核结论。

### 两版星号变化的试验性对照

2026-11-07 对上述 2020 官方 PDF 和未认证 2025 镜像的本地提取结果，仅比较纯字母加零至两个星号的行：2020 有 2920 个、2025 镜像有 3011 个不同的忽略大小写拼写键，其中 2811 个共有；去除任一版本出现重复行的 5 个键后，2806 个可作单行比较，其中 264 个星号数量不同。按旧数量→新数量分组：0→1 为 64、1→0 为 129、2→0 为 70、2→1 为 1。另有 109 个仅在 2020 简单行出现、200 个仅在 2025 镜像简单行出现；**这些不等于课标删词或新增词**，因为复杂写法、提取偏差、同形异义和权威来源尚未排除。标星变化同样只是一项待核线索，不能自动确定课程等级变化、覆盖或优先级。

本地复现需先按两版各自方法生成 review CSV，再运行 `python3 tools/content/compare_curriculum_versions.py /path/to/2020-review.csv /path/to/2025-review.csv`；脚本验证两份固定摘要。可加 `--review-csv /tmp/etyra-mark-changes.csv` 生成包含页码的本地差异清单，既有文件不会覆盖。差异清单含来源词项，许可未核实前不得提交仓库或产品；所有结果必须回到原页和可验证的现行课标逐条复核。

## 小样本覆盖试算

从上述未认证 PDF 镜像印刷页 73–75 人工抽取 27 个单词或名称，以去首尾空格、忽略大小写的精确文本与两份已保存词表的并集比较：24 项精确匹配，3 项未匹配：`abnormal`、`adorable`、`Antarctica`。这 3 项在镜像中均带有两个星号，仍需对照权威原件和适用范围复核；`Antarctica` 属于专名，最终词库如何计数须单独决定。对照没有尝试词形还原、英美拼写映射、同形异义或分类判定。

该试算不是随机样本，也不是完整附录的覆盖率，不能将 24/27 外推为整体覆盖。它说明两份通用词表即便有 5342 个不同文本，也存在需要补充的课标候选；不得根据词表并集大小声称已覆盖所有高中必学词。正式对照前应取得可验证的课标原件并逐页检查文本提取和标星，尤其要处理双栏、斜杠及括号形式。

## 2025 镜像整表探索性提取

使用固定摘要的第三方 PDF 镜像及 `tools/content/compare_curriculum_pilot.py`，按 PDF 页码 76–132 的双栏位置提取，再只将纯字母加可选星号的行作为简单词项，按小写形式与两份候选词表做精确文本对照。一次运行得到 3098 条提取行，其中 3013 条为简单词项行（3011 个不同的小写拼写），2720 行精确匹配、293 行未匹配；其余 85 行包含缩写、括号、斜线、连字符或其他需人工处理的形式，被排除在匹配统计外。统计单位是提取行，包含同形条目，不能等同课标词条数；镜像未认证、提取结果也未逐页校对，以上结果不能作为官方覆盖率。

复现方式：准备摘要与上节记录完全相同的 PDF 镜像，使用已提供 `pdfplumber` 的 Python 环境运行 `python3 tools/content/compare_curriculum_pilot.py /path/to/mirror.pdf`。默认只打印汇总；可用 `--review-csv /tmp/etyra-review.csv` 在本地新建含页码、原始词行与匹配分类的待审清单，现有文件不会被覆盖。镜像来源和整理内容的再分发权利未核实，该清单只用于本地审核；摘要不符则拒绝运行。下一步逐页核对布局、重名项和复杂项，并通过权威原件确认附录后才可计算正式覆盖率。

2026-11-07 重新下载上述镜像，摘要一致，使用已有的打包 Python 环境复现 3098 行及 85 行复杂项结果。对这 85 行仅去除末尾星号及其前面的空格、忽略大小写，再与主候选和补充候选做整行精确比较：2 行可定位到主候选、12 行可定位到补充候选、71 行未按整行匹配。前两项涉及提取文本 `behalf **` 和 `café*`：前者的星号前空格、后者的重音字符使原简单行规则没有纳入；这说明复杂分类不都意味着必须拆词。12 个补充候选包含短语、缩写和标点形式，整行相同也不证明词义、课标等级或最终独立词条划分正确。85 行仍需逐行对照原页、权威版本及许可，不能将本统计作为覆盖率或批准入库。

复现该二次分诊：在本地先生成上述 review CSV，再运行 `python3 tools/content/audit_complex_exact_matches.py /path/to/review.csv`；脚本校验已记录的提取文件摘要，仅输出汇总，不复制课标整表至仓库。

对这 85 行再按既有 `build_complex_gap_candidates.py` 的规则提取括号、斜线或逗号分隔的字面片段，与主表和补充表的候选拼写键比较：84 行的所有片段有同拼写候选；1 行仍含未匹配片段，即 `BCE` 的括号展开说明 `Before the Common Era`，已在本页后文记录其独立词条查询及缩写关系线索。对全部 85 行检查过两套分片函数的输出一致。分片匹配不代表括号两侧同义，也不证明大小写、专名、缩写、动词变形、词义或课程等级正确；例如 `father (dad)`、`be (am, are, is)` 都不能仅凭分隔符认定为同一词条。全部复杂行继续待审核，未经许可不将镜像整表提交或作为正式覆盖报告。

为逐行跟踪，`docs/COMPLEX_CURRICULUM_REVIEW_INDEX.csv` 保存 85 个提取行在该固定镜像中的顺序、PDF 页码、原始提取行 SHA-256、整行候选 ID、片段候选 ID 和缺失片段数；不保存原始课标行。原始行摘要仅用于与本地提取结果对应，不证明原件真伪或提取正确。`null` 仅表示该拆分片段未匹配候选键；拆分规则有限，候选 ID 不证明词形、词义、等级或许可。全部为 `candidate_only`。使用上述固定摘要的本地 review CSV 运行 `python3 tools/content/build_complex_review_manifest.py /path/to/review.csv /tmp/complex-index.csv` 可复现；源文件授权、逐行识别及权威版本仍须审核。

对 `am`、`are`、`is`、`has` 四项，参照 Cambridge Dictionary 的 [be 形式表](https://dictionary.cambridge.org/grammar/british-grammar/basic)和 [have 形式说明](https://dictionary.cambridge.org/grammar/british-grammar/have%3A)，在 [`docs/INFLECTION_REVIEW_PILOT.csv`](../../INFLECTION_REVIEW_PILOT.csv) 记录与 `be`、`have` 的动词屈折关系线索及各自候选 ID；语法事实用于审核定位，来源作为参考而非授权复制词典文本。拼写可有其他词性，原型、不同词义及是否作为独立学习对象均待审；这些关系不自动合并候选、产品 ID 或学习记录，也不证明课标适用性。镜像行及分级仍须核对权威版本。

对 `colour/color`、`centre/center`、`favourite/favorite` 和 `theatre/theater` 四组，依据 [`SPELLING_REVIEW_PILOT.csv`](../../SPELLING_REVIEW_PILOT.csv) 所列 Cambridge Dictionary 词条记录英美拼写线索，分别保留主候选和补充候选 ID；不复制其词典释义。词性、专名、地区实际用法和课标原文仍须逐项核验，例如 `theatre` 也可见于美国语境。拼写关联不自动证明所有义项等同，也不自动合并产品 ID、学习记录或词条数量。

## 课标镜像缺口补充候选

上述 293 个未匹配的简单词项行按忽略大小写去重后为 292 个拼写；通过 OEWN 2024 的 `Lemma.writtenForm` 比对，有 274 个拼写找到词典入口。已将这些 OEWN 词头、词条 ID、词性和镜像 PDF 页码写入 [`docs/CURRICULUM_GAP_CANDIDATES.csv`](../../CURRICULUM_GAP_CANDIDATES.csv)，每条仍为 `candidate_only`。其余 18 个拼写尚未匹配到 OEWN，包括代词和部分词形，需要其他来源或词形审核；85 行复杂形式也尚未处理。

这 274 条是以第三方课标镜像探索性比对结果筛选出的 OEWN 词条候选，并非经核验的课标词表或产品词条。表中原始词形取自 OEWN，PDF 页码用于定位线索；相同规范化拼写可能对应不同大小写或词义，专名是否纳入词库仍需审查。其候选 ID 与主清单采用同一规则；按当前拼写键计算，与主清单没有重复，合计 5616 个待审候选键，但不能推断正式词条数或课标覆盖率。词典词项和词性仅作为审核线索，不证明词源关系。

补充候选表取自 Open English WordNet 2024 和 Princeton WordNet，筛选与课标镜像比较后未精确匹配的词头，保留词典标识及页码；适用前述 OEWN/Princeton 许可及署名要求，产品分发前须核对实际使用内容。复现：在有 `pdfplumber` 的 Python 3.11+ 环境中运行 `python3 tools/content/build_curriculum_gap_candidates.py /path/to/mirror.pdf /path/to/english-wordnet-2024.xml.gz /tmp/etyra-gap-candidates.csv`；脚本验证两个输入摘要并拒绝覆盖输出。课标原文及整表没有放入仓库。

### 词典未匹配的 18 个简单词形

2026-11-01 对剩余 18 个拼写查询 English Wiktionary，均找到包含英语章节和相关词性标题的页面，结果写入 [`docs/WIKTIONARY_GAP_CANDIDATES.csv`](../../WIKTIONARY_GAP_CANDIDATES.csv)。其中多为代词或限定词，`chopsticks` 页面包含名词标题；表内记录固定页面修订 ID、该修订时间、英语章节中机器识别到的词性标题及课标镜像页码。机器识别整个英语章节的标题，不代表每个标题的所有义项都适合该词的高中语境；每个词仍须人工选义并核验课标原件。不得把未在 WordNet 找到视为无效单词，也不应强制构造词根关系。

这些页面为 Wiktionary 社群内容，页面修订链接见 CSV；文字复用须核对修订内容的来源、许可、署名、修改标记和适用的 CC BY-SA 4.0 条件，具体参见 `docs/CONTENT_SOURCE_AUDIT.md`。表内只记录词头、词性标题和定位元数据，不收录释义；未来纳入释义或词源前须逐页核查。生成时对 `/tmp` 中的 MediaWiki API 修订内容响应检查了英语章节及标题，脚本为 `tools/content/build_wiktionary_gap_candidates.py`，输入为本地镜像试算 CSV 和 API 修订响应，现有输出不会被覆盖。页面可能变化，正式审校应使用记录的修订 ID。

以规范化拼写计，原始 5342 个候选加 OEWN 补充 274 个、Wiktionary 补充 18 个，共 5634 个不同候选键。数字只代表待审工作量；85 个复杂词形、课标原件一致性、词义、翻译和词源关系仍未完成，也未证明高中必学词已全部覆盖。

2026-11-08 对全部 85 个复杂行进行未认证镜像原页视觉核对，记录见 [`docs/COMPLEX_CURRICULUM_VISUAL_REVIEW.csv`](../../COMPLEX_CURRICULUM_VISUAL_REVIEW.csv)：保留页码、行摘要、候选 ID、可见标记及结构，并区分斜线并列、缩写展开、短语成分和括号拼写变体。标注是审核线索，不能证明权威版本、词义、课程等级或授权；这只完成了指定镜像的视觉核对，全部行仍须核验权威版本、词义、归并策略和许可。

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

2026-11-01 和 2026-11-07 分批查询 English Wiktionary 页面固定修订，主候选清单全部 5342 项的定位元数据见 [`docs/WIKTIONARY_BULK_SOURCE_INDEX.csv`](../../WIKTIONARY_BULK_SOURCE_INDEX.csv)；其中 5321 项检测到英语词源章节标题，21 项未检测到标题；未检测到标题不等于没有来源，仍需人工核对或寻找替代来源。此前遇到 HTTP 429 后已暂停，2026-11-07 以串行、分批方式恢复。此表仅定位页面版本，并不包含或确认词源、词义、词根关系及高中适用性；缺少标题也不等于没有词源。许可与后续文字复用条件见 `docs/CONTENT_SOURCE_AUDIT.md`。

对 21 个无标题页面中的 20 个，依据原固定修订英语章节内明确的拼写、缩略和屈折模板、定义链接或大小写使用说明，另记录目标词条的固定修订和词源标题至 [`docs/WIKTIONARY_HEADING_ABSENT_REVIEW.csv`](../../WIKTIONARY_HEADING_ABSENT_REVIEW.csv)。目标页面修订仅定位线索：`descendent` 在不同词性下标注不同，`gym` 还指向 `gymnastics`，不能把列出的单个目标推广到所有义项。其中定义链接只供查找语境，不能证明词源；`TRUE/FALSE` 与小写形式只作大小写对照，不能视为等同。`memorize` 则使用 [Online Etymology Dictionary](https://www.etymonline.com/word/memorize) 的外部词源线索和 `memory` 页面固定修订作为独立待审参考；该线索并非原 Wiktionary 页面提供，内容复用许可另行核验。所有变体、词性、课程适用性和许可仍待审，不自动合并 ID 或学习进度。表仅保存页面元数据和人工审核备注，不复制词典正文。

工具 `tools/content/index_vocabulary_etymology.py` 将原始 API 响应分批暂存于仓库外的指定目录，并校验输入清单摘要和批次以支持中断续采；输出只含定位元数据，且拒绝覆盖已有文件。限流时应停止并等待服务允许，遵循其访问政策；续采时使用保留的缓存目录和新输出路径，复核完整性后再更新索引。缓存位于临时目录时可能被系统清理，不作为永久归档。原始 400 条临时缓存已不存在，不能仅凭缓存完整复现；可依照固定修订链接逐条追溯。本次最后一批缓存仍可用时可离线重建：`python3 tools/content/index_vocabulary_etymology.py /tmp/etyra-wiki-resume /tmp/etyra-last-check.csv --start-offset 4600 --max-batches 19 --cached-only`；校验并与已保存的固定修订对照，不覆盖旧修订。页面修订 URL 是持久追溯依据，远端内容可用性无法保证。

对上述 5342 个固定修订中的英语词源章节，提取显式的简单 `af`、`affix`、`prefix`、`suffix`、`compound` 模板参数，得到 [`docs/WIKTIONARY_MORPHOLOGY_CLUES.csv`](../../WIKTIONARY_MORPHOLOGY_CLUES.csv) 中 804 个词的 850 条构词线索；每条保留章节、模板、原始组件、页面修订及 `morphology_clue_unreviewed`。仅记录模板参数，并非词根—单词关系：前缀、后缀和复合词组件不能自动归为词根；现代构词分析也不能等同历史词源。模板所在句可能带有不确定、对比或否定语境，命名参数未纳入组件，嵌套模板被排除，必须打开固定修订逐项核验完整上下文、词义、许可及词根边界。无模板线索不等于没有构词关系；本索引不作为正式产品数据。

[`docs/MORPHOLOGY_COMPONENT_REVIEW_INDEX.csv`](../../MORPHOLOGY_COMPONENT_REVIEW_INDEX.csv) 将上述 850 条线索展开为 1708 个组件位置，并对组件原样去除首尾空格、按 Unicode casefold 与主候选及补充候选的完整拼写键精确匹配：885 个组件位置找到候选 ID，823 个未匹配。行数是组件位置，不是不同词数，也不是已建立的词根关系；部分模板以不带连字符的文本表示词缀，因此匹配到同拼写单词也不能确认组件词性或关联。索引保留原模板行号、组件顺序、固定修订和未审状态，大小写、词源语境、词义、关系和许可仍须复核。可用 `python3 tools/content/index_morphology_components.py /tmp/morphology-components.csv` 复现；脚本不覆盖已有文件，不自动批准关联。来源、署名和许可适用上文 Wiktionary/Kaikki 说明。

[`docs/MORPHOLOGY_CONTEXT_REVIEW_PILOT.csv`](../../MORPHOLOGY_CONTEXT_REVIEW_PILOT.csv) 对其中 47 个词的 50 条模板线索回读固定修订的英文词源上下文并记录编辑摘要，四批原始 API 响应 SHA-256 依次为 `f0f7684922987fad543427780b35b9c69a3ad2e81136d6bf3001f54e776a0b31`、`02d11f1f1788ee7688e8622760a832b3f9178debc3d1dbd7c9f35599f525a3ac`、`30dcd946df012bb301a78e0091845469c071b8f2b14f96b8e3762aae472b441f`、`bc7e7d56f23f7a588415e44756c148bf704cc6812b6a06a812ce41ae6d908f83`（快照位于仓库外）。摘要区分历史路径和现代可分析形式，并将 `flight` 的两个词源章节分别处理；`less` 在 `endless` 中是后缀线索而不是同拼写独立词。记录仍待专家复核词义、来源及许可，不构成已批准的产品关系。复查可通过 Wiktionary MediaWiki API 以表中 revision ID 获取原文；来源和署名许可同本节。

本次新增批次在缓存仍可用时可单独复现：`python3 tools/content/extract_wiktionary_morphology_clues.py /tmp/etyra-wiki-resume /tmp/etyra-new-clues.csv --index /tmp/etyra-index-resume-400.csv`；临时文件被清理后需按固定修订重新取得内容。脚本对照缓存中的页面标题、修订和 API 返回的 SHA-1 元数据，未重新计算正文摘要，并拒绝覆盖输出。原始缓存可能被系统清理；重新取得修订时须保持固定版本并遵守站点访问限制。来源是 English Wiktionary contributors，适用前述逐页来源、署名、许可及修改记录要求。

## 镜像星号分层试算

对既有未认证镜像的探索性提取结果，仅对简单单词行按去星号、忽略大小写的拼写键分类：无星号行中 1427 行匹配主清单、111 行匹配缺口补充候选；一个星号分别为 437、58 行；两个星号分别为 856、124 行；85 行复杂形式排除。当前没有简单行落入这两类之外。统计单位为提取行而非去重单词，补充候选包括 OEWN 缺口和 Wiktionary 缺口；匹配只是字符串相同，不证明词形、大小写、词义、星号识别或课程等级已核准。复杂行、地区增补、来源真伪和授权仍未解决，不可用作完整覆盖率或正式入库依据。

复现：先按照本文件“2025 镜像整表探索性提取”使用 `compare_curriculum_pilot.py` 生成本地 review CSV，再运行 `python3 tools/content/summarize_curriculum_levels.py /path/to/review.csv`。本次 review CSV 的 SHA-256 为 `d898a899415c2dc1a275d87e20f71f4a2848047dc0c310dfdc15b8f45cb3849a`，脚本校验该值；原 PDF 和提取整表不提交。若提取环境导致输出字节不同，应重新核查输入及结果，而不是直接修改校验值。
