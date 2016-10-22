$PackageHumanName = "Msysgit"
$PackageInstalledCheck = 'C:\Program Files\Git\bin\git.exe'  # If path exists, exit the script

$PackageUrl = 'https://github.com/git-for-windows/git/releases/download/v2.10.1.windows.1/Git-2.10.1-32-bit.exe'
$PackageDownloadPath = 'c:\vagrant\Downloads'
$PackageInstallerFileName = 'Git-2.10.1-32-bit.exe'
$PackageInstallerFilePath = Join-Path $PackageDownloadPath $PackageInstallerFileName
$PackageInstallerArguments = "/SILENT /LOADINF=c:\vagrant\Configs\git_install_config.inf"
$PackageInstallerExecutable = "$PackageInstallerFileName"

. C:\vagrant\SetupScripts\functions.ps1

Package_Install