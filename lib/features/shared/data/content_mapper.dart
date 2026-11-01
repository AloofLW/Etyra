import 'dart:convert';

import '../../roots/domain/root.dart';
import '../../words/domain/word.dart';
import '../domain/content_types.dart';
import '../domain/source_ref.dart';

/// Data-only JSON/row mapping. Malformed rows become Storage at the repository.
final class ContentMapper {
  const ContentMapper();

  Map<String, Object?> sourceToJson(SourceRef source) => {
    'id': source.id,
    'title': source.title,
    'publisher': source.publisher,
    'edition': source.edition,
    'url': source.url,
    'locator': source.locator,
    'licenseName': source.licenseName,
    'licenseUrl': source.licenseUrl,
    'attributionText': source.attributionText,
    'accessedAt': source.accessedAt?.toIso8601String(),
  };

  String sourcesToJson(List<SourceRef> sources) =>
      jsonEncode(sources.map(sourceToJson).toList());

  List<SourceRef> sourcesFromJson(String raw) {
    final decoded = jsonDecode(raw) as List;
    return List.unmodifiable(
      decoded.map((item) {
        final data = item as Map<String, dynamic>;
        return SourceRef(
          id: data['id'] as String,
          title: data['title'] as String,
          publisher: data['publisher'] as String?,
          edition: data['edition'] as String?,
          url: data['url'] as String?,
          locator: data['locator'] as String?,
          licenseName: data['licenseName'] as String?,
          licenseUrl: data['licenseUrl'] as String?,
          attributionText: data['attributionText'] as String?,
          accessedAt: data['accessedAt'] == null
              ? null
              : DateTime.parse(data['accessedAt'] as String),
        );
      }),
    );
  }

  Root root(Map<String, dynamic> row) {
    final sources = sourcesFromJson(row['source_refs'] as String);
    return Root(
      id: row['id'] as String,
      lemma: row['lemma'] as String,
      displayForm: row['display_form'] as String,
      language: row['language'] as String,
      meaning: row['meaning'] as String,
      originNote: row['origin_note'] as String?,
      verificationStatus: sources.isEmpty
          ? VerificationStatus.unverified
          : knownEnum(
                  VerificationStatus.values,
                  row['verification_status'] as String,
                ) ??
                VerificationStatus.unverified,
      sources: sources,
    );
  }

  Affix affix(Map<String, dynamic> row) {
    final sources = sourcesFromJson(row['source_refs'] as String);
    return Affix(
      id: row['id'] as String,
      form: row['form'] as String,
      kind:
          knownEnum(AffixKind.values, row['kind'] as String) ??
          AffixKind.unknown,
      meaning: row['meaning'] as String,
      verificationStatus: sources.isEmpty
          ? VerificationStatus.unverified
          : knownEnum(
                  VerificationStatus.values,
                  row['verification_status'] as String,
                ) ??
                VerificationStatus.unverified,
      sources: sources,
    );
  }

  Word word(Map<String, dynamic> row) => Word(
    id: row['id'] as String,
    word: row['word'] as String,
    normalizedWord: row['normalized_word'] as String,
    partOfSpeech: row['part_of_speech'] as String?,
    definition: row['definition'] as String,
    translation: row['translation'] as String?,
    pronunciationRef: row['pronunciation_ref'] as String?,
    sources: sourcesFromJson(row['source_refs'] as String),
  );

  WordComponent? component(Map<String, dynamic> row) {
    final type = knownEnum(
      ComponentType.values,
      row['component_type'] as String,
    );
    // Unknown future component types are omitted, never mislabeled as roots.
    if (type == null) return null;
    return WordComponent(
      wordId: row['word_id'] as String,
      componentType: type,
      componentId: row['component_id'] as String,
      role:
          knownEnum(ComponentRole.values, row['role'] as String) ??
          ComponentRole.unknown,
      confidence: (row['confidence'] as num?)?.toDouble(),
      sources: sourcesFromJson(row['source_refs'] as String),
    );
  }

  ExampleSentence example(Map<String, dynamic> row) => ExampleSentence(
    id: row['id'] as String,
    wordId: row['word_id'] as String,
    sentence: row['sentence'] as String,
    translation: row['translation'] as String?,
    sources: sourcesFromJson(row['source_refs'] as String),
  );
}
