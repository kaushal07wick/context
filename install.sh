#!/bin/sh
set -e

REPO="kaushal07wick/context"
VERSION="v0.1.0"
BIN="context-linux-x86_64"
INSTALL_DIR="/usr/local/bin"

echo "Installing context..."

tmp="$(mktemp)"

curl -fsSL \
  "https://github.com/$REPO/releases/download/$VERSION/$BIN" \
  -o "$tmp"

chmod +x "$tmp"

if [ -w "$INSTALL_DIR" ]; then
  mv "$tmp" "$INSTALL_DIR/context"
else
  sudo mv "$tmp" "$INSTALL_DIR/context"
fi

echo "context installed successfully"
echo "Run: context --help"
