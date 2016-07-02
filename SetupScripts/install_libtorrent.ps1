$PackageHumanName = "Libtorrent"
$PackageInstalledCheck = 'C:\Python27\Lib\site-packages\libtorrent.pyd'  # If path exists, exit the script

$PackageUrl = 'https://github.com/arvidn/libtorrent/releases/download/libtorrent-1_0_9/python-libtorrent-1.0.9.win32.msi'
$PackageDownloadPath = 'c:\vagrant\Downloads'
$PackageInstallerFileName = 'python-libtorrent-1.0.9.win32.msi'
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
    $psi.FileName = "msiexec.exe"
    $psi.Arguments = "/quiet /log C:\vagrant\Logs\$PackageHumanName.txt /i $PackageInstallerFileName TARGETDIR=C:\Python27"
    #$psi.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Minimized;

    Write-Host "Installing `'$PackageInstaller`'"
    $s = [System.Diagnostics.Process]::Start($psi);
    $s.WaitForExit();
    # if ($s.ExitCode -ne 0) {
    #   Write-Error ".NET Framework install failed with exit code `'$($s.ExitCode)`'."
    # }

  } else {
    Write-Host "The package `'$PackageHumanName`' is already installed."
  }
}

Package_Install