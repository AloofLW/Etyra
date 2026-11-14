#!/usr/bin/env python3
"""Summarize raw OCR positions for manual review; never treats text as verified.

Usage: python3 tools/content/summarize_ocr_review.py /tmp/ocr-directory
Inputs must be page-N.tsv files from ocr_moe_scanned_page.swift. Output is
aggregate metadata only; gaps and conflicts are inspection hints, not errors.
"""
import csv
import pathlib
import re
import sys

if len(sys.argv) != 2:
    raise SystemExit(__doc__)
root = pathlib.Path(sys.argv[1])
files = sorted(root.glob('page-*.tsv'), key=lambda p: int(p.stem.split('-')[1]))
if not files:
    raise SystemExit('No page-N.tsv files found')
print('page\tcolumn\tobservations\tposition_groups\tconflicting_groups\tlarge_gaps\tstatus')
for path in files:
    page = int(path.stem.split('-')[1])
    with path.open(encoding='utf-8', newline='') as f:
        rows = list(csv.DictReader(f, delimiter='\t'))
    if not rows or any(int(row['pdf_page']) != page for row in rows):
        raise SystemExit(f'Empty or mismatched page: {path}')
    for col in ('left', 'right'):
        selected = sorted((r for r in rows if r['column'] == col and 0.1 <= float(r['y_mid']) <= 0.9), key=lambda x: -float(x['y_mid']))
        groups = []
        for row in selected:
            y = float(row['y_mid'])
            if not groups or abs(y - groups[-1][0]) > 0.006:
                groups.append((y, [row]))
            else:
                groups[-1][1].append(row)
        normalize = lambda t: re.sub(r'\s+', '', t).casefold()
        conflicts = sum(len({normalize(row['ocr_text']) for row in group}) > 1 for _, group in groups)
        gaps = sum(a[0] - b[0] > 0.05 for a, b in zip(groups, groups[1:]))
        print(f'{page}\t{col}\t{len(selected)}\t{len(groups)}\t{conflicts}\t{gaps}\tunreviewed')
