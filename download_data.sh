#!/bin/bash
set -e  # Exit on any error

# Fetch latest from origin (their own fork)
echo "Fetching latest data branch from origin (your repo)..."
git fetch origin data

# Add data files to .gitignore (only if not already present)
echo "Adding data files from origin/data to .gitignore..."
git ls-tree -r --name-only origin/data | while read file; do
  if ! grep -qxF "$file" .gitignore; then
    echo "$file" >> .gitignore
    echo "Ignored: $file"
  fi
done

# Pull files from the data branch into the working directory, but do not stage them
echo "Pulling files from origin/data..."
git checkout origin/data -- "*"
git restore --staged .

echo -e "\033[92mData successfully pulled\033[0m"
