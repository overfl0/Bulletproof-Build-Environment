$PackageHumanName = "Libtorrent"
$PackageInstalledCheck = 'C:\Python27\Lib\site-packages\libtorrent.pyd'  # If path exists, exit the script

$PackageUrl = 'https://github.com/arvidn/libtorrent/releases/download/libtorrent-1_0_9/python-libtorrent-1.0.9.win32.msi'
$PackageDownloadPath = 'c:\vagrant\Downloads'
$PackageInstallerFileName = 'python-libtorrent-1.0.9.win32.msi'
$PackageInstallerFilePath = Join-Path $PackageDownloadPath $PackageInstallerFileName
$PackageInstallerArguments = "/quiet /log C:\vagrant\Logs\$PackageHumanName.txt /i $PackageInstallerFileName TARGETDIR=C:\Python27"
$PackageInstallerExecutable = "msiexec.exe"

function Package_Postinstall_Hook {}

. C:\vagrant\SetupScripts\functions.ps1

Package_Install