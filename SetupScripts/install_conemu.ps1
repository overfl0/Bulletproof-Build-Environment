$PackageHumanName = "ConEmu"
$PackageInstalledCheck = 'C:\Program Files\ConEmu\ConEmu.exe'  # If path exists, exit the script

$PackageUrl = 'https://github.com/Maximus5/ConEmu/releases/download/v16.06.19/ConEmuSetup.160619.exe'
$PackageDownloadPath = 'c:\vagrant\Downloads'
$PackageInstallerFileName = 'ConEmuSetup.160619.exe'
$PackageInstallerFilePath = Join-Path $PackageDownloadPath $PackageInstallerFileName
$PackageInstallerArguments = "/p:x86,adm /log c:\vagrant\Logs\conemu.txt /qn"
$PackageInstallerExecutable = "$PackageInstallerFileName"

. C:\vagrant\SetupScripts\functions.ps1

Package_Install
