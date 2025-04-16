#!/bin/bash
# Exit script if any command fails
set -e

TEMP_CPP_DIR="_temp_cpp_notes"
CPP_COLLECTION_DIR="_cpp_notes"
# CPP_IMG_DIR="images/cpp" # No longer needed for cpp-notes
CPP_REPO="https://github.com/dev-ai-kar/cpp-notes.git"

echo "Cleaning up previous build artifacts (if they exist)..."
rm -rf $TEMP_CPP_DIR
rm -rf $CPP_COLLECTION_DIR
# Keep rm -rf images/cpp commented out unless you want to clear images on every build
# rm -rf $CPP_IMG_DIR 
# Add future repos cleanup here too

echo "Cloning external repositories..."
# --- C++ Notes ---
echo "Cloning cpp-notes into temporary directory..."
git clone $CPP_REPO $TEMP_CPP_DIR

echo "Processing C++ Notes..."
# Create destination directory for collection
mkdir -p $CPP_COLLECTION_DIR
# mkdir -p $CPP_IMG_DIR # No longer needed

# Copy only markdown files to the collection directory
echo "Copying markdown files to $CPP_COLLECTION_DIR..."
find $TEMP_CPP_DIR -maxdepth 1 -name "*.md" -exec cp {} $CPP_COLLECTION_DIR/ \;

# Copy the img-data directory into the collection directory (if it exists)
if [ -d "$TEMP_CPP_DIR/img-data" ]; then
  echo "Copying img-data directory into $CPP_COLLECTION_DIR..."
  cp -r $TEMP_CPP_DIR/img-data $CPP_COLLECTION_DIR/
else
  echo "No img-data directory found in $TEMP_CPP_DIR. Skipping image copy."
fi

# DO NOT update image paths - keep them relative within the collection
# echo "Updating image paths in markdown files..."
# find ... sed ...
# find ... sed ...

# --- Add processing for future repos below ---

# Clean up temporary directory
echo "Removing temporary clone directory..."
rm -rf $TEMP_CPP_DIR

echo "Running Jekyll build..."
bundle exec jekyll build

echo "Build script finished."
