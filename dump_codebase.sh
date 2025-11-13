#!/bin/bash
# Author: KB (via Grok)
# Purpose: To print out the directory structure of any downloaded codebase and to dump all the files present (keeping the directory) structure into one file. The file can then be uploaded to GhatGPT or Grok for code analysis and reverse enginering (RE); First used for analysis on the INFaaS codebase
# Date: 2025.11.13

OUTPUT_FILE="codebase_dump.txt"

# Clear output file
> "$OUTPUT_FILE"

# Print directory tree
echo "=== DIRECTORY STRUCTURE ===" >> "$OUTPUT_FILE"
tree -a -I '__pycache__|*.pyc|node_modules|.git|.DS_Store' >> "$OUTPUT_FILE"
echo -e "\n\n=== FILE CONTENTS ===\n" >> "$OUTPUT_FILE"

# Iterate through all files and print path + content
find . -type f \( -not -path '*/\.*' -a -not -path '*/__pycache__/*' -a -not -path '*/node_modules/*' \) -print0 | while IFS= read -r -d '' file; do
    # Skip binary files (optional)
    if file "$file" | grep -qE "text|empty"; then
        echo "------------------------------------------------------------" >> "$OUTPUT_FILE"
        echo "FILE: $file" >> "$OUTPUT_FILE"
        echo "------------------------------------------------------------" >> "$OUTPUT_FILE"
        cat "$file" >> "$OUTPUT_FILE"
        echo -e "\n\n" >> "$OUTPUT_FILE"
    fi
done

echo "Codebase dumped to $OUTPUT_FILE"
