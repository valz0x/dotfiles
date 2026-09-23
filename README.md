# ⚡ Dotfiles (Windows)

Personal configurations for **Alacritty**, **Herdr**, and **PowerShell 7 (`pwsh`)**.

## 🛠 Features

- **Alacritty Terminal**:
  - GPU-accelerated with acrylic/mica blur and borderless window.
  - Font: `JetBrainsMono Nerd Font` (with crisp glyphs and ligature support).
  - Dynamic live theming via `theme.toml` import.
  - Launches directly into Herdr session.
- **Herdr Workspace Manager**:
  - Persistent terminal workspace manager for AI coding agents.
  - Catppuccin Mocha theme.
  - Spawns PowerShell 7 (`pwsh`) inside every pane and tab.
- **PowerShell 7 (`pwsh`)**:
  - Complete profile (`Microsoft.PowerShell_profile.ps1`) with emacs keybindings and optimizations.
  - Custom `theme` command for instant fuzzy theme switching across Alacritty & Herdr.
  - Custom functions and auto-cd in `Utils.ps1`.
  - PowerShell engine configuration (`powershell.config.json`).
  - Oh-My-Posh themes (`zash.omp.json`, `poshv1.json`, `poshv2.json`).
- **Dynamic Theming (`theme`)**:
  - 9 pre-configured themes: `catppuccin`, `tokyo-night`, `dracula`, `nord`, `gruvbox`, `one-dark`, `rose-pine`, `solarized`, `kanagawa`.
  - Type `theme` for an interactive fuzzy-search picker (`fzf`), or `theme <name>` to switch live.

---

## 📂 Structure

```text
dotfiles/
├── alacritty/
│   ├── alacritty.toml                    # Main Alacritty configuration
│   ├── theme.toml                        # Active theme (imported dynamically)
│   └── themes/                           # 9 matching color schemes
├── herdr/
│   └── config.toml                       # Herdr server & terminal configuration
├── powershell/
│   ├── Microsoft.PowerShell_profile.ps1  # Main PowerShell 7 profile
│   ├── powershell.config.json            # Engine options & experimental features
│   ├── Utils.ps1                         # Shell utility functions
│   ├── zash.omp.json                     # Custom Oh-My-Posh prompt theme
│   ├── poshv1.json                       # Oh-My-Posh preset 1
│   └── poshv2.json                       # Oh-My-Posh preset 2
├── install.ps1                           # Deploys dotfiles to local system
├── sync.ps1                              # Pulls live configs into this repo
└── README.md
```

---

## 🚀 Quick Start

### 1. Install / Restore on a New Machine
Clone this repository and run:
```powershell
.\install.ps1
```

### 2. Update Dotfiles After Making Changes
When you tweak your configs or themes on your machine, sync the repo:
```powershell
.\sync.ps1
git add .
git commit -m "Update configs"
git push
```
