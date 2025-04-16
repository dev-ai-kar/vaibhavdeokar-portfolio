#!/bin/bash
# Exit script if any command fails
set -e

CPP_COLLECTION_DIR="_cpp_notes"
CPP_REPO="https://github.com/dev-ai-kar/cpp-notes.git"

echo "Cleaning up previous C++ Notes directory..."
rm -rf $CPP_COLLECTION_DIR

echo "Cloning cpp-notes repository directly into $CPP_COLLECTION_DIR..."
git clone --depth 1 $CPP_REPO $CPP_COLLECTION_DIR # Use --depth 1 for faster clone

# Add future repo clones here if needed

echo "Running Jekyll build..."
bundle exec jekyll build

echo "Build script finished."
