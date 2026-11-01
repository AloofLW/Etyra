final class Page<T> {
  Page({required Iterable<T> items, this.nextCursor, this.isFromCache = false})
    : items = List.unmodifiable(items);

  final List<T> items;
  final String? nextCursor;

  /// Local SQLite is authoritative; this is false unless an actual cache is used.
  final bool isFromCache;
}
