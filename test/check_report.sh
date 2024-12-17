#!/bin/bash

# File paths
files=(../*_REPORT.md)

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No color

# Loop through each file
for file in "${files[@]}"; do
	# Check if file exists
	if [[ ! -f $file ]]; then
		echo -e "${RED}FAIL:${NC} File not found: $file"
		continue
	fi

	# Read the file contents starting from the line after the specified heading
	word_count=$(awk '/# Write Text below \(200 words minimum\)/ {flag=1; next} flag' "$file" | wc -w)

	# Check the word count and print the result in color
	if ((word_count >= 200)); then
		echo -e "${GREEN}SUCCESS:${NC} Word count in $file is $word_count, which meets the minimum requirement."
	else
		echo -e "${RED}FAIL:${NC} Word count in $file is $word_count, which is below the minimum requirement."
	fi

done
