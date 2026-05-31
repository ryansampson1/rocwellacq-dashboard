#!/bin/bash
# Double-click to push all changes to GitHub Pages
cd "$(dirname "$0")"

if [ ! -d ".git" ]; then
  echo "❌  Git not set up. Run  1-setup-git.command  first."
  echo ""; read -n 1 -s; exit 1
fi

CHANGED=$(git status --porcelain)
if [ -z "$CHANGED" ]; then
  echo "✅  Nothing to deploy — no changes since last push."
  echo ""; read -n 1 -s; exit 0
fi

echo "Files changed:"
echo "$CHANGED"
echo ""

git merge --abort 2>/dev/null    # clear any stuck merge state
git checkout -- index.html 2>/dev/null  # discard any conflict markers
git add -A
git commit -m "Update — $(date '+%Y-%m-%d %H:%M')"
git push --force origin main 2>&1

echo ""
if [ $? -eq 0 ]; then
  echo "✅  Deployed! Live in ~30 seconds at:"
  echo "   https://ryansampson1.github.io/rocwellacq-dashboard/"
else
  echo "⚠️  Push failed. Check your GitHub authentication."
  echo "   Run:  gh auth login   in Terminal to fix it."
fi

echo ""; echo "Press any key to close…"; read -n 1 -s
