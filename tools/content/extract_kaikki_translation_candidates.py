#!/usr/bin/env python3
"""Extract Chinese translation clues without assigning them to specific senses."""
import argparse
import csv
import gzip
import hashlib
import json
from pathlib import Path
from urllib.parse import quote

from build_vocabulary_review_queue import read
from extract_kaikki_function_candidates import SNAPSHOTS as POS_SNAPSHOTS
from extract_kaikki_main_gap_words import SNAPSHOTS as MAIN_SNAPSHOTS
from extract_kaikki_supplement_words import SNAPSHOTS as SUPP_SNAPSHOTS


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("pos_dir", type=Path)
    parser.add_argument("main_dir", type=Path)
    parser.add_argument("supp_dir", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    candidates = {}
    for name, key, group in (("OEWN_CANDIDATE_INDEX.csv", "headword", "main"),
                             ("WIKTIONARY_GAP_CANDIDATES.csv", "headword", "supplement"),
                             ("COMPLEX_WIKTIONARY_CANDIDATES.csv", "normalized_key", "supplement")):
        for row in read(name):
            if name == "OEWN_CANDIDATE_INDEX.csv" and row["oewn_entry_ids"]:
                continue
            word = row[key]
            candidates[word.casefold()] = (row["candidate_id"], word, group)
    rows = set()

    def collect(data, label, forced_candidate=None):
        for line in data.splitlines():
            entry = json.loads(line)
            if entry.get("lang_code") != "en":
                raise ValueError(f"Non-English entry in {label}")
            word = entry["word"]
            candidate = candidates.get(forced_candidate or word.casefold())
            if not candidate:
                continue
            for translation in entry.get("translations", []):
                if translation.get("lang_code") not in ("zh", "cmn") or not translation.get("word"):
                    continue
                rows.add((candidate[2], candidate[0], candidate[1], word, entry["pos"],
                          translation["lang_code"], translation["word"], translation.get("sense", ""),
                          label, "https://en.wiktionary.org/wiki/" + quote(word.replace(" ", "_"), safe=""),
                          "translation_clue_unreviewed"))

    for pos, expected in POS_SNAPSHOTS.items():
        path = args.pos_dir / f"etyra-kaikki-{pos}.jsonl.gz"
        data = path.read_bytes()
        if hashlib.sha256(data).hexdigest() != expected:
            raise ValueError(f"Snapshot hash mismatch: {path}")
        collect(gzip.decompress(data), f"pos-{pos}")
    for i, (word, expected) in enumerate(MAIN_SNAPSHOTS):
        data = (args.main_dir / f"{i}.jsonl").read_bytes()
        if hashlib.sha256(data).hexdigest() != expected:
            raise ValueError(f"Main snapshot {i} changed")
        collect(data, f"main-{i}", word.casefold())
    for i, (word, source_word, expected) in enumerate(SUPP_SNAPSHOTS):
        data = (args.supp_dir / f"{i}.jsonl").read_bytes()
        if hashlib.sha256(data).hexdigest() != expected:
            raise ValueError(f"Supplement snapshot {i} changed")
        collect(data, f"supplement-{i}", word.casefold())
    with args.output.open("x", encoding="utf-8", newline="") as output:
        writer = csv.writer(output, lineterminator="\n")
        writer.writerow(("inventory", "candidate_id", "headword", "source_word", "pos", "language_code",
                         "translation_original", "source_sense_label", "snapshot", "source_url", "status"))
        writer.writerows(sorted(rows))
    print(f"Extracted {len(rows)} unreviewed translation clues for {len({r[1] for r in rows})} candidates.")
    print("Source sense labels are not verified links to any selected sense.")


if __name__ == "__main__":
    main()
