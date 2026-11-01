import 'package:etyra/features/roots/domain/root.dart';
import 'package:etyra/features/shared/data/content_mapper.dart';
import 'package:etyra/features/shared/domain/content_types.dart';
import 'package:etyra/features/shared/domain/source_ref.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const mapper = ContentMapper();
  test('all provenance and license fields survive JSON round trip', () {
    final source = SourceRef(
      id: 'test-source',
      title: 'TEST_ONLY',
      publisher: 'TEST_ONLY',
      edition: 'test-edition',
      url: 'https://example.invalid/test',
      locator: 'test-page',
      licenseName: 'TEST_ONLY',
      licenseUrl: 'https://example.invalid/license',
      attributionText: 'TEST_ONLY',
      accessedAt: DateTime.parse('2026-11-01T08:00:00+08:00'),
    );
    final decoded = mapper
        .sourcesFromJson(mapper.sourcesToJson([source]))
        .single;
    expect(mapper.sourceToJson(decoded), mapper.sourceToJson(source));
    expect(decoded.accessedAt!.isUtc, isTrue);
  });

  test(
    'missing sources cannot become verified, including direct domain input',
    () {
      final root = Root(
        id: 'test',
        lemma: 'TEST_ONLY',
        displayForm: 'TEST_ONLY',
        language: 'TEST_ONLY',
        meaning: 'TEST_ONLY',
        verificationStatus: VerificationStatus.verified,
        sources: const [],
      );
      expect(root.verificationStatus, VerificationStatus.unverified);
      final mapped = mapper.root({
        'id': 'test',
        'lemma': 'TEST_ONLY',
        'display_form': 'TEST_ONLY',
        'language': 'TEST_ONLY',
        'meaning': 'TEST_ONLY',
        'origin_note': null,
        'verification_status': 'future_status',
        'source_refs': '[]',
      });
      expect(mapped.verificationStatus, VerificationStatus.unverified);
    },
  );

  test(
    'unknown component types are omitted without fabricating a root relation',
    () {
      expect(mapper.component({'component_type': 'future_type'}), isNull);
    },
  );

  test('malformed provenance is not silently accepted as trusted content', () {
    expect(() => mapper.sourcesFromJson('{invalid'), throwsFormatException);
  });
}
