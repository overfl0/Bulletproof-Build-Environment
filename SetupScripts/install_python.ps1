$PackageHumanName = "Python-2.7"
$PackageInstalledCheck = 'C:\Python2.7\python.exe'  # If path exists, exit the script

$PackageUrl = 'https://www.python.org/ftp/python/2.7.11/python-2.7.11.msi'
$PackageDownloadPath = 'c:\vagrant\Downloads'
$PackageInstallerFileName = 'python-2.7.11.msi'
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
      (New-Object Net.WebClient).DownloadFile("$PackageUrl","$PackageInstaller")
    } else {
      Write-Host "NOT downloading `'$PackageHumanName`'  as it already is downloaded in `'$PackageInstaller`'"
    }

    # Run the actual installer
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.WorkingDirectory = "$PackageDownloadPath"
    $psi.FileName = "$PackageInstallerFileName"
    $psi.Arguments = "/qn"
    #$psi.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Minimized;

    Write-Host "Installing `'$PackageInstaller`'"
    $s = [System.Diagnostics.Process]::Start($psi);
    $s.WaitForExit();
    # if ($s.ExitCode -ne 0) {
    #   Write-Error ".NET Framework install failed with exit code `'$($s.ExitCode)`'."
    # }

    # Add python to PATH
    $PATH = [Environment]::GetEnvironmentVariable("PATH")
    $package_path = "C:\Python27;C:\Python27\Scripts"
    if( $PATH -notlike "*"+$package_path+"*" ){
       [Environment]::SetEnvironmentVariable("PATH", "$PATH;$package_path", "Machine")
    }
    $PATH = [Environment]::GetEnvironmentVariable("PATH")

  } else {
    Write-Host "The package `'$PackageHumanName`' is already installed."
  }
}

Package_Install
