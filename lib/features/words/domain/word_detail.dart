import '../../roots/domain/root.dart';
import 'word.dart';

/// A read-only snapshot of one word and its explicitly stored relationships.
final class WordDetail {
  WordDetail({
    required this.word,
    required Iterable<Root> roots,
    required Iterable<Affix> affixes,
    required Iterable<WordComponent> components,
    required Iterable<ExampleSentence> examples,
  }) : roots = List.unmodifiable(roots),
       affixes = List.unmodifiable(affixes),
       components = List.unmodifiable(components),
       examples = List.unmodifiable(examples);

  final Word word;
  final List<Root> roots;
  final List<Affix> affixes;
  final List<WordComponent> components;
  final List<ExampleSentence> examples;
}
