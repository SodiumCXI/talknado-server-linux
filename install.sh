#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
    echo "Error: Root access required"
    exit 1
fi

REPO_URL="https://raw.githubusercontent.com/SodiumCXI/talknado-server-linux/main"
INSTALL_DIR="/usr/local/bin"
DATA_DIR="/usr/local/share/talknado-server"

echo "Installing Talknado Server..."

mkdir -p "$DATA_DIR"
chmod 777 "$DATA_DIR"

touch "$DATA_DIR/connection.key" "$DATA_DIR/password"
chmod 666 "$DATA_DIR/connection.key" "$DATA_DIR/password"

curl -fsSL "$REPO_URL/talknado-server" -o "$INSTALL_DIR/talknado-server"
curl -fsSL "$REPO_URL/talknado-server-bin" -o "$INSTALL_DIR/talknado-server-bin"

chmod +x "$INSTALL_DIR/talknado-server" "$INSTALL_DIR/talknado-server-bin"

echo "Done!"

"$INSTALL_DIR/talknado-server" --help || true