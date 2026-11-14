#!/usr/bin/env python3
"""Structural checks for Muse handoff CSVs; no semantic or license approval.

Usage: python3 tools/content/check_muse_delivery.py DIRECTORY
Reads seven UTF-8 CSVs and writes a JSON report to stdout. It never changes input.
Exit 0: no structural errors; 1: structural errors; 2: bad invocation.
Empty files and unresolved review statuses are warnings, not completion.
"""
import csv
import json
import sys
import unicodedata
from collections import defaultdict
from pathlib import Path

HEADERS = {
    'words': 'candidate_id,headword,display_form,part_of_speech,scope,review_status,reviewer,reviewed_at,notes',
    'senses': 'sense_id,candidate_id,part_of_speech,meaning_zh,usage_note,source_id,source_locator,review_status,reviewer,reviewed_at',
    'components': 'component_id,form,component_type,meaning_zh,source_id,source_locator,verification_status,reviewer,reviewed_at,notes',
    'word_components': 'candidate_id,component_id,component_role,position,relation_type,evidence,source_id,source_locator,verification_status,reviewer,reviewed_at',
    'sources': 'source_id,title,publisher,version,url,locator,license_name,license_url,attribution,modification_notice,accessed_at,redistribution_decision,decision_basis',
    'coverage': 'curriculum_version,source_locator,original_entry_or_permitted_reference,scope,candidate_id,match_type,decision,review_status,notes',
    'issues': 'issue_id,category,affected_ids,description,severity,next_action,status',
}
IDS = {'words': 'candidate_id', 'senses': 'sense_id', 'components': 'component_id', 'sources': 'source_id', 'issues': 'issue_id'}


def audit(directory):
    errors, warnings, data = [], [], {}
    for name, header in HEADERS.items():
        path = directory / (name + '.csv')
        try:
            with path.open(encoding='utf-8-sig', newline='') as f:
                reader = csv.DictReader(f)
                columns = reader.fieldnames or []
                required = header.split(',')
                missing = sorted(set(required) - set(columns))
                if missing or len(columns) != len(set(columns)):
                    errors.append(f'{name}: missing columns {missing} or duplicate header')
                    continue
                rows = list(reader)
        except (OSError, UnicodeError, csv.Error) as exc:
            errors.append(f'{name}: cannot read CSV: {exc}')
            continue
        data[name] = rows
        if not rows:
            warnings.append(f'{name}: no rows; completeness unverified')
        for index, row in enumerate(rows, 2):
            if None in row or any(value is None for value in row.values()):
                errors.append(f'{name}:{index}: malformed CSV row')
    if len(data) != len(HEADERS):
        return {'errors': errors, 'warnings': warnings, 'counts': {k: len(v) for k, v in data.items()}}

    indices = {}
    for name, field in IDS.items():
        ids = set()
        for index, row in enumerate(data[name], 2):
            value = (row.get(field) or '').strip()
            if not value:
                errors.append(f'{name}:{index}: missing {field}')
            elif value in ids:
                errors.append(f'{name}:{index}: duplicate {field}: {value}')
            ids.add(value)
        indices[name] = ids

    for name in ('senses', 'word_components', 'coverage'):
        for index, row in enumerate(data[name], 2):
            candidate = (row.get('candidate_id') or '').strip()
            if not candidate and name != 'coverage':
                errors.append(f'{name}:{index}: missing candidate_id')
            elif candidate and candidate not in indices['words']:
                errors.append(f'{name}:{index}: unknown candidate_id: {candidate}')
    for index, row in enumerate(data['word_components'], 2):
        component = (row.get('component_id') or '').strip()
        if not component or component not in indices['components']:
            errors.append(f'word_components:{index}: missing or unknown component_id: {component}')
    for name in ('senses', 'components', 'word_components'):
        for index, row in enumerate(data[name], 2):
            source = (row.get('source_id') or '').strip()
            if source and source not in indices['sources']:
                errors.append(f'{name}:{index}: unknown source_id: {source}')

    for name, state_field in (('words', 'review_status'), ('senses', 'review_status'), ('components', 'verification_status'), ('word_components', 'verification_status')):
        pending = 0
        for index, row in enumerate(data[name], 2):
            state = (row.get(state_field) or '').strip()
            if not state:
                errors.append(f'{name}:{index}: missing {state_field}')
            elif state.casefold() == 'approved':
                required = ['reviewer', 'reviewed_at']
                required += {
                    'words': ['headword', 'display_form'],
                    'senses': ['part_of_speech', 'meaning_zh', 'source_id', 'source_locator'],
                    'components': ['form', 'component_type', 'meaning_zh', 'source_id', 'source_locator'],
                    'word_components': ['component_role', 'relation_type', 'evidence', 'source_id', 'source_locator'],
                }[name]
                missing = [key for key in required if not (row.get(key) or '').strip()]
                if missing:
                    errors.append(f'{name}:{index}: approved row missing {missing}')
                source_id = (row.get('source_id') or '').strip()
                if source_id:
                    source = next((item for item in data['sources'] if (item.get('source_id') or '').strip() == source_id), None)
                    if source:
                        source_fields = ['title', 'publisher', 'version', 'url', 'license_name', 'license_url', 'accessed_at', 'redistribution_decision', 'decision_basis']
                        missing_source = [key for key in source_fields if not (source.get(key) or '').strip()]
                        if missing_source:
                            errors.append(f'{name}:{index}: approved row source {source_id} missing {missing_source}')
            else:
                pending += 1
        if pending:
            warnings.append(f'{name}: {pending} rows not marked approved; still require review')
    approved_words = {(row.get('candidate_id') or '').strip() for row in data['words'] if (row.get('review_status') or '').strip().casefold() == 'approved'}
    approved_components = {(row.get('component_id') or '').strip() for row in data['components'] if (row.get('verification_status') or '').strip().casefold() == 'approved'}
    approved_sense_words = {(row.get('candidate_id') or '').strip() for row in data['senses'] if (row.get('review_status') or '').strip().casefold() == 'approved'}
    for word_id in sorted(approved_words - approved_sense_words):
        errors.append(f'words: approved candidate_id has no approved sense in this delivery: {word_id}')
    for index, row in enumerate(data['word_components'], 2):
        if (row.get('verification_status') or '').strip().casefold() == 'approved':
            candidate = (row.get('candidate_id') or '').strip()
            component = (row.get('component_id') or '').strip()
            if candidate not in approved_words:
                errors.append(f'word_components:{index}: approved relation has non-approved word: {candidate}')
            if component not in approved_components:
                errors.append(f'word_components:{index}: approved relation has non-approved component: {component}')
    # Case-folded matches are review candidates, not automatic merges: e.g. May/may.
    spelling_groups = defaultdict(list)
    for row in data['words']:
        if (row.get('review_status') or '').strip().casefold() == 'approved':
            word = unicodedata.normalize('NFKC', (row.get('headword') or '').strip()).casefold()
            if word:
                spelling_groups[word].append((row.get('candidate_id') or '').strip())
    collisions = {key: ids for key, ids in spelling_groups.items() if len(ids) > 1}
    if collisions:
        warnings.append(f'{len(collisions)} approved spelling groups have multiple IDs; review case, homographs and variants manually')
    warnings.append('Structural checks cannot verify reviewer identity, semantic correctness, source authority, license, coverage, or approval.')
    return {'errors': errors, 'warnings': warnings, 'counts': {k: len(v) for k, v in data.items()},
            'approved_spelling_candidates': {'casefold_groups': len(spelling_groups), 'duplicate_groups': collisions}}



if __name__ == '__main__':
    if len(sys.argv) != 2:
        print(__doc__, file=sys.stderr)
        sys.exit(2)
    report = audit(Path(sys.argv[1]))
    print(json.dumps(report, ensure_ascii=False, indent=2))
    sys.exit(1 if report['errors'] else 0)
