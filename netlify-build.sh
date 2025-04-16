#!/bin/bash
# Exit script if any command fails
set -e

echo "Cloning external repositories..."
# --- C++ Notes ---
echo "Cloning cpp-notes..."
git clone https://github.com/dev-ai-kar/cpp-notes.git _cpp_notes

# --- Add future repos below ---
# echo "Cloning repo2..."
# git clone https://github.com/user/repo2.git _repo2_notes

echo "Processing cloned repositories..."
# --- Add front matter for cpp-notes ---
echo "Adding front matter to cpp-notes..."
find _cpp_notes -name '*.md' -exec sed -i '1i---\
---' {} +

# --- Add processing for future repos below ---
# echo "Adding front matter to repo2..."
# find _repo2_notes -name '*.md' -exec sed -i '1i---\
# ---' {} +

echo "Running Jekyll build..."
bundle exec jekyll build

echo "Build script finished."
