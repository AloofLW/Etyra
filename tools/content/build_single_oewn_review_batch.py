#!/usr/bin/env python3
"""Prepare a source-linked review batch; no sense or translation is approved."""

import argparse
import collections
import csv
import json
from pathlib import Path

DOCS = Path(__file__).resolve().parents[2] / "docs"


def read(name):
    with (DOCS / name).open(encoding="utf-8-sig", newline="") as file:
        return list(csv.DictReader(file))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path, help="New output CSV; never overwrites existing files")
    args = parser.parse_args()
    inventory = {row["candidate_id"]: row for row in read("VOCABULARY_CANDIDATES.csv")}
    senses = collections.defaultdict(list)
    links = collections.defaultdict(list)
    for row in read("OEWN_SENSE_CANDIDATES.csv"):
        if row["candidate_id"] not in inventory or row["status"] != "candidate_only":
            raise ValueError("Invalid OEWN candidate")
        senses[row["candidate_id"]].append(row)
    for row in read("COW_SENSE_CANDIDATES.csv"):
        if row["candidate_id"] not in inventory or row["status"] != "candidate_only":
            raise ValueError("Invalid COW candidate")
        links[(row["candidate_id"], row["sense_id"])].append(row)
    result = []
    for candidate_id in sorted(inventory):
        if len(senses[candidate_id]) != 1:
            continue
        source = senses[candidate_id][0]
        matches = links[(candidate_id, source["sense_id"])]
        if len(matches) != 1:
            continue
        cow = matches[0]
        if (source["synset_id"] != cow["oewn_synset_id"] or source["pos"] != cow["pos"]
                or source["oewn_written_form"] != cow["oewn_written_form"]):
            raise ValueError(f"Inconsistent source reference: {candidate_id}")
        definitions = json.loads(source["definitions_json"])
        chinese = json.loads(cow["chinese_lemmas_json"])
        if not definitions or not chinese:
            raise ValueError(f"Empty definition or Chinese candidate: {candidate_id}")
        result.append((candidate_id, inventory[candidate_id]["headword"], source["oewn_written_form"],
                       source["pos"], source["sense_id"], source["synset_id"], cow["ili"],
                       cow["cow_synset_ids"], source["definitions_json"], cow["chinese_lemmas_json"],
                       len(chinese), "candidate_only"))
    with args.output.open("x", encoding="utf-8", newline="") as output:
        writer = csv.writer(output, lineterminator="\n")
        writer.writerow(("candidate_id", "headword", "oewn_written_form", "pos", "sense_id", "oewn_synset_id",
                         "ili", "cow_synset_ids", "english_definitions_json", "chinese_lemmas_json",
                         "chinese_option_count", "status"))
        writer.writerows(result)
    print(f"Prepared {len(result)} review candidates; {sum(row[-2] == 1 for row in result)} have one Chinese option.")
    print("One indexed OEWN sense does not establish a unique meaning, accurate translation, or curriculum relevance.")


if __name__ == "__main__":
    main()
