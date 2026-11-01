import '../../roots/domain/root.dart';
import '../../words/domain/word.dart';

/// Data-layer input, not a presentation model. Human review is required; source
/// metadata alone is not evidence of redistribution permission.
final class SeedPackage {
  SeedPackage({
    required this.packageId,
    required this.version,
    required this.reviewedBy,
    required this.reviewReference,
    required DateTime reviewedAt,
    required this.approvedForRedistribution,
    Iterable<Root> roots = const [],
    Iterable<Affix> affixes = const [],
    Iterable<Word> words = const [],
    Iterable<WordComponent> components = const [],
    Iterable<ExampleSentence> examples = const [],
  }) : reviewedAt = reviewedAt.toUtc(),
       roots = List.unmodifiable(roots),
       affixes = List.unmodifiable(affixes),
       words = List.unmodifiable(words),
       components = List.unmodifiable(components),
       examples = List.unmodifiable(examples);
  final String packageId;
  final int version;
  final String reviewedBy;
  final String reviewReference;
  final DateTime reviewedAt;
  final bool approvedForRedistribution;
  final List<Root> roots;
  final List<Affix> affixes;
  final List<Word> words;
  final List<WordComponent> components;
  final List<ExampleSentence> examples;
}

final class SeedImportReceipt {
  const SeedImportReceipt({
    required this.packageId,
    required this.version,
    required this.itemCount,
    required this.alreadyImported,
  });
  final String packageId;
  final int version;
  final int itemCount;
  final bool alreadyImported;
}
