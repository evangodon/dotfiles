#!/bin/sh

if ! command -v cargo &>/dev/null; then
    echo "Installing Cargo..."
    curl https://sh.rustup.rs -sSf | sh -s -- -yV
fi

echo "Installing Cargo packages..."

cargo install \
    lsd       \
    ripgrep   \
    stylua    \
    bottom    \
    bat       


echo "Finished installing Cargo packages..."
