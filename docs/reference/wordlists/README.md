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

## 高中课标覆盖基准

- [教育部制定的《普通高中英语课程标准（2017 年版 2020 年修订）》](https://www.ictr.edu.cn/Uploads/File/2025/02/07/4.%E6%99%AE%E9%80%9A%E9%AB%98%E4%B8%AD%E8%8B%B1%E8%AF%AD%E8%AF%BE%E7%A8%8B%E6%A0%87%E5%87%86%EF%BC%882017%E5%B9%B4%E7%89%882020%E5%B9%B4%E4%BF%AE%E8%AE%A2%EF%BC%89.20250207211247.pdf)由教育部课程教材研究所网站提供，附录 2 称列 3000 词，其中包含义务教育 1500 词、高中必修新增 500 词、选择性必修新增 1000 词；正文不含词性和中文释义。作为已定位的官方历史对照来源，不能据此声称已满足最新版。
- 2025 年日常修订版已经出现：课程教材研究所[刊物目录](https://www.ictr.edu.cn/Uploads/File/2025/12/01/2025%E5%B9%B412%E6%9C%88%E7%9B%AE%E5%BD%95.20251201190727.pdf)列有该版解读，高等教育出版社的[图书信息](https://xuanshu.hep.com.cn/front/h5Mobile/bookDetails?bookId=6a5a6320e119ac972986fa53)确认由课程教材研究所组织编写的解读书。尚未取得并核验 2025 版原文的权威可用文件及附录清单，故其词目、标星、地方实施及出版许可仍待核实；不得以 2020 版取代新版验收。
- [新乡工程学院外国语学院页面](https://www.xxgc.edu.cn/fll/info/1061/5288.htm)列出题为 2025 修订版的 PDF 附件，但当前下载要求验证码，附件内容及与正式版本的一致性尚未核验；可作为后续寻找可靠原文的线索。
- 课标原文和整表的再分发许可尚未确认。当前仅记录来源链接和事实，不将课标全文或其整表复制入仓库/产品。必要时取得有权使用的版本或许可，再固定来源版本、页码、文件摘要和覆盖对照。

## 工作顺序与验收口径

1. 获得并核实适用的 2025 版课标附录、实施范围及使用权限，保留基准版本；先处理必修、选择性必修，再处理相关地方增补和常用扩展词。
2. 针对每个课标词项记录原始拼写、词条/变体归并规则、课程类别、来源定位及审核状态；显式保留英美拼写、专名、短语、多词性和同形异义的例外，不把不同来源统计口径混为一谈。
3. 将 NGSL-GR 与课标基准做可复现对照，产出已匹配、候选匹配、缺失、歧义四类清单，并逐项复核；补充课标缺口，再为常见扩展词标明来源和选用理由。
4. 制作不少于 5000 个去重后的正式 `Word` 词条，定义词条计数与拼写变体口径；来源、词性、释义、许可和状态各自可追溯。学习进度稳定 ID 不能依赖外部排名。
5. 词源关系仅在独立证据支持时建立，词条可以没有已证实词根；不靠词形相似推导关系，也不为凑数量把未审核关系写为事实。审核词源时固定来源页面版本并记录依据。
6. 验收应提供最新适用课标逐项覆盖报告、未匹配/歧义清单及处理结论、5000+ 正式词条的去重报告、来源和许可材料，以及真实离线内容包导入和学习流程的证据。当前全部未完成。
