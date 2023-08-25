#!/bin/bash

# Fetch clipboard content
clipboard_content=$(xclip -selection clipboard -o)

# Edit content using the user's default editor (e.g., nano, vim, etc.)
echo "$clipboard_content" > /tmp/clipboard_tmp.txt
${EDITOR:-nano} /tmp/clipboard_tmp.txt

# After editing, place the content back to clipboard
xclip -selection clipboard -i /tmp/clipboard_tmp.txt

# Clean up
rm /tmp/clipboard_tmp.txt
