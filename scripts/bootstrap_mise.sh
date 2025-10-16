#!/usr/bin/env bash
set -euo pipefail

echo "==> Installing Mise..."

if command -v mise &> /dev/null; then
    echo "Mise is already installed."
else
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew &> /dev/null; then
            brew install mise
        else
            curl https://mise.run | sh
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        curl https://mise.run | sh
    else
        echo "Unsupported OS: $OSTYPE"
        exit 1
    fi
fi

echo "==> Activating Mise..."
eval "$(mise activate bash)"

echo "==> Installing tools from .mise.toml..."
mise install

echo "==> Mise setup complete!"
echo ""
echo "To activate Mise in your shell, add the following to your shell config:"
echo ""
echo "  For bash: eval \"\$(mise activate bash)\""
echo "  For zsh:  eval \"\$(mise activate zsh)\""
echo "  For fish: mise activate fish | source"
echo ""
