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

# Set Aliases
#

# Shows hidden and system files on ls command
#
Function listDir {Get-ChildItem -Force}
Set-Alias -Name ls -Value listDir -Option AllScope

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

# Dotfiles config function
#
function gitConfig {git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $args}
New-Alias -Name config -Value gitConfig

# Path variables
#

# Start shell prompt
#
Invoke-Expression (&starship init powershell)

# Clear the PowerShell starting information
#
#Clear-Host
