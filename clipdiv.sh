k#!/bin/bash

CHAR_LIMIT=10000
divider="This divides approx ${CHAR_LIMIT} characters, but not more"

# Fetch clipboard content
clipboard_content=$(xclip -selection clipboard -o)

new_content=""
remaining_content="$clipboard_content"

while [[ ${#remaining_content} -gt $CHAR_LIMIT ]]; do
    part="${remaining_content:0:$CHAR_LIMIT}"
    
    # Identify the last newline character before CHAR_LIMIT
    pos=$(echo "$part" | rev | grep -aob '\n' | grep -oE '[0-9]+' | head -n 1)
    
    if [[ -z $pos ]]; then
        pos=$CHAR_LIMIT
    else
        pos=$(( CHAR_LIMIT - pos ))
    fi
    
    segment="${remaining_content:0:$pos}"
    new_content="${new_content}${segment}${divider}"
    remaining_content="${remaining_content:$pos}"
done

new_content="${new_content}${remaining_content}"

# Update clipboard
echo "$new_content" | xclip -selection clipboard

