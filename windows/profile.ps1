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

# Path variables
#

# PowerShell Profile
# Windows Environment Only
#
$myProfile = "C:\Users\a1060303\OneDrive - Alight Solutions\Documents\WindowsPowerShell\profile.ps1"

# Windows Terminal Settings
# Windows Environment Only
#
$termSettings = "C:\Users\a1060303\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

# Start shell prompt
#
Invoke-Expression (&starship init powershell)

# Clear the PowerShell starting information
#
#Clear-Host
