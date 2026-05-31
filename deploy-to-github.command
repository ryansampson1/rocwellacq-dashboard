#!/bin/bash
# Double-click to deploy Rocwell ACQ Dashboard to GitHub Pages

cd "$(dirname "$0")"

REPO_URL="https://github.com/ryansampson1/rocwellacq-dashboard.git"

echo "================================================"
echo "  Rocwell ACQ Dashboard — Deploy to GitHub"
echo "================================================"
echo ""

# Initialize git if needed
if [ ! -d ".git" ]; then
  echo "Setting up git for the first time..."
  git init
  git remote add origin "$REPO_URL"
  git branch -M main
  echo "Git initialized."
else
  # Make sure remote is set
  if ! git remote get-url origin &>/dev/null; then
    git remote add origin "$REPO_URL"
  fi
fi

echo ""
echo "Adding files..."
git add index.html

echo "Committing..."
git commit -m "Update dashboard — $(date '+%Y-%m-%d %H:%M')"

echo ""
echo "Pushing to GitHub Pages..."
git push -u origin main

echo ""
if [ $? -eq 0 ]; then
  echo "✅ Deployed! Live at:"
  echo "   https://ryansampson1.github.io/rocwellacq-dashboard/"
else
  echo "⚠️  Push failed. You may need to authenticate."
  echo "   Try running: gh auth login"
  echo "   Or sign in via: https://github.com/login"
fi

echo ""
echo "Press any key to close..."
read -n 1
