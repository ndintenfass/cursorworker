#!/bin/bash
set -e

WORK_DIR="/workspace"
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

if [ ! -d ".git" ]; then
  git init
  git config user.email "worker@cursor.com"
  git config user.name "Cursor Worker"
  git commit --allow-empty -m "init"

  # Set origin remote so the worker can derive the repository URL
  if [ -n "$CURSOR_REPO_URL" ]; then
    git remote add origin "$CURSOR_REPO_URL"
  else
    echo "WARNING: CURSOR_REPO_URL not set. Worker may not function correctly."
    echo "Set CURSOR_REPO_URL to your target repository (e.g. https://github.com/org/repo)"
  fi
fi

exec agent worker start --management-addr ":10000" --worker-dir "$WORK_DIR"
