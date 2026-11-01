import 'package:drift/drift.dart';

@DataClassName('RootRow')
class Roots extends Table {
  TextColumn get id => text()();
  TextColumn get lemma => text()();
  TextColumn get displayForm => text()();
  TextColumn get language => text()();
  TextColumn get meaning => text()();
  TextColumn get originNote => text().nullable()();
  TextColumn get verificationStatus => text()();
  TextColumn get sourceRefs => text()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('AffixRow')
class Affixes extends Table {
  TextColumn get id => text()();
  TextColumn get form => text()();
  TextColumn get kind => text()();
  TextColumn get meaning => text()();
  TextColumn get verificationStatus => text()();
  TextColumn get sourceRefs => text()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WordRow')
class Words extends Table {
  TextColumn get id => text()();
  TextColumn get word => text()();
  TextColumn get normalizedWord => text()();
  TextColumn get partOfSpeech => text().nullable()();
  TextColumn get definition => text()();
  TextColumn get translation => text().nullable()();
  TextColumn get pronunciationRef => text().nullable()();
  TextColumn get sourceRefs => text()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WordComponentRow')
class WordComponents extends Table {
  TextColumn get wordId => text().references(Words, #id)();
  TextColumn get componentType => text()();
  TextColumn get componentId => text()();
  TextColumn get role => text()();
  RealColumn get confidence => real().nullable()();
  TextColumn get sourceRefs => text()();
  @override
  Set<Column> get primaryKey => {wordId, componentType, componentId, role};
  @override
  List<String> get customConstraints => [
    'CHECK (confidence IS NULL OR (confidence >= 0 AND confidence <= 1))',
  ];
}

@DataClassName('ExampleRow')
class Examples extends Table {
  TextColumn get id => text()();
  TextColumn get wordId => text().references(Words, #id)();
  TextColumn get sentence => text()();
  TextColumn get translation => text().nullable()();
  TextColumn get sourceRefs => text()();
  @override
  Set<Column> get primaryKey => {id};
}

/// A receipt is committed atomically with its content. Exact payload comparison
/// rejects reuse of a package version with changed data, without a hash dependency.
@DataClassName('SeedImportRow')
class SeedImports extends Table {
  TextColumn get packageId => text()();
  IntColumn get version => integer()();
  TextColumn get payloadJson => text()();
  TextColumn get reviewedBy => text()();
  TextColumn get reviewReference => text()();
  IntColumn get reviewedAt => integer()();
  IntColumn get importedAt => integer()();
  IntColumn get itemCount => integer()();
  @override
  Set<Column> get primaryKey => {packageId, version};
}
