#!/bin/bash

# fetch clipboard content
clipboard_content=$(xclip -selection clipboard -o)

# remove empty lines
cleaned_content=$(echo "$clipboard_content" | grep -v '^$')

# cleaned content back to clipboard
echo "$cleaned_content" | xclip -selection clipboard
