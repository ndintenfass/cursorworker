#!/bin/bash
set -e

WORK_DIR="/workspace"
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

# Set up git credentials if GIT_TOKEN is provided
if [ -n "$GIT_TOKEN" ] && [ -n "$CURSOR_REPO_URL" ]; then
  git config --global credential.helper store
  REPO_HOST=$(echo "$CURSOR_REPO_URL" | sed -n 's|https://\([^/]*\).*|\1|p')
  echo "https://x-access-token:${GIT_TOKEN}@${REPO_HOST}" > ~/.git-credentials
fi

# Initialize workspace git repo with origin remote
if [ ! -d ".git" ]; then
  git init
  git config user.email "worker@cursor.com"
  git config user.name "Cursor Worker"
  git commit --allow-empty -m "init"
  if [ -n "$CURSOR_REPO_URL" ]; then
    git remote add origin "$CURSOR_REPO_URL"
  else
    echo "WARNING: CURSOR_REPO_URL not set. Worker will start but may not accept sessions."
  fi
fi

# Build agent command
CMD="agent worker start --management-addr :10000 --worker-dir $WORK_DIR"

# Optional: single-use mode
if [ "$CURSOR_SINGLE_USE" = "true" ]; then
  CMD="$CMD --single-use"
fi

# Optional: idle release timeout
if [ -n "$CURSOR_IDLE_TIMEOUT" ]; then
  CMD="$CMD --idle-release-timeout $CURSOR_IDLE_TIMEOUT"
fi

# Optional: labels
if [ -n "$CURSOR_LABELS" ]; then
  for label in $CURSOR_LABELS; do
    CMD="$CMD --label $label"
  done
fi

exec $CMD
