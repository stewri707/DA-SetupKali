#!/bin/sh

echo ================ FZF config
echo "FZF config, Press Enter to continue..."
read blaj

# Instruct the shell to exit immediately if any command returns a non-zero status (fails)
set -e

# Define the directory where this script is located
SCRIPT_DIR=$(dirname "$0")

# Check for zsh
if command -v zsh >/dev/null 2>&1; then
    echo "--> zsh detected. Backing up the user's .zshrc..."
    cp "${HOME}/.zshrc" "${HOME}/.zshrc-Pre-fzf-config"
    echo "--> Appending fzf-config-zsh to the user's .zshrc..."
    cat "${SCRIPT_DIR}/fzf-config-zsh" >> "${HOME}/.zshrc"
fi

# Check for bash
if command -v bash >/dev/null 2>&1; then
    echo "--> bash detected. Backing up the user's .bashrc..."
    cp "${HOME}/.bashrc" "${HOME}/.bashrc-Pre-fzf-config"
    echo "--> Appending fzf-config-bash to the user's .bashrc..."
    cat "${SCRIPT_DIR}/fzf-config-bash" >> "${HOME}/.bashrc"
fi

echo "--> Configuration complete."