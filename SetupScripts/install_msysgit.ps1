$PackageHumanName = "Msysgit"
$PackageInstalledCheck = 'C:\Program Files\Git\bin\git.exe'  # If path exists, exit the script

$PackageUrl = 'https://github.com/msysgit/msysgit/releases/download/Git-1.9.5-preview20141217/Git-1.9.5-preview20141217.exe'
$PackageDownloadPath = 'c:\vagrant\Downloads'
$PackageInstallerFileName = 'Git-1.9.5-preview20141217.exe'
$PackageInstallerFilePath = Join-Path $PackageDownloadPath $PackageInstallerFileName
$PackageInstallerArguments = "/SILENT /LOADINF=c:\vagrant\Configs\git_install_config.inf"
$PackageInstallerExecutable = "$PackageInstallerFileName"

. C:\vagrant\SetupScripts\functions.ps1

Package_Install