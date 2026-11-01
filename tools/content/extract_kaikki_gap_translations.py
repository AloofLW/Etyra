#!/usr/bin/env python3
"""Extract unreviewed Chinese translations from pinned Kaikki word snapshots."""
import argparse
import csv
import hashlib
import json
from pathlib import Path
from urllib.parse import quote

from build_vocabulary_review_queue import read


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("directory", type=Path, help="Directory with candidate-ID.jsonl snapshots")
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    manifest = read("KAIKKI_CHINESE_GAP_SNAPSHOTS.csv")
    candidates = {row["candidate_id"]: row["headword"] for row in read("VOCABULARY_CANDIDATES.csv")}
    seen = set()
    rows = set()
    for item in manifest:
        candidate_id, word = item["candidate_id"], item["word"]
        if candidate_id in seen or candidates.get(candidate_id) != word:
            raise ValueError(f"Duplicate or mismatched candidate: {candidate_id}")
        seen.add(candidate_id)
        data = (args.directory / f"{candidate_id}.jsonl").read_bytes()
        if hashlib.sha256(data).hexdigest() != item["sha256"]:
            raise ValueError(f"Snapshot changed: {word}")
        for line in data.splitlines():
            entry = json.loads(line)
            if entry.get("lang_code") != "en" or entry.get("word") != word:
                raise ValueError(f"Unexpected word or language: {word}")
            for translation in entry.get("translations", []):
                if translation.get("lang_code") not in ("zh", "cmn") or not translation.get("word"):
                    continue
                rows.add((candidate_id, word, entry["pos"], translation["lang_code"], translation["word"],
                          translation.get("sense", ""), "https://en.wiktionary.org/wiki/" + quote(word, safe=""),
                          "translation_clue_unreviewed"))
    with args.output.open("x", encoding="utf-8", newline="") as output:
        writer = csv.writer(output, lineterminator="\n")
        writer.writerow(("candidate_id", "headword", "pos", "language_code", "translation_original",
                         "source_sense_label", "source_url", "status"))
        writer.writerows(sorted(rows))
    print(f"Extracted {len(rows)} unreviewed translation clues for {len({r[0] for r in rows})} of {len(manifest)} candidates.")


if __name__ == "__main__":
    main()
