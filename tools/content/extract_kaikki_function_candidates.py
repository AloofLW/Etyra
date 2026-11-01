#!/usr/bin/env python3
"""Extract provisional senses for OEWN-unmatched candidates from fixed Kaikki snapshots."""
import argparse
import csv
import gzip
import hashlib
import json
from pathlib import Path
from urllib.parse import quote

ROOT = Path(__file__).resolve().parents[2]
SNAPSHOTS = {
    "article": "d42ba9fce9ec018bdc606dd1948eb2d4ce7209af5205967f60188ff758a54d92",
    "conj": "90417a911907ff580f588c7a41846647fc055c930ead96638cb40bb00a29fe11",
    "det": "1950b79784a27d931e62bddabe7a5111d86df57af72a22bc3a0b2fc77b9b8a1b",
    "prep": "a995558554ea0b3e59003925f6aa8ea8a50089da05d3bfff0daaab2f266dddc6",
    "pron": "38d5dcad952274fa2d3284cb0580f25fdea461007e76980e362dbea475ca9ac2",
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("directory", type=Path, help="Directory containing etyra-kaikki-POS.jsonl.gz snapshots")
    parser.add_argument("output", type=Path)
    parser.add_argument("--supplement", action="store_true", help="Use the two Wiktionary supplement candidate inventories")
    args = parser.parse_args()
    candidates = {}
    if args.supplement:
        inputs = (("WIKTIONARY_GAP_CANDIDATES.csv", "headword"),
                  ("COMPLEX_WIKTIONARY_CANDIDATES.csv", "normalized_key"))
        for name, key in inputs:
            with (ROOT / "docs" / name).open(encoding="utf-8", newline="") as source:
                for row in csv.DictReader(source):
                    word = row[key].strip()
                    normalized = word.casefold()
                    if normalized in candidates:
                        raise ValueError(f"Duplicate supplement key: {word}")
                    candidates[normalized] = {"headword": word, "candidate_id": row["candidate_id"]}
    else:
        with (ROOT / "docs/OEWN_CANDIDATE_INDEX.csv").open(encoding="utf-8", newline="") as source:
            candidates = {row["headword"].strip().casefold(): row for row in csv.DictReader(source) if not row["oewn_entry_ids"]}
    rows = []
    for pos, expected in SNAPSHOTS.items():
        path = args.directory / f"etyra-kaikki-{pos}.jsonl.gz"
        with path.open("rb") as source:
            if hashlib.file_digest(source, "sha256").hexdigest() != expected:
                raise ValueError(f"Snapshot hash mismatch: {path}")
        with gzip.open(path, "rt", encoding="utf-8") as source:
            for line in source:
                entry = json.loads(line)
                if entry.get("lang_code") != "en" or entry.get("pos") != pos:
                    raise ValueError(f"Unexpected language or POS in {path}")
                word = entry["word"]
                candidate = candidates.get(word.strip().casefold())
                if not candidate:
                    continue
                for sense in entry.get("senses", []):
                    glosses = sense.get("glosses", [])
                    if not glosses:
                        continue
                    rows.append((candidate["candidate_id"], candidate["headword"], word, pos,
                                 sense.get("id", ""), json.dumps(glosses, ensure_ascii=False),
                                 json.dumps(sense.get("tags", []), ensure_ascii=False),
                                 "https://en.wiktionary.org/wiki/" + quote(word.replace(" ", "_"), safe=""),
                                 "candidate_only"))
    rows.sort()
    with args.output.open("x", encoding="utf-8", newline="") as output:
        writer = csv.writer(output, lineterminator="\n")
        writer.writerow(("candidate_id", "headword", "source_word", "pos", "sense_id", "glosses_json", "tags_json", "source_url", "status"))
        writer.writerows(rows)
    print(f"Extracted {len(rows)} unreviewed senses for {len({r[0] for r in rows})} candidate words.")


if __name__ == "__main__":
    main()
