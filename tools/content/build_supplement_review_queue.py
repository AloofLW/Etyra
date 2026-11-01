#!/usr/bin/env python3
"""Consolidate supplemental vocabulary review signals without approving entries."""
import argparse
import csv
from pathlib import Path

from build_vocabulary_review_queue import count, read


GROUPS = (
    ("CURRICULUM_GAP_CANDIDATES.csv", "normalized_key", "curriculum_gap"),
    ("WIKTIONARY_GAP_CANDIDATES.csv", "headword", "wiktionary_gap"),
    ("COMPLEX_FORM_CANDIDATES.csv", "normalized_key", "complex_oewn"),
    ("COMPLEX_WIKTIONARY_CANDIDATES.csv", "normalized_key", "complex_wiktionary"),
    ("RELATION_WORD_CANDIDATES.csv", "normalized_key", "root_relation"),
)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    main_ids = {row["candidate_id"] for row in read("VOCABULARY_CANDIDATES.csv")}
    sources = {
        "oewn_senses": count("OEWN_SUPPLEMENT_SENSE_CANDIDATES.csv") + count("OEWN_RELATION_SENSE_CANDIDATES.csv"),
        "cow_sense_links": count("COW_SUPPLEMENT_SENSE_CANDIDATES.csv") + count("COW_RELATION_SENSE_CANDIDATES.csv"),
        "word_drafts": count("CURATED_WORD_PILOT.csv", "vocabulary_candidate_id"),
    }
    candidates = []
    ids = set()
    for filename, word_key, group in GROUPS:
        for row in read(filename):
            candidate_id = row["candidate_id"]
            if candidate_id in main_ids or candidate_id in ids:
                raise ValueError(f"Candidate overlaps another inventory: {candidate_id}")
            ids.add(candidate_id)
            candidates.append((candidate_id, row[word_key], group, row))
    for name in ("oewn_senses", "cow_sense_links"):
        if set(sources[name]) - ids:
            raise ValueError(f"Unknown supplemental ID in {name}")
    with args.output.open("x", encoding="utf-8", newline="") as output:
        writer = csv.writer(output, lineterminator="\n")
        writer.writerow(("candidate_id", "headword_key", "source_group", "mirror_pdf_pages", "oewn_senses",
                         "cow_sense_links", "word_drafts", "wiktionary_revision", "review_flags", "status"))
        for candidate_id, word, group, row in sorted(candidates):
            english = sources["oewn_senses"][candidate_id]
            chinese = sources["cow_sense_links"][candidate_id]
            drafts = sources["word_drafts"][candidate_id]
            flags = ["curriculum_review_needed", "license_review_needed"]
            if not english:
                flags.append("english_sense_clue_needed")
            if not (chinese or drafts):
                flags.append("chinese_sense_clue_needed")
            if english > 1:
                flags.append("sense_selection_needed")
            if group.startswith("complex_"):
                flags.append("complex_form_review_needed")
            if group == "root_relation":
                flags.append("root_relation_review_needed")
            writer.writerow((candidate_id, word, group, row.get("mirror_pdf_pages", ""), english, chinese,
                             drafts, row.get("source_revision", ""), "|".join(flags), "candidate_only"))
    print(f"Built a review queue for {len(candidates)} supplementary candidate IDs; none approved.")


if __name__ == "__main__":
    main()
