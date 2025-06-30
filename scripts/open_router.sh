#!/bin/bash

# Check for required arguments
if [ $# -eq 0 ]; then
  echo "ERROR: Please provide a query as an argument."
  exit 1
fi

source ${HOME}/.api-keys
# Avoid rate limit errors for unprompted survey questions.
USER_CONTENT="$1"
USER_CONTENT="Explain shortly in plain text. $1"
MODEL_NAME="deepseek/deepseek-r1-0528:free"
# Generate JSON payload safely (use jq if available)
if command -v jq &> /dev/null; then
  PAYLOAD=$(jq -n \
    --arg model "${MODEL_NAME}" \
    --arg content "$USER_CONTENT" \
    '{model: $model, messages: [{role: "user", content: $content}], stream: true}'
  )
else
  # Fallback to printf (caution: may break with special characters)
  ESCAPED_CONTENT=$(printf '%s' "$USER_CONTENT" | sed 's/"/\\"/g')
  PAYLOAD="{\"model\":\"openai/gpt-4o\",\"messages\":[{\"role\":\"user\",\"content\":\"$ESCAPED_CONTENT\"}]}"
fi
#
# Stream the response with curl (no buffering)
stdbuf -oL curl -N -s -X POST "https://openrouter.ai/api/v1/chat/completions" \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  -H "Content-Type: application/json" \
  -H "Openrouter-User-Metadata: 0" \
  -d "$PAYLOAD"
  # sed -u 's/^data: //' | \
  # grep --line-buffered -o '^{.*}' | \
  # stdbuf -oL jq '.choices[0].delta.content // empty'
#   sed -u 's/ $//' | \
#   awk '{printf "%s", $0; fflush()}' | \
#   sed -u 's/"//g'  # Extract response text
# echo 
  # -d "$PAYLOAD" | sed 's/^data: //'| grep -o '^{.*}' | jq '.choices[0].delta.content // empty' | sed 's/ $//' | awk '{printf "%s ", $0}'  # Extract response text
  # -d "$PAYLOAD" \
  # | awk -F '"' '/"content"/ {printf $32 }; END {print }'
  # -d "$PAYLOAD" | jq '.choices[0].message.content'  # Extract response text
