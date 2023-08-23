#!/bin/bash

# Fetch clipboard content
clipboard_content=$(xclip -selection clipboard -o)

# Remove newlines, tabs, and spaces
minified_content=$(echo "$clipboard_content" | tr -d '\n\t' | tr -s ' ')

# Place the minified content back to clipboard
echo "$minified_content" | xclip -selection clipboard
