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

echo "Processing cloned repositories..."
# --- Add front matter with generated title for cpp-notes ---
echo "Adding front matter to cpp-notes..."
# Loop through all markdown files found
find _cpp_notes -name '*.md' -print0 | while IFS= read -r -d $'\0' file; do
  # Get filename without extension (e.g., "sorting" from "sorting.md")
  filename=$(basename "$file" .md)
  # Basic title generation: replace underscores/hyphens with spaces, capitalize first letter (simple)
  # For more complex capitalization, additional tools might be needed.
  gentitle=$(echo "$filename" | sed -e 's/[_-]/ /g' -e 's/\b\(.\)/\u\1/')
  # Escape quotes in title for YAML safety
  gentitle_escaped=$(echo "$gentitle" | sed "s/'/''/g; s/\"/\\\\\"/g")

  # Use sed to insert front matter with title. Using printf for clarity and safety.
  printf '%s\n' "---" "title: \"${gentitle_escaped}\"" "---" | cat - "$file" > temp && mv temp "$file"
done

# --- Add processing for future repos below ---
# You would replicate the loop structure for other repos, adjusting paths.
# echo "Adding front matter to repo2..."
# find _repo2_notes -name '*.md' -print0 | while ... ; do ... done
# find _repo2_notes -name '*.md' -exec sed -i '1i---\
# ---' {} +

echo "Running Jekyll build..."
bundle exec jekyll build

echo "Build script finished."
