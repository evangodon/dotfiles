#!/bin/bash

# Append new logs to the log file in the work notes

set -u

if [ -z "${1}" ]; then
  echo "Empty log so cancelling" 
  exit 1
fi


DATE="### $(date +'%A, %B %d')"
TIME=$(date +'[%I:%M%p]' | sed 's/^0//')
LOG_FILE="$WORK_NOTES_DIR/Log/log.md"
NEW_ENTRY="- $TIME $1"

# Trim only trailing empty lines at the end of the log file (works on macOS)
sed -i '' -e :a -e '/^\n*$/{$d;N;};/\n$/ba' "$LOG_FILE"

# Check if today's date already exists in the log file
if ! grep -q "^$DATE" "$LOG_FILE"; then
    # If not, add the date header and the new entry
    printf "\n%s\n\n%s\n" "$DATE" "$NEW_ENTRY" >> "$LOG_FILE"
else
    # If the date exists, just add the time and new entry
    printf "%s\n" "$NEW_ENTRY" >> "$LOG_FILE"
fi

echo "New log added $TIME"
