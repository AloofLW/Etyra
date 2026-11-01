import 'dart:convert';

import 'package:drift/drift.dart';

import '../../shared/data/content_mapper.dart';
import '../../shared/domain/content_types.dart';
import '../../shared/domain/result.dart';
import '../../shared/domain/source_ref.dart';
import 'seed_package.dart';

/// Additive-only v1 importer. Changed content under an existing stable ID is
/// rejected until an audited content-upgrade policy is agreed. Never REPLACE,
/// delete content, or write user tables. Each package is self-contained.
final class SeedImporter {
  SeedImporter(this.database, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;
  final GeneratedDatabase database;
  final DateTime Function() _clock;
  static const _mapper = ContentMapper();

  Future<Result<SeedImportReceipt>> importPackage(SeedPackage package) async {
    final invalid = _validate(package);
    if (invalid != null) return Failure(invalid);
    try {
      final groups = _rows(package);
      // The canonical payload includes human-review metadata as audit evidence.
      final payload = jsonEncode({
        'packageId': package.packageId,
        'version': package.version,
        'reviewedBy': package.reviewedBy,
        'reviewReference': package.reviewReference,
        'reviewedAt': package.reviewedAt.toIso8601String(),
        'tables': groups,
      });
      final count = groups.values.fold<int>(0, (n, rows) => n + rows.length);
      return await database.transaction(() async {
        final previous = await database
            .customSelect(
              'SELECT payload_json FROM seed_imports WHERE package_id = ? AND version = ?',
              variables: [
                Variable<String>(package.packageId),
                Variable<int>(package.version),
              ],
            )
            .get();
        if (previous.isNotEmpty) {
          if (previous.single.read<String>('payload_json') != payload) {
            throw const _ImportRejected(
              DomainFailure(
                FailureKind.conflict,
                'seed.version_payload_changed',
              ),
            );
          }
          return Success(
            SeedImportReceipt(
              packageId: package.packageId,
              version: package.version,
              itemCount: count,
              alreadyImported: true,
            ),
          );
        }
        final newer = await database
            .customSelect(
              'SELECT version FROM seed_imports WHERE package_id = ? AND version > ? LIMIT 1',
              variables: [
                Variable<String>(package.packageId),
                Variable<int>(package.version),
              ],
            )
            .get();
        if (newer.isNotEmpty) {
          throw const _ImportRejected(
            DomainFailure(FailureKind.conflict, 'seed.downgrade_rejected'),
          );
        }
        final now = _clock().toUtc().millisecondsSinceEpoch;
        for (final group in groups.entries) {
          for (final row in group.value) {
            await _insertUnchangedOrNew(group.key, row, now);
          }
        }
        await database.customStatement(
          'INSERT INTO seed_imports (package_id, version, payload_json, reviewed_by, review_reference, reviewed_at, imported_at, item_count) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
          [
            package.packageId,
            package.version,
            payload,
            package.reviewedBy,
            package.reviewReference,
            package.reviewedAt.millisecondsSinceEpoch,
            now,
            count,
          ],
        );
        return Success(
          SeedImportReceipt(
            packageId: package.packageId,
            version: package.version,
            itemCount: count,
            alreadyImported: false,
          ),
        );
      });
    } on _ImportRejected catch (failure) {
      return Failure(failure.error);
    } catch (_) {
      return const Failure(
        DomainFailure(FailureKind.storage, 'seed.import_failed'),
      );
    }
  }

  Future<void> _insertUnchangedOrNew(
    String table,
    Map<String, Object?> row,
    int now,
  ) async {
    final keys = table == 'word_components'
        ? ['word_id', 'component_type', 'component_id', 'role']
        : ['id'];
    final existing = await database
        .customSelect(
          'SELECT * FROM $table WHERE ${keys.map((k) => '$k = ?').join(' AND ')}',
          variables: [
            for (final key in keys) Variable<String>(row[key]! as String),
          ],
        )
        .get();
    if (existing.isNotEmpty) {
      if (row.entries.any((e) => existing.single.data[e.key] != e.value)) {
        throw const _ImportRejected(
          DomainFailure(FailureKind.conflict, 'seed.existing_content_changed'),
        );
      }
      return;
    }
    final values = <String, Object?>{
      ...row,
      if (table == 'roots') ...{'created_at': now, 'updated_at': now},
    };
    await database.customStatement(
      'INSERT INTO $table (${values.keys.join(', ')}) VALUES (${List.filled(values.length, '?').join(', ')})',
      values.values.toList(),
    );
  }

  DomainFailure? _validate(SeedPackage package) {
    DomainFailure invalid(String key) =>
        DomainFailure(FailureKind.validation, key);
    if (package.packageId.trim().isEmpty || package.version <= 0) {
      return invalid('seed.invalid_manifest');
    }
    if (!package.approvedForRedistribution ||
        package.reviewedBy.trim().isEmpty ||
        package.reviewReference.trim().isEmpty) {
      return invalid('seed.review_required');
    }
    bool validIds(Iterable<String> ids) {
      final values = ids.toList();
      return values.every((id) => id.trim().isNotEmpty) &&
          values.toSet().length == values.length;
    }

    if (!validIds(package.roots.map((r) => r.id)) ||
        !validIds(package.affixes.map((a) => a.id)) ||
        !validIds(package.words.map((w) => w.id)) ||
        !validIds(package.examples.map((e) => e.id))) {
      return invalid('seed.invalid_or_duplicate_id');
    }
    final sourcesById = <String, String>{};
    bool validSources(List<SourceRef> sources) {
      if (sources.isEmpty) return false;
      for (final source in sources) {
        if (source.id.trim().isEmpty ||
            source.title.trim().isEmpty ||
            ((source.url ?? '').trim().isEmpty &&
                (source.locator ?? '').trim().isEmpty) ||
            (source.licenseName ?? '').trim().isEmpty) {
          return false;
        }
        final serialized = jsonEncode(_mapper.sourceToJson(source));
        if (sourcesById.containsKey(source.id) &&
            sourcesById[source.id] != serialized) {
          return false;
        }
        sourcesById[source.id] = serialized;
      }
      return true;
    }

    for (final sources in [
      ...package.roots.map((r) => r.sources),
      ...package.affixes.map((a) => a.sources),
      ...package.words.map((w) => w.sources),
      ...package.components.map((c) => c.sources),
      ...package.examples.map((e) => e.sources),
    ]) {
      if (!validSources(sources)) {
        return invalid('seed.source_or_license_missing');
      }
    }
    if (package.roots.any(
          (r) => [
            r.lemma,
            r.displayForm,
            r.language,
            r.meaning,
          ].any((s) => s.trim().isEmpty),
        ) ||
        package.affixes.any(
          (a) => a.form.trim().isEmpty || a.meaning.trim().isEmpty,
        ) ||
        package.words.any(
          (w) => [
            w.word,
            w.normalizedWord,
            w.definition,
          ].any((s) => s.trim().isEmpty),
        ) ||
        package.examples.any((e) => e.sentence.trim().isEmpty)) {
      return invalid('seed.required_text_missing');
    }
    final roots = package.roots.map((r) => r.id).toSet();
    final affixes = package.affixes.map((a) => a.id).toSet();
    final words = package.words.map((w) => w.id).toSet();
    final componentKeys = <(String, ComponentType, String, ComponentRole)>{};
    for (final component in package.components) {
      if (!words.contains(component.wordId) ||
          !(component.componentType == ComponentType.root ? roots : affixes)
              .contains(component.componentId)) {
        return invalid('seed.dangling_component');
      }
      if (!componentKeys.add((
        component.wordId,
        component.componentType,
        component.componentId,
        component.role,
      ))) {
        return invalid('seed.duplicate_component');
      }
      final confidence = component.confidence;
      if (confidence != null &&
          (!confidence.isFinite || confidence < 0 || confidence > 1)) {
        return invalid('seed.invalid_confidence');
      }
    }
    if (package.examples.any((e) => !words.contains(e.wordId))) {
      return invalid('seed.dangling_example');
    }
    return null;
  }

  Map<String, List<Map<String, Object?>>> _rows(SeedPackage package) {
    // Stable list ordering, including source IDs, makes equivalent packages
    // independent of the order in which their content records were supplied.
    String sources(List<SourceRef> values) => _mapper.sourcesToJson(
      values.toList()..sort((a, b) => a.id.compareTo(b.id)),
    );
    List<Map<String, Object?>> sorted(Iterable<Map<String, Object?>> values) =>
        values.toList()..sort((a, b) => jsonEncode(a).compareTo(jsonEncode(b)));
    return {
      'roots': sorted(
        package.roots.map(
          (r) => <String, Object?>{
            'id': r.id,
            'lemma': r.lemma,
            'display_form': r.displayForm,
            'language': r.language,
            'meaning': r.meaning,
            'origin_note': r.originNote,
            'verification_status': r.verificationStatus.name,
            'source_refs': sources(r.sources),
          },
        ),
      ),
      'affixes': sorted(
        package.affixes.map(
          (a) => <String, Object?>{
            'id': a.id,
            'form': a.form,
            'kind': a.kind.name,
            'meaning': a.meaning,
            'verification_status': a.verificationStatus.name,
            'source_refs': sources(a.sources),
          },
        ),
      ),
      'words': sorted(
        package.words.map(
          (w) => <String, Object?>{
            'id': w.id,
            'word': w.word,
            'normalized_word': w.normalizedWord,
            'part_of_speech': w.partOfSpeech,
            'definition': w.definition,
            'translation': w.translation,
            'pronunciation_ref': w.pronunciationRef,
            'source_refs': sources(w.sources),
          },
        ),
      ),
      'word_components': sorted(
        package.components.map(
          (c) => <String, Object?>{
            'word_id': c.wordId,
            'component_type': c.componentType.name,
            'component_id': c.componentId,
            'role': c.role.name,
            'confidence': c.confidence,
            'source_refs': sources(c.sources),
          },
        ),
      ),
      'examples': sorted(
        package.examples.map(
          (e) => <String, Object?>{
            'id': e.id,
            'word_id': e.wordId,
            'sentence': e.sentence,
            'translation': e.translation,
            'source_refs': sources(e.sources),
          },
        ),
      ),
    };
  }
}

final class _ImportRejected implements Exception {
  const _ImportRejected(this.error);
  final DomainFailure error;
}
