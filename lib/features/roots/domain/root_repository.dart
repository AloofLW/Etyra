import '../../shared/domain/page.dart';
import '../../shared/domain/result.dart';
import 'root.dart';

abstract interface class RootRepository {
  Future<Result<Page<Root>>> listRoots({
    String? query,
    String? cursor,
    int limit = 30,
  });
  Future<Result<RootDetail>> getRootDetail(String rootId);
}
