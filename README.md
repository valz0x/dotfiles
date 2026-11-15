# ⚡ Cross-Platform Dotfiles (Windows & Linux)

Unified personal configurations for **Neovim**, **Alacritty**, **Herdr**, **WezTerm**, **PowerShell 7**, and **Ghostty**.

---

## 📂 Configuration Matrix

| Tool | Platform | Target Location (Windows) | Target Location (Linux) |
|---|---|---|---|
| **Neovim (`nvim`)** | 🌐 Shared | `%LOCALAPPDATA%\nvim` | `~/.config/nvim` |
| **Alacritty** | 🌐 Shared | `%APPDATA%\alacritty` | `~/.config/alacritty` |
| **Herdr** | 🌐 Shared | `%APPDATA%\herdr` | `~/.config/herdr` |
| **Ghostty** | 🐧 Linux | — | `~/.config/ghostty/config` |
| **WezTerm** | 🪟 Windows | `~/.config/wezterm` | — |
| **PowerShell 7** | 🪟 Windows | `~/Documents/PowerShell` | — |

---

## 📁 Repository Structure

```text
dotfiles/
├── alacritty/                  # [SHARED] Alacritty config, live theme picker, 9 themes
│   ├── alacritty.toml
│   ├── theme.toml
│   └── themes/
├── herdr/                      # [SHARED] Herdr terminal workspace manager
│   └── config.toml
├── nvim/                       # [SHARED] Neovim config (Lazy, LSP, DAP, Treesitter)
│   ├── init.lua
│   └── lua/
├── ghostty/                    # [LINUX ONLY] Ghostty terminal config
│   └── config
├── wezterm/                    # [WINDOWS ONLY] WezTerm modular config
│   ├── wezterm.lua
│   └── config/
├── powershell/                 # [WINDOWS ONLY] PowerShell profile & utilities
│   ├── Microsoft.PowerShell_profile.ps1
│   ├── Utils.ps1
│   ├── powershell.config.json
│   ├── install-modules.ps1     # Automated installer for required PS modules
│   └── *.omp.json              # Oh-My-Posh themes
├── configs/                    # Preserved configs & snippets from OneDrive share
│   ├── i3-config-part.md       # Linux i3wm cheat sheet & shortcuts
│   ├── httpd-vhosts.conf
│   └── ...
├── install.ps1                 # Windows deployment script
├── sync.ps1                    # Windows sync script (pulls live configs into repo)
├── install.sh                  # Linux deployment script (symlinks into ~/.config)
└── sync.sh                     # Linux sync script (pulls live configs into repo)
```

---

## 🚀 Installation & Usage

### 🪟 On Windows
Open PowerShell 7 in this folder:

```powershell
# 1. Deploy all Windows configurations
.\install.ps1

# 2. (First-time only) Automatically install PowerShell modules & tools
.\powershell\install-modules.ps1
# (or run: .\install.ps1 -InstallModules)
```

**Syncing your latest Windows tweaks back into git:**
```powershell
.\sync.ps1
git commit -am "Update configs"
git push
```

---

### 🐧 On Linux
Clone the repo on your Linux machine:

```bash
git clone https://github.com/valz0x/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Make scripts executable and run installer
chmod +x install.sh sync.sh
./install.sh
```
This symlinks `nvim`, `alacritty`, `herdr`, and `ghostty` directly into `~/.config/`. Any edits you make in your editors will be live immediately!

**Syncing Linux tweaks back into git:**
```bash
./sync.sh
git commit -am "Update linux configs"
git push
```
