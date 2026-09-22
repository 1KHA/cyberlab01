#!/bin/bash
# Prepares the lab once per container: builds manifests, then tampers files.
set -e
LAB="${LAB_DIR:-/lab}"; DATA="${DATA_DIR:-/opt/lab-data}"; ANSWER="${ANSWER_FILE:-/root/.answer}"
if [ ! -f "$LAB/.initialized" ]; then
  mkdir -p "$LAB"
  cp -r "$DATA"/part1 "$DATA"/part2 "$DATA"/part3 "$DATA"/part4 "$LAB"/

  # Part 2: manifest of the ORIGINAL files, then change ONE character in ONE random file
  cd "$LAB/part2/received"
  sha256sum * > ../SHA256SUMS
  files=(*); target="${files[RANDOM % ${#files[@]}]}"
  sed -i '0,/0/s/0/8/' "$target"
  echo "part2 tampered file: $target" > "$ANSWER"

  # Part 3: vendor publishes a checksum; the "mirror" copy was altered (look-alike domain)
  cd "$LAB/part3/official"
  sha256sum tool-1.0.sh > ../SHA256SUMS
  mkdir -p ../mirror
  sed 's/updates\.example\.org/updates.examp1e.org/' tool-1.0.sh > ../mirror/tool-1.0.sh
  echo "part3: mirror copy uses examp1e.org (digit 1 instead of letter l)" >> "$ANSWER"

  touch "$LAB/.initialized"
fi
cd "$LAB"
exec "$@"
