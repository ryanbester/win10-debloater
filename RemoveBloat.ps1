<#  
.SYNOPSIS  
    Removes most of Windows 10 bloatware.
.DESCRIPTION  
    This script removes most of the bloatware shipped with Windows 10,
    including Cortana. Microsoft Edge is a virus and cannot be removed (easily).
.NOTES  
    File Name : RemoveBloat.ps1
    Author    : Ryan Bester
.LINK
    https://github.com/ryanbester/win10-debloater
#>

$pkgNames = @(
    'Microsoft.WindowsAlarm',
    'Microsoft.WindowsCamera',
    'microsoft.windowscommunicationsapps',
    'Microsoft.GetHelp',
    'Microsoft.ZuneMusic',
    'Microsoft.ZuneVideo',
    'Microsoft.WindowsMaps',
    'Microsoft.MicrosoftEdge', # Doesn't work
    'Microsoft.MicrosoftEdge.Stable', # Doesn't work
    'Microsoft.MixedReality',
    'Microsoft.Office.OneNote',
    'Microsoft.MSPaint',
    'Microsoft.People',
    'Microsoft.MicrosoftStickyNotes',
    'Microsoft.Getstarted',
    'Microsoft.WindowsSoundRecorder',
    'Microsoft.BingWeather',
    'Microsoft.MicrosoftSolitaireCollection',
    'Microsoft.SkypeApp',
    'Microsoft.WindowsFeedbackHub',
    'Microsoft.YourPhone',
    'Microsoft.549981C3F5F10' # CORTANA
)

$count = 0
foreach ( $pkgName in $pkgNames )
{
    $pkg = Get-AppxPackage | Where-Object Name -Match ".*$pkgName.*"

    if ($null -eq $pkg)
    {
        Write-Output "Package $pkgName has already been uninstalled."
        continue
    }


    $pkgFullName = Select-Object -InputObject $pkg -Property PackageFullName | ForEach-Object {$_.PackageFullName}
    try {
        Remove-AppxPackage "$pkgFullName"
    } catch {
        Write-Output "Error removing package: ${pkgName}: $_"
        continue
    }
    Write-Output "Removed package $pkgFullName"

    $count++
}

Write-Output "`n"
Write-Output "Removed $count packages successfully."
