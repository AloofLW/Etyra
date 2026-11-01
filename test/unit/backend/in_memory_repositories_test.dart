import 'package:etyra/features/roots/application/root_queries.dart';
import 'package:etyra/features/roots/domain/root.dart';
import 'package:etyra/features/shared/data/in_memory_content_repository.dart';
import 'package:etyra/features/shared/domain/content_types.dart';
import 'package:etyra/features/shared/domain/result.dart';
import 'package:etyra/features/shared/domain/source_ref.dart';
import 'package:etyra/features/study/application/study_commands.dart';
import 'package:etyra/features/study/data/in_memory_study_repository.dart';
import 'package:etyra/features/study/domain/study_models.dart';
import 'package:flutter_test/flutter_test.dart';

// Synthetic identifiers/text only: these fixtures make no linguistic claims
// and must never be included in a redistributable content package.
Root fixture(String id) => Root(
  id: id,
  lemma: 'TEST_ONLY',
  displayForm: 'TEST_ONLY',
  language: 'TEST_ONLY',
  meaning: 'TEST_ONLY',
  verificationStatus: VerificationStatus.unverified,
  sources: const [],
);

T value<T>(Result<T> result) {
  expect(result, isA<Success<T>>());
  return (result as Success<T>).value;
}

void expectFailure<T>(Result<T> result, FailureKind kind) {
  expect(result, isA<Failure<T>>());
  expect((result as Failure<T>).error.kind, kind);
}

void main() {
  test('empty content creates no submittable session', () async {
    final repository = InMemoryStudyRepository(InMemoryContentRepository());
    final start = value(await repository.startStudySession(StudyMode.roots));
    expect(start.session, isNull);
    expect(start.firstCard, isNull);
    expect(start.totalCount, 0);
    expect(repository.events, isEmpty);
  });

  test(
    'keyset pagination preserves order and rejects mismatched cursors',
    () async {
      final repository = InMemoryContentRepository(
        roots: [fixture('b'), fixture('a'), fixture('c')],
      );
      final first = value(await repository.listRoots(limit: 2));
      expect(first.items.map((r) => r.id), ['a', 'b']);
      final second = value(
        await repository.listRoots(limit: 2, cursor: first.nextCursor),
      );
      expect(second.items.map((r) => r.id), ['c']);
      expect(second.nextCursor, isNull);
      expectFailure(
        await repository.listRoots(query: 'changed', cursor: first.nextCursor),
        FailureKind.validation,
      );
      expectFailure(
        await repository.listRoots(cursor: 'malformed'),
        FailureKind.validation,
      );
      expectFailure(
        await ListRoots(repository)(limit: 0),
        FailureKind.validation,
      );
    },
  );

  test(
    'duplicate concurrent submissions create one event and one state update',
    () async {
      final repository = InMemoryStudyRepository(
        InMemoryContentRepository(roots: [fixture('a')]),
      );
      final start = value(await repository.startStudySession(StudyMode.roots));
      final input = AnswerInput(
        sessionId: start.session!.id,
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
      expect(repository.events, hasLength(1));
      final state = value(await repository.getState(ContentType.root, 'a'));
      expect(state.stage, LearningStage.learned);
      expect(state.studyCount, 1);
      expect(state.dueAt, isNull);
      final summary = value(await repository.finishSession(start.session!.id));
      expect(summary.completedCount, 1);
      expect(summary.status, StudySessionStatus.completed);
      final repeat = value(await repository.finishSession(start.session!.id));
      expect(repeat.finishedAt, summary.finishedAt);
    },
  );

  test('skip counts separately and leaves learning state untouched', () async {
    final repository = InMemoryStudyRepository(
      InMemoryContentRepository(roots: [fixture('a')]),
    );
    final start = value(await repository.startStudySession(StudyMode.roots));
    final answer = value(await repository.skipItem(start.session!.id, 'a'));
    expect(answer.outcome, AnswerOutcome.skipped);
    expect(answer.completedCount, 0);
    expect(answer.skippedCount, 1);
    expect(answer.sessionFinished, isTrue);
    expect(answer.nextCard, isNull);
    final state = value(await repository.getState(ContentType.root, 'a'));
    expect(state.stage, LearningStage.newItem);
    expect(state.studyCount, 0);
  });

  test(
    'item stage follows its answer independently of session completion',
    () async {
      final repository = InMemoryStudyRepository(
        InMemoryContentRepository(roots: [fixture('a'), fixture('b')]),
      );
      final start = value(await repository.startStudySession(StudyMode.roots));
      final first = value(
        await repository.submitAnswer(
          AnswerInput(
            sessionId: start.session!.id,
            itemId: 'a',
            rating: AnswerRating.recalled,
          ),
        ),
      );
      expect(first.sessionFinished, isFalse);
      final recalled = value(await repository.getState(ContentType.root, 'a'));
      expect(recalled.stage, LearningStage.learned);
      expect(recalled.dueAt, isNull);

      final last = value(
        await repository.submitAnswer(
          AnswerInput(
            sessionId: start.session!.id,
            itemId: 'b',
            rating: AnswerRating.needsPractice,
          ),
        ),
      );
      expect(last.sessionFinished, isTrue);
      await repository.finishSession(start.session!.id);
      expect(
        value(await repository.getState(ContentType.root, 'a')).stage,
        LearningStage.learned,
      );
      expect(
        value(await repository.getState(ContentType.root, 'b')).stage,
        LearningStage.learning,
      );
    },
  );

  test(
    'practice becomes learned on recall and later practice cannot downgrade it',
    () async {
      final repository = InMemoryStudyRepository(
        InMemoryContentRepository(roots: [fixture('a')]),
      );
      final initial = value(await repository.getState(ContentType.root, 'a'));
      expect(initial.stage, LearningStage.newItem);
      final ratings = [
        AnswerRating.needsPractice,
        AnswerRating.recalled,
        AnswerRating.needsPractice,
      ];
      final stages = [
        LearningStage.learning,
        LearningStage.learned,
        LearningStage.learned,
      ];
      for (var i = 0; i < ratings.length; i++) {
        final start = value(
          await repository.startStudySession(StudyMode.roots),
        );
        await repository.submitAnswer(
          AnswerInput(
            sessionId: start.session!.id,
            itemId: 'a',
            rating: ratings[i],
          ),
        );
        final state = value(await repository.getState(ContentType.root, 'a'));
        expect(state.stage, stages[i]);
        expect(state.studyCount, i + 1);
        expect(state.dueAt, isNull);
      }
    },
  );

  for (final rating in AnswerRating.values) {
    test('skip preserves existing state after ${rating.name}', () async {
      final repository = InMemoryStudyRepository(
        InMemoryContentRepository(roots: [fixture('a')]),
      );
      final start = value(await repository.startStudySession(StudyMode.roots));
      await repository.submitAnswer(
        AnswerInput(sessionId: start.session!.id, itemId: 'a', rating: rating),
      );
      final before = value(await repository.getState(ContentType.root, 'a'));
      final next = value(await repository.startStudySession(StudyMode.roots));
      final skipped = value(await repository.skipItem(next.session!.id, 'a'));
      await repository.finishSession(next.session!.id);
      final after = value(await repository.getState(ContentType.root, 'a'));
      expect(skipped.sessionFinished, isTrue);
      expect(after.stage, before.stage);
      expect(after.studyCount, before.studyCount);
      expect(after.lastStudiedAt, before.lastStudiedAt);
      expect(after.dueAt, isNull);
    });
  }

  test('abandon preserves answers and forbids further submissions', () async {
    final repository = InMemoryStudyRepository(
      InMemoryContentRepository(roots: [fixture('a'), fixture('b')]),
    );
    final start = value(await repository.startStudySession(StudyMode.roots));
    final id = start.session!.id;
    await repository.submitAnswer(
      AnswerInput(
        sessionId: id,
        itemId: 'a',
        rating: AnswerRating.needsPractice,
      ),
    );
    final summary = value(await repository.abandonSession(id));
    expect(summary.status, StudySessionStatus.abandoned);
    expect(summary.completedCount, 1);
    expect(repository.events, hasLength(1));
    expectFailure(await repository.skipItem(id, 'b'), FailureKind.conflict);
    expectFailure(await repository.finishSession(id), FailureKind.conflict);
    expect(
      value(await repository.abandonSession(id)).finishedAt,
      summary.finishedAt,
    );
  });

  test(
    'reject out-of-order answers, unknown content and early finish',
    () async {
      final repository = InMemoryStudyRepository(
        InMemoryContentRepository(roots: [fixture('a'), fixture('b')]),
      );
      expectFailure(
        await repository.startStudySession(
          StudyMode.roots,
          contentIds: ['missing'],
        ),
        FailureKind.notFound,
      );
      expectFailure(
        await StartStudySession(repository)(
          StudyMode.roots,
          contentIds: ['a', 'a'],
        ),
        FailureKind.validation,
      );
      final start = value(await repository.startStudySession(StudyMode.roots));
      expectFailure(
        await repository.skipItem(start.session!.id, 'b'),
        FailureKind.conflict,
      );
      expectFailure(
        await repository.finishSession(start.session!.id),
        FailureKind.conflict,
      );
      expectFailure(
        await SubmitAnswer(repository)(
          AnswerInput(
            sessionId: start.session!.id,
            itemId: 'a',
            rating: AnswerRating.recalled,
            responseMilliseconds: -1,
          ),
        ),
        FailureKind.validation,
      );
      expect(repository.events, isEmpty);
    },
  );

  test('model snapshots copy collections and normalize timestamps to UTC', () {
    final sources = <SourceRef>[];
    final root = Root(
      id: 'test',
      lemma: 'TEST_ONLY',
      displayForm: 'TEST_ONLY',
      language: 'TEST_ONLY',
      meaning: 'TEST_ONLY',
      verificationStatus: VerificationStatus.unverified,
      sources: sources,
    );
    sources.add(SourceRef(id: 'test-source', title: 'TEST_ONLY'));
    expect(root.sources, isEmpty);
    expect(() => root.sources.add(sources.single), throwsUnsupportedError);
    final state = LearningState(
      contentId: 'test',
      contentType: ContentType.root,
      stage: LearningStage.learning,
      studyCount: 1,
      lastStudiedAt: DateTime.parse('2026-11-01T12:00:00+08:00'),
    );
    expect(state.lastStudiedAt, DateTime.utc(2026, 11, 1, 4));
    expect(state.lastStudiedAt!.isUtc, isTrue);
  });
}
