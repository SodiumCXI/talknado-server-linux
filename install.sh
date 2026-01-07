#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
    echo "Error: Root access required"
    exit 1
fi

GITHUB_REPO="SodiumCXI/talknado-server-linux"
VERSION="${1:-latest}"
INSTALL_DIR="/usr/local/bin"

echo "Installing Talknado Server..."

if [ "$VERSION" = "latest" ]; then
    echo "Fetching latest release..."
    RELEASE_TAG=$(curl -fsSL "https://api.github.com/repos/$GITHUB_REPO/releases/latest" | grep '"tag_name":' | cut -d '"' -f 4)
    if [ -z "$RELEASE_TAG" ]; then
        echo "Error: Could not fetch latest release"
        exit 1
    fi
    echo "Latest version: $RELEASE_TAG"
    BASE_URL="https://github.com/$GITHUB_REPO/releases/download/$RELEASE_TAG"
else
    echo "Installing version: $VERSION"
    BASE_URL="https://github.com/$GITHUB_REPO/releases/download/$VERSION"
fi

curl -fsSL "$BASE_URL/talknado" -o "$INSTALL_DIR/talknado" || {
    echo "Error: Failed to download. Check if version exists."
    exit 1
}

curl -fsSL "$BASE_URL/talknado-server-bin" -o "$INSTALL_DIR/talknado-server-bin" || {
    rm -f "$INSTALL_DIR/talknado"
    echo "Error: Failed to download binary"
    exit 1
}

chmod +x "$INSTALL_DIR/talknado"
chmod +x "$INSTALL_DIR/talknado-server-bin"

echo "Done!"

"$INSTALL_DIR/talknado" --help || true