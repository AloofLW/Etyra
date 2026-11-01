// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RootsTable extends Roots with TableInfo<$RootsTable, RootRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RootsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lemmaMeta = const VerificationMeta('lemma');
  @override
  late final GeneratedColumn<String> lemma = GeneratedColumn<String>(
    'lemma',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayFormMeta = const VerificationMeta(
    'displayForm',
  );
  @override
  late final GeneratedColumn<String> displayForm = GeneratedColumn<String>(
    'display_form',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meaningMeta = const VerificationMeta(
    'meaning',
  );
  @override
  late final GeneratedColumn<String> meaning = GeneratedColumn<String>(
    'meaning',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originNoteMeta = const VerificationMeta(
    'originNote',
  );
  @override
  late final GeneratedColumn<String> originNote = GeneratedColumn<String>(
    'origin_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _verificationStatusMeta =
      const VerificationMeta('verificationStatus');
  @override
  late final GeneratedColumn<String> verificationStatus =
      GeneratedColumn<String>(
        'verification_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _sourceRefsMeta = const VerificationMeta(
    'sourceRefs',
  );
  @override
  late final GeneratedColumn<String> sourceRefs = GeneratedColumn<String>(
    'source_refs',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lemma,
    displayForm,
    language,
    meaning,
    originNote,
    verificationStatus,
    sourceRefs,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'roots';
  @override
  VerificationContext validateIntegrity(
    Insertable<RootRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('lemma')) {
      context.handle(
        _lemmaMeta,
        lemma.isAcceptableOrUnknown(data['lemma']!, _lemmaMeta),
      );
    } else if (isInserting) {
      context.missing(_lemmaMeta);
    }
    if (data.containsKey('display_form')) {
      context.handle(
        _displayFormMeta,
        displayForm.isAcceptableOrUnknown(
          data['display_form']!,
          _displayFormMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayFormMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('meaning')) {
      context.handle(
        _meaningMeta,
        meaning.isAcceptableOrUnknown(data['meaning']!, _meaningMeta),
      );
    } else if (isInserting) {
      context.missing(_meaningMeta);
    }
    if (data.containsKey('origin_note')) {
      context.handle(
        _originNoteMeta,
        originNote.isAcceptableOrUnknown(data['origin_note']!, _originNoteMeta),
      );
    }
    if (data.containsKey('verification_status')) {
      context.handle(
        _verificationStatusMeta,
        verificationStatus.isAcceptableOrUnknown(
          data['verification_status']!,
          _verificationStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_verificationStatusMeta);
    }
    if (data.containsKey('source_refs')) {
      context.handle(
        _sourceRefsMeta,
        sourceRefs.isAcceptableOrUnknown(data['source_refs']!, _sourceRefsMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceRefsMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RootRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RootRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      lemma: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lemma'],
      )!,
      displayForm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_form'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      meaning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meaning'],
      )!,
      originNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin_note'],
      ),
      verificationStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verification_status'],
      )!,
      sourceRefs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_refs'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RootsTable createAlias(String alias) {
    return $RootsTable(attachedDatabase, alias);
  }
}

class RootRow extends DataClass implements Insertable<RootRow> {
  final String id;
  final String lemma;
  final String displayForm;
  final String language;
  final String meaning;
  final String? originNote;
  final String verificationStatus;
  final String sourceRefs;
  final int createdAt;
  final int updatedAt;
  const RootRow({
    required this.id,
    required this.lemma,
    required this.displayForm,
    required this.language,
    required this.meaning,
    this.originNote,
    required this.verificationStatus,
    required this.sourceRefs,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['lemma'] = Variable<String>(lemma);
    map['display_form'] = Variable<String>(displayForm);
    map['language'] = Variable<String>(language);
    map['meaning'] = Variable<String>(meaning);
    if (!nullToAbsent || originNote != null) {
      map['origin_note'] = Variable<String>(originNote);
    }
    map['verification_status'] = Variable<String>(verificationStatus);
    map['source_refs'] = Variable<String>(sourceRefs);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  RootsCompanion toCompanion(bool nullToAbsent) {
    return RootsCompanion(
      id: Value(id),
      lemma: Value(lemma),
      displayForm: Value(displayForm),
      language: Value(language),
      meaning: Value(meaning),
      originNote: originNote == null && nullToAbsent
          ? const Value.absent()
          : Value(originNote),
      verificationStatus: Value(verificationStatus),
      sourceRefs: Value(sourceRefs),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RootRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RootRow(
      id: serializer.fromJson<String>(json['id']),
      lemma: serializer.fromJson<String>(json['lemma']),
      displayForm: serializer.fromJson<String>(json['displayForm']),
      language: serializer.fromJson<String>(json['language']),
      meaning: serializer.fromJson<String>(json['meaning']),
      originNote: serializer.fromJson<String?>(json['originNote']),
      verificationStatus: serializer.fromJson<String>(
        json['verificationStatus'],
      ),
      sourceRefs: serializer.fromJson<String>(json['sourceRefs']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lemma': serializer.toJson<String>(lemma),
      'displayForm': serializer.toJson<String>(displayForm),
      'language': serializer.toJson<String>(language),
      'meaning': serializer.toJson<String>(meaning),
      'originNote': serializer.toJson<String?>(originNote),
      'verificationStatus': serializer.toJson<String>(verificationStatus),
      'sourceRefs': serializer.toJson<String>(sourceRefs),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  RootRow copyWith({
    String? id,
    String? lemma,
    String? displayForm,
    String? language,
    String? meaning,
    Value<String?> originNote = const Value.absent(),
    String? verificationStatus,
    String? sourceRefs,
    int? createdAt,
    int? updatedAt,
  }) => RootRow(
    id: id ?? this.id,
    lemma: lemma ?? this.lemma,
    displayForm: displayForm ?? this.displayForm,
    language: language ?? this.language,
    meaning: meaning ?? this.meaning,
    originNote: originNote.present ? originNote.value : this.originNote,
    verificationStatus: verificationStatus ?? this.verificationStatus,
    sourceRefs: sourceRefs ?? this.sourceRefs,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RootRow copyWithCompanion(RootsCompanion data) {
    return RootRow(
      id: data.id.present ? data.id.value : this.id,
      lemma: data.lemma.present ? data.lemma.value : this.lemma,
      displayForm: data.displayForm.present
          ? data.displayForm.value
          : this.displayForm,
      language: data.language.present ? data.language.value : this.language,
      meaning: data.meaning.present ? data.meaning.value : this.meaning,
      originNote: data.originNote.present
          ? data.originNote.value
          : this.originNote,
      verificationStatus: data.verificationStatus.present
          ? data.verificationStatus.value
          : this.verificationStatus,
      sourceRefs: data.sourceRefs.present
          ? data.sourceRefs.value
          : this.sourceRefs,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RootRow(')
          ..write('id: $id, ')
          ..write('lemma: $lemma, ')
          ..write('displayForm: $displayForm, ')
          ..write('language: $language, ')
          ..write('meaning: $meaning, ')
          ..write('originNote: $originNote, ')
          ..write('verificationStatus: $verificationStatus, ')
          ..write('sourceRefs: $sourceRefs, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    lemma,
    displayForm,
    language,
    meaning,
    originNote,
    verificationStatus,
    sourceRefs,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RootRow &&
          other.id == this.id &&
          other.lemma == this.lemma &&
          other.displayForm == this.displayForm &&
          other.language == this.language &&
          other.meaning == this.meaning &&
          other.originNote == this.originNote &&
          other.verificationStatus == this.verificationStatus &&
          other.sourceRefs == this.sourceRefs &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RootsCompanion extends UpdateCompanion<RootRow> {
  final Value<String> id;
  final Value<String> lemma;
  final Value<String> displayForm;
  final Value<String> language;
  final Value<String> meaning;
  final Value<String?> originNote;
  final Value<String> verificationStatus;
  final Value<String> sourceRefs;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const RootsCompanion({
    this.id = const Value.absent(),
    this.lemma = const Value.absent(),
    this.displayForm = const Value.absent(),
    this.language = const Value.absent(),
    this.meaning = const Value.absent(),
    this.originNote = const Value.absent(),
    this.verificationStatus = const Value.absent(),
    this.sourceRefs = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RootsCompanion.insert({
    required String id,
    required String lemma,
    required String displayForm,
    required String language,
    required String meaning,
    this.originNote = const Value.absent(),
    required String verificationStatus,
    required String sourceRefs,
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       lemma = Value(lemma),
       displayForm = Value(displayForm),
       language = Value(language),
       meaning = Value(meaning),
       verificationStatus = Value(verificationStatus),
       sourceRefs = Value(sourceRefs),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<RootRow> custom({
    Expression<String>? id,
    Expression<String>? lemma,
    Expression<String>? displayForm,
    Expression<String>? language,
    Expression<String>? meaning,
    Expression<String>? originNote,
    Expression<String>? verificationStatus,
    Expression<String>? sourceRefs,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lemma != null) 'lemma': lemma,
      if (displayForm != null) 'display_form': displayForm,
      if (language != null) 'language': language,
      if (meaning != null) 'meaning': meaning,
      if (originNote != null) 'origin_note': originNote,
      if (verificationStatus != null) 'verification_status': verificationStatus,
      if (sourceRefs != null) 'source_refs': sourceRefs,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RootsCompanion copyWith({
    Value<String>? id,
    Value<String>? lemma,
    Value<String>? displayForm,
    Value<String>? language,
    Value<String>? meaning,
    Value<String?>? originNote,
    Value<String>? verificationStatus,
    Value<String>? sourceRefs,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return RootsCompanion(
      id: id ?? this.id,
      lemma: lemma ?? this.lemma,
      displayForm: displayForm ?? this.displayForm,
      language: language ?? this.language,
      meaning: meaning ?? this.meaning,
      originNote: originNote ?? this.originNote,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      sourceRefs: sourceRefs ?? this.sourceRefs,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lemma.present) {
      map['lemma'] = Variable<String>(lemma.value);
    }
    if (displayForm.present) {
      map['display_form'] = Variable<String>(displayForm.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (meaning.present) {
      map['meaning'] = Variable<String>(meaning.value);
    }
    if (originNote.present) {
      map['origin_note'] = Variable<String>(originNote.value);
    }
    if (verificationStatus.present) {
      map['verification_status'] = Variable<String>(verificationStatus.value);
    }
    if (sourceRefs.present) {
      map['source_refs'] = Variable<String>(sourceRefs.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RootsCompanion(')
          ..write('id: $id, ')
          ..write('lemma: $lemma, ')
          ..write('displayForm: $displayForm, ')
          ..write('language: $language, ')
          ..write('meaning: $meaning, ')
          ..write('originNote: $originNote, ')
          ..write('verificationStatus: $verificationStatus, ')
          ..write('sourceRefs: $sourceRefs, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AffixesTable extends Affixes with TableInfo<$AffixesTable, AffixRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AffixesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formMeta = const VerificationMeta('form');
  @override
  late final GeneratedColumn<String> form = GeneratedColumn<String>(
    'form',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meaningMeta = const VerificationMeta(
    'meaning',
  );
  @override
  late final GeneratedColumn<String> meaning = GeneratedColumn<String>(
    'meaning',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _verificationStatusMeta =
      const VerificationMeta('verificationStatus');
  @override
  late final GeneratedColumn<String> verificationStatus =
      GeneratedColumn<String>(
        'verification_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _sourceRefsMeta = const VerificationMeta(
    'sourceRefs',
  );
  @override
  late final GeneratedColumn<String> sourceRefs = GeneratedColumn<String>(
    'source_refs',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    form,
    kind,
    meaning,
    verificationStatus,
    sourceRefs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'affixes';
  @override
  VerificationContext validateIntegrity(
    Insertable<AffixRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('form')) {
      context.handle(
        _formMeta,
        form.isAcceptableOrUnknown(data['form']!, _formMeta),
      );
    } else if (isInserting) {
      context.missing(_formMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('meaning')) {
      context.handle(
        _meaningMeta,
        meaning.isAcceptableOrUnknown(data['meaning']!, _meaningMeta),
      );
    } else if (isInserting) {
      context.missing(_meaningMeta);
    }
    if (data.containsKey('verification_status')) {
      context.handle(
        _verificationStatusMeta,
        verificationStatus.isAcceptableOrUnknown(
          data['verification_status']!,
          _verificationStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_verificationStatusMeta);
    }
    if (data.containsKey('source_refs')) {
      context.handle(
        _sourceRefsMeta,
        sourceRefs.isAcceptableOrUnknown(data['source_refs']!, _sourceRefsMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceRefsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AffixRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AffixRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      form: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}form'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      meaning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meaning'],
      )!,
      verificationStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verification_status'],
      )!,
      sourceRefs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_refs'],
      )!,
    );
  }

  @override
  $AffixesTable createAlias(String alias) {
    return $AffixesTable(attachedDatabase, alias);
  }
}

class AffixRow extends DataClass implements Insertable<AffixRow> {
  final String id;
  final String form;
  final String kind;
  final String meaning;
  final String verificationStatus;
  final String sourceRefs;
  const AffixRow({
    required this.id,
    required this.form,
    required this.kind,
    required this.meaning,
    required this.verificationStatus,
    required this.sourceRefs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['form'] = Variable<String>(form);
    map['kind'] = Variable<String>(kind);
    map['meaning'] = Variable<String>(meaning);
    map['verification_status'] = Variable<String>(verificationStatus);
    map['source_refs'] = Variable<String>(sourceRefs);
    return map;
  }

  AffixesCompanion toCompanion(bool nullToAbsent) {
    return AffixesCompanion(
      id: Value(id),
      form: Value(form),
      kind: Value(kind),
      meaning: Value(meaning),
      verificationStatus: Value(verificationStatus),
      sourceRefs: Value(sourceRefs),
    );
  }

  factory AffixRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AffixRow(
      id: serializer.fromJson<String>(json['id']),
      form: serializer.fromJson<String>(json['form']),
      kind: serializer.fromJson<String>(json['kind']),
      meaning: serializer.fromJson<String>(json['meaning']),
      verificationStatus: serializer.fromJson<String>(
        json['verificationStatus'],
      ),
      sourceRefs: serializer.fromJson<String>(json['sourceRefs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'form': serializer.toJson<String>(form),
      'kind': serializer.toJson<String>(kind),
      'meaning': serializer.toJson<String>(meaning),
      'verificationStatus': serializer.toJson<String>(verificationStatus),
      'sourceRefs': serializer.toJson<String>(sourceRefs),
    };
  }

  AffixRow copyWith({
    String? id,
    String? form,
    String? kind,
    String? meaning,
    String? verificationStatus,
    String? sourceRefs,
  }) => AffixRow(
    id: id ?? this.id,
    form: form ?? this.form,
    kind: kind ?? this.kind,
    meaning: meaning ?? this.meaning,
    verificationStatus: verificationStatus ?? this.verificationStatus,
    sourceRefs: sourceRefs ?? this.sourceRefs,
  );
  AffixRow copyWithCompanion(AffixesCompanion data) {
    return AffixRow(
      id: data.id.present ? data.id.value : this.id,
      form: data.form.present ? data.form.value : this.form,
      kind: data.kind.present ? data.kind.value : this.kind,
      meaning: data.meaning.present ? data.meaning.value : this.meaning,
      verificationStatus: data.verificationStatus.present
          ? data.verificationStatus.value
          : this.verificationStatus,
      sourceRefs: data.sourceRefs.present
          ? data.sourceRefs.value
          : this.sourceRefs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AffixRow(')
          ..write('id: $id, ')
          ..write('form: $form, ')
          ..write('kind: $kind, ')
          ..write('meaning: $meaning, ')
          ..write('verificationStatus: $verificationStatus, ')
          ..write('sourceRefs: $sourceRefs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, form, kind, meaning, verificationStatus, sourceRefs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AffixRow &&
          other.id == this.id &&
          other.form == this.form &&
          other.kind == this.kind &&
          other.meaning == this.meaning &&
          other.verificationStatus == this.verificationStatus &&
          other.sourceRefs == this.sourceRefs);
}

class AffixesCompanion extends UpdateCompanion<AffixRow> {
  final Value<String> id;
  final Value<String> form;
  final Value<String> kind;
  final Value<String> meaning;
  final Value<String> verificationStatus;
  final Value<String> sourceRefs;
  final Value<int> rowid;
  const AffixesCompanion({
    this.id = const Value.absent(),
    this.form = const Value.absent(),
    this.kind = const Value.absent(),
    this.meaning = const Value.absent(),
    this.verificationStatus = const Value.absent(),
    this.sourceRefs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AffixesCompanion.insert({
    required String id,
    required String form,
    required String kind,
    required String meaning,
    required String verificationStatus,
    required String sourceRefs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       form = Value(form),
       kind = Value(kind),
       meaning = Value(meaning),
       verificationStatus = Value(verificationStatus),
       sourceRefs = Value(sourceRefs);
  static Insertable<AffixRow> custom({
    Expression<String>? id,
    Expression<String>? form,
    Expression<String>? kind,
    Expression<String>? meaning,
    Expression<String>? verificationStatus,
    Expression<String>? sourceRefs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (form != null) 'form': form,
      if (kind != null) 'kind': kind,
      if (meaning != null) 'meaning': meaning,
      if (verificationStatus != null) 'verification_status': verificationStatus,
      if (sourceRefs != null) 'source_refs': sourceRefs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AffixesCompanion copyWith({
    Value<String>? id,
    Value<String>? form,
    Value<String>? kind,
    Value<String>? meaning,
    Value<String>? verificationStatus,
    Value<String>? sourceRefs,
    Value<int>? rowid,
  }) {
    return AffixesCompanion(
      id: id ?? this.id,
      form: form ?? this.form,
      kind: kind ?? this.kind,
      meaning: meaning ?? this.meaning,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      sourceRefs: sourceRefs ?? this.sourceRefs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (form.present) {
      map['form'] = Variable<String>(form.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (meaning.present) {
      map['meaning'] = Variable<String>(meaning.value);
    }
    if (verificationStatus.present) {
      map['verification_status'] = Variable<String>(verificationStatus.value);
    }
    if (sourceRefs.present) {
      map['source_refs'] = Variable<String>(sourceRefs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AffixesCompanion(')
          ..write('id: $id, ')
          ..write('form: $form, ')
          ..write('kind: $kind, ')
          ..write('meaning: $meaning, ')
          ..write('verificationStatus: $verificationStatus, ')
          ..write('sourceRefs: $sourceRefs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WordsTable extends Words with TableInfo<$WordsTable, WordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
    'word',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedWordMeta = const VerificationMeta(
    'normalizedWord',
  );
  @override
  late final GeneratedColumn<String> normalizedWord = GeneratedColumn<String>(
    'normalized_word',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _partOfSpeechMeta = const VerificationMeta(
    'partOfSpeech',
  );
  @override
  late final GeneratedColumn<String> partOfSpeech = GeneratedColumn<String>(
    'part_of_speech',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _definitionMeta = const VerificationMeta(
    'definition',
  );
  @override
  late final GeneratedColumn<String> definition = GeneratedColumn<String>(
    'definition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translationMeta = const VerificationMeta(
    'translation',
  );
  @override
  late final GeneratedColumn<String> translation = GeneratedColumn<String>(
    'translation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pronunciationRefMeta = const VerificationMeta(
    'pronunciationRef',
  );
  @override
  late final GeneratedColumn<String> pronunciationRef = GeneratedColumn<String>(
    'pronunciation_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceRefsMeta = const VerificationMeta(
    'sourceRefs',
  );
  @override
  late final GeneratedColumn<String> sourceRefs = GeneratedColumn<String>(
    'source_refs',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    word,
    normalizedWord,
    partOfSpeech,
    definition,
    translation,
    pronunciationRef,
    sourceRefs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'words';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('word')) {
      context.handle(
        _wordMeta,
        word.isAcceptableOrUnknown(data['word']!, _wordMeta),
      );
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('normalized_word')) {
      context.handle(
        _normalizedWordMeta,
        normalizedWord.isAcceptableOrUnknown(
          data['normalized_word']!,
          _normalizedWordMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedWordMeta);
    }
    if (data.containsKey('part_of_speech')) {
      context.handle(
        _partOfSpeechMeta,
        partOfSpeech.isAcceptableOrUnknown(
          data['part_of_speech']!,
          _partOfSpeechMeta,
        ),
      );
    }
    if (data.containsKey('definition')) {
      context.handle(
        _definitionMeta,
        definition.isAcceptableOrUnknown(data['definition']!, _definitionMeta),
      );
    } else if (isInserting) {
      context.missing(_definitionMeta);
    }
    if (data.containsKey('translation')) {
      context.handle(
        _translationMeta,
        translation.isAcceptableOrUnknown(
          data['translation']!,
          _translationMeta,
        ),
      );
    }
    if (data.containsKey('pronunciation_ref')) {
      context.handle(
        _pronunciationRefMeta,
        pronunciationRef.isAcceptableOrUnknown(
          data['pronunciation_ref']!,
          _pronunciationRefMeta,
        ),
      );
    }
    if (data.containsKey('source_refs')) {
      context.handle(
        _sourceRefsMeta,
        sourceRefs.isAcceptableOrUnknown(data['source_refs']!, _sourceRefsMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceRefsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      word: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word'],
      )!,
      normalizedWord: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_word'],
      )!,
      partOfSpeech: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_of_speech'],
      ),
      definition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}definition'],
      )!,
      translation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation'],
      ),
      pronunciationRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pronunciation_ref'],
      ),
      sourceRefs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_refs'],
      )!,
    );
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(attachedDatabase, alias);
  }
}

class WordRow extends DataClass implements Insertable<WordRow> {
  final String id;
  final String word;
  final String normalizedWord;
  final String? partOfSpeech;
  final String definition;
  final String? translation;
  final String? pronunciationRef;
  final String sourceRefs;
  const WordRow({
    required this.id,
    required this.word,
    required this.normalizedWord,
    this.partOfSpeech,
    required this.definition,
    this.translation,
    this.pronunciationRef,
    required this.sourceRefs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['word'] = Variable<String>(word);
    map['normalized_word'] = Variable<String>(normalizedWord);
    if (!nullToAbsent || partOfSpeech != null) {
      map['part_of_speech'] = Variable<String>(partOfSpeech);
    }
    map['definition'] = Variable<String>(definition);
    if (!nullToAbsent || translation != null) {
      map['translation'] = Variable<String>(translation);
    }
    if (!nullToAbsent || pronunciationRef != null) {
      map['pronunciation_ref'] = Variable<String>(pronunciationRef);
    }
    map['source_refs'] = Variable<String>(sourceRefs);
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      id: Value(id),
      word: Value(word),
      normalizedWord: Value(normalizedWord),
      partOfSpeech: partOfSpeech == null && nullToAbsent
          ? const Value.absent()
          : Value(partOfSpeech),
      definition: Value(definition),
      translation: translation == null && nullToAbsent
          ? const Value.absent()
          : Value(translation),
      pronunciationRef: pronunciationRef == null && nullToAbsent
          ? const Value.absent()
          : Value(pronunciationRef),
      sourceRefs: Value(sourceRefs),
    );
  }

  factory WordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordRow(
      id: serializer.fromJson<String>(json['id']),
      word: serializer.fromJson<String>(json['word']),
      normalizedWord: serializer.fromJson<String>(json['normalizedWord']),
      partOfSpeech: serializer.fromJson<String?>(json['partOfSpeech']),
      definition: serializer.fromJson<String>(json['definition']),
      translation: serializer.fromJson<String?>(json['translation']),
      pronunciationRef: serializer.fromJson<String?>(json['pronunciationRef']),
      sourceRefs: serializer.fromJson<String>(json['sourceRefs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'word': serializer.toJson<String>(word),
      'normalizedWord': serializer.toJson<String>(normalizedWord),
      'partOfSpeech': serializer.toJson<String?>(partOfSpeech),
      'definition': serializer.toJson<String>(definition),
      'translation': serializer.toJson<String?>(translation),
      'pronunciationRef': serializer.toJson<String?>(pronunciationRef),
      'sourceRefs': serializer.toJson<String>(sourceRefs),
    };
  }

  WordRow copyWith({
    String? id,
    String? word,
    String? normalizedWord,
    Value<String?> partOfSpeech = const Value.absent(),
    String? definition,
    Value<String?> translation = const Value.absent(),
    Value<String?> pronunciationRef = const Value.absent(),
    String? sourceRefs,
  }) => WordRow(
    id: id ?? this.id,
    word: word ?? this.word,
    normalizedWord: normalizedWord ?? this.normalizedWord,
    partOfSpeech: partOfSpeech.present ? partOfSpeech.value : this.partOfSpeech,
    definition: definition ?? this.definition,
    translation: translation.present ? translation.value : this.translation,
    pronunciationRef: pronunciationRef.present
        ? pronunciationRef.value
        : this.pronunciationRef,
    sourceRefs: sourceRefs ?? this.sourceRefs,
  );
  WordRow copyWithCompanion(WordsCompanion data) {
    return WordRow(
      id: data.id.present ? data.id.value : this.id,
      word: data.word.present ? data.word.value : this.word,
      normalizedWord: data.normalizedWord.present
          ? data.normalizedWord.value
          : this.normalizedWord,
      partOfSpeech: data.partOfSpeech.present
          ? data.partOfSpeech.value
          : this.partOfSpeech,
      definition: data.definition.present
          ? data.definition.value
          : this.definition,
      translation: data.translation.present
          ? data.translation.value
          : this.translation,
      pronunciationRef: data.pronunciationRef.present
          ? data.pronunciationRef.value
          : this.pronunciationRef,
      sourceRefs: data.sourceRefs.present
          ? data.sourceRefs.value
          : this.sourceRefs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordRow(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('normalizedWord: $normalizedWord, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('definition: $definition, ')
          ..write('translation: $translation, ')
          ..write('pronunciationRef: $pronunciationRef, ')
          ..write('sourceRefs: $sourceRefs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    word,
    normalizedWord,
    partOfSpeech,
    definition,
    translation,
    pronunciationRef,
    sourceRefs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordRow &&
          other.id == this.id &&
          other.word == this.word &&
          other.normalizedWord == this.normalizedWord &&
          other.partOfSpeech == this.partOfSpeech &&
          other.definition == this.definition &&
          other.translation == this.translation &&
          other.pronunciationRef == this.pronunciationRef &&
          other.sourceRefs == this.sourceRefs);
}

class WordsCompanion extends UpdateCompanion<WordRow> {
  final Value<String> id;
  final Value<String> word;
  final Value<String> normalizedWord;
  final Value<String?> partOfSpeech;
  final Value<String> definition;
  final Value<String?> translation;
  final Value<String?> pronunciationRef;
  final Value<String> sourceRefs;
  final Value<int> rowid;
  const WordsCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.normalizedWord = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.definition = const Value.absent(),
    this.translation = const Value.absent(),
    this.pronunciationRef = const Value.absent(),
    this.sourceRefs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordsCompanion.insert({
    required String id,
    required String word,
    required String normalizedWord,
    this.partOfSpeech = const Value.absent(),
    required String definition,
    this.translation = const Value.absent(),
    this.pronunciationRef = const Value.absent(),
    required String sourceRefs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       word = Value(word),
       normalizedWord = Value(normalizedWord),
       definition = Value(definition),
       sourceRefs = Value(sourceRefs);
  static Insertable<WordRow> custom({
    Expression<String>? id,
    Expression<String>? word,
    Expression<String>? normalizedWord,
    Expression<String>? partOfSpeech,
    Expression<String>? definition,
    Expression<String>? translation,
    Expression<String>? pronunciationRef,
    Expression<String>? sourceRefs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (word != null) 'word': word,
      if (normalizedWord != null) 'normalized_word': normalizedWord,
      if (partOfSpeech != null) 'part_of_speech': partOfSpeech,
      if (definition != null) 'definition': definition,
      if (translation != null) 'translation': translation,
      if (pronunciationRef != null) 'pronunciation_ref': pronunciationRef,
      if (sourceRefs != null) 'source_refs': sourceRefs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordsCompanion copyWith({
    Value<String>? id,
    Value<String>? word,
    Value<String>? normalizedWord,
    Value<String?>? partOfSpeech,
    Value<String>? definition,
    Value<String?>? translation,
    Value<String?>? pronunciationRef,
    Value<String>? sourceRefs,
    Value<int>? rowid,
  }) {
    return WordsCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
      normalizedWord: normalizedWord ?? this.normalizedWord,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      definition: definition ?? this.definition,
      translation: translation ?? this.translation,
      pronunciationRef: pronunciationRef ?? this.pronunciationRef,
      sourceRefs: sourceRefs ?? this.sourceRefs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (normalizedWord.present) {
      map['normalized_word'] = Variable<String>(normalizedWord.value);
    }
    if (partOfSpeech.present) {
      map['part_of_speech'] = Variable<String>(partOfSpeech.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    if (pronunciationRef.present) {
      map['pronunciation_ref'] = Variable<String>(pronunciationRef.value);
    }
    if (sourceRefs.present) {
      map['source_refs'] = Variable<String>(sourceRefs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsCompanion(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('normalizedWord: $normalizedWord, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('definition: $definition, ')
          ..write('translation: $translation, ')
          ..write('pronunciationRef: $pronunciationRef, ')
          ..write('sourceRefs: $sourceRefs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WordComponentsTable extends WordComponents
    with TableInfo<$WordComponentsTable, WordComponentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordComponentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<String> wordId = GeneratedColumn<String>(
    'word_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES words (id)',
    ),
  );
  static const VerificationMeta _componentTypeMeta = const VerificationMeta(
    'componentType',
  );
  @override
  late final GeneratedColumn<String> componentType = GeneratedColumn<String>(
    'component_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _componentIdMeta = const VerificationMeta(
    'componentId',
  );
  @override
  late final GeneratedColumn<String> componentId = GeneratedColumn<String>(
    'component_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceRefsMeta = const VerificationMeta(
    'sourceRefs',
  );
  @override
  late final GeneratedColumn<String> sourceRefs = GeneratedColumn<String>(
    'source_refs',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    wordId,
    componentType,
    componentId,
    role,
    confidence,
    sourceRefs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_components';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordComponentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('word_id')) {
      context.handle(
        _wordIdMeta,
        wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (data.containsKey('component_type')) {
      context.handle(
        _componentTypeMeta,
        componentType.isAcceptableOrUnknown(
          data['component_type']!,
          _componentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_componentTypeMeta);
    }
    if (data.containsKey('component_id')) {
      context.handle(
        _componentIdMeta,
        componentId.isAcceptableOrUnknown(
          data['component_id']!,
          _componentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_componentIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('source_refs')) {
      context.handle(
        _sourceRefsMeta,
        sourceRefs.isAcceptableOrUnknown(data['source_refs']!, _sourceRefsMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceRefsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    wordId,
    componentType,
    componentId,
    role,
  };
  @override
  WordComponentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordComponentRow(
      wordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word_id'],
      )!,
      componentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}component_type'],
      )!,
      componentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}component_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      ),
      sourceRefs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_refs'],
      )!,
    );
  }

  @override
  $WordComponentsTable createAlias(String alias) {
    return $WordComponentsTable(attachedDatabase, alias);
  }
}

class WordComponentRow extends DataClass
    implements Insertable<WordComponentRow> {
  final String wordId;
  final String componentType;
  final String componentId;
  final String role;
  final double? confidence;
  final String sourceRefs;
  const WordComponentRow({
    required this.wordId,
    required this.componentType,
    required this.componentId,
    required this.role,
    this.confidence,
    required this.sourceRefs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['word_id'] = Variable<String>(wordId);
    map['component_type'] = Variable<String>(componentType);
    map['component_id'] = Variable<String>(componentId);
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || confidence != null) {
      map['confidence'] = Variable<double>(confidence);
    }
    map['source_refs'] = Variable<String>(sourceRefs);
    return map;
  }

  WordComponentsCompanion toCompanion(bool nullToAbsent) {
    return WordComponentsCompanion(
      wordId: Value(wordId),
      componentType: Value(componentType),
      componentId: Value(componentId),
      role: Value(role),
      confidence: confidence == null && nullToAbsent
          ? const Value.absent()
          : Value(confidence),
      sourceRefs: Value(sourceRefs),
    );
  }

  factory WordComponentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordComponentRow(
      wordId: serializer.fromJson<String>(json['wordId']),
      componentType: serializer.fromJson<String>(json['componentType']),
      componentId: serializer.fromJson<String>(json['componentId']),
      role: serializer.fromJson<String>(json['role']),
      confidence: serializer.fromJson<double?>(json['confidence']),
      sourceRefs: serializer.fromJson<String>(json['sourceRefs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'wordId': serializer.toJson<String>(wordId),
      'componentType': serializer.toJson<String>(componentType),
      'componentId': serializer.toJson<String>(componentId),
      'role': serializer.toJson<String>(role),
      'confidence': serializer.toJson<double?>(confidence),
      'sourceRefs': serializer.toJson<String>(sourceRefs),
    };
  }

  WordComponentRow copyWith({
    String? wordId,
    String? componentType,
    String? componentId,
    String? role,
    Value<double?> confidence = const Value.absent(),
    String? sourceRefs,
  }) => WordComponentRow(
    wordId: wordId ?? this.wordId,
    componentType: componentType ?? this.componentType,
    componentId: componentId ?? this.componentId,
    role: role ?? this.role,
    confidence: confidence.present ? confidence.value : this.confidence,
    sourceRefs: sourceRefs ?? this.sourceRefs,
  );
  WordComponentRow copyWithCompanion(WordComponentsCompanion data) {
    return WordComponentRow(
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
      componentType: data.componentType.present
          ? data.componentType.value
          : this.componentType,
      componentId: data.componentId.present
          ? data.componentId.value
          : this.componentId,
      role: data.role.present ? data.role.value : this.role,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      sourceRefs: data.sourceRefs.present
          ? data.sourceRefs.value
          : this.sourceRefs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordComponentRow(')
          ..write('wordId: $wordId, ')
          ..write('componentType: $componentType, ')
          ..write('componentId: $componentId, ')
          ..write('role: $role, ')
          ..write('confidence: $confidence, ')
          ..write('sourceRefs: $sourceRefs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    wordId,
    componentType,
    componentId,
    role,
    confidence,
    sourceRefs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordComponentRow &&
          other.wordId == this.wordId &&
          other.componentType == this.componentType &&
          other.componentId == this.componentId &&
          other.role == this.role &&
          other.confidence == this.confidence &&
          other.sourceRefs == this.sourceRefs);
}

class WordComponentsCompanion extends UpdateCompanion<WordComponentRow> {
  final Value<String> wordId;
  final Value<String> componentType;
  final Value<String> componentId;
  final Value<String> role;
  final Value<double?> confidence;
  final Value<String> sourceRefs;
  final Value<int> rowid;
  const WordComponentsCompanion({
    this.wordId = const Value.absent(),
    this.componentType = const Value.absent(),
    this.componentId = const Value.absent(),
    this.role = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sourceRefs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordComponentsCompanion.insert({
    required String wordId,
    required String componentType,
    required String componentId,
    required String role,
    this.confidence = const Value.absent(),
    required String sourceRefs,
    this.rowid = const Value.absent(),
  }) : wordId = Value(wordId),
       componentType = Value(componentType),
       componentId = Value(componentId),
       role = Value(role),
       sourceRefs = Value(sourceRefs);
  static Insertable<WordComponentRow> custom({
    Expression<String>? wordId,
    Expression<String>? componentType,
    Expression<String>? componentId,
    Expression<String>? role,
    Expression<double>? confidence,
    Expression<String>? sourceRefs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (wordId != null) 'word_id': wordId,
      if (componentType != null) 'component_type': componentType,
      if (componentId != null) 'component_id': componentId,
      if (role != null) 'role': role,
      if (confidence != null) 'confidence': confidence,
      if (sourceRefs != null) 'source_refs': sourceRefs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordComponentsCompanion copyWith({
    Value<String>? wordId,
    Value<String>? componentType,
    Value<String>? componentId,
    Value<String>? role,
    Value<double?>? confidence,
    Value<String>? sourceRefs,
    Value<int>? rowid,
  }) {
    return WordComponentsCompanion(
      wordId: wordId ?? this.wordId,
      componentType: componentType ?? this.componentType,
      componentId: componentId ?? this.componentId,
      role: role ?? this.role,
      confidence: confidence ?? this.confidence,
      sourceRefs: sourceRefs ?? this.sourceRefs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (wordId.present) {
      map['word_id'] = Variable<String>(wordId.value);
    }
    if (componentType.present) {
      map['component_type'] = Variable<String>(componentType.value);
    }
    if (componentId.present) {
      map['component_id'] = Variable<String>(componentId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (sourceRefs.present) {
      map['source_refs'] = Variable<String>(sourceRefs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordComponentsCompanion(')
          ..write('wordId: $wordId, ')
          ..write('componentType: $componentType, ')
          ..write('componentId: $componentId, ')
          ..write('role: $role, ')
          ..write('confidence: $confidence, ')
          ..write('sourceRefs: $sourceRefs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExamplesTable extends Examples
    with TableInfo<$ExamplesTable, ExampleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamplesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<String> wordId = GeneratedColumn<String>(
    'word_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES words (id)',
    ),
  );
  static const VerificationMeta _sentenceMeta = const VerificationMeta(
    'sentence',
  );
  @override
  late final GeneratedColumn<String> sentence = GeneratedColumn<String>(
    'sentence',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translationMeta = const VerificationMeta(
    'translation',
  );
  @override
  late final GeneratedColumn<String> translation = GeneratedColumn<String>(
    'translation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceRefsMeta = const VerificationMeta(
    'sourceRefs',
  );
  @override
  late final GeneratedColumn<String> sourceRefs = GeneratedColumn<String>(
    'source_refs',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    wordId,
    sentence,
    translation,
    sourceRefs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'examples';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExampleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('word_id')) {
      context.handle(
        _wordIdMeta,
        wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (data.containsKey('sentence')) {
      context.handle(
        _sentenceMeta,
        sentence.isAcceptableOrUnknown(data['sentence']!, _sentenceMeta),
      );
    } else if (isInserting) {
      context.missing(_sentenceMeta);
    }
    if (data.containsKey('translation')) {
      context.handle(
        _translationMeta,
        translation.isAcceptableOrUnknown(
          data['translation']!,
          _translationMeta,
        ),
      );
    }
    if (data.containsKey('source_refs')) {
      context.handle(
        _sourceRefsMeta,
        sourceRefs.isAcceptableOrUnknown(data['source_refs']!, _sourceRefsMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceRefsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExampleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExampleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      wordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word_id'],
      )!,
      sentence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sentence'],
      )!,
      translation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation'],
      ),
      sourceRefs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_refs'],
      )!,
    );
  }

  @override
  $ExamplesTable createAlias(String alias) {
    return $ExamplesTable(attachedDatabase, alias);
  }
}

class ExampleRow extends DataClass implements Insertable<ExampleRow> {
  final String id;
  final String wordId;
  final String sentence;
  final String? translation;
  final String sourceRefs;
  const ExampleRow({
    required this.id,
    required this.wordId,
    required this.sentence,
    this.translation,
    required this.sourceRefs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['word_id'] = Variable<String>(wordId);
    map['sentence'] = Variable<String>(sentence);
    if (!nullToAbsent || translation != null) {
      map['translation'] = Variable<String>(translation);
    }
    map['source_refs'] = Variable<String>(sourceRefs);
    return map;
  }

  ExamplesCompanion toCompanion(bool nullToAbsent) {
    return ExamplesCompanion(
      id: Value(id),
      wordId: Value(wordId),
      sentence: Value(sentence),
      translation: translation == null && nullToAbsent
          ? const Value.absent()
          : Value(translation),
      sourceRefs: Value(sourceRefs),
    );
  }

  factory ExampleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExampleRow(
      id: serializer.fromJson<String>(json['id']),
      wordId: serializer.fromJson<String>(json['wordId']),
      sentence: serializer.fromJson<String>(json['sentence']),
      translation: serializer.fromJson<String?>(json['translation']),
      sourceRefs: serializer.fromJson<String>(json['sourceRefs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'wordId': serializer.toJson<String>(wordId),
      'sentence': serializer.toJson<String>(sentence),
      'translation': serializer.toJson<String?>(translation),
      'sourceRefs': serializer.toJson<String>(sourceRefs),
    };
  }

  ExampleRow copyWith({
    String? id,
    String? wordId,
    String? sentence,
    Value<String?> translation = const Value.absent(),
    String? sourceRefs,
  }) => ExampleRow(
    id: id ?? this.id,
    wordId: wordId ?? this.wordId,
    sentence: sentence ?? this.sentence,
    translation: translation.present ? translation.value : this.translation,
    sourceRefs: sourceRefs ?? this.sourceRefs,
  );
  ExampleRow copyWithCompanion(ExamplesCompanion data) {
    return ExampleRow(
      id: data.id.present ? data.id.value : this.id,
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
      sentence: data.sentence.present ? data.sentence.value : this.sentence,
      translation: data.translation.present
          ? data.translation.value
          : this.translation,
      sourceRefs: data.sourceRefs.present
          ? data.sourceRefs.value
          : this.sourceRefs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExampleRow(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('sentence: $sentence, ')
          ..write('translation: $translation, ')
          ..write('sourceRefs: $sourceRefs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, wordId, sentence, translation, sourceRefs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleRow &&
          other.id == this.id &&
          other.wordId == this.wordId &&
          other.sentence == this.sentence &&
          other.translation == this.translation &&
          other.sourceRefs == this.sourceRefs);
}

class ExamplesCompanion extends UpdateCompanion<ExampleRow> {
  final Value<String> id;
  final Value<String> wordId;
  final Value<String> sentence;
  final Value<String?> translation;
  final Value<String> sourceRefs;
  final Value<int> rowid;
  const ExamplesCompanion({
    this.id = const Value.absent(),
    this.wordId = const Value.absent(),
    this.sentence = const Value.absent(),
    this.translation = const Value.absent(),
    this.sourceRefs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExamplesCompanion.insert({
    required String id,
    required String wordId,
    required String sentence,
    this.translation = const Value.absent(),
    required String sourceRefs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       wordId = Value(wordId),
       sentence = Value(sentence),
       sourceRefs = Value(sourceRefs);
  static Insertable<ExampleRow> custom({
    Expression<String>? id,
    Expression<String>? wordId,
    Expression<String>? sentence,
    Expression<String>? translation,
    Expression<String>? sourceRefs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wordId != null) 'word_id': wordId,
      if (sentence != null) 'sentence': sentence,
      if (translation != null) 'translation': translation,
      if (sourceRefs != null) 'source_refs': sourceRefs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExamplesCompanion copyWith({
    Value<String>? id,
    Value<String>? wordId,
    Value<String>? sentence,
    Value<String?>? translation,
    Value<String>? sourceRefs,
    Value<int>? rowid,
  }) {
    return ExamplesCompanion(
      id: id ?? this.id,
      wordId: wordId ?? this.wordId,
      sentence: sentence ?? this.sentence,
      translation: translation ?? this.translation,
      sourceRefs: sourceRefs ?? this.sourceRefs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (wordId.present) {
      map['word_id'] = Variable<String>(wordId.value);
    }
    if (sentence.present) {
      map['sentence'] = Variable<String>(sentence.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    if (sourceRefs.present) {
      map['source_refs'] = Variable<String>(sourceRefs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamplesCompanion(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('sentence: $sentence, ')
          ..write('translation: $translation, ')
          ..write('sourceRefs: $sourceRefs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SeedImportsTable extends SeedImports
    with TableInfo<$SeedImportsTable, SeedImportRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SeedImportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _packageIdMeta = const VerificationMeta(
    'packageId',
  );
  @override
  late final GeneratedColumn<String> packageId = GeneratedColumn<String>(
    'package_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reviewedByMeta = const VerificationMeta(
    'reviewedBy',
  );
  @override
  late final GeneratedColumn<String> reviewedBy = GeneratedColumn<String>(
    'reviewed_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reviewReferenceMeta = const VerificationMeta(
    'reviewReference',
  );
  @override
  late final GeneratedColumn<String> reviewReference = GeneratedColumn<String>(
    'review_reference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reviewedAtMeta = const VerificationMeta(
    'reviewedAt',
  );
  @override
  late final GeneratedColumn<int> reviewedAt = GeneratedColumn<int>(
    'reviewed_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _importedAtMeta = const VerificationMeta(
    'importedAt',
  );
  @override
  late final GeneratedColumn<int> importedAt = GeneratedColumn<int>(
    'imported_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemCountMeta = const VerificationMeta(
    'itemCount',
  );
  @override
  late final GeneratedColumn<int> itemCount = GeneratedColumn<int>(
    'item_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    packageId,
    version,
    payloadJson,
    reviewedBy,
    reviewReference,
    reviewedAt,
    importedAt,
    itemCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'seed_imports';
  @override
  VerificationContext validateIntegrity(
    Insertable<SeedImportRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('package_id')) {
      context.handle(
        _packageIdMeta,
        packageId.isAcceptableOrUnknown(data['package_id']!, _packageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_packageIdMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('reviewed_by')) {
      context.handle(
        _reviewedByMeta,
        reviewedBy.isAcceptableOrUnknown(data['reviewed_by']!, _reviewedByMeta),
      );
    } else if (isInserting) {
      context.missing(_reviewedByMeta);
    }
    if (data.containsKey('review_reference')) {
      context.handle(
        _reviewReferenceMeta,
        reviewReference.isAcceptableOrUnknown(
          data['review_reference']!,
          _reviewReferenceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reviewReferenceMeta);
    }
    if (data.containsKey('reviewed_at')) {
      context.handle(
        _reviewedAtMeta,
        reviewedAt.isAcceptableOrUnknown(data['reviewed_at']!, _reviewedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_reviewedAtMeta);
    }
    if (data.containsKey('imported_at')) {
      context.handle(
        _importedAtMeta,
        importedAt.isAcceptableOrUnknown(data['imported_at']!, _importedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_importedAtMeta);
    }
    if (data.containsKey('item_count')) {
      context.handle(
        _itemCountMeta,
        itemCount.isAcceptableOrUnknown(data['item_count']!, _itemCountMeta),
      );
    } else if (isInserting) {
      context.missing(_itemCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {packageId, version};
  @override
  SeedImportRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SeedImportRow(
      packageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}package_id'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      reviewedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reviewed_by'],
      )!,
      reviewReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}review_reference'],
      )!,
      reviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reviewed_at'],
      )!,
      importedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}imported_at'],
      )!,
      itemCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item_count'],
      )!,
    );
  }

  @override
  $SeedImportsTable createAlias(String alias) {
    return $SeedImportsTable(attachedDatabase, alias);
  }
}

class SeedImportRow extends DataClass implements Insertable<SeedImportRow> {
  final String packageId;
  final int version;
  final String payloadJson;
  final String reviewedBy;
  final String reviewReference;
  final int reviewedAt;
  final int importedAt;
  final int itemCount;
  const SeedImportRow({
    required this.packageId,
    required this.version,
    required this.payloadJson,
    required this.reviewedBy,
    required this.reviewReference,
    required this.reviewedAt,
    required this.importedAt,
    required this.itemCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['package_id'] = Variable<String>(packageId);
    map['version'] = Variable<int>(version);
    map['payload_json'] = Variable<String>(payloadJson);
    map['reviewed_by'] = Variable<String>(reviewedBy);
    map['review_reference'] = Variable<String>(reviewReference);
    map['reviewed_at'] = Variable<int>(reviewedAt);
    map['imported_at'] = Variable<int>(importedAt);
    map['item_count'] = Variable<int>(itemCount);
    return map;
  }

  SeedImportsCompanion toCompanion(bool nullToAbsent) {
    return SeedImportsCompanion(
      packageId: Value(packageId),
      version: Value(version),
      payloadJson: Value(payloadJson),
      reviewedBy: Value(reviewedBy),
      reviewReference: Value(reviewReference),
      reviewedAt: Value(reviewedAt),
      importedAt: Value(importedAt),
      itemCount: Value(itemCount),
    );
  }

  factory SeedImportRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SeedImportRow(
      packageId: serializer.fromJson<String>(json['packageId']),
      version: serializer.fromJson<int>(json['version']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      reviewedBy: serializer.fromJson<String>(json['reviewedBy']),
      reviewReference: serializer.fromJson<String>(json['reviewReference']),
      reviewedAt: serializer.fromJson<int>(json['reviewedAt']),
      importedAt: serializer.fromJson<int>(json['importedAt']),
      itemCount: serializer.fromJson<int>(json['itemCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'packageId': serializer.toJson<String>(packageId),
      'version': serializer.toJson<int>(version),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'reviewedBy': serializer.toJson<String>(reviewedBy),
      'reviewReference': serializer.toJson<String>(reviewReference),
      'reviewedAt': serializer.toJson<int>(reviewedAt),
      'importedAt': serializer.toJson<int>(importedAt),
      'itemCount': serializer.toJson<int>(itemCount),
    };
  }

  SeedImportRow copyWith({
    String? packageId,
    int? version,
    String? payloadJson,
    String? reviewedBy,
    String? reviewReference,
    int? reviewedAt,
    int? importedAt,
    int? itemCount,
  }) => SeedImportRow(
    packageId: packageId ?? this.packageId,
    version: version ?? this.version,
    payloadJson: payloadJson ?? this.payloadJson,
    reviewedBy: reviewedBy ?? this.reviewedBy,
    reviewReference: reviewReference ?? this.reviewReference,
    reviewedAt: reviewedAt ?? this.reviewedAt,
    importedAt: importedAt ?? this.importedAt,
    itemCount: itemCount ?? this.itemCount,
  );
  SeedImportRow copyWithCompanion(SeedImportsCompanion data) {
    return SeedImportRow(
      packageId: data.packageId.present ? data.packageId.value : this.packageId,
      version: data.version.present ? data.version.value : this.version,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      reviewedBy: data.reviewedBy.present
          ? data.reviewedBy.value
          : this.reviewedBy,
      reviewReference: data.reviewReference.present
          ? data.reviewReference.value
          : this.reviewReference,
      reviewedAt: data.reviewedAt.present
          ? data.reviewedAt.value
          : this.reviewedAt,
      importedAt: data.importedAt.present
          ? data.importedAt.value
          : this.importedAt,
      itemCount: data.itemCount.present ? data.itemCount.value : this.itemCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SeedImportRow(')
          ..write('packageId: $packageId, ')
          ..write('version: $version, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('reviewedBy: $reviewedBy, ')
          ..write('reviewReference: $reviewReference, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('importedAt: $importedAt, ')
          ..write('itemCount: $itemCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    packageId,
    version,
    payloadJson,
    reviewedBy,
    reviewReference,
    reviewedAt,
    importedAt,
    itemCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SeedImportRow &&
          other.packageId == this.packageId &&
          other.version == this.version &&
          other.payloadJson == this.payloadJson &&
          other.reviewedBy == this.reviewedBy &&
          other.reviewReference == this.reviewReference &&
          other.reviewedAt == this.reviewedAt &&
          other.importedAt == this.importedAt &&
          other.itemCount == this.itemCount);
}

class SeedImportsCompanion extends UpdateCompanion<SeedImportRow> {
  final Value<String> packageId;
  final Value<int> version;
  final Value<String> payloadJson;
  final Value<String> reviewedBy;
  final Value<String> reviewReference;
  final Value<int> reviewedAt;
  final Value<int> importedAt;
  final Value<int> itemCount;
  final Value<int> rowid;
  const SeedImportsCompanion({
    this.packageId = const Value.absent(),
    this.version = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.reviewedBy = const Value.absent(),
    this.reviewReference = const Value.absent(),
    this.reviewedAt = const Value.absent(),
    this.importedAt = const Value.absent(),
    this.itemCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SeedImportsCompanion.insert({
    required String packageId,
    required int version,
    required String payloadJson,
    required String reviewedBy,
    required String reviewReference,
    required int reviewedAt,
    required int importedAt,
    required int itemCount,
    this.rowid = const Value.absent(),
  }) : packageId = Value(packageId),
       version = Value(version),
       payloadJson = Value(payloadJson),
       reviewedBy = Value(reviewedBy),
       reviewReference = Value(reviewReference),
       reviewedAt = Value(reviewedAt),
       importedAt = Value(importedAt),
       itemCount = Value(itemCount);
  static Insertable<SeedImportRow> custom({
    Expression<String>? packageId,
    Expression<int>? version,
    Expression<String>? payloadJson,
    Expression<String>? reviewedBy,
    Expression<String>? reviewReference,
    Expression<int>? reviewedAt,
    Expression<int>? importedAt,
    Expression<int>? itemCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (packageId != null) 'package_id': packageId,
      if (version != null) 'version': version,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (reviewedBy != null) 'reviewed_by': reviewedBy,
      if (reviewReference != null) 'review_reference': reviewReference,
      if (reviewedAt != null) 'reviewed_at': reviewedAt,
      if (importedAt != null) 'imported_at': importedAt,
      if (itemCount != null) 'item_count': itemCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SeedImportsCompanion copyWith({
    Value<String>? packageId,
    Value<int>? version,
    Value<String>? payloadJson,
    Value<String>? reviewedBy,
    Value<String>? reviewReference,
    Value<int>? reviewedAt,
    Value<int>? importedAt,
    Value<int>? itemCount,
    Value<int>? rowid,
  }) {
    return SeedImportsCompanion(
      packageId: packageId ?? this.packageId,
      version: version ?? this.version,
      payloadJson: payloadJson ?? this.payloadJson,
      reviewedBy: reviewedBy ?? this.reviewedBy,
      reviewReference: reviewReference ?? this.reviewReference,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      importedAt: importedAt ?? this.importedAt,
      itemCount: itemCount ?? this.itemCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (packageId.present) {
      map['package_id'] = Variable<String>(packageId.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (reviewedBy.present) {
      map['reviewed_by'] = Variable<String>(reviewedBy.value);
    }
    if (reviewReference.present) {
      map['review_reference'] = Variable<String>(reviewReference.value);
    }
    if (reviewedAt.present) {
      map['reviewed_at'] = Variable<int>(reviewedAt.value);
    }
    if (importedAt.present) {
      map['imported_at'] = Variable<int>(importedAt.value);
    }
    if (itemCount.present) {
      map['item_count'] = Variable<int>(itemCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeedImportsCompanion(')
          ..write('packageId: $packageId, ')
          ..write('version: $version, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('reviewedBy: $reviewedBy, ')
          ..write('reviewReference: $reviewReference, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('importedAt: $importedAt, ')
          ..write('itemCount: $itemCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LearningStatesTable extends LearningStates
    with TableInfo<$LearningStatesTable, LearningStateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearningStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentIdMeta = const VerificationMeta(
    'contentId',
  );
  @override
  late final GeneratedColumn<String> contentId = GeneratedColumn<String>(
    'content_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stageMeta = const VerificationMeta('stage');
  @override
  late final GeneratedColumn<String> stage = GeneratedColumn<String>(
    'stage',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastStudiedAtMeta = const VerificationMeta(
    'lastStudiedAt',
  );
  @override
  late final GeneratedColumn<int> lastStudiedAt = GeneratedColumn<int>(
    'last_studied_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _studyCountMeta = const VerificationMeta(
    'studyCount',
  );
  @override
  late final GeneratedColumn<int> studyCount = GeneratedColumn<int>(
    'study_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<int> dueAt = GeneratedColumn<int>(
    'due_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fsrsStateJsonMeta = const VerificationMeta(
    'fsrsStateJson',
  );
  @override
  late final GeneratedColumn<String> fsrsStateJson = GeneratedColumn<String>(
    'fsrs_state_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fsrsDueAtMeta = const VerificationMeta(
    'fsrsDueAt',
  );
  @override
  late final GeneratedColumn<int> fsrsDueAt = GeneratedColumn<int>(
    'fsrs_due_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fsrsVersionMeta = const VerificationMeta(
    'fsrsVersion',
  );
  @override
  late final GeneratedColumn<String> fsrsVersion = GeneratedColumn<String>(
    'fsrs_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    contentType,
    contentId,
    stage,
    lastStudiedAt,
    studyCount,
    dueAt,
    fsrsStateJson,
    fsrsDueAt,
    fsrsVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learning_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<LearningStateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('content_id')) {
      context.handle(
        _contentIdMeta,
        contentId.isAcceptableOrUnknown(data['content_id']!, _contentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contentIdMeta);
    }
    if (data.containsKey('stage')) {
      context.handle(
        _stageMeta,
        stage.isAcceptableOrUnknown(data['stage']!, _stageMeta),
      );
    } else if (isInserting) {
      context.missing(_stageMeta);
    }
    if (data.containsKey('last_studied_at')) {
      context.handle(
        _lastStudiedAtMeta,
        lastStudiedAt.isAcceptableOrUnknown(
          data['last_studied_at']!,
          _lastStudiedAtMeta,
        ),
      );
    }
    if (data.containsKey('study_count')) {
      context.handle(
        _studyCountMeta,
        studyCount.isAcceptableOrUnknown(data['study_count']!, _studyCountMeta),
      );
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    }
    if (data.containsKey('fsrs_state_json')) {
      context.handle(
        _fsrsStateJsonMeta,
        fsrsStateJson.isAcceptableOrUnknown(
          data['fsrs_state_json']!,
          _fsrsStateJsonMeta,
        ),
      );
    }
    if (data.containsKey('fsrs_due_at')) {
      context.handle(
        _fsrsDueAtMeta,
        fsrsDueAt.isAcceptableOrUnknown(data['fsrs_due_at']!, _fsrsDueAtMeta),
      );
    }
    if (data.containsKey('fsrs_version')) {
      context.handle(
        _fsrsVersionMeta,
        fsrsVersion.isAcceptableOrUnknown(
          data['fsrs_version']!,
          _fsrsVersionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {contentType, contentId};
  @override
  LearningStateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearningStateRow(
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
      )!,
      contentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_id'],
      )!,
      stage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stage'],
      )!,
      lastStudiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_studied_at'],
      ),
      studyCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}study_count'],
      )!,
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_at'],
      ),
      fsrsStateJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fsrs_state_json'],
      ),
      fsrsDueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fsrs_due_at'],
      ),
      fsrsVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fsrs_version'],
      ),
    );
  }

  @override
  $LearningStatesTable createAlias(String alias) {
    return $LearningStatesTable(attachedDatabase, alias);
  }
}

class LearningStateRow extends DataClass
    implements Insertable<LearningStateRow> {
  final String contentType;
  final String contentId;
  final String stage;
  final int? lastStudiedAt;
  final int studyCount;
  final int? dueAt;
  final String? fsrsStateJson;
  final int? fsrsDueAt;
  final String? fsrsVersion;
  const LearningStateRow({
    required this.contentType,
    required this.contentId,
    required this.stage,
    this.lastStudiedAt,
    required this.studyCount,
    this.dueAt,
    this.fsrsStateJson,
    this.fsrsDueAt,
    this.fsrsVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['content_type'] = Variable<String>(contentType);
    map['content_id'] = Variable<String>(contentId);
    map['stage'] = Variable<String>(stage);
    if (!nullToAbsent || lastStudiedAt != null) {
      map['last_studied_at'] = Variable<int>(lastStudiedAt);
    }
    map['study_count'] = Variable<int>(studyCount);
    if (!nullToAbsent || dueAt != null) {
      map['due_at'] = Variable<int>(dueAt);
    }
    if (!nullToAbsent || fsrsStateJson != null) {
      map['fsrs_state_json'] = Variable<String>(fsrsStateJson);
    }
    if (!nullToAbsent || fsrsDueAt != null) {
      map['fsrs_due_at'] = Variable<int>(fsrsDueAt);
    }
    if (!nullToAbsent || fsrsVersion != null) {
      map['fsrs_version'] = Variable<String>(fsrsVersion);
    }
    return map;
  }

  LearningStatesCompanion toCompanion(bool nullToAbsent) {
    return LearningStatesCompanion(
      contentType: Value(contentType),
      contentId: Value(contentId),
      stage: Value(stage),
      lastStudiedAt: lastStudiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastStudiedAt),
      studyCount: Value(studyCount),
      dueAt: dueAt == null && nullToAbsent
          ? const Value.absent()
          : Value(dueAt),
      fsrsStateJson: fsrsStateJson == null && nullToAbsent
          ? const Value.absent()
          : Value(fsrsStateJson),
      fsrsDueAt: fsrsDueAt == null && nullToAbsent
          ? const Value.absent()
          : Value(fsrsDueAt),
      fsrsVersion: fsrsVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(fsrsVersion),
    );
  }

  factory LearningStateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearningStateRow(
      contentType: serializer.fromJson<String>(json['contentType']),
      contentId: serializer.fromJson<String>(json['contentId']),
      stage: serializer.fromJson<String>(json['stage']),
      lastStudiedAt: serializer.fromJson<int?>(json['lastStudiedAt']),
      studyCount: serializer.fromJson<int>(json['studyCount']),
      dueAt: serializer.fromJson<int?>(json['dueAt']),
      fsrsStateJson: serializer.fromJson<String?>(json['fsrsStateJson']),
      fsrsDueAt: serializer.fromJson<int?>(json['fsrsDueAt']),
      fsrsVersion: serializer.fromJson<String?>(json['fsrsVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'contentType': serializer.toJson<String>(contentType),
      'contentId': serializer.toJson<String>(contentId),
      'stage': serializer.toJson<String>(stage),
      'lastStudiedAt': serializer.toJson<int?>(lastStudiedAt),
      'studyCount': serializer.toJson<int>(studyCount),
      'dueAt': serializer.toJson<int?>(dueAt),
      'fsrsStateJson': serializer.toJson<String?>(fsrsStateJson),
      'fsrsDueAt': serializer.toJson<int?>(fsrsDueAt),
      'fsrsVersion': serializer.toJson<String?>(fsrsVersion),
    };
  }

  LearningStateRow copyWith({
    String? contentType,
    String? contentId,
    String? stage,
    Value<int?> lastStudiedAt = const Value.absent(),
    int? studyCount,
    Value<int?> dueAt = const Value.absent(),
    Value<String?> fsrsStateJson = const Value.absent(),
    Value<int?> fsrsDueAt = const Value.absent(),
    Value<String?> fsrsVersion = const Value.absent(),
  }) => LearningStateRow(
    contentType: contentType ?? this.contentType,
    contentId: contentId ?? this.contentId,
    stage: stage ?? this.stage,
    lastStudiedAt: lastStudiedAt.present
        ? lastStudiedAt.value
        : this.lastStudiedAt,
    studyCount: studyCount ?? this.studyCount,
    dueAt: dueAt.present ? dueAt.value : this.dueAt,
    fsrsStateJson: fsrsStateJson.present
        ? fsrsStateJson.value
        : this.fsrsStateJson,
    fsrsDueAt: fsrsDueAt.present ? fsrsDueAt.value : this.fsrsDueAt,
    fsrsVersion: fsrsVersion.present ? fsrsVersion.value : this.fsrsVersion,
  );
  LearningStateRow copyWithCompanion(LearningStatesCompanion data) {
    return LearningStateRow(
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      stage: data.stage.present ? data.stage.value : this.stage,
      lastStudiedAt: data.lastStudiedAt.present
          ? data.lastStudiedAt.value
          : this.lastStudiedAt,
      studyCount: data.studyCount.present
          ? data.studyCount.value
          : this.studyCount,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      fsrsStateJson: data.fsrsStateJson.present
          ? data.fsrsStateJson.value
          : this.fsrsStateJson,
      fsrsDueAt: data.fsrsDueAt.present ? data.fsrsDueAt.value : this.fsrsDueAt,
      fsrsVersion: data.fsrsVersion.present
          ? data.fsrsVersion.value
          : this.fsrsVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearningStateRow(')
          ..write('contentType: $contentType, ')
          ..write('contentId: $contentId, ')
          ..write('stage: $stage, ')
          ..write('lastStudiedAt: $lastStudiedAt, ')
          ..write('studyCount: $studyCount, ')
          ..write('dueAt: $dueAt, ')
          ..write('fsrsStateJson: $fsrsStateJson, ')
          ..write('fsrsDueAt: $fsrsDueAt, ')
          ..write('fsrsVersion: $fsrsVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    contentType,
    contentId,
    stage,
    lastStudiedAt,
    studyCount,
    dueAt,
    fsrsStateJson,
    fsrsDueAt,
    fsrsVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearningStateRow &&
          other.contentType == this.contentType &&
          other.contentId == this.contentId &&
          other.stage == this.stage &&
          other.lastStudiedAt == this.lastStudiedAt &&
          other.studyCount == this.studyCount &&
          other.dueAt == this.dueAt &&
          other.fsrsStateJson == this.fsrsStateJson &&
          other.fsrsDueAt == this.fsrsDueAt &&
          other.fsrsVersion == this.fsrsVersion);
}

class LearningStatesCompanion extends UpdateCompanion<LearningStateRow> {
  final Value<String> contentType;
  final Value<String> contentId;
  final Value<String> stage;
  final Value<int?> lastStudiedAt;
  final Value<int> studyCount;
  final Value<int?> dueAt;
  final Value<String?> fsrsStateJson;
  final Value<int?> fsrsDueAt;
  final Value<String?> fsrsVersion;
  final Value<int> rowid;
  const LearningStatesCompanion({
    this.contentType = const Value.absent(),
    this.contentId = const Value.absent(),
    this.stage = const Value.absent(),
    this.lastStudiedAt = const Value.absent(),
    this.studyCount = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.fsrsStateJson = const Value.absent(),
    this.fsrsDueAt = const Value.absent(),
    this.fsrsVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LearningStatesCompanion.insert({
    required String contentType,
    required String contentId,
    required String stage,
    this.lastStudiedAt = const Value.absent(),
    this.studyCount = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.fsrsStateJson = const Value.absent(),
    this.fsrsDueAt = const Value.absent(),
    this.fsrsVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : contentType = Value(contentType),
       contentId = Value(contentId),
       stage = Value(stage);
  static Insertable<LearningStateRow> custom({
    Expression<String>? contentType,
    Expression<String>? contentId,
    Expression<String>? stage,
    Expression<int>? lastStudiedAt,
    Expression<int>? studyCount,
    Expression<int>? dueAt,
    Expression<String>? fsrsStateJson,
    Expression<int>? fsrsDueAt,
    Expression<String>? fsrsVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (contentType != null) 'content_type': contentType,
      if (contentId != null) 'content_id': contentId,
      if (stage != null) 'stage': stage,
      if (lastStudiedAt != null) 'last_studied_at': lastStudiedAt,
      if (studyCount != null) 'study_count': studyCount,
      if (dueAt != null) 'due_at': dueAt,
      if (fsrsStateJson != null) 'fsrs_state_json': fsrsStateJson,
      if (fsrsDueAt != null) 'fsrs_due_at': fsrsDueAt,
      if (fsrsVersion != null) 'fsrs_version': fsrsVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LearningStatesCompanion copyWith({
    Value<String>? contentType,
    Value<String>? contentId,
    Value<String>? stage,
    Value<int?>? lastStudiedAt,
    Value<int>? studyCount,
    Value<int?>? dueAt,
    Value<String?>? fsrsStateJson,
    Value<int?>? fsrsDueAt,
    Value<String?>? fsrsVersion,
    Value<int>? rowid,
  }) {
    return LearningStatesCompanion(
      contentType: contentType ?? this.contentType,
      contentId: contentId ?? this.contentId,
      stage: stage ?? this.stage,
      lastStudiedAt: lastStudiedAt ?? this.lastStudiedAt,
      studyCount: studyCount ?? this.studyCount,
      dueAt: dueAt ?? this.dueAt,
      fsrsStateJson: fsrsStateJson ?? this.fsrsStateJson,
      fsrsDueAt: fsrsDueAt ?? this.fsrsDueAt,
      fsrsVersion: fsrsVersion ?? this.fsrsVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (contentId.present) {
      map['content_id'] = Variable<String>(contentId.value);
    }
    if (stage.present) {
      map['stage'] = Variable<String>(stage.value);
    }
    if (lastStudiedAt.present) {
      map['last_studied_at'] = Variable<int>(lastStudiedAt.value);
    }
    if (studyCount.present) {
      map['study_count'] = Variable<int>(studyCount.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<int>(dueAt.value);
    }
    if (fsrsStateJson.present) {
      map['fsrs_state_json'] = Variable<String>(fsrsStateJson.value);
    }
    if (fsrsDueAt.present) {
      map['fsrs_due_at'] = Variable<int>(fsrsDueAt.value);
    }
    if (fsrsVersion.present) {
      map['fsrs_version'] = Variable<String>(fsrsVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearningStatesCompanion(')
          ..write('contentType: $contentType, ')
          ..write('contentId: $contentId, ')
          ..write('stage: $stage, ')
          ..write('lastStudiedAt: $lastStudiedAt, ')
          ..write('studyCount: $studyCount, ')
          ..write('dueAt: $dueAt, ')
          ..write('fsrsStateJson: $fsrsStateJson, ')
          ..write('fsrsDueAt: $fsrsDueAt, ')
          ..write('fsrsVersion: $fsrsVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudySessionsTable extends StudySessions
    with TableInfo<$StudySessionsTable, StudySessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudySessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<int> startedAt = GeneratedColumn<int>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _finishedAtMeta = const VerificationMeta(
    'finishedAt',
  );
  @override
  late final GeneratedColumn<int> finishedAt = GeneratedColumn<int>(
    'finished_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemCountMeta = const VerificationMeta(
    'itemCount',
  );
  @override
  late final GeneratedColumn<int> itemCount = GeneratedColumn<int>(
    'item_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedCountMeta = const VerificationMeta(
    'completedCount',
  );
  @override
  late final GeneratedColumn<int> completedCount = GeneratedColumn<int>(
    'completed_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _skippedCountMeta = const VerificationMeta(
    'skippedCount',
  );
  @override
  late final GeneratedColumn<int> skippedCount = GeneratedColumn<int>(
    'skipped_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mode,
    status,
    startedAt,
    finishedAt,
    itemCount,
    completedCount,
    skippedCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudySessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('finished_at')) {
      context.handle(
        _finishedAtMeta,
        finishedAt.isAcceptableOrUnknown(data['finished_at']!, _finishedAtMeta),
      );
    }
    if (data.containsKey('item_count')) {
      context.handle(
        _itemCountMeta,
        itemCount.isAcceptableOrUnknown(data['item_count']!, _itemCountMeta),
      );
    } else if (isInserting) {
      context.missing(_itemCountMeta);
    }
    if (data.containsKey('completed_count')) {
      context.handle(
        _completedCountMeta,
        completedCount.isAcceptableOrUnknown(
          data['completed_count']!,
          _completedCountMeta,
        ),
      );
    }
    if (data.containsKey('skipped_count')) {
      context.handle(
        _skippedCountMeta,
        skippedCount.isAcceptableOrUnknown(
          data['skipped_count']!,
          _skippedCountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudySessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudySessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}started_at'],
      )!,
      finishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}finished_at'],
      ),
      itemCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item_count'],
      )!,
      completedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_count'],
      )!,
      skippedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}skipped_count'],
      )!,
    );
  }

  @override
  $StudySessionsTable createAlias(String alias) {
    return $StudySessionsTable(attachedDatabase, alias);
  }
}

class StudySessionRow extends DataClass implements Insertable<StudySessionRow> {
  final String id;
  final String mode;
  final String status;
  final int startedAt;
  final int? finishedAt;
  final int itemCount;
  final int completedCount;
  final int skippedCount;
  const StudySessionRow({
    required this.id,
    required this.mode,
    required this.status,
    required this.startedAt,
    this.finishedAt,
    required this.itemCount,
    required this.completedCount,
    required this.skippedCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['mode'] = Variable<String>(mode);
    map['status'] = Variable<String>(status);
    map['started_at'] = Variable<int>(startedAt);
    if (!nullToAbsent || finishedAt != null) {
      map['finished_at'] = Variable<int>(finishedAt);
    }
    map['item_count'] = Variable<int>(itemCount);
    map['completed_count'] = Variable<int>(completedCount);
    map['skipped_count'] = Variable<int>(skippedCount);
    return map;
  }

  StudySessionsCompanion toCompanion(bool nullToAbsent) {
    return StudySessionsCompanion(
      id: Value(id),
      mode: Value(mode),
      status: Value(status),
      startedAt: Value(startedAt),
      finishedAt: finishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedAt),
      itemCount: Value(itemCount),
      completedCount: Value(completedCount),
      skippedCount: Value(skippedCount),
    );
  }

  factory StudySessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudySessionRow(
      id: serializer.fromJson<String>(json['id']),
      mode: serializer.fromJson<String>(json['mode']),
      status: serializer.fromJson<String>(json['status']),
      startedAt: serializer.fromJson<int>(json['startedAt']),
      finishedAt: serializer.fromJson<int?>(json['finishedAt']),
      itemCount: serializer.fromJson<int>(json['itemCount']),
      completedCount: serializer.fromJson<int>(json['completedCount']),
      skippedCount: serializer.fromJson<int>(json['skippedCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'mode': serializer.toJson<String>(mode),
      'status': serializer.toJson<String>(status),
      'startedAt': serializer.toJson<int>(startedAt),
      'finishedAt': serializer.toJson<int?>(finishedAt),
      'itemCount': serializer.toJson<int>(itemCount),
      'completedCount': serializer.toJson<int>(completedCount),
      'skippedCount': serializer.toJson<int>(skippedCount),
    };
  }

  StudySessionRow copyWith({
    String? id,
    String? mode,
    String? status,
    int? startedAt,
    Value<int?> finishedAt = const Value.absent(),
    int? itemCount,
    int? completedCount,
    int? skippedCount,
  }) => StudySessionRow(
    id: id ?? this.id,
    mode: mode ?? this.mode,
    status: status ?? this.status,
    startedAt: startedAt ?? this.startedAt,
    finishedAt: finishedAt.present ? finishedAt.value : this.finishedAt,
    itemCount: itemCount ?? this.itemCount,
    completedCount: completedCount ?? this.completedCount,
    skippedCount: skippedCount ?? this.skippedCount,
  );
  StudySessionRow copyWithCompanion(StudySessionsCompanion data) {
    return StudySessionRow(
      id: data.id.present ? data.id.value : this.id,
      mode: data.mode.present ? data.mode.value : this.mode,
      status: data.status.present ? data.status.value : this.status,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      finishedAt: data.finishedAt.present
          ? data.finishedAt.value
          : this.finishedAt,
      itemCount: data.itemCount.present ? data.itemCount.value : this.itemCount,
      completedCount: data.completedCount.present
          ? data.completedCount.value
          : this.completedCount,
      skippedCount: data.skippedCount.present
          ? data.skippedCount.value
          : this.skippedCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudySessionRow(')
          ..write('id: $id, ')
          ..write('mode: $mode, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('itemCount: $itemCount, ')
          ..write('completedCount: $completedCount, ')
          ..write('skippedCount: $skippedCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mode,
    status,
    startedAt,
    finishedAt,
    itemCount,
    completedCount,
    skippedCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudySessionRow &&
          other.id == this.id &&
          other.mode == this.mode &&
          other.status == this.status &&
          other.startedAt == this.startedAt &&
          other.finishedAt == this.finishedAt &&
          other.itemCount == this.itemCount &&
          other.completedCount == this.completedCount &&
          other.skippedCount == this.skippedCount);
}

class StudySessionsCompanion extends UpdateCompanion<StudySessionRow> {
  final Value<String> id;
  final Value<String> mode;
  final Value<String> status;
  final Value<int> startedAt;
  final Value<int?> finishedAt;
  final Value<int> itemCount;
  final Value<int> completedCount;
  final Value<int> skippedCount;
  final Value<int> rowid;
  const StudySessionsCompanion({
    this.id = const Value.absent(),
    this.mode = const Value.absent(),
    this.status = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.finishedAt = const Value.absent(),
    this.itemCount = const Value.absent(),
    this.completedCount = const Value.absent(),
    this.skippedCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudySessionsCompanion.insert({
    required String id,
    required String mode,
    required String status,
    required int startedAt,
    this.finishedAt = const Value.absent(),
    required int itemCount,
    this.completedCount = const Value.absent(),
    this.skippedCount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       mode = Value(mode),
       status = Value(status),
       startedAt = Value(startedAt),
       itemCount = Value(itemCount);
  static Insertable<StudySessionRow> custom({
    Expression<String>? id,
    Expression<String>? mode,
    Expression<String>? status,
    Expression<int>? startedAt,
    Expression<int>? finishedAt,
    Expression<int>? itemCount,
    Expression<int>? completedCount,
    Expression<int>? skippedCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mode != null) 'mode': mode,
      if (status != null) 'status': status,
      if (startedAt != null) 'started_at': startedAt,
      if (finishedAt != null) 'finished_at': finishedAt,
      if (itemCount != null) 'item_count': itemCount,
      if (completedCount != null) 'completed_count': completedCount,
      if (skippedCount != null) 'skipped_count': skippedCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudySessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? mode,
    Value<String>? status,
    Value<int>? startedAt,
    Value<int?>? finishedAt,
    Value<int>? itemCount,
    Value<int>? completedCount,
    Value<int>? skippedCount,
    Value<int>? rowid,
  }) {
    return StudySessionsCompanion(
      id: id ?? this.id,
      mode: mode ?? this.mode,
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      itemCount: itemCount ?? this.itemCount,
      completedCount: completedCount ?? this.completedCount,
      skippedCount: skippedCount ?? this.skippedCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<int>(startedAt.value);
    }
    if (finishedAt.present) {
      map['finished_at'] = Variable<int>(finishedAt.value);
    }
    if (itemCount.present) {
      map['item_count'] = Variable<int>(itemCount.value);
    }
    if (completedCount.present) {
      map['completed_count'] = Variable<int>(completedCount.value);
    }
    if (skippedCount.present) {
      map['skipped_count'] = Variable<int>(skippedCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudySessionsCompanion(')
          ..write('id: $id, ')
          ..write('mode: $mode, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('itemCount: $itemCount, ')
          ..write('completedCount: $completedCount, ')
          ..write('skippedCount: $skippedCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudySessionItemsTable extends StudySessionItems
    with TableInfo<$StudySessionItemsTable, StudySessionItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudySessionItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_sessions (id)',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _promptMeta = const VerificationMeta('prompt');
  @override
  late final GeneratedColumn<String> prompt = GeneratedColumn<String>(
    'prompt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answerMeta = const VerificationMeta('answer');
  @override
  late final GeneratedColumn<String> answer = GeneratedColumn<String>(
    'answer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hintsJsonMeta = const VerificationMeta(
    'hintsJson',
  );
  @override
  late final GeneratedColumn<String> hintsJson = GeneratedColumn<String>(
    'hints_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    sessionId,
    itemId,
    contentType,
    prompt,
    answer,
    hintsJson,
    position,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_session_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudySessionItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('prompt')) {
      context.handle(
        _promptMeta,
        prompt.isAcceptableOrUnknown(data['prompt']!, _promptMeta),
      );
    } else if (isInserting) {
      context.missing(_promptMeta);
    }
    if (data.containsKey('answer')) {
      context.handle(
        _answerMeta,
        answer.isAcceptableOrUnknown(data['answer']!, _answerMeta),
      );
    } else if (isInserting) {
      context.missing(_answerMeta);
    }
    if (data.containsKey('hints_json')) {
      context.handle(
        _hintsJsonMeta,
        hintsJson.isAcceptableOrUnknown(data['hints_json']!, _hintsJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_hintsJsonMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sessionId, itemId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {sessionId, position},
  ];
  @override
  StudySessionItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudySessionItemRow(
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
      )!,
      prompt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt'],
      )!,
      answer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer'],
      )!,
      hintsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hints_json'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $StudySessionItemsTable createAlias(String alias) {
    return $StudySessionItemsTable(attachedDatabase, alias);
  }
}

class StudySessionItemRow extends DataClass
    implements Insertable<StudySessionItemRow> {
  final String sessionId;
  final String itemId;
  final String contentType;
  final String prompt;
  final String answer;
  final String hintsJson;
  final int position;
  const StudySessionItemRow({
    required this.sessionId,
    required this.itemId,
    required this.contentType,
    required this.prompt,
    required this.answer,
    required this.hintsJson,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['session_id'] = Variable<String>(sessionId);
    map['item_id'] = Variable<String>(itemId);
    map['content_type'] = Variable<String>(contentType);
    map['prompt'] = Variable<String>(prompt);
    map['answer'] = Variable<String>(answer);
    map['hints_json'] = Variable<String>(hintsJson);
    map['position'] = Variable<int>(position);
    return map;
  }

  StudySessionItemsCompanion toCompanion(bool nullToAbsent) {
    return StudySessionItemsCompanion(
      sessionId: Value(sessionId),
      itemId: Value(itemId),
      contentType: Value(contentType),
      prompt: Value(prompt),
      answer: Value(answer),
      hintsJson: Value(hintsJson),
      position: Value(position),
    );
  }

  factory StudySessionItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudySessionItemRow(
      sessionId: serializer.fromJson<String>(json['sessionId']),
      itemId: serializer.fromJson<String>(json['itemId']),
      contentType: serializer.fromJson<String>(json['contentType']),
      prompt: serializer.fromJson<String>(json['prompt']),
      answer: serializer.fromJson<String>(json['answer']),
      hintsJson: serializer.fromJson<String>(json['hintsJson']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sessionId': serializer.toJson<String>(sessionId),
      'itemId': serializer.toJson<String>(itemId),
      'contentType': serializer.toJson<String>(contentType),
      'prompt': serializer.toJson<String>(prompt),
      'answer': serializer.toJson<String>(answer),
      'hintsJson': serializer.toJson<String>(hintsJson),
      'position': serializer.toJson<int>(position),
    };
  }

  StudySessionItemRow copyWith({
    String? sessionId,
    String? itemId,
    String? contentType,
    String? prompt,
    String? answer,
    String? hintsJson,
    int? position,
  }) => StudySessionItemRow(
    sessionId: sessionId ?? this.sessionId,
    itemId: itemId ?? this.itemId,
    contentType: contentType ?? this.contentType,
    prompt: prompt ?? this.prompt,
    answer: answer ?? this.answer,
    hintsJson: hintsJson ?? this.hintsJson,
    position: position ?? this.position,
  );
  StudySessionItemRow copyWithCompanion(StudySessionItemsCompanion data) {
    return StudySessionItemRow(
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      prompt: data.prompt.present ? data.prompt.value : this.prompt,
      answer: data.answer.present ? data.answer.value : this.answer,
      hintsJson: data.hintsJson.present ? data.hintsJson.value : this.hintsJson,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudySessionItemRow(')
          ..write('sessionId: $sessionId, ')
          ..write('itemId: $itemId, ')
          ..write('contentType: $contentType, ')
          ..write('prompt: $prompt, ')
          ..write('answer: $answer, ')
          ..write('hintsJson: $hintsJson, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    sessionId,
    itemId,
    contentType,
    prompt,
    answer,
    hintsJson,
    position,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudySessionItemRow &&
          other.sessionId == this.sessionId &&
          other.itemId == this.itemId &&
          other.contentType == this.contentType &&
          other.prompt == this.prompt &&
          other.answer == this.answer &&
          other.hintsJson == this.hintsJson &&
          other.position == this.position);
}

class StudySessionItemsCompanion extends UpdateCompanion<StudySessionItemRow> {
  final Value<String> sessionId;
  final Value<String> itemId;
  final Value<String> contentType;
  final Value<String> prompt;
  final Value<String> answer;
  final Value<String> hintsJson;
  final Value<int> position;
  final Value<int> rowid;
  const StudySessionItemsCompanion({
    this.sessionId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.contentType = const Value.absent(),
    this.prompt = const Value.absent(),
    this.answer = const Value.absent(),
    this.hintsJson = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudySessionItemsCompanion.insert({
    required String sessionId,
    required String itemId,
    required String contentType,
    required String prompt,
    required String answer,
    required String hintsJson,
    required int position,
    this.rowid = const Value.absent(),
  }) : sessionId = Value(sessionId),
       itemId = Value(itemId),
       contentType = Value(contentType),
       prompt = Value(prompt),
       answer = Value(answer),
       hintsJson = Value(hintsJson),
       position = Value(position);
  static Insertable<StudySessionItemRow> custom({
    Expression<String>? sessionId,
    Expression<String>? itemId,
    Expression<String>? contentType,
    Expression<String>? prompt,
    Expression<String>? answer,
    Expression<String>? hintsJson,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sessionId != null) 'session_id': sessionId,
      if (itemId != null) 'item_id': itemId,
      if (contentType != null) 'content_type': contentType,
      if (prompt != null) 'prompt': prompt,
      if (answer != null) 'answer': answer,
      if (hintsJson != null) 'hints_json': hintsJson,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudySessionItemsCompanion copyWith({
    Value<String>? sessionId,
    Value<String>? itemId,
    Value<String>? contentType,
    Value<String>? prompt,
    Value<String>? answer,
    Value<String>? hintsJson,
    Value<int>? position,
    Value<int>? rowid,
  }) {
    return StudySessionItemsCompanion(
      sessionId: sessionId ?? this.sessionId,
      itemId: itemId ?? this.itemId,
      contentType: contentType ?? this.contentType,
      prompt: prompt ?? this.prompt,
      answer: answer ?? this.answer,
      hintsJson: hintsJson ?? this.hintsJson,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (prompt.present) {
      map['prompt'] = Variable<String>(prompt.value);
    }
    if (answer.present) {
      map['answer'] = Variable<String>(answer.value);
    }
    if (hintsJson.present) {
      map['hints_json'] = Variable<String>(hintsJson.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudySessionItemsCompanion(')
          ..write('sessionId: $sessionId, ')
          ..write('itemId: $itemId, ')
          ..write('contentType: $contentType, ')
          ..write('prompt: $prompt, ')
          ..write('answer: $answer, ')
          ..write('hintsJson: $hintsJson, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudyLogsTable extends StudyLogs
    with TableInfo<$StudyLogsTable, StudyLogRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_sessions (id)',
    ),
  );
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentIdMeta = const VerificationMeta(
    'contentId',
  );
  @override
  late final GeneratedColumn<String> contentId = GeneratedColumn<String>(
    'content_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _outcomeMeta = const VerificationMeta(
    'outcome',
  );
  @override
  late final GeneratedColumn<String> outcome = GeneratedColumn<String>(
    'outcome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answeredAtMeta = const VerificationMeta(
    'answeredAt',
  );
  @override
  late final GeneratedColumn<int> answeredAt = GeneratedColumn<int>(
    'answered_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _responseMsMeta = const VerificationMeta(
    'responseMs',
  );
  @override
  late final GeneratedColumn<int> responseMs = GeneratedColumn<int>(
    'response_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    contentType,
    contentId,
    outcome,
    answeredAt,
    responseMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyLogRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('content_id')) {
      context.handle(
        _contentIdMeta,
        contentId.isAcceptableOrUnknown(data['content_id']!, _contentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contentIdMeta);
    }
    if (data.containsKey('outcome')) {
      context.handle(
        _outcomeMeta,
        outcome.isAcceptableOrUnknown(data['outcome']!, _outcomeMeta),
      );
    } else if (isInserting) {
      context.missing(_outcomeMeta);
    }
    if (data.containsKey('answered_at')) {
      context.handle(
        _answeredAtMeta,
        answeredAt.isAcceptableOrUnknown(data['answered_at']!, _answeredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_answeredAtMeta);
    }
    if (data.containsKey('response_ms')) {
      context.handle(
        _responseMsMeta,
        responseMs.isAcceptableOrUnknown(data['response_ms']!, _responseMsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {sessionId, contentId},
  ];
  @override
  StudyLogRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyLogRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
      )!,
      contentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_id'],
      )!,
      outcome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outcome'],
      )!,
      answeredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}answered_at'],
      )!,
      responseMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}response_ms'],
      ),
    );
  }

  @override
  $StudyLogsTable createAlias(String alias) {
    return $StudyLogsTable(attachedDatabase, alias);
  }
}

class StudyLogRow extends DataClass implements Insertable<StudyLogRow> {
  final String id;
  final String sessionId;
  final String contentType;
  final String contentId;
  final String outcome;
  final int answeredAt;
  final int? responseMs;
  const StudyLogRow({
    required this.id,
    required this.sessionId,
    required this.contentType,
    required this.contentId,
    required this.outcome,
    required this.answeredAt,
    this.responseMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['content_type'] = Variable<String>(contentType);
    map['content_id'] = Variable<String>(contentId);
    map['outcome'] = Variable<String>(outcome);
    map['answered_at'] = Variable<int>(answeredAt);
    if (!nullToAbsent || responseMs != null) {
      map['response_ms'] = Variable<int>(responseMs);
    }
    return map;
  }

  StudyLogsCompanion toCompanion(bool nullToAbsent) {
    return StudyLogsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      contentType: Value(contentType),
      contentId: Value(contentId),
      outcome: Value(outcome),
      answeredAt: Value(answeredAt),
      responseMs: responseMs == null && nullToAbsent
          ? const Value.absent()
          : Value(responseMs),
    );
  }

  factory StudyLogRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyLogRow(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      contentType: serializer.fromJson<String>(json['contentType']),
      contentId: serializer.fromJson<String>(json['contentId']),
      outcome: serializer.fromJson<String>(json['outcome']),
      answeredAt: serializer.fromJson<int>(json['answeredAt']),
      responseMs: serializer.fromJson<int?>(json['responseMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'contentType': serializer.toJson<String>(contentType),
      'contentId': serializer.toJson<String>(contentId),
      'outcome': serializer.toJson<String>(outcome),
      'answeredAt': serializer.toJson<int>(answeredAt),
      'responseMs': serializer.toJson<int?>(responseMs),
    };
  }

  StudyLogRow copyWith({
    String? id,
    String? sessionId,
    String? contentType,
    String? contentId,
    String? outcome,
    int? answeredAt,
    Value<int?> responseMs = const Value.absent(),
  }) => StudyLogRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    contentType: contentType ?? this.contentType,
    contentId: contentId ?? this.contentId,
    outcome: outcome ?? this.outcome,
    answeredAt: answeredAt ?? this.answeredAt,
    responseMs: responseMs.present ? responseMs.value : this.responseMs,
  );
  StudyLogRow copyWithCompanion(StudyLogsCompanion data) {
    return StudyLogRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
      answeredAt: data.answeredAt.present
          ? data.answeredAt.value
          : this.answeredAt,
      responseMs: data.responseMs.present
          ? data.responseMs.value
          : this.responseMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyLogRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('contentType: $contentType, ')
          ..write('contentId: $contentId, ')
          ..write('outcome: $outcome, ')
          ..write('answeredAt: $answeredAt, ')
          ..write('responseMs: $responseMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    contentType,
    contentId,
    outcome,
    answeredAt,
    responseMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyLogRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.contentType == this.contentType &&
          other.contentId == this.contentId &&
          other.outcome == this.outcome &&
          other.answeredAt == this.answeredAt &&
          other.responseMs == this.responseMs);
}

class StudyLogsCompanion extends UpdateCompanion<StudyLogRow> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> contentType;
  final Value<String> contentId;
  final Value<String> outcome;
  final Value<int> answeredAt;
  final Value<int?> responseMs;
  final Value<int> rowid;
  const StudyLogsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.contentType = const Value.absent(),
    this.contentId = const Value.absent(),
    this.outcome = const Value.absent(),
    this.answeredAt = const Value.absent(),
    this.responseMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudyLogsCompanion.insert({
    required String id,
    required String sessionId,
    required String contentType,
    required String contentId,
    required String outcome,
    required int answeredAt,
    this.responseMs = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       contentType = Value(contentType),
       contentId = Value(contentId),
       outcome = Value(outcome),
       answeredAt = Value(answeredAt);
  static Insertable<StudyLogRow> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? contentType,
    Expression<String>? contentId,
    Expression<String>? outcome,
    Expression<int>? answeredAt,
    Expression<int>? responseMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (contentType != null) 'content_type': contentType,
      if (contentId != null) 'content_id': contentId,
      if (outcome != null) 'outcome': outcome,
      if (answeredAt != null) 'answered_at': answeredAt,
      if (responseMs != null) 'response_ms': responseMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudyLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String>? contentType,
    Value<String>? contentId,
    Value<String>? outcome,
    Value<int>? answeredAt,
    Value<int?>? responseMs,
    Value<int>? rowid,
  }) {
    return StudyLogsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      contentType: contentType ?? this.contentType,
      contentId: contentId ?? this.contentId,
      outcome: outcome ?? this.outcome,
      answeredAt: answeredAt ?? this.answeredAt,
      responseMs: responseMs ?? this.responseMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (contentId.present) {
      map['content_id'] = Variable<String>(contentId.value);
    }
    if (outcome.present) {
      map['outcome'] = Variable<String>(outcome.value);
    }
    if (answeredAt.present) {
      map['answered_at'] = Variable<int>(answeredAt.value);
    }
    if (responseMs.present) {
      map['response_ms'] = Variable<int>(responseMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyLogsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('contentType: $contentType, ')
          ..write('contentId: $contentId, ')
          ..write('outcome: $outcome, ')
          ..write('answeredAt: $answeredAt, ')
          ..write('responseMs: $responseMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RootsTable roots = $RootsTable(this);
  late final $AffixesTable affixes = $AffixesTable(this);
  late final $WordsTable words = $WordsTable(this);
  late final $WordComponentsTable wordComponents = $WordComponentsTable(this);
  late final $ExamplesTable examples = $ExamplesTable(this);
  late final $SeedImportsTable seedImports = $SeedImportsTable(this);
  late final $LearningStatesTable learningStates = $LearningStatesTable(this);
  late final $StudySessionsTable studySessions = $StudySessionsTable(this);
  late final $StudySessionItemsTable studySessionItems =
      $StudySessionItemsTable(this);
  late final $StudyLogsTable studyLogs = $StudyLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    roots,
    affixes,
    words,
    wordComponents,
    examples,
    seedImports,
    learningStates,
    studySessions,
    studySessionItems,
    studyLogs,
  ];
}

typedef $$RootsTableCreateCompanionBuilder = RootsCompanion Function({
  required String id,
  required String lemma,
  required String displayForm,
  required String language,
  required String meaning,
  Value<String?> originNote,
  required String verificationStatus,
  required String sourceRefs,
  required int createdAt,
  required int updatedAt,
  Value<int> rowid,
});
typedef $$RootsTableUpdateCompanionBuilder = RootsCompanion Function({
  Value<String> id,
  Value<String> lemma,
  Value<String> displayForm,
  Value<String> language,
  Value<String> meaning,
  Value<String?> originNote,
  Value<String> verificationStatus,
  Value<String> sourceRefs,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<int> rowid,
});

class $$RootsTableFilterComposer extends Composer<_$AppDatabase, $RootsTable> {
  $$RootsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lemma => $composableBuilder(
    column: $table.lemma,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayForm => $composableBuilder(
    column: $table.displayForm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originNote => $composableBuilder(
    column: $table.originNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get verificationStatus => $composableBuilder(
    column: $table.verificationStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRefs => $composableBuilder(
    column: $table.sourceRefs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RootsTableOrderingComposer
    extends Composer<_$AppDatabase, $RootsTable> {
  $$RootsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lemma => $composableBuilder(
    column: $table.lemma,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayForm => $composableBuilder(
    column: $table.displayForm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originNote => $composableBuilder(
    column: $table.originNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verificationStatus => $composableBuilder(
    column: $table.verificationStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRefs => $composableBuilder(
    column: $table.sourceRefs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RootsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RootsTable> {
  $$RootsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lemma =>
      $composableBuilder(column: $table.lemma, builder: (column) => column);

  GeneratedColumn<String> get displayForm => $composableBuilder(
    column: $table.displayForm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get meaning =>
      $composableBuilder(column: $table.meaning, builder: (column) => column);

  GeneratedColumn<String> get originNote => $composableBuilder(
    column: $table.originNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get verificationStatus => $composableBuilder(
    column: $table.verificationStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceRefs => $composableBuilder(
    column: $table.sourceRefs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RootsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RootsTable,
          RootRow,
          $$RootsTableFilterComposer,
          $$RootsTableOrderingComposer,
          $$RootsTableAnnotationComposer,
          $$RootsTableCreateCompanionBuilder,
          $$RootsTableUpdateCompanionBuilder,
          (RootRow, BaseReferences<_$AppDatabase, $RootsTable, RootRow>),
          RootRow,
          PrefetchHooks Function()
        > {
  $$RootsTableTableManager(_$AppDatabase db, $RootsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RootsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RootsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RootsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> lemma = const Value.absent(),
                Value<String> displayForm = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> meaning = const Value.absent(),
                Value<String?> originNote = const Value.absent(),
                Value<String> verificationStatus = const Value.absent(),
                Value<String> sourceRefs = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RootsCompanion(
                id: id,
                lemma: lemma,
                displayForm: displayForm,
                language: language,
                meaning: meaning,
                originNote: originNote,
                verificationStatus: verificationStatus,
                sourceRefs: sourceRefs,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String lemma,
                required String displayForm,
                required String language,
                required String meaning,
                Value<String?> originNote = const Value.absent(),
                required String verificationStatus,
                required String sourceRefs,
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => RootsCompanion.insert(
                id: id,
                lemma: lemma,
                displayForm: displayForm,
                language: language,
                meaning: meaning,
                originNote: originNote,
                verificationStatus: verificationStatus,
                sourceRefs: sourceRefs,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RootsTable, RootRow>(table),
                  BaseReferences<_$AppDatabase, $RootsTable, RootRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RootsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RootsTable,
      RootRow,
      $$RootsTableFilterComposer,
      $$RootsTableOrderingComposer,
      $$RootsTableAnnotationComposer,
      $$RootsTableCreateCompanionBuilder,
      $$RootsTableUpdateCompanionBuilder,
      (RootRow, BaseReferences<_$AppDatabase, $RootsTable, RootRow>),
      RootRow,
      PrefetchHooks Function()
    >;
typedef $$AffixesTableCreateCompanionBuilder = AffixesCompanion Function({
  required String id,
  required String form,
  required String kind,
  required String meaning,
  required String verificationStatus,
  required String sourceRefs,
  Value<int> rowid,
});
typedef $$AffixesTableUpdateCompanionBuilder = AffixesCompanion Function({
  Value<String> id,
  Value<String> form,
  Value<String> kind,
  Value<String> meaning,
  Value<String> verificationStatus,
  Value<String> sourceRefs,
  Value<int> rowid,
});

class $$AffixesTableFilterComposer
    extends Composer<_$AppDatabase, $AffixesTable> {
  $$AffixesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get verificationStatus => $composableBuilder(
    column: $table.verificationStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRefs => $composableBuilder(
    column: $table.sourceRefs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AffixesTableOrderingComposer
    extends Composer<_$AppDatabase, $AffixesTable> {
  $$AffixesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verificationStatus => $composableBuilder(
    column: $table.verificationStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRefs => $composableBuilder(
    column: $table.sourceRefs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AffixesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AffixesTable> {
  $$AffixesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get form =>
      $composableBuilder(column: $table.form, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get meaning =>
      $composableBuilder(column: $table.meaning, builder: (column) => column);

  GeneratedColumn<String> get verificationStatus => $composableBuilder(
    column: $table.verificationStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceRefs => $composableBuilder(
    column: $table.sourceRefs,
    builder: (column) => column,
  );
}

class $$AffixesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AffixesTable,
          AffixRow,
          $$AffixesTableFilterComposer,
          $$AffixesTableOrderingComposer,
          $$AffixesTableAnnotationComposer,
          $$AffixesTableCreateCompanionBuilder,
          $$AffixesTableUpdateCompanionBuilder,
          (AffixRow, BaseReferences<_$AppDatabase, $AffixesTable, AffixRow>),
          AffixRow,
          PrefetchHooks Function()
        > {
  $$AffixesTableTableManager(_$AppDatabase db, $AffixesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AffixesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AffixesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AffixesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> form = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> meaning = const Value.absent(),
                Value<String> verificationStatus = const Value.absent(),
                Value<String> sourceRefs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AffixesCompanion(
                id: id,
                form: form,
                kind: kind,
                meaning: meaning,
                verificationStatus: verificationStatus,
                sourceRefs: sourceRefs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String form,
                required String kind,
                required String meaning,
                required String verificationStatus,
                required String sourceRefs,
                Value<int> rowid = const Value.absent(),
              }) => AffixesCompanion.insert(
                id: id,
                form: form,
                kind: kind,
                meaning: meaning,
                verificationStatus: verificationStatus,
                sourceRefs: sourceRefs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AffixesTable, AffixRow>(table),
                  BaseReferences<_$AppDatabase, $AffixesTable, AffixRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AffixesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AffixesTable,
      AffixRow,
      $$AffixesTableFilterComposer,
      $$AffixesTableOrderingComposer,
      $$AffixesTableAnnotationComposer,
      $$AffixesTableCreateCompanionBuilder,
      $$AffixesTableUpdateCompanionBuilder,
      (AffixRow, BaseReferences<_$AppDatabase, $AffixesTable, AffixRow>),
      AffixRow,
      PrefetchHooks Function()
    >;
typedef $$WordsTableCreateCompanionBuilder = WordsCompanion Function({
  required String id,
  required String word,
  required String normalizedWord,
  Value<String?> partOfSpeech,
  required String definition,
  Value<String?> translation,
  Value<String?> pronunciationRef,
  required String sourceRefs,
  Value<int> rowid,
});
typedef $$WordsTableUpdateCompanionBuilder = WordsCompanion Function({
  Value<String> id,
  Value<String> word,
  Value<String> normalizedWord,
  Value<String?> partOfSpeech,
  Value<String> definition,
  Value<String?> translation,
  Value<String?> pronunciationRef,
  Value<String> sourceRefs,
  Value<int> rowid,
});

final class $$WordsTableReferences
    extends BaseReferences<_$AppDatabase, $WordsTable, WordRow> {
  $$WordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WordComponentsTable, List<WordComponentRow>>
  _wordComponentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.wordComponents,
    aliasName: 'words__id__word_components__word_id',
  );

  $$WordComponentsTableProcessedTableManager get wordComponentsRefs {
    final manager = $$WordComponentsTableTableManager(
      $_db,
      $_db.wordComponents,
    ).filter((f) => f.wordId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordComponentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExamplesTable, List<ExampleRow>>
  _examplesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.examples,
    aliasName: 'words__id__examples__word_id',
  );

  $$ExamplesTableProcessedTableManager get examplesRefs {
    final manager = $$ExamplesTableTableManager(
      $_db,
      $_db.examples,
    ).filter((f) => f.wordId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_examplesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WordsTableFilterComposer extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedWord => $composableBuilder(
    column: $table.normalizedWord,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pronunciationRef => $composableBuilder(
    column: $table.pronunciationRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRefs => $composableBuilder(
    column: $table.sourceRefs,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> wordComponentsRefs(
    Expression<bool> Function($$WordComponentsTableFilterComposer f) f,
  ) {
    final $$WordComponentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordComponents,
      getReferencedColumn: (t) => t.wordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordComponentsTableFilterComposer(
            $db: $db,
            $table: $db.wordComponents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> examplesRefs(
    Expression<bool> Function($$ExamplesTableFilterComposer f) f,
  ) {
    final $$ExamplesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.examples,
      getReferencedColumn: (t) => t.wordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamplesTableFilterComposer(
            $db: $db,
            $table: $db.examples,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordsTableOrderingComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedWord => $composableBuilder(
    column: $table.normalizedWord,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pronunciationRef => $composableBuilder(
    column: $table.pronunciationRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRefs => $composableBuilder(
    column: $table.sourceRefs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<String> get normalizedWord => $composableBuilder(
    column: $table.normalizedWord,
    builder: (column) => column,
  );

  GeneratedColumn<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => column,
  );

  GeneratedColumn<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pronunciationRef => $composableBuilder(
    column: $table.pronunciationRef,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceRefs => $composableBuilder(
    column: $table.sourceRefs,
    builder: (column) => column,
  );

  Expression<T> wordComponentsRefs<T extends Object>(
    Expression<T> Function($$WordComponentsTableAnnotationComposer a) f,
  ) {
    final $$WordComponentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordComponents,
      getReferencedColumn: (t) => t.wordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordComponentsTableAnnotationComposer(
            $db: $db,
            $table: $db.wordComponents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> examplesRefs<T extends Object>(
    Expression<T> Function($$ExamplesTableAnnotationComposer a) f,
  ) {
    final $$ExamplesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.examples,
      getReferencedColumn: (t) => t.wordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamplesTableAnnotationComposer(
            $db: $db,
            $table: $db.examples,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordsTable,
          WordRow,
          $$WordsTableFilterComposer,
          $$WordsTableOrderingComposer,
          $$WordsTableAnnotationComposer,
          $$WordsTableCreateCompanionBuilder,
          $$WordsTableUpdateCompanionBuilder,
          (WordRow, $$WordsTableReferences),
          WordRow,
          PrefetchHooks Function({bool wordComponentsRefs, bool examplesRefs})
        > {
  $$WordsTableTableManager(_$AppDatabase db, $WordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> word = const Value.absent(),
                Value<String> normalizedWord = const Value.absent(),
                Value<String?> partOfSpeech = const Value.absent(),
                Value<String> definition = const Value.absent(),
                Value<String?> translation = const Value.absent(),
                Value<String?> pronunciationRef = const Value.absent(),
                Value<String> sourceRefs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordsCompanion(
                id: id,
                word: word,
                normalizedWord: normalizedWord,
                partOfSpeech: partOfSpeech,
                definition: definition,
                translation: translation,
                pronunciationRef: pronunciationRef,
                sourceRefs: sourceRefs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String word,
                required String normalizedWord,
                Value<String?> partOfSpeech = const Value.absent(),
                required String definition,
                Value<String?> translation = const Value.absent(),
                Value<String?> pronunciationRef = const Value.absent(),
                required String sourceRefs,
                Value<int> rowid = const Value.absent(),
              }) => WordsCompanion.insert(
                id: id,
                word: word,
                normalizedWord: normalizedWord,
                partOfSpeech: partOfSpeech,
                definition: definition,
                translation: translation,
                pronunciationRef: pronunciationRef,
                sourceRefs: sourceRefs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WordsTable, WordRow>(table),
                  $$WordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({wordComponentsRefs = false, examplesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (wordComponentsRefs) db.wordComponents,
                    if (examplesRefs) db.examples,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (wordComponentsRefs)
                        await $_getPrefetchedDataByColumns<
                          WordRow,
                          $WordsTable,
                          WordComponentRow,
                          $WordComponentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$WordsTableReferences
                              ._wordComponentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WordsTableReferences(
                                db,
                                table,
                                p0,
                              ).wordComponentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'word_id',
                          typedResults: items,
                        ),
                      if (examplesRefs)
                        await $_getPrefetchedDataByColumns<
                          WordRow,
                          $WordsTable,
                          ExampleRow,
                          $ExamplesTable
                        >(
                          currentTable: table,
                          referencedTable: $$WordsTableReferences
                              ._examplesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WordsTableReferences(
                                db,
                                table,
                                p0,
                              ).examplesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'word_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordsTable,
      WordRow,
      $$WordsTableFilterComposer,
      $$WordsTableOrderingComposer,
      $$WordsTableAnnotationComposer,
      $$WordsTableCreateCompanionBuilder,
      $$WordsTableUpdateCompanionBuilder,
      (WordRow, $$WordsTableReferences),
      WordRow,
      PrefetchHooks Function({bool wordComponentsRefs, bool examplesRefs})
    >;
typedef $$WordComponentsTableCreateCompanionBuilder =
    WordComponentsCompanion Function({
      required String wordId,
      required String componentType,
      required String componentId,
      required String role,
      Value<double?> confidence,
      required String sourceRefs,
      Value<int> rowid,
    });
typedef $$WordComponentsTableUpdateCompanionBuilder =
    WordComponentsCompanion Function({
      Value<String> wordId,
      Value<String> componentType,
      Value<String> componentId,
      Value<String> role,
      Value<double?> confidence,
      Value<String> sourceRefs,
      Value<int> rowid,
    });

final class $$WordComponentsTableReferences
    extends
        BaseReferences<_$AppDatabase, $WordComponentsTable, WordComponentRow> {
  $$WordComponentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WordsTable _wordIdTable(_$AppDatabase db) =>
      db.words.createAlias('word_components__word_id__words__id');

  $$WordsTableProcessedTableManager get wordId {
    final $_column = $_itemColumn<String>('word_id')!;

    final manager = $$WordsTableTableManager(
      $_db,
      $_db.words,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WordComponentsTableFilterComposer
    extends Composer<_$AppDatabase, $WordComponentsTable> {
  $$WordComponentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get componentType => $composableBuilder(
    column: $table.componentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get componentId => $composableBuilder(
    column: $table.componentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRefs => $composableBuilder(
    column: $table.sourceRefs,
    builder: (column) => ColumnFilters(column),
  );

  $$WordsTableFilterComposer get wordId {
    final $$WordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableFilterComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordComponentsTableOrderingComposer
    extends Composer<_$AppDatabase, $WordComponentsTable> {
  $$WordComponentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get componentType => $composableBuilder(
    column: $table.componentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get componentId => $composableBuilder(
    column: $table.componentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRefs => $composableBuilder(
    column: $table.sourceRefs,
    builder: (column) => ColumnOrderings(column),
  );

  $$WordsTableOrderingComposer get wordId {
    final $$WordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableOrderingComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordComponentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordComponentsTable> {
  $$WordComponentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get componentType => $composableBuilder(
    column: $table.componentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get componentId => $composableBuilder(
    column: $table.componentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceRefs => $composableBuilder(
    column: $table.sourceRefs,
    builder: (column) => column,
  );

  $$WordsTableAnnotationComposer get wordId {
    final $$WordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableAnnotationComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordComponentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordComponentsTable,
          WordComponentRow,
          $$WordComponentsTableFilterComposer,
          $$WordComponentsTableOrderingComposer,
          $$WordComponentsTableAnnotationComposer,
          $$WordComponentsTableCreateCompanionBuilder,
          $$WordComponentsTableUpdateCompanionBuilder,
          (WordComponentRow, $$WordComponentsTableReferences),
          WordComponentRow,
          PrefetchHooks Function({bool wordId})
        > {
  $$WordComponentsTableTableManager(
    _$AppDatabase db,
    $WordComponentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordComponentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordComponentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordComponentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> wordId = const Value.absent(),
                Value<String> componentType = const Value.absent(),
                Value<String> componentId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<double?> confidence = const Value.absent(),
                Value<String> sourceRefs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordComponentsCompanion(
                wordId: wordId,
                componentType: componentType,
                componentId: componentId,
                role: role,
                confidence: confidence,
                sourceRefs: sourceRefs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String wordId,
                required String componentType,
                required String componentId,
                required String role,
                Value<double?> confidence = const Value.absent(),
                required String sourceRefs,
                Value<int> rowid = const Value.absent(),
              }) => WordComponentsCompanion.insert(
                wordId: wordId,
                componentType: componentType,
                componentId: componentId,
                role: role,
                confidence: confidence,
                sourceRefs: sourceRefs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WordComponentsTable, WordComponentRow>(table),
                  $$WordComponentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (wordId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.wordId,
                        referencedTable: $$WordComponentsTableReferences
                            ._wordIdTable(db),
                        referencedColumn: $$WordComponentsTableReferences
                            ._wordIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WordComponentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordComponentsTable,
      WordComponentRow,
      $$WordComponentsTableFilterComposer,
      $$WordComponentsTableOrderingComposer,
      $$WordComponentsTableAnnotationComposer,
      $$WordComponentsTableCreateCompanionBuilder,
      $$WordComponentsTableUpdateCompanionBuilder,
      (WordComponentRow, $$WordComponentsTableReferences),
      WordComponentRow,
      PrefetchHooks Function({bool wordId})
    >;
typedef $$ExamplesTableCreateCompanionBuilder = ExamplesCompanion Function({
  required String id,
  required String wordId,
  required String sentence,
  Value<String?> translation,
  required String sourceRefs,
  Value<int> rowid,
});
typedef $$ExamplesTableUpdateCompanionBuilder = ExamplesCompanion Function({
  Value<String> id,
  Value<String> wordId,
  Value<String> sentence,
  Value<String?> translation,
  Value<String> sourceRefs,
  Value<int> rowid,
});

final class $$ExamplesTableReferences
    extends BaseReferences<_$AppDatabase, $ExamplesTable, ExampleRow> {
  $$ExamplesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WordsTable _wordIdTable(_$AppDatabase db) =>
      db.words.createAlias('examples__word_id__words__id');

  $$WordsTableProcessedTableManager get wordId {
    final $_column = $_itemColumn<String>('word_id')!;

    final manager = $$WordsTableTableManager(
      $_db,
      $_db.words,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExamplesTableFilterComposer
    extends Composer<_$AppDatabase, $ExamplesTable> {
  $$ExamplesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sentence => $composableBuilder(
    column: $table.sentence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRefs => $composableBuilder(
    column: $table.sourceRefs,
    builder: (column) => ColumnFilters(column),
  );

  $$WordsTableFilterComposer get wordId {
    final $$WordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableFilterComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExamplesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExamplesTable> {
  $$ExamplesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sentence => $composableBuilder(
    column: $table.sentence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRefs => $composableBuilder(
    column: $table.sourceRefs,
    builder: (column) => ColumnOrderings(column),
  );

  $$WordsTableOrderingComposer get wordId {
    final $$WordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableOrderingComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExamplesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExamplesTable> {
  $$ExamplesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sentence =>
      $composableBuilder(column: $table.sentence, builder: (column) => column);

  GeneratedColumn<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceRefs => $composableBuilder(
    column: $table.sourceRefs,
    builder: (column) => column,
  );

  $$WordsTableAnnotationComposer get wordId {
    final $$WordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableAnnotationComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExamplesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExamplesTable,
          ExampleRow,
          $$ExamplesTableFilterComposer,
          $$ExamplesTableOrderingComposer,
          $$ExamplesTableAnnotationComposer,
          $$ExamplesTableCreateCompanionBuilder,
          $$ExamplesTableUpdateCompanionBuilder,
          (ExampleRow, $$ExamplesTableReferences),
          ExampleRow,
          PrefetchHooks Function({bool wordId})
        > {
  $$ExamplesTableTableManager(_$AppDatabase db, $ExamplesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamplesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamplesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamplesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> wordId = const Value.absent(),
                Value<String> sentence = const Value.absent(),
                Value<String?> translation = const Value.absent(),
                Value<String> sourceRefs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExamplesCompanion(
                id: id,
                wordId: wordId,
                sentence: sentence,
                translation: translation,
                sourceRefs: sourceRefs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String wordId,
                required String sentence,
                Value<String?> translation = const Value.absent(),
                required String sourceRefs,
                Value<int> rowid = const Value.absent(),
              }) => ExamplesCompanion.insert(
                id: id,
                wordId: wordId,
                sentence: sentence,
                translation: translation,
                sourceRefs: sourceRefs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExamplesTable, ExampleRow>(table),
                  $$ExamplesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (wordId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.wordId,
                        referencedTable: $$ExamplesTableReferences._wordIdTable(
                          db,
                        ),
                        referencedColumn: $$ExamplesTableReferences
                            ._wordIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExamplesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExamplesTable,
      ExampleRow,
      $$ExamplesTableFilterComposer,
      $$ExamplesTableOrderingComposer,
      $$ExamplesTableAnnotationComposer,
      $$ExamplesTableCreateCompanionBuilder,
      $$ExamplesTableUpdateCompanionBuilder,
      (ExampleRow, $$ExamplesTableReferences),
      ExampleRow,
      PrefetchHooks Function({bool wordId})
    >;
typedef $$SeedImportsTableCreateCompanionBuilder =
    SeedImportsCompanion Function({
      required String packageId,
      required int version,
      required String payloadJson,
      required String reviewedBy,
      required String reviewReference,
      required int reviewedAt,
      required int importedAt,
      required int itemCount,
      Value<int> rowid,
    });
typedef $$SeedImportsTableUpdateCompanionBuilder =
    SeedImportsCompanion Function({
      Value<String> packageId,
      Value<int> version,
      Value<String> payloadJson,
      Value<String> reviewedBy,
      Value<String> reviewReference,
      Value<int> reviewedAt,
      Value<int> importedAt,
      Value<int> itemCount,
      Value<int> rowid,
    });

class $$SeedImportsTableFilterComposer
    extends Composer<_$AppDatabase, $SeedImportsTable> {
  $$SeedImportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get packageId => $composableBuilder(
    column: $table.packageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reviewedBy => $composableBuilder(
    column: $table.reviewedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reviewReference => $composableBuilder(
    column: $table.reviewReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get itemCount => $composableBuilder(
    column: $table.itemCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SeedImportsTableOrderingComposer
    extends Composer<_$AppDatabase, $SeedImportsTable> {
  $$SeedImportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get packageId => $composableBuilder(
    column: $table.packageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reviewedBy => $composableBuilder(
    column: $table.reviewedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reviewReference => $composableBuilder(
    column: $table.reviewReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get itemCount => $composableBuilder(
    column: $table.itemCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SeedImportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SeedImportsTable> {
  $$SeedImportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get packageId =>
      $composableBuilder(column: $table.packageId, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reviewedBy => $composableBuilder(
    column: $table.reviewedBy,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reviewReference => $composableBuilder(
    column: $table.reviewReference,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get itemCount =>
      $composableBuilder(column: $table.itemCount, builder: (column) => column);
}

class $$SeedImportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SeedImportsTable,
          SeedImportRow,
          $$SeedImportsTableFilterComposer,
          $$SeedImportsTableOrderingComposer,
          $$SeedImportsTableAnnotationComposer,
          $$SeedImportsTableCreateCompanionBuilder,
          $$SeedImportsTableUpdateCompanionBuilder,
          (
            SeedImportRow,
            BaseReferences<_$AppDatabase, $SeedImportsTable, SeedImportRow>,
          ),
          SeedImportRow,
          PrefetchHooks Function()
        > {
  $$SeedImportsTableTableManager(_$AppDatabase db, $SeedImportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SeedImportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SeedImportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SeedImportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> packageId = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<String> reviewedBy = const Value.absent(),
                Value<String> reviewReference = const Value.absent(),
                Value<int> reviewedAt = const Value.absent(),
                Value<int> importedAt = const Value.absent(),
                Value<int> itemCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SeedImportsCompanion(
                packageId: packageId,
                version: version,
                payloadJson: payloadJson,
                reviewedBy: reviewedBy,
                reviewReference: reviewReference,
                reviewedAt: reviewedAt,
                importedAt: importedAt,
                itemCount: itemCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String packageId,
                required int version,
                required String payloadJson,
                required String reviewedBy,
                required String reviewReference,
                required int reviewedAt,
                required int importedAt,
                required int itemCount,
                Value<int> rowid = const Value.absent(),
              }) => SeedImportsCompanion.insert(
                packageId: packageId,
                version: version,
                payloadJson: payloadJson,
                reviewedBy: reviewedBy,
                reviewReference: reviewReference,
                reviewedAt: reviewedAt,
                importedAt: importedAt,
                itemCount: itemCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SeedImportsTable, SeedImportRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SeedImportsTable,
                    SeedImportRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SeedImportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SeedImportsTable,
      SeedImportRow,
      $$SeedImportsTableFilterComposer,
      $$SeedImportsTableOrderingComposer,
      $$SeedImportsTableAnnotationComposer,
      $$SeedImportsTableCreateCompanionBuilder,
      $$SeedImportsTableUpdateCompanionBuilder,
      (
        SeedImportRow,
        BaseReferences<_$AppDatabase, $SeedImportsTable, SeedImportRow>,
      ),
      SeedImportRow,
      PrefetchHooks Function()
    >;
typedef $$LearningStatesTableCreateCompanionBuilder =
    LearningStatesCompanion Function({
      required String contentType,
      required String contentId,
      required String stage,
      Value<int?> lastStudiedAt,
      Value<int> studyCount,
      Value<int?> dueAt,
      Value<String?> fsrsStateJson,
      Value<int?> fsrsDueAt,
      Value<String?> fsrsVersion,
      Value<int> rowid,
    });
typedef $$LearningStatesTableUpdateCompanionBuilder =
    LearningStatesCompanion Function({
      Value<String> contentType,
      Value<String> contentId,
      Value<String> stage,
      Value<int?> lastStudiedAt,
      Value<int> studyCount,
      Value<int?> dueAt,
      Value<String?> fsrsStateJson,
      Value<int?> fsrsDueAt,
      Value<String?> fsrsVersion,
      Value<int> rowid,
    });

class $$LearningStatesTableFilterComposer
    extends Composer<_$AppDatabase, $LearningStatesTable> {
  $$LearningStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastStudiedAt => $composableBuilder(
    column: $table.lastStudiedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studyCount => $composableBuilder(
    column: $table.studyCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fsrsStateJson => $composableBuilder(
    column: $table.fsrsStateJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fsrsDueAt => $composableBuilder(
    column: $table.fsrsDueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fsrsVersion => $composableBuilder(
    column: $table.fsrsVersion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LearningStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $LearningStatesTable> {
  $$LearningStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastStudiedAt => $composableBuilder(
    column: $table.lastStudiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studyCount => $composableBuilder(
    column: $table.studyCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fsrsStateJson => $composableBuilder(
    column: $table.fsrsStateJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fsrsDueAt => $composableBuilder(
    column: $table.fsrsDueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fsrsVersion => $composableBuilder(
    column: $table.fsrsVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LearningStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearningStatesTable> {
  $$LearningStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contentId =>
      $composableBuilder(column: $table.contentId, builder: (column) => column);

  GeneratedColumn<String> get stage =>
      $composableBuilder(column: $table.stage, builder: (column) => column);

  GeneratedColumn<int> get lastStudiedAt => $composableBuilder(
    column: $table.lastStudiedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get studyCount => $composableBuilder(
    column: $table.studyCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<String> get fsrsStateJson => $composableBuilder(
    column: $table.fsrsStateJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fsrsDueAt =>
      $composableBuilder(column: $table.fsrsDueAt, builder: (column) => column);

  GeneratedColumn<String> get fsrsVersion => $composableBuilder(
    column: $table.fsrsVersion,
    builder: (column) => column,
  );
}

class $$LearningStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearningStatesTable,
          LearningStateRow,
          $$LearningStatesTableFilterComposer,
          $$LearningStatesTableOrderingComposer,
          $$LearningStatesTableAnnotationComposer,
          $$LearningStatesTableCreateCompanionBuilder,
          $$LearningStatesTableUpdateCompanionBuilder,
          (
            LearningStateRow,
            BaseReferences<
              _$AppDatabase,
              $LearningStatesTable,
              LearningStateRow
            >,
          ),
          LearningStateRow,
          PrefetchHooks Function()
        > {
  $$LearningStatesTableTableManager(
    _$AppDatabase db,
    $LearningStatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LearningStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LearningStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LearningStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> contentType = const Value.absent(),
                Value<String> contentId = const Value.absent(),
                Value<String> stage = const Value.absent(),
                Value<int?> lastStudiedAt = const Value.absent(),
                Value<int> studyCount = const Value.absent(),
                Value<int?> dueAt = const Value.absent(),
                Value<String?> fsrsStateJson = const Value.absent(),
                Value<int?> fsrsDueAt = const Value.absent(),
                Value<String?> fsrsVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearningStatesCompanion(
                contentType: contentType,
                contentId: contentId,
                stage: stage,
                lastStudiedAt: lastStudiedAt,
                studyCount: studyCount,
                dueAt: dueAt,
                fsrsStateJson: fsrsStateJson,
                fsrsDueAt: fsrsDueAt,
                fsrsVersion: fsrsVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String contentType,
                required String contentId,
                required String stage,
                Value<int?> lastStudiedAt = const Value.absent(),
                Value<int> studyCount = const Value.absent(),
                Value<int?> dueAt = const Value.absent(),
                Value<String?> fsrsStateJson = const Value.absent(),
                Value<int?> fsrsDueAt = const Value.absent(),
                Value<String?> fsrsVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearningStatesCompanion.insert(
                contentType: contentType,
                contentId: contentId,
                stage: stage,
                lastStudiedAt: lastStudiedAt,
                studyCount: studyCount,
                dueAt: dueAt,
                fsrsStateJson: fsrsStateJson,
                fsrsDueAt: fsrsDueAt,
                fsrsVersion: fsrsVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LearningStatesTable, LearningStateRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $LearningStatesTable,
                    LearningStateRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LearningStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearningStatesTable,
      LearningStateRow,
      $$LearningStatesTableFilterComposer,
      $$LearningStatesTableOrderingComposer,
      $$LearningStatesTableAnnotationComposer,
      $$LearningStatesTableCreateCompanionBuilder,
      $$LearningStatesTableUpdateCompanionBuilder,
      (
        LearningStateRow,
        BaseReferences<_$AppDatabase, $LearningStatesTable, LearningStateRow>,
      ),
      LearningStateRow,
      PrefetchHooks Function()
    >;
typedef $$StudySessionsTableCreateCompanionBuilder =
    StudySessionsCompanion Function({
      required String id,
      required String mode,
      required String status,
      required int startedAt,
      Value<int?> finishedAt,
      required int itemCount,
      Value<int> completedCount,
      Value<int> skippedCount,
      Value<int> rowid,
    });
typedef $$StudySessionsTableUpdateCompanionBuilder =
    StudySessionsCompanion Function({
      Value<String> id,
      Value<String> mode,
      Value<String> status,
      Value<int> startedAt,
      Value<int?> finishedAt,
      Value<int> itemCount,
      Value<int> completedCount,
      Value<int> skippedCount,
      Value<int> rowid,
    });

final class $$StudySessionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $StudySessionsTable, StudySessionRow> {
  $$StudySessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$StudySessionItemsTable, List<StudySessionItemRow>>
  _studySessionItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.studySessionItems,
        aliasName: 'study_sessions__id__study_session_items__session_id',
      );

  $$StudySessionItemsTableProcessedTableManager get studySessionItemsRefs {
    final manager = $$StudySessionItemsTableTableManager(
      $_db,
      $_db.studySessionItems,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _studySessionItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudyLogsTable, List<StudyLogRow>>
  _studyLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studyLogs,
    aliasName: 'study_sessions__id__study_logs__session_id',
  );

  $$StudyLogsTableProcessedTableManager get studyLogsRefs {
    final manager = $$StudyLogsTableTableManager(
      $_db,
      $_db.studyLogs,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_studyLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StudySessionsTableFilterComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get itemCount => $composableBuilder(
    column: $table.itemCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedCount => $composableBuilder(
    column: $table.completedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get skippedCount => $composableBuilder(
    column: $table.skippedCount,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> studySessionItemsRefs(
    Expression<bool> Function($$StudySessionItemsTableFilterComposer f) f,
  ) {
    final $$StudySessionItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessionItems,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionItemsTableFilterComposer(
            $db: $db,
            $table: $db.studySessionItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studyLogsRefs(
    Expression<bool> Function($$StudyLogsTableFilterComposer f) f,
  ) {
    final $$StudyLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyLogs,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyLogsTableFilterComposer(
            $db: $db,
            $table: $db.studyLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudySessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get itemCount => $composableBuilder(
    column: $table.itemCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedCount => $composableBuilder(
    column: $table.completedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get skippedCount => $composableBuilder(
    column: $table.skippedCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudySessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<int> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get itemCount =>
      $composableBuilder(column: $table.itemCount, builder: (column) => column);

  GeneratedColumn<int> get completedCount => $composableBuilder(
    column: $table.completedCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get skippedCount => $composableBuilder(
    column: $table.skippedCount,
    builder: (column) => column,
  );

  Expression<T> studySessionItemsRefs<T extends Object>(
    Expression<T> Function($$StudySessionItemsTableAnnotationComposer a) f,
  ) {
    final $$StudySessionItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.studySessionItems,
          getReferencedColumn: (t) => t.sessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StudySessionItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.studySessionItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> studyLogsRefs<T extends Object>(
    Expression<T> Function($$StudyLogsTableAnnotationComposer a) f,
  ) {
    final $$StudyLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyLogs,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.studyLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudySessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudySessionsTable,
          StudySessionRow,
          $$StudySessionsTableFilterComposer,
          $$StudySessionsTableOrderingComposer,
          $$StudySessionsTableAnnotationComposer,
          $$StudySessionsTableCreateCompanionBuilder,
          $$StudySessionsTableUpdateCompanionBuilder,
          (StudySessionRow, $$StudySessionsTableReferences),
          StudySessionRow,
          PrefetchHooks Function({
            bool studySessionItemsRefs,
            bool studyLogsRefs,
          })
        > {
  $$StudySessionsTableTableManager(_$AppDatabase db, $StudySessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudySessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudySessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudySessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> startedAt = const Value.absent(),
                Value<int?> finishedAt = const Value.absent(),
                Value<int> itemCount = const Value.absent(),
                Value<int> completedCount = const Value.absent(),
                Value<int> skippedCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudySessionsCompanion(
                id: id,
                mode: mode,
                status: status,
                startedAt: startedAt,
                finishedAt: finishedAt,
                itemCount: itemCount,
                completedCount: completedCount,
                skippedCount: skippedCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String mode,
                required String status,
                required int startedAt,
                Value<int?> finishedAt = const Value.absent(),
                required int itemCount,
                Value<int> completedCount = const Value.absent(),
                Value<int> skippedCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudySessionsCompanion.insert(
                id: id,
                mode: mode,
                status: status,
                startedAt: startedAt,
                finishedAt: finishedAt,
                itemCount: itemCount,
                completedCount: completedCount,
                skippedCount: skippedCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StudySessionsTable, StudySessionRow>(table),
                  $$StudySessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({studySessionItemsRefs = false, studyLogsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (studySessionItemsRefs) db.studySessionItems,
                    if (studyLogsRefs) db.studyLogs,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (studySessionItemsRefs)
                        await $_getPrefetchedDataByColumns<
                          StudySessionRow,
                          $StudySessionsTable,
                          StudySessionItemRow,
                          $StudySessionItemsTable
                        >(
                          currentTable: table,
                          referencedTable: $$StudySessionsTableReferences
                              ._studySessionItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudySessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).studySessionItemsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'session_id',
                          typedResults: items,
                        ),
                      if (studyLogsRefs)
                        await $_getPrefetchedDataByColumns<
                          StudySessionRow,
                          $StudySessionsTable,
                          StudyLogRow,
                          $StudyLogsTable
                        >(
                          currentTable: table,
                          referencedTable: $$StudySessionsTableReferences
                              ._studyLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudySessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).studyLogsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'session_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$StudySessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudySessionsTable,
      StudySessionRow,
      $$StudySessionsTableFilterComposer,
      $$StudySessionsTableOrderingComposer,
      $$StudySessionsTableAnnotationComposer,
      $$StudySessionsTableCreateCompanionBuilder,
      $$StudySessionsTableUpdateCompanionBuilder,
      (StudySessionRow, $$StudySessionsTableReferences),
      StudySessionRow,
      PrefetchHooks Function({bool studySessionItemsRefs, bool studyLogsRefs})
    >;
typedef $$StudySessionItemsTableCreateCompanionBuilder =
    StudySessionItemsCompanion Function({
      required String sessionId,
      required String itemId,
      required String contentType,
      required String prompt,
      required String answer,
      required String hintsJson,
      required int position,
      Value<int> rowid,
    });
typedef $$StudySessionItemsTableUpdateCompanionBuilder =
    StudySessionItemsCompanion Function({
      Value<String> sessionId,
      Value<String> itemId,
      Value<String> contentType,
      Value<String> prompt,
      Value<String> answer,
      Value<String> hintsJson,
      Value<int> position,
      Value<int> rowid,
    });

final class $$StudySessionItemsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $StudySessionItemsTable,
          StudySessionItemRow
        > {
  $$StudySessionItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StudySessionsTable _sessionIdTable(_$AppDatabase db) => db
      .studySessions
      .createAlias('study_session_items__session_id__study_sessions__id');

  $$StudySessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$StudySessionsTableTableManager(
      $_db,
      $_db.studySessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StudySessionItemsTableFilterComposer
    extends Composer<_$AppDatabase, $StudySessionItemsTable> {
  $$StudySessionItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prompt => $composableBuilder(
    column: $table.prompt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answer => $composableBuilder(
    column: $table.answer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hintsJson => $composableBuilder(
    column: $table.hintsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  $$StudySessionsTableFilterComposer get sessionId {
    final $$StudySessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableFilterComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudySessionItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudySessionItemsTable> {
  $$StudySessionItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prompt => $composableBuilder(
    column: $table.prompt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answer => $composableBuilder(
    column: $table.answer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hintsJson => $composableBuilder(
    column: $table.hintsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudySessionsTableOrderingComposer get sessionId {
    final $$StudySessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableOrderingComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudySessionItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudySessionItemsTable> {
  $$StudySessionItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get prompt =>
      $composableBuilder(column: $table.prompt, builder: (column) => column);

  GeneratedColumn<String> get answer =>
      $composableBuilder(column: $table.answer, builder: (column) => column);

  GeneratedColumn<String> get hintsJson =>
      $composableBuilder(column: $table.hintsJson, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $$StudySessionsTableAnnotationComposer get sessionId {
    final $$StudySessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudySessionItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudySessionItemsTable,
          StudySessionItemRow,
          $$StudySessionItemsTableFilterComposer,
          $$StudySessionItemsTableOrderingComposer,
          $$StudySessionItemsTableAnnotationComposer,
          $$StudySessionItemsTableCreateCompanionBuilder,
          $$StudySessionItemsTableUpdateCompanionBuilder,
          (StudySessionItemRow, $$StudySessionItemsTableReferences),
          StudySessionItemRow,
          PrefetchHooks Function({bool sessionId})
        > {
  $$StudySessionItemsTableTableManager(
    _$AppDatabase db,
    $StudySessionItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudySessionItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudySessionItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudySessionItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> sessionId = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<String> contentType = const Value.absent(),
                Value<String> prompt = const Value.absent(),
                Value<String> answer = const Value.absent(),
                Value<String> hintsJson = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudySessionItemsCompanion(
                sessionId: sessionId,
                itemId: itemId,
                contentType: contentType,
                prompt: prompt,
                answer: answer,
                hintsJson: hintsJson,
                position: position,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sessionId,
                required String itemId,
                required String contentType,
                required String prompt,
                required String answer,
                required String hintsJson,
                required int position,
                Value<int> rowid = const Value.absent(),
              }) => StudySessionItemsCompanion.insert(
                sessionId: sessionId,
                itemId: itemId,
                contentType: contentType,
                prompt: prompt,
                answer: answer,
                hintsJson: hintsJson,
                position: position,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StudySessionItemsTable, StudySessionItemRow>(
                    table,
                  ),
                  $$StudySessionItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sessionId,
                        referencedTable: $$StudySessionItemsTableReferences
                            ._sessionIdTable(db),
                        referencedColumn: $$StudySessionItemsTableReferences
                            ._sessionIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StudySessionItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudySessionItemsTable,
      StudySessionItemRow,
      $$StudySessionItemsTableFilterComposer,
      $$StudySessionItemsTableOrderingComposer,
      $$StudySessionItemsTableAnnotationComposer,
      $$StudySessionItemsTableCreateCompanionBuilder,
      $$StudySessionItemsTableUpdateCompanionBuilder,
      (StudySessionItemRow, $$StudySessionItemsTableReferences),
      StudySessionItemRow,
      PrefetchHooks Function({bool sessionId})
    >;
typedef $$StudyLogsTableCreateCompanionBuilder = StudyLogsCompanion Function({
  required String id,
  required String sessionId,
  required String contentType,
  required String contentId,
  required String outcome,
  required int answeredAt,
  Value<int?> responseMs,
  Value<int> rowid,
});
typedef $$StudyLogsTableUpdateCompanionBuilder = StudyLogsCompanion Function({
  Value<String> id,
  Value<String> sessionId,
  Value<String> contentType,
  Value<String> contentId,
  Value<String> outcome,
  Value<int> answeredAt,
  Value<int?> responseMs,
  Value<int> rowid,
});

final class $$StudyLogsTableReferences
    extends BaseReferences<_$AppDatabase, $StudyLogsTable, StudyLogRow> {
  $$StudyLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudySessionsTable _sessionIdTable(_$AppDatabase db) => db
      .studySessions
      .createAlias('study_logs__session_id__study_sessions__id');

  $$StudySessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$StudySessionsTableTableManager(
      $_db,
      $_db.studySessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StudyLogsTableFilterComposer
    extends Composer<_$AppDatabase, $StudyLogsTable> {
  $$StudyLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get responseMs => $composableBuilder(
    column: $table.responseMs,
    builder: (column) => ColumnFilters(column),
  );

  $$StudySessionsTableFilterComposer get sessionId {
    final $$StudySessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableFilterComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudyLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudyLogsTable> {
  $$StudyLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get responseMs => $composableBuilder(
    column: $table.responseMs,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudySessionsTableOrderingComposer get sessionId {
    final $$StudySessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableOrderingComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudyLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudyLogsTable> {
  $$StudyLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contentId =>
      $composableBuilder(column: $table.contentId, builder: (column) => column);

  GeneratedColumn<String> get outcome =>
      $composableBuilder(column: $table.outcome, builder: (column) => column);

  GeneratedColumn<int> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get responseMs => $composableBuilder(
    column: $table.responseMs,
    builder: (column) => column,
  );

  $$StudySessionsTableAnnotationComposer get sessionId {
    final $$StudySessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudyLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudyLogsTable,
          StudyLogRow,
          $$StudyLogsTableFilterComposer,
          $$StudyLogsTableOrderingComposer,
          $$StudyLogsTableAnnotationComposer,
          $$StudyLogsTableCreateCompanionBuilder,
          $$StudyLogsTableUpdateCompanionBuilder,
          (StudyLogRow, $$StudyLogsTableReferences),
          StudyLogRow,
          PrefetchHooks Function({bool sessionId})
        > {
  $$StudyLogsTableTableManager(_$AppDatabase db, $StudyLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudyLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudyLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> contentType = const Value.absent(),
                Value<String> contentId = const Value.absent(),
                Value<String> outcome = const Value.absent(),
                Value<int> answeredAt = const Value.absent(),
                Value<int?> responseMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyLogsCompanion(
                id: id,
                sessionId: sessionId,
                contentType: contentType,
                contentId: contentId,
                outcome: outcome,
                answeredAt: answeredAt,
                responseMs: responseMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required String contentType,
                required String contentId,
                required String outcome,
                required int answeredAt,
                Value<int?> responseMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyLogsCompanion.insert(
                id: id,
                sessionId: sessionId,
                contentType: contentType,
                contentId: contentId,
                outcome: outcome,
                answeredAt: answeredAt,
                responseMs: responseMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StudyLogsTable, StudyLogRow>(table),
                  $$StudyLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sessionId,
                        referencedTable: $$StudyLogsTableReferences
                            ._sessionIdTable(db),
                        referencedColumn: $$StudyLogsTableReferences
                            ._sessionIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StudyLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudyLogsTable,
      StudyLogRow,
      $$StudyLogsTableFilterComposer,
      $$StudyLogsTableOrderingComposer,
      $$StudyLogsTableAnnotationComposer,
      $$StudyLogsTableCreateCompanionBuilder,
      $$StudyLogsTableUpdateCompanionBuilder,
      (StudyLogRow, $$StudyLogsTableReferences),
      StudyLogRow,
      PrefetchHooks Function({bool sessionId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RootsTableTableManager get roots =>
      $$RootsTableTableManager(_db, _db.roots);
  $$AffixesTableTableManager get affixes =>
      $$AffixesTableTableManager(_db, _db.affixes);
  $$WordsTableTableManager get words =>
      $$WordsTableTableManager(_db, _db.words);
  $$WordComponentsTableTableManager get wordComponents =>
      $$WordComponentsTableTableManager(_db, _db.wordComponents);
  $$ExamplesTableTableManager get examples =>
      $$ExamplesTableTableManager(_db, _db.examples);
  $$SeedImportsTableTableManager get seedImports =>
      $$SeedImportsTableTableManager(_db, _db.seedImports);
  $$LearningStatesTableTableManager get learningStates =>
      $$LearningStatesTableTableManager(_db, _db.learningStates);
  $$StudySessionsTableTableManager get studySessions =>
      $$StudySessionsTableTableManager(_db, _db.studySessions);
  $$StudySessionItemsTableTableManager get studySessionItems =>
      $$StudySessionItemsTableTableManager(_db, _db.studySessionItems);
  $$StudyLogsTableTableManager get studyLogs =>
      $$StudyLogsTableTableManager(_db, _db.studyLogs);
}
