#!/usr/bin/env python3
"""Check draft provenance links; this does not approve meanings or licences."""

import argparse
import csv
import json
from pathlib import Path


def read(directory, name):
    with (directory / f"{name}.csv").open(encoding="utf-8-sig", newline="") as f:
        return list(csv.DictReader(f))


def index(rows, columns, label):
    result = {}
    for row in rows:
        key = tuple(row[column] for column in columns)
        if key in result:
            raise ValueError(f"duplicate {label}: {key}")
        result[key] = row
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--docs-dir", type=Path, default=Path(__file__).resolve().parents[2] / "docs")
    directory = parser.parse_args().docs_dir
    drafts = read(directory, "CURATED_WORD_PILOT")
    key = ("candidate_id", "sense_id")
    oewn = index(read(directory, "OEWN_SENSE_CANDIDATES") + read(directory, "OEWN_RELATION_SENSE_CANDIDATES"), key, "OEWN sense")
    cow = index(read(directory, "COW_SENSE_CANDIDATES") + read(directory, "COW_RELATION_SENSE_CANDIDATES"), key, "COW sense")
    relations = index(read(directory, "WORD_CANDIDATES_V0_1"), ("candidate_id",), "relation")
    revisions = index(read(directory, "WORD_ETYM_SOURCE_REVISIONS"), ("word_candidate_id",), "revision")
    index(drafts, ("word_relation_candidate_id",), "draft relation")
    errors = []
    for draft in drafts:
        name = draft["word"]
        sense_key = (draft["vocabulary_candidate_id"], draft["oewn_sense_id"])
        rel_key = (draft["word_relation_candidate_id"],)
        source, translation = oewn.get(sense_key), cow.get(sense_key)
        relation, revision = relations.get(rel_key), revisions.get(rel_key)
        if not all((source, translation, relation, revision)):
            errors.append(f"{name}: missing referenced sense, translation, relation or revision")
            continue
        checks = {
            "word": draft["word"] == relation["word_candidate"] == revision["word_candidate"] == source["headword"] == translation["headword"],
            "root": draft["root_candidate_id"] == relation["root_candidate_id"] == revision["root_candidate_id"],
            "part of speech": draft["pos"] == source["pos"] == translation["pos"],
            "synset": draft["oewn_synset_id"] == source["synset_id"] == translation["oewn_synset_id"],
            "CILI": draft["ili"] == translation["ili"],
            "COW synsets": draft["cow_synset_ids"] == translation["cow_synset_ids"],
            "Chinese lemma": draft["chinese_selected"] in json.loads(translation["chinese_lemmas_json"]),
            "revision URL": draft["etymology_revision_url"] == revision["revision_url"],
            "draft status": draft["status"] == "editorial_draft_pending_final_review",
        }
        errors.extend(f"{name}: {label} mismatch" for label, valid in checks.items() if not valid)
    if errors:
        print("\n".join(errors))
        raise SystemExit(1)
    print(f"Checked {len(drafts)} draft links; semantic accuracy, curriculum coverage and licensing remain unreviewed.")


if __name__ == "__main__":
    main()
