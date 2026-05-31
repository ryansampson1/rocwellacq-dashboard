#!/bin/bash
# Leave this running — it auto-pushes to GitHub every time you save index.html
cd "$(dirname "$0")"

if [ ! -d ".git" ]; then
  echo "❌  Git not set up. Run  1-setup-git.command  first."
  echo ""; read -n 1 -s; exit 1
fi

echo "================================================"
echo "  Rocwell Dashboard — Auto-Deploy Watcher"
echo "================================================"
echo "Watching index.html for changes…"
echo "Press Ctrl+C to stop."
echo ""

LAST=""

while true; do
  CURRENT=$(md5 -q index.html 2>/dev/null)
  if [ "$CURRENT" != "$LAST" ] && [ -n "$LAST" ]; then
    echo "[$(date '+%H:%M:%S')] Change detected — pushing…"
    git add index.html
    if ! git diff --staged --quiet; then
      git commit -m "Auto-deploy — $(date '+%Y-%m-%d %H:%M:%S')"
      if git push origin main 2>&1 | tail -1 | grep -q "main"; then
        echo "   ✅  Live at https://ryansampson1.github.io/rocwellacq-dashboard/"
      else
        git push origin main 2>&1
      fi
    else
      echo "   (No git diff — skipped)"
    fi
    echo ""
  fi
  LAST="$CURRENT"
  sleep 3
done
