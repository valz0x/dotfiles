<#
.SYNOPSIS
    Copies the latest live configuration files from your Windows system back into this dotfiles repository.
#>
param()

$dotfiles = $PSScriptRoot

Write-Host "⚡ Syncing live configurations into dotfiles repo..." -ForegroundColor Cyan

# 1. Alacritty
if (Test-Path "$env:APPDATA\alacritty") {
    Copy-Item "$env:APPDATA\alacritty\alacritty.toml" "$dotfiles\alacritty\alacritty.toml" -Force -ErrorAction SilentlyContinue
    Copy-Item "$env:APPDATA\alacritty\theme.toml" "$dotfiles\alacritty\theme.toml" -Force -ErrorAction SilentlyContinue
    Copy-Item "$env:APPDATA\alacritty\themes\*.toml" "$dotfiles\alacritty\themes\" -Force -ErrorAction SilentlyContinue
    Write-Host "✓ Synced Alacritty" -ForegroundColor Green
}

# 2. Herdr
if (Test-Path "$env:APPDATA\herdr\config.toml") {
    Copy-Item "$env:APPDATA\herdr\config.toml" "$dotfiles\herdr\config.toml" -Force
    Write-Host "✓ Synced Herdr" -ForegroundColor Green
}

# 3. Neovim
$nvimSrc = "$env:LOCALAPPDATA\nvim"
if (Test-Path $nvimSrc) {
    Copy-Item "$nvimSrc\init.lua" "$dotfiles\nvim\init.lua" -Force -ErrorAction SilentlyContinue
    Copy-Item "$nvimSrc\.luarc.json" "$dotfiles\nvim\.luarc.json" -Force -ErrorAction SilentlyContinue
    Copy-Item "$nvimSrc\help.md" "$dotfiles\nvim\help.md" -Force -ErrorAction SilentlyContinue
    Copy-Item "$nvimSrc\lazy-lock.json" "$dotfiles\nvim\lazy-lock.json" -Force -ErrorAction SilentlyContinue
    if (Test-Path "$nvimSrc\lua") {
        Copy-Item "$nvimSrc\lua" "$dotfiles\nvim\lua" -Recurse -Force
    }
    Write-Host "✓ Synced Neovim" -ForegroundColor Green
}

# 4. PowerShell 7
$psSrc = "$env:USERPROFILE\Documents\PowerShell"
if (Test-Path $psSrc) {
    Copy-Item "$psSrc\Microsoft.PowerShell_profile.ps1" "$dotfiles\powershell\Microsoft.PowerShell_profile.ps1" -Force -ErrorAction SilentlyContinue
    Copy-Item "$psSrc\powershell.config.json" "$dotfiles\powershell\powershell.config.json" -Force -ErrorAction SilentlyContinue
    Copy-Item "$psSrc\Utils.ps1" "$dotfiles\powershell\Utils.ps1" -Force -ErrorAction SilentlyContinue
    Write-Host "✓ Synced PowerShell" -ForegroundColor Green
}

# 5. WezTerm
$wezSrc = "$env:USERPROFILE\.config\wezterm"
if (Test-Path $wezSrc) {
    Copy-Item "$wezSrc\wezterm.lua" "$dotfiles\wezterm\wezterm.lua" -Force -ErrorAction SilentlyContinue
    Copy-Item "$wezSrc\.stylua.toml" "$dotfiles\wezterm\.stylua.toml" -Force -ErrorAction SilentlyContinue
    Copy-Item "$wezSrc\cog.toml" "$dotfiles\wezterm\cog.toml" -Force -ErrorAction SilentlyContinue
    foreach ($dir in @("config", "events", "mappings", "picker", "utils")) {
        if (Test-Path "$wezSrc\$dir") {
            Copy-Item "$wezSrc\$dir" "$dotfiles\wezterm\$dir" -Recurse -Force
        }
    }
    Write-Host "✓ Synced WezTerm" -ForegroundColor Green
}

Write-Host "`nGit Status:" -ForegroundColor Yellow
git -C $dotfiles status --short
