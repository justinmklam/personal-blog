#!/bin/bash
# List all blog posts that are still marked as drafts.
# Scans the front matter (first 20 lines) of each page-bundle index.md
# for `draft: true` (YAML front matter only).
set -e

count=0
found=()

while IFS= read -r -d '' f; do
  if head -20 "$f" | grep -Eq '^draft:\s*true'; then
    title=$(head -10 "$f" | grep '^title:' | sed 's/^title:\s*//; s/^"//; s/"$//')
    path=$(dirname "$f" | sed 's|^content/posts/||')
    found+=("  $path  —  $title")
    count=$((count + 1))
  fi
done < <(find content/posts -name 'index.md' -print0)

if [ "$count" -eq 0 ]; then
  echo "No draft posts found."
else
  echo "Draft posts ($count):"
  printf '%s\n' "${found[@]}"
fi
