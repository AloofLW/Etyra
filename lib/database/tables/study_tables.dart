import 'package:drift/drift.dart';

@DataClassName('LearningStateRow')
class LearningStates extends Table {
  TextColumn get contentType => text()();
  TextColumn get contentId => text()();
  TextColumn get stage => text()();
  IntColumn get lastStudiedAt => integer().nullable()();
  IntColumn get studyCount => integer().withDefault(const Constant(0))();
  // Nullable compatibility slots only. v0.1 never writes scheduling results.
  IntColumn get dueAt => integer().nullable()();
  TextColumn get fsrsStateJson => text().nullable()();
  IntColumn get fsrsDueAt => integer().nullable()();
  TextColumn get fsrsVersion => text().nullable()();
  @override
  Set<Column> get primaryKey => {contentType, contentId};
  @override
  List<String> get customConstraints => ['CHECK (study_count >= 0)'];
}

@DataClassName('StudySessionRow')
class StudySessions extends Table {
  TextColumn get id => text()();
  TextColumn get mode => text()();
  TextColumn get status => text()();
  IntColumn get startedAt => integer()();
  IntColumn get finishedAt => integer().nullable()();
  IntColumn get itemCount => integer()();
  IntColumn get completedCount => integer().withDefault(const Constant(0))();
  IntColumn get skippedCount => integer().withDefault(const Constant(0))();
  @override
  Set<Column> get primaryKey => {id};
  @override
  List<String> get customConstraints => [
    'CHECK (item_count > 0)',
    'CHECK (completed_count >= 0 AND skipped_count >= 0)',
    'CHECK (completed_count + skipped_count <= item_count)',
    'CHECK (finished_at IS NULL OR finished_at >= started_at)',
  ];
}

/// Ordered, durable card snapshots, isolated from later content upgrades.
@DataClassName('StudySessionItemRow')
class StudySessionItems extends Table {
  TextColumn get sessionId => text().references(StudySessions, #id)();
  TextColumn get itemId => text()();
  TextColumn get contentType => text()();
  TextColumn get prompt => text()();
  TextColumn get answer => text()();
  TextColumn get hintsJson => text()();
  IntColumn get position => integer()();
  @override
  Set<Column> get primaryKey => {sessionId, itemId};
  @override
  List<Set<Column>> get uniqueKeys => [
    {sessionId, position},
  ];
  @override
  List<String> get customConstraints => ['CHECK (position > 0)'];
}

@DataClassName('StudyLogRow')
class StudyLogs extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text().references(StudySessions, #id)();
  TextColumn get contentType => text()();
  TextColumn get contentId => text()();
  TextColumn get outcome => text()();
  IntColumn get answeredAt => integer()();
  IntColumn get responseMs => integer().nullable()();
  @override
  Set<Column> get primaryKey => {id};
  @override
  List<Set<Column>> get uniqueKeys => [
    {sessionId, contentId},
  ];
  @override
  List<String> get customConstraints => [
    'CHECK (response_ms IS NULL OR response_ms >= 0)',
    'FOREIGN KEY (session_id, content_id) REFERENCES study_session_items (session_id, item_id)',
  ];
}
