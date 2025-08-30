#!/bin/bash
# Exit script if any command fails
set -e

# --- C++ Notes ---
CPP_COLLECTION_DIR="_cpp_notes"
CPP_REPO="https://github.com/dev-ai-kar/cpp-notes.git"

echo "Cleaning up previous C++ Notes directory..."
rm -rf $CPP_COLLECTION_DIR

echo "Cloning cpp-notes repository directly into $CPP_COLLECTION_DIR..."
git clone --depth 1 $CPP_REPO $CPP_COLLECTION_DIR

# --- Algorithm Notes ---
ALGO_COLLECTION_DIR="_algorithm_notes"
ALGO_REPO="https://github.com/dev-ai-kar/structs-algos-unix.git"
ALGO_TEMP_DIR="_algos_temp"

echo "Cleaning up previous Algorithm Notes directories..."
rm -rf $ALGO_COLLECTION_DIR
rm -rf $ALGO_TEMP_DIR

echo "Cloning and sparse-checking out algorithm-notes repository..."
git clone --filter=blob:none --no-checkout $ALGO_REPO $ALGO_TEMP_DIR
cd $ALGO_TEMP_DIR
git sparse-checkout set --no-cone notes
git checkout
cd ..

echo "Moving algorithm notes to collection directory..."
mkdir -p $ALGO_COLLECTION_DIR
mv $ALGO_TEMP_DIR/notes/* $ALGO_COLLECTION_DIR/
rm -rf $ALGO_TEMP_DIR

# Add future repo clones here if needed

echo "Running Jekyll build..."
bundle exec jekyll build

# --- Post-build steps ---
echo "Copying images to the final site directory..."

# --- C++ Notes Images ---
SOURCE_IMG_DIR_CPP="$CPP_COLLECTION_DIR/img-data"
DEST_IMG_DIR_CPP="_site/notes/cpp/img-data"

if [ -d "$SOURCE_IMG_DIR_CPP" ]; then
  echo "Source image directory '$SOURCE_IMG_DIR_CPP' found."
  echo "Creating destination directory '$DEST_IMG_DIR_CPP'..."
  mkdir -p "$DEST_IMG_DIR_CPP"
  echo "Copying images from '$SOURCE_IMG_DIR_CPP' to '$DEST_IMG_DIR_CPP'..."
  cp -r "$SOURCE_IMG_DIR_CPP"/* "$DEST_IMG_DIR_CPP"/
  echo "C++ notes images copied successfully."
else
  echo "Source image directory '$SOURCE_IMG_DIR_CPP' not found. Skipping C++ image copy."
fi

# --- Algorithm Notes Images ---
# Assuming images are in a similar 'img-data' directory within 'notes'
SOURCE_IMG_DIR_ALGO="$ALGO_COLLECTION_DIR/img-data"
DEST_IMG_DIR_ALGO="_site/notes/algorithms/img-data"

if [ -d "$SOURCE_IMG_DIR_ALGO" ]; then
  echo "Source image directory '$SOURCE_IMG_DIR_ALGO' found."
  echo "Creating destination directory '$DEST_IMG_DIR_ALGO'..."
  mkdir -p "$DEST_IMG_DIR_ALGO"
  echo "Copying images from '$SOURCE_IMG_DIR_ALGO' to '$DEST_IMG_DIR_ALGO'..."
  cp -r "$SOURCE_IMG_DIR_ALGO"/* "$DEST_IMG_DIR_ALGO"/
  echo "Algorithm notes images copied successfully."
else
  echo "Source image directory '$SOURCE_IMG_DIR_ALGO' not found. Skipping Algorithm image copy."
fi

echo "Cleaning up potentially erroneous .html files in destination..."
if [ -d "$DEST_IMG_DIR_CPP" ]; then
  find "$DEST_IMG_DIR_CPP" -type f -name '*.html.jpg' -o -name '*.html.jpeg' -o -name '*.html.png' -o -name '*.html.gif' -o -name '*.html.svg' -exec rm -f {} \;
fi
if [ -d "$DEST_IMG_DIR_ALGO" ]; then
  find "$DEST_IMG_DIR_ALGO" -type f -name '*.html.jpg' -o -name '*.html.jpeg' -o -name '*.html.png' -o -name '*.html.gif' -o -name '*.html.svg' -exec rm -f {} \;
fi
echo "Cleanup finished."

# --- Add future post-build steps here ---

echo "Build script finished."
