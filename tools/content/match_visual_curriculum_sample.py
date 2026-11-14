#!/usr/bin/env python3
"""Match manually reviewed simple words to candidate lists, for internal triage.

Usage: python3 tools/content/match_visual_curriculum_sample.py REVIEW.csv OUTPUT.csv
REVIEW.csv: pdf_page,column,headword,review_status. Input must contain only
visually reviewed simple words; complex lines must be reviewed independently.
Output is unapproved evidence, never a curriculum or product vocabulary list.
"""
import csv
import pathlib
import re
import sys

if len(sys.argv) != 3:
    raise SystemExit(__doc__)
source, output = map(pathlib.Path, sys.argv[1:])
if output.exists():
    raise SystemExit('Refusing to overwrite output')
root = pathlib.Path(__file__).resolve().parents[2]
with (root / 'docs/VOCABULARY_CANDIDATES.csv').open(encoding='utf-8', newline='') as f:
    main = {r['normalized_key']: r['candidate_id'] for r in csv.DictReader(f)}
with (root / 'docs/SUPPLEMENT_REVIEW_QUEUE.csv').open(encoding='utf-8', newline='') as f:
    supp = {r['headword_key']: r['candidate_id'] for r in csv.DictReader(f)}
with source.open(encoding='utf-8', newline='') as f:
    rows = list(csv.DictReader(f))
if not rows:
    raise SystemExit('Empty review input')
results = []
for r in rows:
    key = r['headword'].strip().casefold()
    if r['review_status'] != 'visual_reviewed' or r['column'] not in ('left', 'right') or not r['pdf_page'].isdigit() or not re.fullmatch(r'[a-z]+', key):
        raise SystemExit('Only visually reviewed simple alphabetic entries allowed')
    if key in main:
        group, candidate = 'main', main[key]
    elif key in supp:
        group, candidate = 'supplement', supp[key]
    else:
        group, candidate = 'unmatched', ''
    results.append({'pdf_page': r['pdf_page'], 'column': r['column'], 'headword': r['headword'], 'match_group': group, 'candidate_id': candidate, 'status': 'candidate_only_not_approved'})
with output.open('x', encoding='utf-8', newline='') as f:
    writer = csv.DictWriter(f, fieldnames=results[0], lineterminator='\n')
    writer.writeheader()
    writer.writerows(results)
print(f'Compared {len(results)} visually reviewed simple rows; no entries approved.')
