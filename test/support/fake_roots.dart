import 'package:etyra/features/roots/domain/root.dart';
import 'package:etyra/features/roots/domain/root_repository.dart';
import 'package:etyra/features/shared/domain/page.dart' as domain;
import 'package:etyra/features/shared/domain/result.dart';

class FakeRoots implements RootRepository {
  Future<Result<domain.Page<Root>>> Function(String? cursor) list = (_) async =>
      Success(domain.Page(items: []));
  Future<Result<RootDetail>> Function(String id) detail = (_) async =>
      const Failure(DomainFailure(FailureKind.notFound, 'root.not_found'));
  final cursors = <String?>[];

  @override
  Future<Result<domain.Page<Root>>> listRoots({
    String? query,
    String? cursor,
    int limit = 30,
  }) {
    cursors.add(cursor);
    return list(cursor);
  }

  @override
  Future<Result<RootDetail>> getRootDetail(String rootId) => detail(rootId);
}
