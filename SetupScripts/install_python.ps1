$PackageHumanName = "Python-2.7"
$PackageInstalledCheck = 'C:\Python27\python.exe'  # If path exists, exit the script

$PackageUrl = 'https://www.python.org/ftp/python/2.7.11/python-2.7.11.msi'
$PackageDownloadPath = 'c:\vagrant\Downloads'
$PackageInstallerFileName = 'python-2.7.11.msi'
$PackageInstallerFilePath = Join-Path $PackageDownloadPath $PackageInstallerFileName
$PackageInstallerArguments = "/qn"
$PackageInstallerExecutable = "$PackageInstallerFileName"

function Package_Postinstall_Hook {
    # Add python to PATH
    $PATH = [Environment]::GetEnvironmentVariable("PATH")
    $package_path = "C:\Python27;C:\Python27\Scripts"
    if( $PATH -notlike "*"+$package_path+"*" ){
       [Environment]::SetEnvironmentVariable("PATH", "$PATH;$package_path", "Machine")
    }
    $PATH = [Environment]::GetEnvironmentVariable("PATH")
}

. C:\vagrant\SetupScripts\functions.ps1

Package_Install
