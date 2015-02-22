$PackageHumanName = "Kivy"
$PackageInstalledCheck = 'C:\Kivy-1.8.0-py2.7-win32'  # If path exists, exit the script

$PackageUrl = 'http://kivy.org/downloads/1.8.0/Kivy-1.8.0-py2.7-win32.zip'
$PackageDownloadPath = 'c:\vagrant\Downloads'
$PackageInstallerFileName = 'Kivy-1.8.0-py2.7-win32.zip'
$PackageInstaller = Join-Path $PackageDownloadPath $PackageInstallerFileName


function Is64Bit {  [IntPtr]::Size -eq 8  }

function Expand-ZIPFile($file, $destination)
{
  $shell = new-object -com shell.application
  $zip = $shell.NameSpace($file)

  foreach($item in $zip.items())
  {
    $shell.Namespace($destination).copyhere($item)
  }
}

function Package_Install {
  # if(Is64Bit) {$fx="framework64"} else {$fx="framework"}

  if(!(test-path "$PackageInstalledCheck")) {
    # Check if the download directory is present
    if (!(Test-Path $PackageDownloadPath)) {
      Write-Host "Creating folder `'$PackageDownloadPath`'"
      $null = New-Item -Path "$PackageDownloadPath" -ItemType Directory
    }

    # Download the file
    if (!(Test-Path $PackageInstaller)) {
      Write-Host "Downloading `'$PackageUrl`' to `'$PackageInstaller`'"
      (New-Object Net.WebClient).DownloadFile("$PackageUrl","$PackageInstaller")
    } else {
      Write-Host "NOT downloading `'$PackageHumanName`'  as it already is downloaded in `'$PackageInstaller`'"
    }
    
    Write-Host "Unzipping $PackageInstallerFileName. This will take a LONG time!"
    $null = New-Item -Path "$PackageInstalledCheck" -ItemType Directory  # Create dir
    Expand-ZIPFile -File "$PackageInstaller" -Destination "$PackageInstalledCheck"

    } else {
    Write-Host "The package `'$PackageHumanName`' is already installed."
  }
}

Package_Install