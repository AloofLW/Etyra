import '../../shared/domain/page.dart';
import '../../shared/domain/result.dart';
import '../domain/word.dart';
import '../domain/word_detail.dart';
import '../domain/word_repository.dart';

final class GetWord {
  const GetWord(this.repository);
  final WordRepository repository;
  Future<Result<Word>> call(String id) => repository.getWord(id);
}

final class GetWordDetail {
  const GetWordDetail(this.repository);
  final WordRepository repository;
  Future<Result<WordDetail>> call(String id) => repository.getWordDetail(id);
}

final class ListWords {
  const ListWords(this.repository);
  final WordRepository repository;
  Future<Result<Page<Word>>> call({
    String? query,
    String? cursor,
    int limit = 30,
  }) {
    if (limit <= 0) {
      return Future.value(
        const Failure(
          DomainFailure(FailureKind.validation, 'pagination.invalid_limit'),
        ),
      );
    }
    return repository.listWords(query: query, cursor: cursor, limit: limit);
  }
}

final class GetExamples {
  const GetExamples(this.repository);
  final WordRepository repository;
  Future<Result<List<ExampleSentence>>> call(String wordId) =>
      repository.getExamples(wordId);
}
