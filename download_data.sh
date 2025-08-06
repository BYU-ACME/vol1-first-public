#!/bin/bash
set -e  # Exit on any error

echo "Fetching latest data branch from upstream..."
git fetch upstream data

echo "Adding data files from upstream/data to .gitignore..."
git ls-tree -r --name-only upstream/data | while read file; do
  if ! grep -qxF "$file" .gitignore; then
    echo "$file" >> .gitignore
    echo "Ignored: $file"
  fi
done

echo "Pulling files from upstream/data..."
git checkout upstream/data -- "*"

echo -e "\033[92mData successfully pulled\033[0m"
