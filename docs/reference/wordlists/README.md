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

## OEWN 词义候选索引

[`docs/OEWN_CANDIDATE_INDEX.csv`](../../OEWN_CANDIDATE_INDEX.csv) 将 5342 个合并候选的规范化拼写与 [Open English WordNet 2024 发行版](https://github.com/globalwordnet/english-wordnet/releases/tag/2024-edition)的 `Lemma.writtenForm` 以去首尾空格、Unicode casefold 方式比对。5265 个候选至少匹配一个 OEWN 词条，77 个未匹配；每行记录候选 ID、OEWN 词条 ID、词性代码和不同义项 ID 数量，状态仍为 `candidate_only`。小写归并会合并不同大小写含义，例如 `a` 可能匹配 `A`；相同拼写也可能有大量不同词义。匹配结果不能自动选择义项、释义、课标等级或词根，未匹配也不代表不是单词。

本索引基于 Open English WordNet 2024 和 Princeton WordNet 改编：提取词条标识、词性与义项数量，关联 Etyra 候选拼写，不含 OEWN 释义正文。OEWN 团队与 Princeton WordNet 均须署名；OEWN 为 CC BY 4.0，底层 Princeton WordNet 条款及免责声明同时适用。保留发布版本的原始 [OEWN 许可](OEWN-2024-LICENSE.md) 和 [WordNet 条款](OEWN-2024-WNDB-license.txt)。合并候选本身还受上节所述 CC BY-SA 4.0 条件约束；内容与应用代码分别管理。

输入文件为发行版 XML gzip，下载地址 `https://github.com/globalwordnet/english-wordnet/releases/download/2024-edition/english-wordnet-2024.xml.gz`，SHA-256 `e1f633b0a93758cae34ea27c44c4dad310a8af2467b155f99dd6673af697e875`。运行 `python3 tools/content/index_oewn_candidates.py /path/to/english-wordnet-2024.xml.gz /tmp/etyra-oewn-index.csv` 可复现；脚本校验摘要且拒绝覆盖输出，需要 Python 3.11 及以上。原始词典体积较大，未放入项目；后续正式内容包须再次保留适用许可和署名。

## 高中课标覆盖基准

- [教育部制定的《普通高中英语课程标准（2017 年版 2020 年修订）》](https://www.ictr.edu.cn/Uploads/File/2025/02/07/4.%E6%99%AE%E9%80%9A%E9%AB%98%E4%B8%AD%E8%8B%B1%E8%AF%AD%E8%AF%BE%E7%A8%8B%E6%A0%87%E5%87%86%EF%BC%882017%E5%B9%B4%E7%89%882020%E5%B9%B4%E4%BF%AE%E8%AE%A2%EF%BC%89.20250207211247.pdf)由教育部课程教材研究所网站提供，附录 2 称列 3000 词，其中包含义务教育 1500 词、高中必修新增 500 词、选择性必修新增 1000 词；正文不含词性和中文释义。作为已定位的官方历史对照来源，不能据此声称已满足最新版。
- 2025 年日常修订版已经出现：课程教材研究所[刊物目录](https://www.ictr.edu.cn/Uploads/File/2025/12/01/2025%E5%B9%B412%E6%9C%88%E7%9B%AE%E5%BD%95.20251201190727.pdf)列有该版解读，高等教育出版社的[图书信息](https://xuanshu.hep.com.cn/front/h5Mobile/bookDetails?bookId=6a5a6320e119ac972986fa53)确认由课程教材研究所组织编写的解读书。尚未取得并核验 2025 版原文的权威可用文件及附录清单，故其词目、标星、地方实施及出版许可仍待核实；不得以 2020 版取代新版验收。
- 2026-11-01 找到一份[题为 2025 年修订版的第三方 PDF 镜像](https://forum.freemdict.com/uploads/short-url/doVmJXenSoIbcg8t5HA0hkWcccm.pdf)，附录 2 标注从印刷页 73 开始，包含星号等级。该次下载文件 SHA-256 为 `4d2d0f33e511dc0d239d2cdc53fe16f38a107afde9bd1ae557cec9ce7bb1bba0`；仅供研究定位，出版来源、内容完整性、与权威原件一致性和使用许可均尚未核实，不能用作最终覆盖验收。镜像文件未提交仓库。
- 初步比较发现[第三方整理页面](https://wangjunjian.com/posts/2026-06-07-general-high-school-vocabulary-2025/)虽然自称完整课标表，但与上述 PDF 镜像开头的词项有明显差异：镜像列有 `accommodation**`、`addict*`，整理页开头列为 `addicted` 且全文文本搜索未找到 `accommodation`；整理页还列出 `abortion`，镜像相应字母顺序区域未见该项。两者都不是已认证原件，这些差异只说明整理页不宜直接作为完整课标依据；网页中文释义亦非课标原文释义。进一步比对时须保留原页与原始词形、等级及审核结论。
- [新乡工程学院外国语学院页面](https://www.xxgc.edu.cn/fll/info/1061/5288.htm)列出题为 2025 修订版的 PDF 附件，但当前下载要求验证码，附件内容及与正式版本的一致性尚未核验；可作为后续寻找可靠原文的线索。
- 课标原文和整表的再分发许可尚未确认。当前仅记录来源链接和事实，不将课标全文或其整表复制入仓库/产品。必要时取得有权使用的版本或许可，再固定来源版本、页码、文件摘要和覆盖对照。

## 小样本覆盖试算

从上述未认证 PDF 镜像印刷页 73–75 人工抽取 27 个单词或名称，以去首尾空格、忽略大小写的精确文本与两份已保存词表的并集比较：24 项精确匹配，3 项未匹配：`abnormal`、`adorable`、`Antarctica`。这 3 项在镜像中均带有两个星号，仍需对照权威原件和适用范围复核；`Antarctica` 属于专名，最终词库如何计数须单独决定。对照没有尝试词形还原、英美拼写映射、同形异义或分类判定。

该试算不是随机样本，也不是完整附录的覆盖率，不能将 24/27 外推为整体覆盖。它说明两份通用词表即便有 5342 个不同文本，也存在需要补充的课标候选；不得根据词表并集大小声称已覆盖所有高中必学词。正式对照前应取得可验证的课标原件并逐页检查文本提取和标星，尤其要处理双栏、斜杠及括号形式。

## 2025 镜像整表探索性提取

使用固定摘要的第三方 PDF 镜像及 `tools/content/compare_curriculum_pilot.py`，按 PDF 页码 76–132 的双栏位置提取，再只将纯字母加可选星号的行作为简单词项，按小写形式与两份候选词表做精确文本对照。一次运行得到 3098 条提取行，其中 3013 条为简单词项行（3011 个不同的小写拼写），2720 行精确匹配、293 行未匹配；其余 85 行包含缩写、括号、斜线、连字符或其他需人工处理的形式，被排除在匹配统计外。统计单位是提取行，包含同形条目，不能等同课标词条数；镜像未认证、提取结果也未逐页校对，以上结果不能作为官方覆盖率。

复现方式：准备摘要与上节记录完全相同的 PDF 镜像，使用已提供 `pdfplumber` 的 Python 环境运行 `python3 tools/content/compare_curriculum_pilot.py /path/to/mirror.pdf`。默认只打印汇总；可用 `--review-csv /tmp/etyra-review.csv` 在本地新建含页码、原始词行与匹配分类的待审清单，现有文件不会被覆盖。镜像来源和整理内容的再分发权利未核实，该清单只用于本地审核；摘要不符则拒绝运行。下一步逐页核对布局、重名项和复杂项，并通过权威原件确认附录后才可计算正式覆盖率。

## 工作顺序与验收口径

1. 获得并核实适用的 2025 版课标附录、实施范围及使用权限，保留基准版本；先处理必修、选择性必修，再处理相关地方增补和常用扩展词。
2. 针对每个课标词项记录原始拼写、词条/变体归并规则、课程类别、来源定位及审核状态；显式保留英美拼写、专名、短语、多词性和同形异义的例外，不把不同来源统计口径混为一谈。
3. 将 NGSL-GR 与课标基准做可复现对照，产出已匹配、候选匹配、缺失、歧义四类清单，并逐项复核；补充课标缺口，再为常见扩展词标明来源和选用理由。
4. 制作不少于 5000 个去重后的正式 `Word` 词条，定义词条计数与拼写变体口径；来源、词性、释义、许可和状态各自可追溯。学习进度稳定 ID 不能依赖外部排名。
5. 词源关系仅在独立证据支持时建立，词条可以没有已证实词根；不靠词形相似推导关系，也不为凑数量把未审核关系写为事实。审核词源时固定来源页面版本并记录依据。
6. 验收应提供最新适用课标逐项覆盖报告、未匹配/歧义清单及处理结论、5000+ 正式词条的去重报告、来源和许可材料，以及真实离线内容包导入和学习流程的证据。当前全部未完成。
