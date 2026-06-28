#!/usr/bin/env bash
# release.sh — release a new privacy-policy version on GitHub Pages.
#
# Two phases (edit the actual policy text by hand in between):
#   1) ./release.sh new v2.1       # scaffold v2.1 from the current version + stamp current.json
#        ...edit v2.1/index.html: write your changes and update the "Last updated" date...
#   2) ./release.sh publish v2.1   # commit + tag + push  ->  GitHub Pages goes live automatically
#
set -euo pipefail
BASE="https://cair-tech.github.io/sepeo-privacy"
CMD="${1:-}"; VER="${2:-}"

current_version() {
  grep -o '"version"[[:space:]]*:[[:space:]]*"[^"]*"' current.json | head -1 \
    | sed 's/.*"\([^"]*\)"$/\1/'
}

case "$CMD" in
  new)
    [ -n "$VER" ] || { echo "Usage: ./release.sh new vX.Y"; exit 1; }
    PREV="$(current_version)"
    [ -d "$VER" ] || cp -r "$PREV" "$VER"          # scaffold the new version from the previous one
    cat > current.json <<JSON
{
  "version": "$VER",
  "url": "$BASE/$VER/",
  "publishedAt": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
JSON
    echo "Created $VER (from $PREV) and updated current.json."
    echo "NEXT: edit $VER/index.html (write changes + update the 'Last updated' date), then run:"
    echo "      ./release.sh publish $VER"
    ;;
  publish)
    [ -n "$VER" ] || { echo "Usage: ./release.sh publish vX.Y"; exit 1; }
    git add .
    git commit -m "Publish privacy policy $VER"
    git tag "$VER"
    git push && git push --tags
    echo "Pushed. GitHub Pages auto-deploys — live in ~1-10 min at:"
    echo "  $BASE/$VER/"
    echo "  $BASE/current.json"
    ;;
  *)
    echo "Usage:"
    echo "  ./release.sh new vX.Y       # scaffold new version + stamp current.json"
    echo "  ./release.sh publish vX.Y   # commit, tag, push (GitHub Pages auto-deploys)"
    exit 1
    ;;
esac
