#!/usr/bin/env python3
"""Create a traceable triage index, not a curriculum coverage or approval report."""

import argparse
import csv
import hashlib
import json
import re
from pathlib import Path

from audit_complex_exact_matches import DOCS, EXPECTED, fragments, read


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("review_csv", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    if hashlib.sha256(args.review_csv.read_bytes()).hexdigest() != EXPECTED:
        parser.error("Review CSV digest does not match the recorded mirror extraction")
    if args.output.exists():
        raise FileExistsError(args.output)

    main_rows = read(DOCS / "VOCABULARY_CANDIDATES.csv")
    supplement_rows = read(DOCS / "SUPPLEMENT_REVIEW_QUEUE.csv")
    keys = {}
    for rows, column in ((main_rows, "headword"), (supplement_rows, "headword_key")):
        for row in rows:
            key = row[column].casefold()
            if key in keys:
                raise ValueError(f"Ambiguous candidate spelling key: {key}")
            keys[key] = row["candidate_id"]

    source = [r for r in read(args.review_csv) if r["classification"] == "complex_needs_review"]
    if len(source) != 85:
        raise ValueError("Unexpected number of complex mirror rows")
    output = []
    for sequence, row in enumerate(source, 1):
        text = row["source_line"]
        exact_key = re.sub(r"\s*\*+$", "", text).strip().casefold()
        pieces = list(fragments(text))
        if not pieces:
            raise ValueError(f"No fragments in source row {sequence}")
        matches = [keys.get(piece.casefold()) for piece in pieces]
        output.append((sequence, row["pdf_page"], hashlib.sha256(text.encode("utf-8")).hexdigest(),
                       keys.get(exact_key, ""), len(pieces),
                       json.dumps(matches, separators=(",", ":")), sum(x is None for x in matches),
                       "unverified_mirror|layout_and_level_review|case_and_sense_review|license_review",
                       "candidate_only"))
    with args.output.open("x", encoding="utf-8", newline="") as f:
        writer = csv.writer(f, lineterminator="\n")
        writer.writerow(("complex_row_sequence", "mirror_pdf_page", "source_line_sha256",
                         "exact_candidate_id", "fragment_count", "fragment_candidate_ids_json",
                         "unmatched_fragments", "review_flags", "status"))
        writer.writerows(output)
    print(f"Indexed {len(output)} complex mirror rows; all require review.")


if __name__ == "__main__":
    main()
