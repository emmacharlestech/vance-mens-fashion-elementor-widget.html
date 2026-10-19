#!/usr/bin/env bash
# Copies the Top-Notch page and only the files it uses from c:\xampp\htdocs\lp into this
# deploy folder. Run after changing the page:  bash tools/sync-from-lp.sh  then commit and push.
set -euo pipefail
SRC=/c/xampp/htdocs/lp
PAGE=vance-mens-fashion-elementor-widget.html
DEST="$(cd "$(dirname "$0")/.." && pwd)"

rm -rf "$DEST/images" "$DEST/videos"
cp "$SRC/$PAGE" "$DEST/index.html"

# Every images/… and videos/… path the page mentions, plus the sharper @2x copies
# the Venue album viewer builds in its script.
grep -oE "(images|videos)/[^ \"'),]*\.(jpg|jpeg|png|webp|mp4)" "$SRC/$PAGE" | sort -u | while read -r rel; do
  for f in "$rel" "${rel%.jpg}@2x.jpg"; do
    if [ -f "$SRC/$f" ]; then mkdir -p "$DEST/$(dirname "$f")"; cp "$SRC/$f" "$DEST/$f"; fi
  done
done
echo "Synced $(find "$DEST/images" "$DEST/videos" -type f | wc -l) files ($(du -sh "$DEST/images" "$DEST/videos" | awk '{print $1}' | paste -sd+ -))"
