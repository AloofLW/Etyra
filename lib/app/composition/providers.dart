import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../database/app_database.dart';
import '../../features/roots/application/root_queries.dart';
import '../../features/roots/domain/root_repository.dart';
import '../../features/shared/data/drift_content_repository.dart';
import '../../features/study/application/get_learning_state.dart';
import '../../features/study/application/study_commands.dart';
import '../../features/study/data/drift_learning_state_repository.dart';
import '../../features/study/data/drift_study_repository.dart';
import '../../features/study/domain/study_repository.dart';
import '../../features/words/application/word_queries.dart';
import '../../features/words/domain/word_repository.dart';

/// The single lazily opened SQLite database for the application scope.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase(driftDatabase(name: 'etyra'));
  ref.onDispose(() => unawaited(database.close()));
  return database;
});

/// One content adapter implements both read-only content repositories.
final driftContentRepositoryProvider = Provider<DriftContentRepository>(
  (ref) => DriftContentRepository(ref.watch(appDatabaseProvider)),
);

final rootRepositoryProvider = Provider<RootRepository>(
  (ref) => ref.watch(driftContentRepositoryProvider),
);

final wordRepositoryProvider = Provider<WordRepository>(
  (ref) => ref.watch(driftContentRepositoryProvider),
);

final studyRepositoryProvider = Provider<StudyRepository>(
  (ref) => DriftStudyRepository(ref.watch(appDatabaseProvider)),
);

final learningStateRepositoryProvider = Provider<LearningStateRepository>(
  (ref) => DriftLearningStateRepository(ref.watch(appDatabaseProvider)),
);

final listRootsProvider = Provider<ListRoots>(
  (ref) => ListRoots(ref.watch(rootRepositoryProvider)),
);

final getRootDetailProvider = Provider<GetRootDetail>(
  (ref) => GetRootDetail(ref.watch(rootRepositoryProvider)),
);

final getWordProvider = Provider<GetWord>(
  (ref) => GetWord(ref.watch(wordRepositoryProvider)),
);

final getWordDetailProvider = Provider<GetWordDetail>(
  (ref) => GetWordDetail(ref.watch(wordRepositoryProvider)),
);

final listWordsProvider = Provider<ListWords>(
  (ref) => ListWords(ref.watch(wordRepositoryProvider)),
);

final getExamplesProvider = Provider<GetExamples>(
  (ref) => GetExamples(ref.watch(wordRepositoryProvider)),
);

final startStudySessionProvider = Provider<StartStudySession>(
  (ref) => StartStudySession(ref.watch(studyRepositoryProvider)),
);

final submitAnswerProvider = Provider<SubmitAnswer>(
  (ref) => SubmitAnswer(ref.watch(studyRepositoryProvider)),
);

final skipItemProvider = Provider<SkipItem>(
  (ref) => SkipItem(ref.watch(studyRepositoryProvider)),
);

final finishSessionProvider = Provider<FinishSession>(
  (ref) => FinishSession(ref.watch(studyRepositoryProvider)),
);

final abandonSessionProvider = Provider<AbandonSession>(
  (ref) => AbandonSession(ref.watch(studyRepositoryProvider)),
);

final getLearningStateProvider = Provider<GetLearningState>(
  (ref) => GetLearningState(ref.watch(learningStateRepositoryProvider)),
);
