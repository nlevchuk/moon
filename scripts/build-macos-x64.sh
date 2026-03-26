#!/usr/bin/env bash
set -euo pipefail

version="${1:-}"

if [[ -z "$version" ]]; then
  echo "Usage: $0 <version>" >&2
  echo "Example: $0 v2.0.4" >&2
  exit 1
fi

git fetch upstream "refs/tags/${version}:refs/tags/${version}"
git checkout x86_64-apple-darwin
git reset --hard "$version"
git checkout HEAD@{1} -- .github/workflows/build-macos-x64.yml
git checkout HEAD@{1} -- scripts/build-macos-x64.sh
git commit -m "chore(github): restore macOS x64 build workflow for ${version}"
git push origin x86_64-apple-darwin --force
