#!/usr/bin/env python3
"""Index literal morphology components for review, without asserting relationships."""
import argparse
import csv
import json
from pathlib import Path

DOCS = Path(__file__).resolve().parents[2] / "docs"


def read(name):
    with (DOCS / name).open(encoding="utf-8", newline="") as f:
        return list(csv.DictReader(f))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    inventory = read("VOCABULARY_CANDIDATES.csv")
    supplements = read("SUPPLEMENT_REVIEW_QUEUE.csv")
    lookup = {}
    for row, key in [(r, "normalized_key") for r in inventory] + [(r, "headword_key") for r in supplements]:
        normalized = row[key].strip().casefold()
        if normalized in lookup:
            raise ValueError(f"Duplicate candidate key: {normalized}")
        lookup[normalized] = row["candidate_id"]
    clues = read("WIKTIONARY_MORPHOLOGY_CLUES.csv")
    records = []
    for source_row, clue in enumerate(clues, 1):
        components = json.loads(clue["components_json"])
        for position, component in enumerate(components, 1):
            if not isinstance(component, str) or not component.strip():
                raise ValueError(f"Invalid component at source row {source_row}")
            key = component.strip().casefold()
            candidate_id = lookup.get(key, "")
            records.append((source_row, clue["candidate_id"], clue["headword"],
                            clue["revision_id"], clue["revision_url"], clue["etymology_heading"],
                            clue["template"], position, component, candidate_id,
                            "exact_casefold_match" if candidate_id else "no_exact_match",
                            "component_role_context_sense_and_license_review_needed",
                            "candidate_only"))
    with args.output.open("x", encoding="utf-8", newline="") as f:
        writer = csv.writer(f, lineterminator="\n")
        writer.writerow(("source_row", "word_candidate_id", "headword", "revision_id", "revision_url",
                         "etymology_heading", "template", "component_position", "component_text",
                         "matched_candidate_id", "match_type", "review_flags", "status"))
        writer.writerows(records)
    print(f"Indexed {len(records)} components from {len(clues)} clues; no relationships approved.")


if __name__ == "__main__":
    main()
