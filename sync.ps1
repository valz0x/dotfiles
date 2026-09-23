<#
.SYNOPSIS
    Copies the latest live configuration files from the system into this dotfiles repository.
#>
param()

$dotfiles = $PSScriptRoot

Write-Host "Syncing latest configuration files into dotfiles repo..." -ForegroundColor Cyan

# Alacritty
Copy-Item "$env:APPDATA\alacritty\alacritty.toml" "$dotfiles\alacritty\alacritty.toml" -Force
Copy-Item "$env:APPDATA\alacritty\theme.toml" "$dotfiles\alacritty\theme.toml" -Force
Copy-Item "$env:APPDATA\alacritty\themes\*.toml" "$dotfiles\alacritty\themes\" -Force

# Herdr
Copy-Item "$env:APPDATA\herdr\config.toml" "$dotfiles\herdr\config.toml" -Force

# PowerShell 7
$psSrc = "$env:USERPROFILE\Documents\PowerShell"
Copy-Item "$psSrc\Microsoft.PowerShell_profile.ps1" "$dotfiles\powershell\Microsoft.PowerShell_profile.ps1" -Force
if (Test-Path "$psSrc\powershell.config.json") {
    Copy-Item "$psSrc\powershell.config.json" "$dotfiles\powershell\powershell.config.json" -Force
}
if (Test-Path "$psSrc\Utils.ps1") {
    Copy-Item "$psSrc\Utils.ps1" "$dotfiles\powershell\Utils.ps1" -Force
}

Write-Host "✓ Synced live configs." -ForegroundColor Green
Write-Host "`nGit Status:" -ForegroundColor Yellow
git -C $dotfiles status --short
