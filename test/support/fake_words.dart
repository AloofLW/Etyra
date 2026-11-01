import 'package:etyra/features/shared/domain/page.dart';
import 'package:etyra/features/shared/domain/result.dart';
import 'package:etyra/features/words/domain/word.dart';
import 'package:etyra/features/words/domain/word_detail.dart';
import 'package:etyra/features/words/domain/word_repository.dart';

class FakeWords implements WordRepository {
  Future<Result<Page<Word>>> Function(String? cursor) list = (_) async =>
      Success(Page(items: []));
  Future<Result<WordDetail>> Function(String id) detail = (_) async =>
      const Failure(DomainFailure(FailureKind.notFound, 'word.not_found'));
  final cursors = <String?>[];

  @override
  Future<Result<Page<Word>>> listWords({
    String? query,
    String? cursor,
    int limit = 30,
  }) {
    cursors.add(cursor);
    return list(cursor);
  }

  @override
  Future<Result<WordDetail>> getWordDetail(String id) => detail(id);

  @override
  Future<Result<Word>> getWord(String id) async =>
      const Failure(DomainFailure(FailureKind.notFound, 'word.not_found'));

  @override
  Future<Result<List<ExampleSentence>>> getExamples(String wordId) async =>
      const Success([]);
}
