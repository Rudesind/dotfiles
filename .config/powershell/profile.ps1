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

# Clear the PowerShell starting information
#
#Clear-Host
Invoke-Expression (&starship init powershell)
