#!/bin/bash
source ${HOME}/.api-keys

# Check for required arguments
if [ $# -eq 0 ]; then
  echo "ERROR: Please provide a query as an argument."
  exit 1
fi

# Avoid rate limit errors for unprompted survey questions.
USER_CONTENT="Be short and concise. The output has to be formatted for displaying in a terminal. This is the query: $1"

# Generate JSON payload safely (use jq if available)
PAYLOAD=$(jq -n \
    --arg content "${USER_CONTENT}" \
    '{
        "contents": [
        {
            "parts": [
            {
                "text": $content
            }
        ]
    }
]
}'
)

stdbuf -oL curl -N -s -X POST "https://generativelanguage.googleapis.com/v1beta/models/gemma-3n-e4b-it:generateContent?key=${GEMINI_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD" | \
  jq -r '.candidates[0].content.parts[0].text' | \
  awk '{printf "%s", $0; fflush()}'
  echo

  # grep --line-buffered -o '^{.*}' | \
  # stdbuf -oL jq '.choices[0].delta.content // empty'
#   sed -u 's/ $//' | \
#   awk '{printf "%s", $0; fflush()}' | \
#   sed -u 's/"//g'  # Extract response text
# echo 
