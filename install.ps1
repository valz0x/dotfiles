<#
.SYNOPSIS
    Installs dotfiles to their target locations on Windows.
    Optionally installs PowerShell modules with -InstallModules switch.
#>
param(
    [switch]$InstallModules
)

$dotfiles = $PSScriptRoot

Write-Host "⚡ Installing dotfiles on Windows from $dotfiles..." -ForegroundColor Cyan

# 1. Alacritty (Shared)
$alacrittyDest = "$env:APPDATA\alacritty"
if (-not (Test-Path $alacrittyDest)) { New-Item -ItemType Directory -Path $alacrittyDest -Force | Out-Null }
Copy-Item "$dotfiles\alacritty\alacritty.toml" "$alacrittyDest\alacritty.toml" -Force
Copy-Item "$dotfiles\alacritty\theme.toml" "$alacrittyDest\theme.toml" -Force
if (-not (Test-Path "$alacrittyDest\themes")) { New-Item -ItemType Directory -Path "$alacrittyDest\themes" -Force | Out-Null }
Copy-Item "$dotfiles\alacritty\themes\*.toml" "$alacrittyDest\themes\" -Force
Write-Host "✓ Alacritty installed -> $alacrittyDest" -ForegroundColor Green

# 2. Herdr (Shared)
$herdrDest = "$env:APPDATA\herdr"
if (-not (Test-Path $herdrDest)) { New-Item -ItemType Directory -Path $herdrDest -Force | Out-Null }
Copy-Item "$dotfiles\herdr\config.toml" "$herdrDest\config.toml" -Force
Write-Host "✓ Herdr config installed -> $herdrDest" -ForegroundColor Green

# 3. Neovim (Shared)
$nvimDest = "$env:LOCALAPPDATA\nvim"
if (-not (Test-Path $nvimDest)) { New-Item -ItemType Directory -Path $nvimDest -Force | Out-Null }
Copy-Item "$dotfiles\nvim\*" $nvimDest -Recurse -Force
Write-Host "✓ Neovim config installed -> $nvimDest" -ForegroundColor Green

# 4. PowerShell 7 (Windows-specific)
$psDest = "$env:USERPROFILE\Documents\PowerShell"
if (-not (Test-Path $psDest)) { New-Item -ItemType Directory -Path $psDest -Force | Out-Null }
Copy-Item "$dotfiles\powershell\Microsoft.PowerShell_profile.ps1" "$psDest\Microsoft.PowerShell_profile.ps1" -Force
Copy-Item "$dotfiles\powershell\powershell.config.json" "$psDest\powershell.config.json" -Force -ErrorAction SilentlyContinue
Copy-Item "$dotfiles\powershell\Utils.ps1" "$psDest\Utils.ps1" -Force -ErrorAction SilentlyContinue
if (Test-Path "$dotfiles\powershell\zash.omp.json") {
    $ompDest = "$env:USERPROFILE\.config\oh-my-posh"
    if (-not (Test-Path $ompDest)) { New-Item -ItemType Directory -Path $ompDest -Force | Out-Null }
    Copy-Item "$dotfiles\powershell\*.omp.json" "$ompDest\" -Force -ErrorAction SilentlyContinue
    Copy-Item "$dotfiles\powershell\poshv*.json" "$ompDest\" -Force -ErrorAction SilentlyContinue
}
Write-Host "✓ PowerShell 7 profile installed -> $psDest" -ForegroundColor Green

# 5. WezTerm (Windows-specific)
$wezDest = "$env:USERPROFILE\.config\wezterm"
if (-not (Test-Path $wezDest)) { New-Item -ItemType Directory -Path $wezDest -Force | Out-Null }
Copy-Item "$dotfiles\wezterm\*" $wezDest -Recurse -Force
Write-Host "✓ WezTerm config installed -> $wezDest" -ForegroundColor Green

# Optional: Install PowerShell Modules
if ($InstallModules) {
    Write-Host "`n📦 Running PowerShell module installation..." -ForegroundColor Cyan
    & "$dotfiles\powershell\install-modules.ps1"
} else {
    Write-Host "`n💡 Tip: To automatically install required PS modules, run: .\powershell\install-modules.ps1" -ForegroundColor Yellow
}

Write-Host "`n🎉 All Windows dotfiles deployed successfully!" -ForegroundColor Cyan
