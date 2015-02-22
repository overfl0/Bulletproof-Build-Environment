$PackageHumanName = "Notepad++"
$PackageInstalledCheck = 'C:\Program Files\Notepad++\notepad++.exe'  # If path exists, exit the script

$PackageUrl = 'http://download.tuxfamily.org/notepadplus/6.7.4/npp.6.7.4.Installer.exe'
$PackageDownloadPath = 'c:\vagrant\Downloads'
$PackageInstallerFileName = 'npp.6.7.4.Installer.exe'
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
    $psi.Arguments = "/S"
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