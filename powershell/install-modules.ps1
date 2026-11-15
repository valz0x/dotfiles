<#
.SYNOPSIS
    Installs all required PowerShell modules and tools for your shell environment.
    Runs without admin rights (installs to CurrentUser scope).
#>

[CmdletBinding()]
param(
    [switch]$Force
)

Write-Host "📦 Installing PowerShell Modules for CurrentUser..." -ForegroundColor Cyan

# 1. Ensure PSGallery is trusted
$psGallery = Get-PSRepository -Name "PSGallery" -ErrorAction SilentlyContinue
if ($psGallery -and $psGallery.InstallationPolicy -ne 'Trusted') {
    Write-Host "Setting PSGallery repository to Trusted..." -ForegroundColor Yellow
    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
}

# 2. List of core modules used in profile
$modules = @(
    "PSReadLine",
    "Terminal-Icons",
    "PSFzf",
    "z",
    "posh-git",
    "cd-extras"
)

foreach ($module in $modules) {
    if (-not (Get-Module -ListAvailable -Name $module) -or $Force) {
        Write-Host "  Installing $module..." -ForegroundColor Yellow
        Install-Module -Name $module -Scope CurrentUser -Force -SkipPublisherCheck -AllowClobber
        Write-Host "  ✓ $module installed" -ForegroundColor Green
    } else {
        Write-Host "  ✓ $module is already installed" -ForegroundColor DarkGray
    }
}

# 3. Check for Oh-My-Posh
if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    Write-Host "`n🎨 Oh-My-Posh is not detected." -ForegroundColor Yellow
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "Installing Oh-My-Posh via winget..." -ForegroundColor Cyan
        winget install JanDeDobbeleer.OhMyPosh -s winget --accept-source-agreements --accept-package-agreements
    } else {
        Write-Host "Installing Oh-My-Posh via PowerShell script..." -ForegroundColor Cyan
        Set-ExecutionPolicy Bypass -Scope Process -Force
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
    }
} else {
    Write-Host "✓ Oh-My-Posh is already installed" -ForegroundColor Green
}

# 4. Check for fzf (required for PSFzf)
if (-not (Get-Command fzf -ErrorAction SilentlyContinue)) {
    Write-Host "`n🔍 fzf is not detected (recommended for PSFzf)." -ForegroundColor Yellow
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "Installing fzf via winget..." -ForegroundColor Cyan
        winget install junegunn.fzf -s winget --accept-source-agreements --accept-package-agreements
    }
} else {
    Write-Host "✓ fzf is already installed" -ForegroundColor Green
}

Write-Host "`n🎉 All PowerShell modules and prerequisites installed successfully!" -ForegroundColor Cyan
