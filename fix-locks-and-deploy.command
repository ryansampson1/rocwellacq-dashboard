#!/bin/bash
cd "$(dirname "$0")"
echo "Clearing lock files and aborting any rebase..."
rm -f .git/HEAD.lock .git/index.lock
git rebase --abort 2>/dev/null
git merge --abort 2>/dev/null
echo "Staging index.html..."
git add index.html
git commit -m "Add duplicate detection & merge tool, fix dead deals — $(date '+%Y-%m-%d %H:%M')" 2>/dev/null || echo "(nothing new to commit)"
echo "Force pushing to GitHub Pages..."
git push --force origin main
if [ $? -eq 0 ]; then
  echo ""
  echo "✅ Deployed! Refresh: https://ryansampson1.github.io/rocwellacq-dashboard/"
else
  echo ""
  echo "❌ Push failed — check output above."
fi
echo "Press any key to close..."
read -n 1
