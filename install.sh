#!/usr/bin/env bash
#
# 🐧 Linux Dotfiles Installer
# Links/copies configurations for: Neovim, Alacritty, Herdr, and Ghostty.
#

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

echo -e "\033[1;36m⚡ Deploying dotfiles on Linux from $DOTFILES_DIR...\033[0m"

# Ensure ~/.config exists
mkdir -p "$CONFIG_DIR"

# Helper function to link or copy config
deploy_config() {
    local src="$1"
    local dest="$2"
    local name="$3"

    echo -e "\033[1;33mSetting up $name -> $dest...\033[0m"
    mkdir -p "$(dirname "$dest")"

    # Backup if dest exists and is not a symlink to our src
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "  Backing up existing $dest to ${dest}.backup"
        mv "$dest" "${dest}.backup"
    fi

    # Symlink directory/file
    ln -sfn "$src" "$dest"
    echo -e "\033[1;32m✓ $name linked successfully.\033[0m"
}

# 1. Neovim (Shared)
deploy_config "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim" "Neovim"

# 2. Alacritty (Shared)
deploy_config "$DOTFILES_DIR/alacritty" "$CONFIG_DIR/alacritty" "Alacritty"

# 3. Herdr (Shared)
deploy_config "$DOTFILES_DIR/herdr" "$CONFIG_DIR/herdr" "Herdr"

# 4. Ghostty (Linux-specific)
deploy_config "$DOTFILES_DIR/ghostty" "$CONFIG_DIR/ghostty" "Ghostty"

echo -e "\n\033[1;36m🎉 All Linux dotfiles deployed successfully!\033[0m"
