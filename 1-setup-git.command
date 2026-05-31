#!/bin/bash
# Run this ONE TIME to connect your local folder to GitHub
cd "$(dirname "$0")"
clear

echo "================================================"
echo "  Rocwell Dashboard — First-Time Git Setup"
echo "================================================"
echo ""

# Check git is installed
if ! command -v git &>/dev/null; then
  echo "❌  Git is not installed."
  echo "    Download it at: https://git-scm.com/download/mac"
  echo "    Then re-run this script."
  echo ""; read -n 1 -s; exit 1
fi

REPO="https://github.com/ryansampson1/rocwellacq-dashboard.git"

# Init if needed
if [ ! -d ".git" ]; then
  echo "Initializing local git repo..."
  git init -b main
  git remote add origin "$REPO"
else
  echo "✅ Git already initialized."
  # Make sure remote is correct
  git remote set-url origin "$REPO" 2>/dev/null || git remote add origin "$REPO"
fi

echo ""
echo "Staging all files..."
git add -A

echo "Creating commit..."
git commit -m "Local setup — $(date '+%Y-%m-%d %H:%M')" 2>&1 | grep -v "^$"

echo ""
echo "Pushing to GitHub (you may be asked to log in)..."
git push -u origin main 2>&1

CODE=$?
echo ""
if [ $CODE -eq 0 ]; then
  echo "✅  Setup complete!"
  echo ""
  echo "   Live site: https://ryansampson1.github.io/rocwellacq-dashboard/"
  echo ""
  echo "From now on just double-click  2-deploy.command  to push changes."
  echo "Or double-click  3-watch-and-auto-deploy.command  for live auto-push."
else
  echo "⚠️  Push failed (exit $CODE)."
  echo ""
  echo "Most likely fix — authenticate with GitHub CLI:"
  echo "  1. Open Terminal"
  echo "  2. Run:  brew install gh  (if not installed)"
  echo "  3. Run:  gh auth login"
  echo "  4. Then re-run this script."
  echo ""
  echo "Or install GitHub Desktop: https://desktop.github.com"
fi

echo ""; echo "Press any key to close…"; read -n 1 -s
