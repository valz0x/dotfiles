<#
.SYNOPSIS
    Installs dotfiles to their target locations on Windows.
#>
param()

$dotfiles = $PSScriptRoot

Write-Host "Installing dotfiles from $dotfiles..." -ForegroundColor Cyan

# 1. Alacritty
$alacrittyDest = "$env:APPDATA\alacritty"
if (-not (Test-Path $alacrittyDest)) { New-Item -ItemType Directory -Path $alacrittyDest -Force | Out-Null }
Copy-Item "$dotfiles\alacritty\alacritty.toml" "$alacrittyDest\alacritty.toml" -Force
Copy-Item "$dotfiles\alacritty\theme.toml" "$alacrittyDest\theme.toml" -Force
if (-not (Test-Path "$alacrittyDest\themes")) { New-Item -ItemType Directory -Path "$alacrittyDest\themes" -Force | Out-Null }
Copy-Item "$dotfiles\alacritty\themes\*.toml" "$alacrittyDest\themes\" -Force
Write-Host "✓ Alacritty configs installed to $alacrittyDest" -ForegroundColor Green

# 2. Herdr
$herdrDest = "$env:APPDATA\herdr"
if (-not (Test-Path $herdrDest)) { New-Item -ItemType Directory -Path $herdrDest -Force | Out-Null }
Copy-Item "$dotfiles\herdr\config.toml" "$herdrDest\config.toml" -Force
Write-Host "✓ Herdr config installed to $herdrDest" -ForegroundColor Green

# 3. PowerShell 7 (pwsh) Configs
$psDest = "$env:USERPROFILE\Documents\PowerShell"
if (-not (Test-Path $psDest)) { New-Item -ItemType Directory -Path $psDest -Force | Out-Null }
Copy-Item "$dotfiles\powershell\Microsoft.PowerShell_profile.ps1" "$psDest\Microsoft.PowerShell_profile.ps1" -Force
Copy-Item "$dotfiles\powershell\powershell.config.json" "$psDest\powershell.config.json" -Force
Copy-Item "$dotfiles\powershell\Utils.ps1" "$psDest\Utils.ps1" -Force
Write-Host "✓ PowerShell configs & profile installed to $psDest" -ForegroundColor Green

# 4. Oh-My-Posh Themes (if present)
if (Test-Path "$dotfiles\powershell\zash.omp.json") {
    $ompDest = "$env:USERPROFILE\.config\oh-my-posh"
    if (-not (Test-Path $ompDest)) { New-Item -ItemType Directory -Path $ompDest -Force | Out-Null }
    Copy-Item "$dotfiles\powershell\*.omp.json" "$ompDest\" -Force -ErrorAction SilentlyContinue
    Copy-Item "$dotfiles\powershell\poshv*.json" "$ompDest\" -Force -ErrorAction SilentlyContinue
    Write-Host "✓ Oh-My-Posh themes installed to $ompDest" -ForegroundColor Green
}

Write-Host "`n🎉 All dotfiles installed successfully!" -ForegroundColor Cyan
