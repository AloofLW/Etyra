import 'dart:io';

import 'package:drift/drift.dart' show Variable;
import 'package:drift/native.dart';
import 'package:etyra/database/app_database.dart';
import 'package:etyra/features/shared/domain/content_types.dart';
import 'package:etyra/features/shared/domain/result.dart';
import 'package:etyra/features/study/data/drift_learning_state_repository.dart';
import 'package:etyra/features/study/data/drift_study_repository.dart';
import 'package:etyra/features/study/domain/study_models.dart';
import 'package:flutter_test/flutter_test.dart';

T success<T>(Result<T> result) {
  expect(result, isA<Success<T>>());
  return (result as Success<T>).value;
}

void failure<T>(Result<T> result, FailureKind kind) {
  expect(result, isA<Failure<T>>());
  expect((result as Failure<T>).error.kind, kind);
}

void main() {
  late Directory directory;
  late File file;
  late AppDatabase database;
  late DriftStudyRepository repository;
  final now = DateTime.utc(2026, 11, 1);

  Future<void> addRoot(String id) => database.customStatement(
    'INSERT INTO roots (id, lemma, display_form, language, meaning, verification_status, source_refs, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
    [
      id,
      'TEST_ONLY',
      'prompt-$id',
      'TEST_ONLY',
      'answer-$id',
      'unverified',
      '[]',
      0,
      0,
    ],
  );

  Future<int> count(String table) async =>
      (await database
              .customSelect('SELECT COUNT(*) AS n FROM $table')
              .getSingle())
          .read<int>('n');

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('etyra_study_test_');
    file = File('${directory.path}/study.sqlite');
    database = AppDatabase(NativeDatabase(file));
    repository = DriftStudyRepository(database, clock: () => now);
  });

  tearDown(() async {
    await database.close();
    await directory.delete(recursive: true);
  });

  test(
    'empty session and invalid or missing requested IDs do not write',
    () async {
      final empty = success(
        await repository.startStudySession(StudyMode.roots),
      );
      expect(empty.session, isNull);
      expect(empty.firstCard, isNull);
      expect(empty.totalCount, 0);
      failure(
        await repository.startStudySession(
          StudyMode.roots,
          contentIds: ['missing'],
        ),
        FailureKind.notFound,
      );
      failure(
        await repository.startStudySession(
          StudyMode.roots,
          contentIds: ['a', 'a'],
        ),
        FailureKind.validation,
      );
      expect(await count('study_sessions'), 0);
    },
  );

  test(
    'snapshots persist across restart and answers atomically complete session',
    () async {
      await addRoot('a');
      await addRoot('b');
      final start = success(
        await repository.startStudySession(
          StudyMode.roots,
          contentIds: ['b', 'a'],
        ),
      );
      final id = start.session!.id;
      expect(start.firstCard!.itemId, 'b');
      expect(start.firstCard!.position, 1);
      await database.customStatement(
        "UPDATE roots SET meaning = 'changed' WHERE id = 'a'",
      );
      await database.close();
      database = AppDatabase(NativeDatabase(file));
      repository = DriftStudyRepository(database, clock: () => now);
      final first = success(
        await repository.submitAnswer(
          AnswerInput(
            sessionId: id,
            itemId: 'b',
            rating: AnswerRating.recalled,
            responseMilliseconds: 23,
          ),
        ),
      );
      expect(first.nextCard!.itemId, 'a');
      expect(first.nextCard!.answer, 'answer-a');
      expect(first.sessionFinished, isFalse);
      expect(first.completedCount, 1);
      final second = success(
        await repository.submitAnswer(
          AnswerInput(
            sessionId: id,
            itemId: 'a',
            rating: AnswerRating.needsPractice,
          ),
        ),
      );
      expect(second.nextCard, isNull);
      expect(second.sessionFinished, isTrue);
      expect(second.completedCount, 2);
      await database.close();
      database = AppDatabase(NativeDatabase(file));
      repository = DriftStudyRepository(database, clock: () => now);
      final summary = success(await repository.finishSession(id));
      expect(summary.status, StudySessionStatus.completed);
      expect(summary.finishedAt, now);
      expect(success(await repository.finishSession(id)).finishedAt, now);
      failure(await repository.abandonSession(id), FailureKind.conflict);
      failure(await repository.skipItem(id, 'a'), FailureKind.conflict);
      final states = DriftLearningStateRepository(database);
      expect(
        success(await states.getState(ContentType.root, 'b')).stage,
        LearningStage.learned,
      );
      expect(
        success(await states.getState(ContentType.root, 'a')).stage,
        LearningStage.learning,
      );
      expect(await count('study_logs'), 2);
      final log = await database
          .customSelect(
            "SELECT response_ms FROM study_logs WHERE content_id = 'b'",
          )
          .getSingle();
      expect(log.read<int>('response_ms'), 23);
      final reserved = await database
          .customSelect(
            'SELECT due_at, fsrs_state_json, fsrs_due_at, fsrs_version FROM learning_states',
          )
          .get();
      for (final row in reserved) {
        expect(row.data.values, everyElement(isNull));
      }
    },
  );

  test(
    'duplicate and out-of-order submissions conflict without duplicate writes',
    () async {
      await addRoot('a');
      await addRoot('b');
      final start = success(
        await repository.startStudySession(StudyMode.roots),
      );
      final id = start.session!.id;
      failure(await repository.skipItem(id, 'b'), FailureKind.conflict);
      final input = AnswerInput(
        sessionId: id,
        itemId: 'a',
        rating: AnswerRating.recalled,
      );
      final results = await Future.wait([
        repository.submitAnswer(input),
        repository.submitAnswer(input),
      ]);
      expect(results.whereType<Success<AnswerResult>>(), hasLength(1));
      expect(
        results.whereType<Failure<AnswerResult>>().single.error.kind,
        FailureKind.conflict,
      );
      failure(await repository.finishSession(id), FailureKind.conflict);
      expect(await count('study_logs'), 1);
      final state = success(
        await DriftLearningStateRepository(database)
            .getState(ContentType.root, 'a'),
      );
      expect(state.studyCount, 1);
      expect(state.stage, LearningStage.learned);
    },
  );

  test(
    'skip preserves state; needsPractice cannot downgrade learned',
    () async {
      await addRoot('a');
      Future<String> session() async =>
          success(await repository.startStudySession(StudyMode.roots))
              .session!
              .id;
      final first = await session();
      success(
        await repository.submitAnswer(
          AnswerInput(
            sessionId: first,
            itemId: 'a',
            rating: AnswerRating.recalled,
          ),
        ),
      );
      final states = DriftLearningStateRepository(database);
      final before = success(await states.getState(ContentType.root, 'a'));
      final skip = await session();
      final skipped = success(await repository.skipItem(skip, 'a'));
      expect(skipped.outcome, AnswerOutcome.skipped);
      expect(skipped.completedCount, 0);
      expect(skipped.skippedCount, 1);
      final after = success(await states.getState(ContentType.root, 'a'));
      expect(after.stage, before.stage);
      expect(after.studyCount, before.studyCount);
      expect(after.lastStudiedAt, before.lastStudiedAt);
      final next = await session();
      success(
        await repository.submitAnswer(
          AnswerInput(
            sessionId: next,
            itemId: 'a',
            rating: AnswerRating.needsPractice,
          ),
        ),
      );
      final finalState = success(await states.getState(ContentType.root, 'a'));
      expect(finalState.stage, LearningStage.learned);
      expect(finalState.studyCount, 2);
      expect(finalState.dueAt, isNull);
    },
  );

  test(
    'abandon is idempotent, retains events and rejects further writes',
    () async {
      await addRoot('a');
      await addRoot('b');
      final start = success(
        await repository.startStudySession(StudyMode.roots),
      );
      final id = start.session!.id;
      success(
        await repository.submitAnswer(
          AnswerInput(
            sessionId: id,
            itemId: 'a',
            rating: AnswerRating.needsPractice,
          ),
        ),
      );
      final summary = success(await repository.abandonSession(id));
      expect(summary.status, StudySessionStatus.abandoned);
      expect(summary.completedCount, 1);
      expect(
        success(await repository.abandonSession(id)).finishedAt,
        summary.finishedAt,
      );
      failure(await repository.skipItem(id, 'b'), FailureKind.conflict);
      failure(await repository.finishSession(id), FailureKind.conflict);
      expect(await count('study_logs'), 1);
      expect(await count('learning_states'), 1);
    },
  );

  test(
    'a storage failure after log and state writes rolls back the entire answer',
    () async {
      await addRoot('a');
      final start = success(
        await repository.startStudySession(StudyMode.roots),
      );
      final id = start.session!.id;
      await database.customStatement(
        "CREATE TRIGGER fail_session BEFORE UPDATE ON study_sessions BEGIN SELECT RAISE(ABORT, 'test failure'); END",
      );
      failure(
        await repository.submitAnswer(
          AnswerInput(
            sessionId: id,
            itemId: 'a',
            rating: AnswerRating.recalled,
          ),
        ),
        FailureKind.storage,
      );
      expect(await count('study_logs'), 0);
      expect(await count('learning_states'), 0);
      final row = await database
          .customSelect(
            'SELECT status, completed_count, skipped_count, finished_at FROM study_sessions WHERE id = ?',
            variables: [Variable<String>(id)],
          )
          .getSingle();
      expect(row.read<String>('status'), 'active');
      expect(row.read<int>('completed_count'), 0);
      expect(row.read<int>('skipped_count'), 0);
      expect(row.readNullable<int>('finished_at'), isNull);
      await database.customStatement('DROP TRIGGER fail_session');
      expect(
        success(
          await repository.submitAnswer(
            AnswerInput(
              sessionId: id,
              itemId: 'a',
              rating: AnswerRating.recalled,
            ),
          ),
        ).sessionFinished,
        isTrue,
      );
    },
  );

  test(
    'two database connections reject the second concurrent answer',
    () async {
      await addRoot('a');
      await addRoot('b');
      final start = success(
        await repository.startStudySession(StudyMode.roots),
      );
      final otherDatabase = AppDatabase(NativeDatabase(file));
      try {
        await otherDatabase.customSelect('SELECT id FROM study_sessions').get();
        final other = DriftStudyRepository(otherDatabase, clock: () => now);
        final input = AnswerInput(
          sessionId: start.session!.id,
          itemId: 'a',
          rating: AnswerRating.recalled,
        );
        final answers = await Future.wait([
          repository.submitAnswer(input),
          other.submitAnswer(input),
        ]);
        expect(answers.whereType<Success<AnswerResult>>(), hasLength(1));
        expect(
          answers.whereType<Failure<AnswerResult>>().single.error.kind,
          FailureKind.conflict,
        );
        expect(await count('study_logs'), 1);
      } finally {
        await otherDatabase.close();
      }
    },
  );

  test('word mode snapshots translation and skipping new content does not create a state', () async {
    await database.customStatement(
      'INSERT INTO words (id, word, normalized_word, definition, translation, source_refs) VALUES (?, ?, ?, ?, ?, ?)',
      ['w', 'TEST_ONLY', 'test_only', 'definition', 'translation', '[]'],
    );
    final start = success(await repository.startStudySession(StudyMode.words));
    expect(start.firstCard!.contentType, ContentType.word);
    expect(start.firstCard!.answer, 'translation');
    expect(
      success(await repository.skipItem(start.session!.id, 'w'))
          .sessionFinished,
      isTrue,
    );
    expect(await count('study_logs'), 1);
    expect(await count('learning_states'), 0);
  });

  test('unknown session mode fails closed without changing data', () async {
    await addRoot('a');
    final start = success(await repository.startStudySession(StudyMode.roots));
    final id = start.session!.id;
    await database.customStatement(
      'UPDATE study_sessions SET mode = ? WHERE id = ?',
      ['future', id],
    );
    failure(
      await repository.submitAnswer(
        AnswerInput(sessionId: id, itemId: 'a', rating: AnswerRating.recalled),
      ),
      FailureKind.unsupported,
    );
    failure(await repository.abandonSession(id), FailureKind.unsupported);
    expect(await count('study_logs'), 0);
    final row = await database
        .customSelect(
          'SELECT status, mode FROM study_sessions WHERE id = ?',
          variables: [Variable<String>(id)],
        )
        .getSingle();
    expect(row.read<String>('mode'), 'future');
    expect(row.read<String>('status'), 'active');
  });

  test(
    'unknown persisted learning stages fail closed without writing an event',
    () async {
      await addRoot('a');
      await database.customStatement(
        "INSERT INTO learning_states (content_type, content_id, stage, study_count) VALUES ('root', 'a', 'future', 5)",
      );
      final start = success(
        await repository.startStudySession(StudyMode.roots),
      );
      failure(
        await repository.submitAnswer(
          AnswerInput(
            sessionId: start.session!.id,
            itemId: 'a',
            rating: AnswerRating.recalled,
          ),
        ),
        FailureKind.unsupported,
      );
      expect(await count('study_logs'), 0);
      final row = await database
          .customSelect(
            "SELECT stage, study_count FROM learning_states WHERE content_id = 'a'",
          )
          .getSingle();
      expect(row.read<String>('stage'), 'future');
      expect(row.read<int>('study_count'), 5);
    },
  );
}
