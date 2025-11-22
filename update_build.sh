#!/usr/bin/env bash
set -e

BRANCH="main"

# Resolve repo root as "one level up from this script"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="${SCRIPT_DIR}/.."

cd "$ROOT_DIR"

echo "[app-update] Fetching latest $BRANCH from origin..."
git fetch origin "$BRANCH"

LOCAL_SHA="$(git rev-parse "$BRANCH")"
REMOTE_SHA="$(git rev-parse "origin/$BRANCH")"

if [ "$LOCAL_SHA" = "$REMOTE_SHA" ]; then
    echo "[app-update] Up to date ($BRANCH @ $LOCAL_SHA)"
    exit 0
fi

echo "[app-update] Updating $BRANCH from $LOCAL_SHA to $REMOTE_SHA..."
git pull --rebase origin "$BRANCH"

echo "[app-update] Configuring CMake..."
cmake -B build -G Ninja

echo "[app-update] Building..."
cmake --build build -j"$(nproc)"

echo "[app-update] Done. New build at ./build/app"
