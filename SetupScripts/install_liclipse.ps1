$PackageHumanName = "LiClipse"
$PackageInstalledCheck = 'C:\Program Files\Brainwy\LiClipse 3.0.3\LiClipse.exe'  # If path exists, exit the script

$PackageUrl = 'https://googledrive.com/host/0BwwQN8QrgsRpLVlDeHRNemw3S1E/LiClipse%203.0.3/liclipse_3.0.3_win32.x86.exe'
$PackageDownloadPath = 'c:\vagrant\Downloads'
$PackageInstallerFileName = 'liclipse_3.0.3_win32.x86.exe'
$PackageInstallerFilePath = Join-Path $PackageDownloadPath $PackageInstallerFileName
$PackageInstallerArguments = "/SILENT /LOG C:\vagrant\Logs\$PackageHumanName.txt"
$PackageInstallerExecutable = "$PackageInstallerFileName"

function Package_Postinstall_Hook {
    Write-Host "Copying basic LiClipse configuration"
    Copy-Item "C:\vagrant\Configs\LiClipse Workspace" C:\Users\IEUser\Documents -recurse
}

. C:\vagrant\SetupScripts\functions.ps1

Package_Install