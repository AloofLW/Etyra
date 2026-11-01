import '../../shared/domain/content_types.dart';
import '../../shared/domain/source_ref.dart';
import '../../words/domain/word.dart';

final class Root {
  Root({
    required this.id,
    required this.lemma,
    required this.displayForm,
    required this.language,
    required this.meaning,
    this.originNote,
    required VerificationStatus verificationStatus,
    required Iterable<SourceRef> sources,
  }) : sources = List.unmodifiable(sources),
       verificationStatus = sources.isEmpty
           ? VerificationStatus.unverified
           : verificationStatus;
  final String id;
  final String lemma;
  final String displayForm;
  final String language;
  final String meaning;
  final String? originNote;
  final VerificationStatus verificationStatus;
  final List<SourceRef> sources;
}

final class Affix {
  Affix({
    required this.id,
    required this.form,
    required this.kind,
    required this.meaning,
    required VerificationStatus verificationStatus,
    required Iterable<SourceRef> sources,
  }) : sources = List.unmodifiable(sources),
       verificationStatus = sources.isEmpty
           ? VerificationStatus.unverified
           : verificationStatus;
  final String id;
  final String form;
  final AffixKind kind;
  final String meaning;
  final VerificationStatus verificationStatus;
  final List<SourceRef> sources;
}

final class RootDetail {
  RootDetail({
    required this.root,
    required Iterable<Affix> affixes,
    required Iterable<Word> words,
    required Iterable<WordComponent> components,
    required Iterable<ExampleSentence> examples,
  }) : affixes = List.unmodifiable(affixes),
       words = List.unmodifiable(words),
       components = List.unmodifiable(components),
       examples = List.unmodifiable(examples);
  final Root root;
  final List<Affix> affixes;
  final List<Word> words;
  final List<WordComponent> components;
  final List<ExampleSentence> examples;
}
