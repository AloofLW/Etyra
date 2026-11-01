enum FailureKind { notFound, validation, storage, conflict, unsupported }

/// Stable UI-facing failure. Never contains a database exception or SQL text.
final class DomainFailure {
  const DomainFailure(this.kind, this.messageKey);
  final FailureKind kind;
  final String messageKey;
}

sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;
}

final class Failure<T> extends Result<T> {
  const Failure(this.error);
  final DomainFailure error;
}
