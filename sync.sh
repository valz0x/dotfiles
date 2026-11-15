#!/usr/bin/env bash
#
# 🐧 Linux Dotfiles Sync
# Pulls live configuration files from ~/.config into this dotfiles repository.
#

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

echo -e "\033[1;36m⚡ Syncing live Linux configs into dotfiles repository...\033[0m"

# Sync Neovim
if [ -d "$CONFIG_DIR/nvim" ]; then
    rsync -av --delete \
        --exclude '.git' \
        --exclude 'lazy' \
        --exclude 'nvim.log' \
        "$CONFIG_DIR/nvim/" "$DOTFILES_DIR/nvim/"
    echo -e "\033[1;32m✓ Synced Neovim\033[0m"
fi

# Sync Alacritty
if [ -d "$CONFIG_DIR/alacritty" ]; then
    rsync -av --delete "$CONFIG_DIR/alacritty/" "$DOTFILES_DIR/alacritty/"
    echo -e "\033[1;32m✓ Synced Alacritty\033[0m"
fi

# Sync Herdr
if [ -f "$CONFIG_DIR/herdr/config.toml" ]; then
    mkdir -p "$DOTFILES_DIR/herdr"
    cp "$CONFIG_DIR/herdr/config.toml" "$DOTFILES_DIR/herdr/config.toml"
    echo -e "\033[1;32m✓ Synced Herdr\033[0m"
fi

# Sync Ghostty
if [ -d "$CONFIG_DIR/ghostty" ]; then
    rsync -av --delete "$CONFIG_DIR/ghostty/" "$DOTFILES_DIR/ghostty/"
    echo -e "\033[1;32m✓ Synced Ghostty\033[0m"
fi

echo -e "\n\033[1;33mGit status:\033[0m"
git -C "$DOTFILES_DIR" status --short
