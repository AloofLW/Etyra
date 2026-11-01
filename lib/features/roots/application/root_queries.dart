import '../../shared/domain/page.dart';
import '../../shared/domain/result.dart';
import '../domain/root.dart';
import '../domain/root_repository.dart';

final class ListRoots {
  const ListRoots(this.repository);
  final RootRepository repository;
  Future<Result<Page<Root>>> call({
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
    return repository.listRoots(query: query, cursor: cursor, limit: limit);
  }
}

final class GetRootDetail {
  const GetRootDetail(this.repository);
  final RootRepository repository;
  Future<Result<RootDetail>> call(String rootId) {
    if (rootId.trim().isEmpty) {
      return Future.value(
        const Failure(
          DomainFailure(FailureKind.validation, 'content.invalid_id'),
        ),
      );
    }
    return repository.getRootDetail(rootId);
  }
}
