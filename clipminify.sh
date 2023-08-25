#!/bin/bash

# fetch clipboard content
clipboard_content=$(xclip -selection clipboard -o)

# remove newlines, tabs, and spaces
minified_content=$(echo "$clipboard_content" | tr -d '\n\t' | tr -s ' ')

# place the minified content back to clipboard
echo "$minified_content" | xclip -selection clipboard
