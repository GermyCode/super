#!/bin/bash

# Check if input and output directories are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input_directory> <output_directory>"
  exit 1
fi

# Input and output directories
INPUT_DIR="$1"
OUTPUT_DIR="$2"

# Validate that the input is a directory
if [ ! -d "$INPUT_DIR" ]; then
  echo "Error: $INPUT_DIR is not a directory."
  exit 1
fi

# Ensure the output directory exists
mkdir -p "$OUTPUT_DIR"

# Search for files containing 'NewServerWorld' and copy them
echo "Searching for 'NewServerWorld' in files within $INPUT_DIR..."
grep -rl "NewServerWorld" "$INPUT_DIR" | while read -r FILE; do
  echo "Found: $FILE"
  
  # Copy the file to the output directory, maintaining the directory structure
  RELATIVE_PATH="${FILE#$INPUT_DIR/}"
  DEST_DIR="$OUTPUT_DIR/$(dirname "$RELATIVE_PATH")"
  mkdir -p "$DEST_DIR"
  cp "$FILE" "$DEST_DIR/"
done

echo "All matching files have been copied to $OUTPUT_DIR."

exit 0
