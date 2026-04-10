#!/usr/bin/env bash
set -euo pipefail

FILE="${1:-index.html}"
BRANCH="${2:-$(git rev-parse --abbrev-ref HEAD)}"
REMOTE="${3:-origin}"

if ! command -v inotifywait >/dev/null 2>&1; then
  echo "Erreur: inotifywait manquant. Installe inotify-tools." >&2
  exit 1
fi

if [[ ! -f "$FILE" ]]; then
  echo "Erreur: fichier introuvable: $FILE" >&2
  exit 1
fi

echo "Auto-push actif pour $FILE -> $REMOTE/$BRANCH"
echo "Ctrl+C pour arrêter."

while true; do
  inotifywait -q -e close_write "$FILE"

  if git diff --quiet -- "$FILE" && git diff --cached --quiet -- "$FILE"; then
    continue
  fi

  git add "$FILE"
  if git commit -m "chore: auto-update $(basename "$FILE") $(date -u +'%Y-%m-%dT%H:%M:%SZ')"; then
    git push "$REMOTE" "$BRANCH"
    echo "Push OK: $REMOTE/$BRANCH"
  fi
done
