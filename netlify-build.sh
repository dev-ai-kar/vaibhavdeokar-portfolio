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

# --- Post-build steps ---
echo "Copying images to the final site directory..."
SOURCE_IMG_DIR="$CPP_COLLECTION_DIR/img-data"
DEST_IMG_DIR="_site/notes/cpp/img-data" # The final path required for the URL

if [ -d "$SOURCE_IMG_DIR" ]; then
  echo "Source image directory '$SOURCE_IMG_DIR' found."
  echo "Creating destination directory '$DEST_IMG_DIR'..."
  mkdir -p "$DEST_IMG_DIR"
  echo "Copying images from '$SOURCE_IMG_DIR' to '$DEST_IMG_DIR'..."
  cp -r "$SOURCE_IMG_DIR"/* "$DEST_IMG_DIR"/
  echo "Images copied successfully."
else
  echo "Source image directory '$SOURCE_IMG_DIR' not found. Skipping image copy."
fi

echo "Cleaning up potentially erroneous .html files in destination..."
# Remove files like image.html.jpg, image.html.png etc. just in case
find "$DEST_IMG_DIR" -type f -name '*.html.jpg' -o -name '*.html.jpeg' -o -name '*.html.png' -o -name '*.html.gif' -o -name '*.html.svg' -exec rm -f {} \;
echo "Cleanup finished."
# --- Add future post-build steps here ---

echo "Build script finished."
