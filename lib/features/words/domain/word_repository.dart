import '../../shared/domain/page.dart';
import '../../shared/domain/result.dart';
import 'word.dart';
import 'word_detail.dart';

abstract interface class WordRepository {
  Future<Result<Word>> getWord(String id);
  Future<Result<WordDetail>> getWordDetail(String id);
  Future<Result<Page<Word>>> listWords({
    String? query,
    String? cursor,
    int limit = 30,
  });
  Future<Result<List<ExampleSentence>>> getExamples(String wordId);
}
