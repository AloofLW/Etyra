#!/usr/bin/env python3
"""Extract unreviewed senses from seven pinned, individual Kaikki word files."""
import argparse
import csv
import hashlib
import json
from pathlib import Path
from urllib.parse import quote

from build_vocabulary_review_queue import read

SNAPSHOTS = (
    ("app", "app", "8ef85125065ccec196de9a7dc03e61b8f92fd60e0bc91674e20fb42d60240236"),
    ("chopsticks", "chopsticks", "f2bc1179421c987698fe9217fdb70b0033b7ae5f47b5c9d045bdcd45c36905d9"),
    ("has", "has", "eaddacde188010e578c18628d0c735ac3ff458716b66b7ee45e69802a05b7d4c"),
    ("per cent", "per cent", "7e58864500c4f9964964b5b24d1f62f218508e018bc9039844ea013a93ca7fc0"),
    ("o’clock", "o'clock", "e27d1c4d2122dce427a852fff567e987e11aa03ab5ba7ae7a6a09352fc755007"),
    ("wi-fi", "Wi-Fi", "f65bb8092fc621c517151799171bba9246140f29add8294ac6b813022ac180d8"),
    ("ought to", "ought to", "2f4d6a0c56bf97b0cec56594815c5ff64ff77eedbd6bc8a22e6f77c75482f69c"),
)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("directory", type=Path, help="Directory with numbered 0.jsonl to 6.jsonl snapshots")
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    candidates = {}
    for filename, key in (("WIKTIONARY_GAP_CANDIDATES.csv", "headword"), ("COMPLEX_WIKTIONARY_CANDIDATES.csv", "normalized_key")):
        for row in read(filename):
            word = row[key]
            if word in candidates:
                raise ValueError(f"Duplicate candidate: {word}")
            candidates[word] = row
    rows = []
    for i, (word, source_word, expected) in enumerate(SNAPSHOTS):
        data = (args.directory / f"{i}.jsonl").read_bytes()
        if hashlib.sha256(data).hexdigest() != expected:
            raise ValueError(f"Snapshot {i} changed")
        candidate = candidates[word]
        if candidate.get("source_title", source_word) != source_word:
            raise ValueError(f"Source title mapping changed for {word}")
        for line in data.splitlines():
            entry = json.loads(line)
            if entry.get("lang_code") != "en" or entry.get("word") != source_word:
                raise ValueError(f"Unexpected entry in snapshot {i}")
            for sense in entry.get("senses", []):
                if not sense.get("glosses"):
                    continue
                rows.append((candidate["candidate_id"], word, source_word, entry["pos"], sense.get("id", ""),
                             json.dumps(sense["glosses"], ensure_ascii=False), json.dumps(sense.get("tags", []), ensure_ascii=False),
                             "https://en.wiktionary.org/wiki/" + quote(source_word.replace(" ", "_"), safe=""), "candidate_only"))
    rows.sort()
    with args.output.open("x", encoding="utf-8", newline="") as output:
        writer = csv.writer(output, lineterminator="\n")
        writer.writerow(("candidate_id", "headword", "source_word", "pos", "sense_id", "glosses_json", "tags_json", "source_url", "status"))
        writer.writerows(rows)
    print(f"Extracted {len(rows)} unreviewed senses for {len({r[0] for r in rows})} candidates.")


if __name__ == "__main__":
    main()
