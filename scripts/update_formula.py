#!/usr/bin/env python3
"""Update a Homebrew formula's PyPI sdist url and sha256 to the latest release.

Usage: update_formula.py <formula.rb> <pypi-project>

Prints "updated <old> -> <new>" when it rewrote the file and "up to date
(<version>)" otherwise. Exits non-zero on any error. Intended for
dependency-free formulas whose ``url`` points at a Python sdist on
files.pythonhosted.org; other lines are left untouched.
"""

from __future__ import annotations

import json
import re
import sys
import urllib.request
from pathlib import Path

URL_RE = re.compile(r'^(\s*url\s+)"([^"]+)"', re.MULTILINE)
SHA_RE = re.compile(r'^(\s*sha256\s+)"([0-9a-f]{64})"', re.MULTILINE)
PYPI_JSON = "https://pypi.org/pypi/{project}/json"


def fetch_pypi(project: str) -> dict:
    with urllib.request.urlopen(PYPI_JSON.format(project=project), timeout=30) as response:
        return json.load(response)


def sdist_of(data: dict) -> tuple[str, str, str]:
    """Return (version, url, sha256) for the latest sdist."""
    version = str(data["info"]["version"])
    sdist = next((item for item in data["urls"] if item.get("packagetype") == "sdist"), None)
    if sdist is None:
        raise SystemExit(f"{version}: no sdist published on PyPI")
    return version, str(sdist["url"]), str(sdist["digests"]["sha256"])


def update_formula(path: Path, project: str, pypi: dict | None = None) -> tuple[bool, str, str]:
    """Rewrite url/sha256 in *path*. Returns (changed, old_version, new_version)."""
    text = path.read_text(encoding="utf-8")
    url_match = URL_RE.search(text)
    sha_match = SHA_RE.search(text)
    if not url_match or not sha_match:
        raise SystemExit(f"{path}: could not find url/sha256 lines")
    current_url = url_match.group(2)
    normalized = project.replace("-", "_")
    if "files.pythonhosted.org" not in current_url or normalized not in current_url:
        raise SystemExit(f"{path}: refusing to rewrite a non-PyPI url: {current_url}")

    version, new_url, new_sha = sdist_of(pypi if pypi is not None else fetch_pypi(project))
    old_match = re.search(rf"{re.escape(normalized)}-([^-]+)\.tar\.gz$", current_url)
    old_version = old_match.group(1) if old_match else "unknown"

    updated = URL_RE.sub(lambda m: m.group(1) + '"' + new_url + '"', text, count=1)
    updated = SHA_RE.sub(lambda m: m.group(1) + '"' + new_sha + '"', updated, count=1)
    if updated == text:
        print(f"up to date ({version})")
        return False, old_version, version
    path.write_text(updated, encoding="utf-8")
    print(f"updated {old_version} -> {version}")
    return True, old_version, version


def main(argv: list[str]) -> int:
    if len(argv) != 3:
        print("usage: update_formula.py <formula.rb> <pypi-project>", file=sys.stderr)
        return 2
    update_formula(Path(argv[1]), argv[2])
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
