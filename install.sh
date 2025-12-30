#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
    echo "Error: Root access required"
    exit 1
fi

REPO_URL="https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main"
INSTALL_DIR="/usr/local/bin"

echo "Installing Talknado Server..."

curl -fsSL "$REPO_URL/talknado-server" -o "$INSTALL_DIR/talknado-server"
curl -fsSL "$REPO_URL/talknado-server-bin" -o "$INSTALL_DIR/talknado-server-bin"

chmod +x "$INSTALL_DIR/talknado-server"
chmod +x "$INSTALL_DIR/talknado-server-bin"

echo "Done!"
echo "Usage:"
echo "  talknado-server help"