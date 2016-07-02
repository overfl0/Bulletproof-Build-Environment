$PackageHumanName = "Notepad++"
$PackageInstalledCheck = 'C:\Program Files\Notepad++\notepad++.exe'  # If path exists, exit the script

$PackageUrl = 'https://notepad-plus-plus.org/repository/6.x/6.9.2/npp.6.9.2.Installer.exe'
$PackageDownloadPath = 'c:\vagrant\Downloads'
$PackageInstallerFileName = 'npp.6.9.2.Installer.exe'
$PackageInstallerFilePath = Join-Path $PackageDownloadPath $PackageInstallerFileName
$PackageInstallerArguments = "/S"
$PackageInstallerExecutable = "$PackageInstallerFileName"

function Package_Postinstall_Hook {
    Write-Host "Copying basic Notepad++ configuration"
    Copy-Item C:\vagrant\Configs\Notepad++\config.xml C:\Users\IEUser\AppData\Roaming\Notepad++
}

. C:\vagrant\SetupScripts\functions.ps1

Package_Install