#!/usr/bin/env python3
"""Validate source links for single-OEWN sense drafts, without approving them."""

import csv
import json
from pathlib import Path

DOCS = Path(__file__).resolve().parents[2] / "docs"


def read(name):
    with (DOCS / name).open(encoding="utf-8", newline="") as f:
        return list(csv.DictReader(f))


def main():
    drafts = read("CURATED_SINGLE_OEWN_PILOT.csv")
    source = read("SINGLE_OEWN_REVIEW_BATCH.csv")
    by_id = {row["candidate_id"]: row for row in source}
    if len(by_id) != len(source) or len({r["candidate_id"] for r in drafts}) != len(drafts):
        raise ValueError("Duplicate source or draft candidate ID")
    for row in drafts:
        ref = by_id.get(row["candidate_id"])
        if ref is None:
            raise ValueError(f"Missing source: {row['candidate_id']}")
        fields = (("word", "headword"), ("pos", "pos"), ("oewn_sense_id", "sense_id"),
                  ("oewn_synset_id", "oewn_synset_id"), ("ili", "ili"),
                  ("cow_synset_ids", "cow_synset_ids"))
        if any(row[a] != ref[b] for a, b in fields):
            raise ValueError(f"Source field mismatch: {row['candidate_id']}")
        if row["chinese_selected"] not in json.loads(ref["chinese_lemmas_json"]):
            raise ValueError(f"Selected Chinese lemma missing: {row['candidate_id']}")
        if row["status"] != "editorial_draft_pending_final_review":
            raise ValueError(f"Unexpected status: {row['candidate_id']}")
    print(f"Checked {len(drafts)} draft links; semantic, curriculum and licence review remains required.")


if __name__ == "__main__":
    main()
