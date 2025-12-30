#!/bin/bash

set -e

REPO_URL="https://raw.githubusercontent.com/SodiumCXI/talknado-server-linux/main"
INSTALL_DIR="/usr/local/bin"

echo "Installing Talknado Server..."

curl -fsSL "$REPO_URL/talknado-server" -o "$INSTALL_DIR/talknado-server"
curl -fsSL "$REPO_URL/talknado-server-bin" -o "$INSTALL_DIR/talknado-server-bin"

chmod +x "$INSTALL_DIR/talknado-server"
chmod +x "$INSTALL_DIR/talknado-server-bin"

echo "Done!"
echo "Usage:"
echo "  talknado-server help"