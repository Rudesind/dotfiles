<#
    Profile: MyProfile.ps1
    Author : Rudesind <rudesind76@gmail.com>
#>

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

# Drive for ServiceNow Development
#
New-PSDrive -Name sndev -PSProvider FileSystem -Root "~/urmstores.onmicrosoft.com\ServiceNow - Documents\Development" > $null

# New-PSDrive -Name git -PSProvider FileSystem -Root "C:\Users\zach2\git" > $null
# New-PSDrive -Name CMDocs -PSProvider FileSystem -Root "C:\Users\zach2\urmstores.onmicrosoft.com\Configuration Management - Documents" > $null

<#
# Create working directory to config management docs
#
New-PSDrive -Name CMDocs -PSProvider FileSystem -Root "C:\Users\zach2\urmstores.onmicrosoft.com\Configuration Management - Documents" 

New-PSDrive -Name CMImages -PSProvider FileSystem -Root "C:\Users\zach2\urmstores.onmicrosoft.com\Enterprise Imaging - Documents"

New-PSDrive -Name CMPatching -PSProvider FileSystem -Root "C:\Users\zach2\urmstores.onmicrosoft.com\Enterprise Patching - Documents"
#>


# Clear the PowerShell starting information
#
Clear-Host
Invoke-Expression (&starship init powershell)
