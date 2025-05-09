#!/usr/bin/env bash

IFS_BAK=$IFS
IFS="
"

for FILE_PATH in $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS; do
    echo "$FILE_PATH" | cb
    notify-send "Copied to clipboard" "$FILE_PATH"
done

IFS=$IFS_BAK