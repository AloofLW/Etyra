# 离线词库来源与许可审查（第一版）

审查日期：2026-11-01  
状态：来源候选已审查，尚未批准任何产品词条或最终词库来源。

## 范围

本审查为 Etyra 离线分发的首批约 50 个词根和 300–500 个关联单词提供来源选择依据。此次只审查来源、许可及内容适配性，不导入词条、不生成 seed 数据，也不构成法律意见。词条和构词关系仍须逐条核对。

## 来源候选

| 来源 | 可支持的内容 | 分发与归属要求 | 对 Etyra 的判断 |
| --- | --- | --- | --- |
| English Wiktionary（人工逐页审阅或 Wiktextract 提取） | 词条、词性、释义、例句及部分词源信息；覆盖和质量随词条而异 | Wikimedia 说明文本通常依 CC BY-SA 4.0 和/或 GFDL 提供，但具体页面可能有不同来源、许可或额外署名要求。须检查页面、历史及导入内容；署名来源、标记修改，并按适用许可提供改编内容。Wiktextract 的 MIT 许可只适用于提取器代码，不替代提取数据的来源许可。 | 词源候选价值高，但许可义务需要针对实际内容和离线词库包落实。作为候选，等待确认 Etyra 是否接受词库内容采用 CC BY-SA 兼容分发方式。 |
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

将 OEWN 作为“词性与词义的候选辅助来源”，Princeton WordNet 3.0 作为其许可声明要求可接受时的备用辅助来源；两者都不作为词源证据。将 English Wiktionary 保留为词源/构词关系候选，但在 Etyra 分发策略明确接受对应内容许可与署名义务之前，不从中导入或改写正式产品数据。Oxford API 当前不符合无单独许可的离线打包目标。

在任何 seed 内容提交前，需要先决定是否接受 CC BY-SA 派生内容及其分发义务。若不接受，则应选取许可兼容且有可靠词源证据的来源，或由编辑基于可引用来源独立撰写并逐条审校；不得以“改写”作为规避许可或来源归属的方式。

## 待决事项

- Etyra 的词库内容是否接受 CC BY-SA 4.0 兼容的署名/分享相同许可条件？是否计划公开或商业分发应用/词库包？
- 首批词条优先使用 OEWN 等许可相对清晰的数据集作为词义辅助，还是逐项使用 Wiktionary 并承担其许可要求？
- 首批高中词库的年级/考试范围、选词标准和词根纳入标准由谁确认？
- 词源条目的编辑复核流程、审核人和来源快照/修订标识如何归档？

## 本地开发任务影响

- 在上述许可决策完成前，ET-01 的正式词库来源清单和产品 seed 保持未开始。
- 后续 ET-10C 词库包必须携带来源/许可/署名/修改信息；导入校验只检查元数据完整性，不宣称来源内容真实或发布者身份已认证。
- 本文是候选审计记录，不是已批准的数据源清单。最终来源批准后应记录为决策，并更新数据包、模型字段与验收任务。
