$PackageHumanName = "Pylzma"
$PackageInstalledCheck = 'c:\vagrant\Downloads\pylzma-0.4.6-cp27-none-win32.whl'  # If path exists, exit the script

$PackageUrl = 'http://www.lfd.uci.edu/~gohlke/pythonlibs/fnaifn4u/pylzma-0.4.6-cp27-none-win32.whl'
$PackageDownloadPath = 'c:\vagrant\Downloads'
$PackageInstallerFileName = 'pylzma-0.4.6-cp27-none-win32.whl'
$PackageInstaller = Join-Path $PackageDownloadPath $PackageInstallerFileName


function Is64Bit {  [IntPtr]::Size -eq 8  }

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

      $request = (New-Object Net.WebClient)
      $request.headers['User-Agent'] = "User-Agent: Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)"
      $request.DownloadFile("$PackageUrl","$PackageInstaller")
    } else {
      Write-Host "NOT downloading `'$PackageHumanName`'  as it already is downloaded in `'$PackageInstaller`'"
    }
  } else {
    Write-Host "The package `'$PackageHumanName`' is already downloaded."
  }
}

Package_Install