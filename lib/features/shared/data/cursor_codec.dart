import 'dart:convert';

/// A keyset token tied to the exact collection and query. No SQL offsets.
final class CursorCodec {
  const CursorCodec();
  String encode(String scope, String query, String lastId) =>
      base64Url.encode(utf8.encode(jsonEncode([1, scope, query, lastId])));

  String? decode(String? cursor, String scope, String query) {
    if (cursor == null) return null;
    try {
      final value = jsonDecode(utf8.decode(base64Url.decode(cursor)));
      if (value is! List ||
          value.length != 4 ||
          value[0] != 1 ||
          value[1] != scope ||
          value[2] != query ||
          value[3] is! String ||
          (value[3] as String).isEmpty) {
        throw const FormatException('Invalid cursor');
      }
      return value[3] as String;
    } on FormatException {
      rethrow;
    } catch (_) {
      throw const FormatException('Invalid cursor');
    }
  }
}
