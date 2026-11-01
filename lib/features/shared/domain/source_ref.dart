final class SourceRef {
  SourceRef({
    required this.id,
    required this.title,
    this.publisher,
    this.edition,
    this.url,
    this.locator,
    this.licenseName,
    this.licenseUrl,
    this.attributionText,
    DateTime? accessedAt,
  }) : accessedAt = accessedAt?.toUtc();

  final String id;
  final String title;
  final String? publisher;
  final String? edition;
  final String? url;
  final String? locator;
  final String? licenseName;
  final String? licenseUrl;
  final String? attributionText;
  final DateTime? accessedAt;
}
