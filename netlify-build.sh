#!/bin/bash
# Exit script if any command fails
set -e

echo "Cleaning up previous clones (if they exist)..."
rm -rf _cpp_notes
# Add future repos here too, e.g.: rm -rf _repo2_notes

echo "Cloning external repositories..."
# --- C++ Notes ---
echo "Cloning cpp-notes..."
git clone https://github.com/dev-ai-kar/cpp-notes.git _cpp_notes

# --- Add future repos below ---
# echo "Cloning repo2..."
# git clone https://github.com/user/repo2.git _repo2_notes

# No processing needed here anymore, front matter must exist in source repo

echo "Running Jekyll build..."
bundle exec jekyll build

echo "Build script finished."
