#!/usr/bin/env python3
"""Checkpoint Wiktionary revision metadata for the main candidate inventory.

The resulting headings locate sources; they do not validate an etymology or
associate a word with a root. The checkpoint contains source text and stays
outside the repository. Existing output is never overwritten.
"""

import argparse
import csv
import hashlib
import json
import re
import subprocess
import time
from pathlib import Path
from urllib.parse import urlencode

ROOT = Path(__file__).resolve().parents[2]
ENGLISH = re.compile(r"(?ms)^==English==\s*$(.*?)(?=^==[^=\n]+==\s*$|\Z)")
ETYMOLOGY = re.compile(r"^={3,5}\s*(Etymology(?:\s+\d+)?)\s*={3,5}\s*$", re.M)
BATCH_SIZE = 40


def fetch(titles):
    params = {"action": "query", "format": "json", "formatversion": "2",
              "redirects": "1", "prop": "revisions", "rvslots": "main",
              "rvprop": "ids|timestamp|sha1|content", "maxlag": "5",
              "titles": "|".join(titles)}
    cmd = ["curl", "-fsSL", "--max-time", "45", "--get", "--user-agent",
           "EtyraVocabularyResearch/0.1 (educational source audit)",
           "https://en.wiktionary.org/w/api.php"]
    for key, value in params.items():
        cmd += ["--data-urlencode", f"{key}={value}"]
    for attempt in range(4):
        result = subprocess.run(cmd, capture_output=True, text=True)
        try:
            response = json.loads(result.stdout) if result.returncode == 0 else {}
        except json.JSONDecodeError:
            response = {}
        if "query" in response and "pages" in response["query"]:
            return response
        if "429" in result.stderr or response.get("error", {}).get("code") in {"ratelimited", "maxlag"}:
            raise RuntimeError("Wiktionary rate limited requests; stop and retry later")
        if attempt == 3:
            raise RuntimeError(f"API request failed: {result.stderr[:300]} {response.get('error', '')}")
        time.sleep(2 ** attempt * 2)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("cache", type=Path, help="External checkpoint directory")
    parser.add_argument("output", type=Path, help="New output CSV")
    parser.add_argument("--cached-only", action="store_true", help="Index the contiguous cached prefix without making requests")
    args = parser.parse_args()
    if args.output.exists():
        raise FileExistsError(args.output)
    inventory = ROOT / "docs/VOCABULARY_CANDIDATES.csv"
    digest = hashlib.sha256(inventory.read_bytes()).hexdigest()
    with inventory.open(encoding="utf-8", newline="") as source:
        candidates = list(csv.DictReader(source))
    if len({row['candidate_id'] for row in candidates}) != len(candidates):
        raise ValueError("Duplicate candidate IDs")
    args.cache.mkdir(parents=True, exist_ok=True)
    results = []
    total = (len(candidates) + BATCH_SIZE - 1) // BATCH_SIZE
    for offset in range(0, len(candidates), BATCH_SIZE):
        group = candidates[offset:offset + BATCH_SIZE]
        titles = [row["headword"] for row in group]
        path = args.cache / f"batch-{offset // BATCH_SIZE:04d}.json"
        if path.exists():
            checkpoint = json.loads(path.read_text(encoding="utf-8"))
            if checkpoint["inventory_sha256"] != digest or checkpoint["titles"] != titles:
                raise ValueError(f"Checkpoint does not match inventory: {path}")
        else:
            if args.cached_only:
                break
            checkpoint = {"inventory_sha256": digest, "titles": titles, "response": fetch(titles)}
            temporary = path.with_suffix(".tmp")
            temporary.write_text(json.dumps(checkpoint, ensure_ascii=False), encoding="utf-8")
            temporary.replace(path)
            time.sleep(5)
        query = checkpoint["response"]["query"]
        aliases = {item["from"]: item["to"] for item in query.get("normalized", []) + query.get("redirects", [])}
        pages = {page["title"]: page for page in query["pages"]}
        for candidate in group:
            title = candidate["headword"]
            visited = set()
            while title in aliases:
                if title in visited:
                    raise ValueError(f"Circular redirect: {title}")
                visited.add(title)
                title = aliases[title]
            if title not in pages:
                raise ValueError(f"Unresolved API response: {title}")
            page = pages[title]
            revision = page.get("revisions", [{}])[0]
            content = revision.get("slots", {}).get("main", {}).get("content", "")
            english = ENGLISH.search(content)
            headings = ETYMOLOGY.findall(english.group(1)) if english else []
            if "missing" in page or "invalid" in page:
                status = "page_missing"
            elif not revision.get("revid") or not content:
                status = "revision_content_unavailable"
            elif not english:
                status = "english_section_missing"
            elif not headings:
                status = "etymology_heading_absent"
            else:
                status = "source_located_relation_unreviewed"
            url = ("https://en.wiktionary.org/w/index.php?" + urlencode({"title": title, "oldid": revision['revid']})) if revision.get("revid") else ""
            results.append((candidate["candidate_id"], candidate["headword"], title,
                            revision.get("revid", ""), revision.get("timestamp", ""),
                            revision.get("sha1", ""), "|".join(headings), url, status))
        index = offset // BATCH_SIZE + 1
        if index % 10 == 0 or index == total:
            print(f"Processed {index}/{total} batches ({len(results)} candidates)", flush=True)
    if not results:
        raise ValueError("No cached or fetched source records")
    with args.output.open("x", encoding="utf-8", newline="") as output:
        writer = csv.writer(output, lineterminator="\n")
        writer.writerow(("candidate_id", "headword", "source_title", "revision_id", "revision_timestamp_utc",
                         "revision_sha1", "english_etymology_headings", "revision_url", "status"))
        writer.writerows(results)
    print(f"Wrote {len(results)} source records; source location does not verify root relationships.")


if __name__ == "__main__":
    main()
