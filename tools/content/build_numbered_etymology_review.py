#!/usr/bin/env python3
"""Index later numbered etymology sections for sense-specific manual review.

The section number is only a prioritization clue: it does not imply that an
etymology is rare, unrelated, wrong, or safe for a particular sense.
"""
import argparse
import csv
import json
import re
from pathlib import Path

DOCS = Path(__file__).resolve().parents[2] / 'docs'


def read(name):
    with (DOCS / name).open(encoding='utf-8', newline='') as stream:
        return list(csv.DictReader(stream))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('output', type=Path)
    args = parser.parse_args()
    if args.output.exists():
        raise SystemExit('Refusing to overwrite an existing output')
    clues = read('WIKTIONARY_MORPHOLOGY_CLUES.csv')
    reviewed = {(r['candidate_id'], r['etymology_heading'])
                for r in read('MORPHOLOGY_CONTEXT_REVIEW_PILOT.csv')}
    warnings = {(r['candidate_id'], r['clue_heading'])
                for r in read('MORPHOLOGY_CROSS_SENSE_WARNINGS.csv')}
    fields = ['source_row', 'candidate_id', 'headword', 'etymology_heading',
              'revision_id', 'revision_url', 'components_json',
              'existing_context_review', 'existing_cross_sense_warning', 'status']
    result = []
    for number, clue in enumerate(clues, 1):
        match = re.fullmatch(r'Etymology (\d+)', clue['etymology_heading'])
        if not match or int(match.group(1)) <= 1:
            continue
        json.loads(clue['components_json'])
        key = (clue['candidate_id'], clue['etymology_heading'])
        result.append(dict(source_row=number, candidate_id=clue['candidate_id'],
                           headword=clue['headword'],
                           etymology_heading=clue['etymology_heading'],
                           revision_id=clue['revision_id'], revision_url=clue['revision_url'],
                           components_json=clue['components_json'],
                           existing_context_review=str(key in reviewed).lower(),
                           existing_cross_sense_warning=str(key in warnings).lower(),
                           status='sense_and_revision_review_needed'))
    with args.output.open('x', encoding='utf-8', newline='') as stream:
        writer = csv.DictWriter(stream, fieldnames=fields, lineterminator='\n')
        writer.writeheader()
        writer.writerows(result)
    print(f'Indexed {len(result)} later numbered sections; none approved.')


if __name__ == '__main__':
    main()
