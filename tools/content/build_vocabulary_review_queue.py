#!/usr/bin/env python3
"""Consolidate main candidate review signals; no signal approves a word or sense."""
import argparse
import collections
import csv
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
DOCS = ROOT / "docs"


def read(name):
    with (DOCS / name).open(encoding="utf-8", newline="") as source:
        return list(csv.DictReader(source))


def count(name, key="candidate_id"):
    return collections.Counter(row[key] for row in read(name) if row[key])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    inventory = read("VOCABULARY_CANDIDATES.csv")
    ids = {row["candidate_id"] for row in inventory}
    if len(ids) != len(inventory):
        raise ValueError("Duplicate main candidate ID")
    sources = {
        "oewn_senses": count("OEWN_SENSE_CANDIDATES.csv"),
        "cow_sense_links": count("COW_SENSE_CANDIDATES.csv"),
        "kaikki_function_senses": count("KAIKKI_FUNCTION_SENSE_CANDIDATES.csv"),
        "kaikki_gap_senses": count("KAIKKI_MAIN_GAP_SENSE_CANDIDATES.csv"),
        "oewn_form_links": count("OEWN_FORM_CANDIDATES.csv"),
        "word_drafts": count("CURATED_WORD_PILOT.csv", "vocabulary_candidate_id"),
        "function_drafts": count("CURATED_FUNCTION_WORD_PILOT.csv"),
    }
    for name, values in sources.items():
        # Word drafts can refer to the separately maintained supplementary inventory.
        if name != "word_drafts" and set(values) - ids:
            raise ValueError(f"Unknown main candidate ID in {name}")
    revisions = read("WIKTIONARY_BULK_SOURCE_INDEX.csv")
    revisions_by_id = {row["candidate_id"]: row for row in revisions}
    if len(revisions_by_id) != len(revisions) or set(revisions_by_id) - ids:
        raise ValueError("Invalid or duplicated source revision candidate ID")
    columns = list(sources)
    with args.output.open("x", encoding="utf-8", newline="") as output:
        writer = csv.writer(output, lineterminator="\n")
        writer.writerow(["candidate_id", "headword", "wordlist_sources", *columns,
                         "wiktionary_locator_status", "review_flags", "status"])
        for row in inventory:
            candidate_id = row["candidate_id"]
            counts = [sources[name][candidate_id] for name in columns]
            flags = []
            if not (sources["oewn_senses"][candidate_id] or sources["kaikki_function_senses"][candidate_id] or sources["kaikki_gap_senses"][candidate_id]):
                flags.append("english_sense_clue_needed")
            if not (sources["cow_sense_links"][candidate_id] or sources["word_drafts"][candidate_id] or sources["function_drafts"][candidate_id]):
                flags.append("chinese_sense_clue_needed")
            if (sources["oewn_senses"][candidate_id] + sources["kaikki_function_senses"][candidate_id]
                    + sources["kaikki_gap_senses"][candidate_id]) > 1:
                flags.append("sense_selection_needed")
            flags.extend(("curriculum_review_needed", "license_review_needed"))
            source_status = revisions_by_id.get(candidate_id, {}).get("status", "not_indexed")
            writer.writerow([candidate_id, row["headword"], row["source_ids"], *counts,
                             source_status, "|".join(flags), "candidate_only"])
    print(f"Built a review queue for {len(inventory)} main candidates; none approved.")


if __name__ == "__main__":
    main()
