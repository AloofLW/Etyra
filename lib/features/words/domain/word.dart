import '../../shared/domain/content_types.dart';
import '../../shared/domain/source_ref.dart';

final class Word {
  Word({
    required this.id,
    required this.word,
    required this.normalizedWord,
    this.partOfSpeech,
    required this.definition,
    this.translation,
    this.pronunciationRef,
    required Iterable<SourceRef> sources,
  }) : sources = List.unmodifiable(sources);
  final String id;
  final String word;
  final String normalizedWord;
  final String? partOfSpeech;
  final String definition;
  final String? translation;
  final String? pronunciationRef;
  final List<SourceRef> sources;
}

final class WordComponent {
  WordComponent({
    required this.wordId,
    required this.componentType,
    required this.componentId,
    required this.role,
    this.confidence,
    required Iterable<SourceRef> sources,
  }) : sources = List.unmodifiable(sources);
  final String wordId;
  final ComponentType componentType;
  final String componentId;
  final ComponentRole role;
  final double? confidence;
  final List<SourceRef> sources;
}

final class ExampleSentence {
  ExampleSentence({
    required this.id,
    required this.wordId,
    required this.sentence,
    this.translation,
    required Iterable<SourceRef> sources,
  }) : sources = List.unmodifiable(sources);
  final String id;
  final String wordId;
  final String sentence;
  final String? translation;
  final List<SourceRef> sources;
}
