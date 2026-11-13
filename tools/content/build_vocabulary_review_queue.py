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
    independent_drafts = (count("CURATED_PORTABLE_PILOT.csv")
                          + count("CURATED_STRUCT_OEWN_PILOT.csv")
                          + count("CURATED_ACT_OEWN_PILOT.csv")
                          + count("CURATED_SINGLE_OEWN_PILOT.csv")
                          + count("CURATED_COMMON_POLYSEMY_PILOT.csv")
                          + count("CURATED_COMMON_SENSE_GAPS_PILOT.csv")
                          + count("CURATED_SALARY_KAIKKI_PILOT.csv"))
    if set(independent_drafts) - ids:
        raise ValueError("Unknown main candidate ID in independent word drafts")
    sources = {
        "oewn_senses": count("OEWN_SENSE_CANDIDATES.csv"),
        "cow_sense_links": count("COW_SENSE_CANDIDATES.csv"),
        "kaikki_function_senses": count("KAIKKI_FUNCTION_SENSE_CANDIDATES.csv"),
        "kaikki_case_senses": count("KAIKKI_HE_SENSE_CANDIDATES.csv"),
        "kaikki_common_case_senses": count("KAIKKI_COMMON_CASE_SENSE_CANDIDATES.csv"),
        "kaikki_gap_senses": count("KAIKKI_MAIN_GAP_SENSE_CANDIDATES.csv"),
        "kaikki_translation_clues": collections.Counter(row["candidate_id"] for row in read("KAIKKI_TRANSLATION_CANDIDATES.csv") if row["inventory"] == "main"),
        "kaikki_gap_translation_clues": count("KAIKKI_CHINESE_GAP_TRANSLATIONS.csv"),
        "kaikki_common_translation_clues": count("KAIKKI_COMMON_GAP_TRANSLATIONS.csv"),
        "oewn_form_links": count("OEWN_FORM_CANDIDATES.csv"),
        "word_drafts": count("CURATED_WORD_PILOT.csv", "vocabulary_candidate_id") + independent_drafts + count("CURATED_ADDITIONAL_ROOT_OEWN_PILOT.csv"),
        "function_drafts": count("CURATED_FUNCTION_WORD_PILOT.csv"),
        "common_function_drafts": count("CURATED_COMMON_FUNCTION_PILOT.csv"),
        "common_gap_drafts": count("CURATED_COMMON_GAP_PILOT.csv"),
        "main_gap_drafts": count("CURATED_MAIN_GAP_PILOT.csv"),
        "translation_drafts": count("CURATED_GAP_TRANSLATION_PILOT.csv"),
        "untranslated_drafts": count("CURATED_UNTRANSLATED_PILOT.csv"),
        "port_kaikki_drafts": count("CURATED_PORT_KAIKKI_PILOT.csv"),
        "tract_kaikki_drafts": count("CURATED_TRACT_KAIKKI_PILOT.csv"),
        "spect_kaikki_drafts": count("CURATED_SPECT_KAIKKI_PILOT.csv"),
        "submission_kaikki_drafts": count("CURATED_SUBMISSION_KAIKKI_PILOT.csv"),
    }
    for name, values in sources.items():
        # Word drafts can refer to the separately maintained supplementary inventory.
        if name != "word_drafts" and set(values) - ids:
            raise ValueError(f"Unknown main candidate ID in {name}")
    revisions = read("WIKTIONARY_BULK_SOURCE_INDEX.csv")
    case_review = {row["candidate_id"] for row in read("COW_CASE_REVIEW.csv")}
    if case_review - ids:
        raise ValueError("Unknown case-review candidate ID")
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
            if not (sources["oewn_senses"][candidate_id] or sources["kaikki_function_senses"][candidate_id] or sources["kaikki_case_senses"][candidate_id] or sources["kaikki_common_case_senses"][candidate_id] or sources["kaikki_gap_senses"][candidate_id]):
                flags.append("english_sense_clue_needed")
            if not (sources["cow_sense_links"][candidate_id] or sources["word_drafts"][candidate_id] or sources["function_drafts"][candidate_id] or sources["common_function_drafts"][candidate_id] or sources["common_gap_drafts"][candidate_id] or sources["main_gap_drafts"][candidate_id] or sources["translation_drafts"][candidate_id] or sources["untranslated_drafts"][candidate_id] or sources["port_kaikki_drafts"][candidate_id] or sources["tract_kaikki_drafts"][candidate_id] or sources["spect_kaikki_drafts"][candidate_id] or sources["submission_kaikki_drafts"][candidate_id] or sources["kaikki_translation_clues"][candidate_id] or sources["kaikki_gap_translation_clues"][candidate_id] or sources["kaikki_common_translation_clues"][candidate_id]):
                flags.append("chinese_sense_clue_needed")
            if (sources["oewn_senses"][candidate_id] + sources["kaikki_function_senses"][candidate_id]
                    + sources["kaikki_case_senses"][candidate_id] + sources["kaikki_common_case_senses"][candidate_id]
                    + sources["kaikki_gap_senses"][candidate_id]) > 1:
                flags.append("sense_selection_needed")
            if sources["kaikki_common_case_senses"][candidate_id]:
                flags.append("function_word_sense_review_needed")
            if candidate_id in case_review:
                flags.append("cow_case_mismatch_review_needed")
            flags.extend(("curriculum_review_needed", "license_review_needed"))
            source_status = revisions_by_id.get(candidate_id, {}).get("status", "not_indexed")
            writer.writerow([candidate_id, row["headword"], row["source_ids"], *counts,
                             source_status, "|".join(flags), "candidate_only"])
    print(f"Built a review queue for {len(inventory)} main candidates; none approved.")


if __name__ == "__main__":
    main()
