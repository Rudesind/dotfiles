################################################################################
#  ___  ________  __________  ________   ___
# |   \ \       \ \        / /       / /   |
# |    \ \       \ \      / /_______/ /    |
# |     \ \       \ \    / ________  /     |
# |      \ \       \ \  / /       / /      |
# |_______\ \_______\ \/ /_______/ /_______|
#
# my config.
################################################################################


# Set the location of the terminal to root
#
set-location $home > $null

# Enable Vi mode
# 
# Set-PSReadlineOption -EditMode vi

# Chocolatey profile
#
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

# Quick way to get out of the current directory
#
New-Alias -Name .. -Value cd..

# Opens explorer window in current folder
#
Function openEx {ii .}
New-Alias -Name op -Value openEx

# Open home directory
#
function openHome {cd ~/}
New-Alias -Name home -Value openHome

# Create symbolic link
#
function createLink {param($link,$target) ni -p $link -it symboliclink -v $target}
New-Alias -Name ln -Value createLink

# Tries to emulate "sudo"
#
function runAsAdmin {param($arg) Start-Process -Verb RunAs powershell.exe -Args $arg}
New-Alias -Name sudo -value runAsAdmin

# PowerShell Profile
# Windows Environment Only
#
$myProfile = "$HOME/Documents/WindowsPowerShell/profile.ps1"

# Windows Terminal Settings
# Windows Environment Only
#
$termSettings = "$HOME/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"

# Startup folder
$startup = "$HOME/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"

# Function for managing bare bones config
#
function gitConfig {git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $args}
New-Alias -Name config -Value gitConfig

# Start shell prompt
#
Invoke-Expression (&starship init powershell)
