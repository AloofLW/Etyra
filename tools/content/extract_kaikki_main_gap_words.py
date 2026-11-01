#!/usr/bin/env python3
"""Extract review-only senses from pinned individual Kaikki word snapshots."""
import argparse
import csv
import hashlib
import json
from pathlib import Path
from urllib.parse import quote

from build_vocabulary_review_queue import read

SNAPSHOTS = (
    ("café", "897a55a9f354076d5ea60730f087a586374ff52daafcdd0bac16aff2dfb30607"),
    ("could", "83b4b78e4aae01220fab7fc35aad1bb68c95bb06a64d9e842b90450b13c0b4c9"),
    ("criteria", "d240f168a07c0cb6bbb54d06f360ebe24bddba5e9621c5508a9577f4477d9f5c"),
    ("founded", "95bd10a397e46b62987b00d32acf72aa2d62f8c3c14441f06cf77742a989c256"),
    ("goods", "d3ac4b5ae58f52fe4b38c0b3043e06ceecc6e4dd762c1e83cbd6ddc1d66bdc0d"),
    ("hey", "120c98a7cdfd35ea8876c1ff16f4188062df6cef557797f5be56507c483ad6fd"),
    ("media", "77fce36e722ddb08398389182c69416a9d154d29ab22a04669fec456f08a5735"),
    ("multi", "0c9fac365a5746207cf54669ddc8c4e730d18edfd69de59136065943a77e8939"),
    ("shall", "14b25ffddd1f5b03561589514ac91010029188b79ba386ee5754d94c9fcf9507"),
    ("should", "7b67a87644fade2802295f28f908f3e2756881dbf81c0767153dacc358725391"),
    ("trans", "7b918b9170d5bcc4304f89be337edf1a12194982bc7daee4a6d0054bc3fa355c"),
    ("whereby", "a27abe6f80a4691ccfb2f8ce16af2775de7a0b2018672b68a4c654a15d03f1f4"),
    ("would", "4805b870c2f16d16b24dcaec4fa2c0d1cc5e0145ceb4d9a9ba14885151166e97"),
)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("directory", type=Path, help="Directory containing numbered JSONL snapshots")
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    candidates = {row["headword"]: row for row in read("VOCABULARY_CANDIDATES.csv")}
    if len(candidates) != len(read("VOCABULARY_CANDIDATES.csv")):
        raise ValueError("Duplicate candidate headword")
    rows = []
    for i, (word, expected) in enumerate(SNAPSHOTS):
        data = (args.directory / f"{i}.jsonl").read_bytes()
        if hashlib.sha256(data).hexdigest() != expected:
            raise ValueError(f"Snapshot {i} changed")
        for line in data.splitlines():
            entry = json.loads(line)
            if entry.get("lang_code") != "en" or entry.get("word") != word:
                raise ValueError(f"Unexpected entry in snapshot {i}")
            for sense in entry.get("senses", []):
                if sense.get("glosses"):
                    rows.append((candidates[word]["candidate_id"], word, word, entry["pos"], sense.get("id", ""),
                                 json.dumps(sense["glosses"], ensure_ascii=False), json.dumps(sense.get("tags", []), ensure_ascii=False),
                                 "https://en.wiktionary.org/wiki/" + quote(word.replace(" ", "_"), safe=""), "candidate_only"))
    rows.sort()
    with args.output.open("x", encoding="utf-8", newline="") as output:
        writer = csv.writer(output, lineterminator="\n")
        writer.writerow(("candidate_id", "headword", "source_word", "pos", "sense_id", "glosses_json", "tags_json", "source_url", "status"))
        writer.writerows(rows)
    print(f"Extracted {len(rows)} unreviewed senses for {len({r[0] for r in rows})} candidates.")


if __name__ == "__main__":
    main()
