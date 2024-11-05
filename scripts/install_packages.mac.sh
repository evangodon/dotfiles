#!/bin/bash

# Specify the file containing the package list
PACKAGE_FILE="packages.txt"

# Check if the file exists
if [[ ! -f "$PACKAGE_FILE" ]]; then
  echo "Package list file '$PACKAGE_FILE' not found!"
  exit 1
fi

# Read each line from the file and install the package using brew
while IFS= read -r package || [[ -n "$package" ]]; do
  # Skip empty lines
  if [[ -z "$package" ]]; then
    continue
  fi

  echo "Installing $package..."
  brew install "$package"
done < "$PACKAGE_FILE"

echo "All packages installed."

