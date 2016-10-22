$PackageHumanName = "LiClipse"
$PackageInstalledCheck = 'C:\Program Files\Brainwy\LiClipse 3.1.0\LiClipse.exe'  # If path exists, exit the script

$PackageUrl = 'http://update.liclipse.com/standalone/liclipse_3.1.0_win32.x86.exe'
$PackageDownloadPath = 'c:\vagrant\Downloads'
$PackageInstallerFileName = 'liclipse_3.1.0_win32.x86.exe'
$PackageInstallerFilePath = Join-Path $PackageDownloadPath $PackageInstallerFileName
$PackageInstallerArguments = "/SILENT /LOG C:\vagrant\Logs\$PackageHumanName.txt"
$PackageInstallerExecutable = "$PackageInstallerFileName"

function Package_Postinstall_Hook {
    Write-Host "Copying basic LiClipse configuration"
    Copy-Item "C:\vagrant\Configs\LiClipse Workspace" C:\Users\IEUser\Documents -recurse
}

. C:\vagrant\SetupScripts\functions.ps1

Package_Install