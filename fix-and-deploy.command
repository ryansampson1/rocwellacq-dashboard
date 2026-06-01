#!/bin/bash
cd "$(dirname "$0")"

echo "🔧 Clearing git locks..."
rm -f .git/index.lock .git/HEAD.lock 2>/dev/null

echo "📦 Committing changes..."
git add -A
git commit -m "Fix: power company + fee on cards, management fee in proforma, closing costs 2%" 2>/dev/null || echo "(nothing new to commit)"

echo "🚀 Pushing to GitHub Pages..."
git push --force origin main 2>&1

echo ""
echo "✅ Done! Live in ~30 seconds at:"
echo "   https://ryansampson1.github.io/rocwellacq-dashboard/"
echo ""
echo "Press any key to close…"
read -n 1 -s
