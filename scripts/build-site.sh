#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
TARGET_DIR="$ROOT/site-assets"
BUILD_DIR="$ROOT/_build/js/release/build"

cd "$ROOT"
moon build --target js --release

JS_FILE=$(find "$BUILD_DIR" -type f -path '*/main/main.js' | head -n 1)

if [ -z "${JS_FILE:-}" ]; then
  echo "[build-site] failed to locate compiled Rabbita output" >&2
  exit 1
fi

mkdir -p "$TARGET_DIR"
sed '/sourceMappingURL/d' "$JS_FILE" > "$TARGET_DIR/main.js"
cp "$ROOT/styles.css" "$TARGET_DIR/styles.css"

echo "[build-site] synced $JS_FILE -> $TARGET_DIR/main.js"
