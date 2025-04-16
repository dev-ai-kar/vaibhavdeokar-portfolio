#!/bin/bash
# Exit script if any command fails
set -e

TEMP_CPP_DIR="_temp_cpp_notes"
CPP_COLLECTION_DIR="_cpp_notes"
CPP_IMG_DIR="images/cpp" # Re-enable image directory
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
# Create destination directories
mkdir -p $CPP_COLLECTION_DIR
mkdir -p $CPP_IMG_DIR # Re-enable image directory creation

# Copy images to the assets directory (handle if img-data doesn't exist)
if [ -d "$TEMP_CPP_DIR/img-data" ]; then
  echo "Copying images to $CPP_IMG_DIR..."
  cp -r $TEMP_CPP_DIR/img-data/* $CPP_IMG_DIR/ # Copy contents to images/cpp
else
  echo "No img-data directory found in $TEMP_CPP_DIR. Skipping image copy."
fi

# Copy only markdown files to the collection directory
echo "Copying markdown files to $CPP_COLLECTION_DIR..."
find $TEMP_CPP_DIR -maxdepth 1 -name "*.md" -exec cp {} $CPP_COLLECTION_DIR/ \;

# Update image paths in the markdown files within the collection directory
echo "Updating image paths in markdown files..."
# Using find + sed. Note: -i requires GNU sed or careful handling on BSD/macOS. Netlify uses Ubuntu (GNU).
# Update HTML image paths: src="img-data/..." -> src="/images/cpp/..."
find $CPP_COLLECTION_DIR -name "*.md" -exec sed -i -E 's#src="(img-data/)([^"]+)"#src="/images/cpp/\2"#g' {} \;
# Update Markdown image paths: (img-data/...) -> (/images/cpp/...)
find $CPP_COLLECTION_DIR -name "*.md" -exec sed -i -E 's#\((img-data/)([^)]+)\)#(/images/cpp/\2)#g' {} \;

# --- Add processing for future repos below ---

# Clean up temporary directory
echo "Removing temporary clone directory..."
rm -rf $TEMP_CPP_DIR

echo "Running Jekyll build..."
bundle exec jekyll build

echo "Build script finished."
