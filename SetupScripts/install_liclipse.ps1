$PackageHumanName = "LiClipse"
$PackageInstalledCheck = 'C:\Program Files\Brainwy\LiClipse 3.0.3\LiClipse.exe'  # If path exists, exit the script

$PackageUrl = 'https://googledrive.com/host/0BwwQN8QrgsRpLVlDeHRNemw3S1E/LiClipse%203.0.3/liclipse_3.0.3_win32.x86.exe'
$PackageDownloadPath = 'c:\vagrant\Downloads'
$PackageInstallerFileName = 'liclipse_3.0.3_win32.x86.exe'
$PackageInstaller = Join-Path $PackageDownloadPath $PackageInstallerFileName


function Is64Bit {  [IntPtr]::Size -eq 8  }

function Package_Install {
  Write-Host "Ensuring `'$PackageHumanName`' is installed..."
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
    $psi.Arguments = "/SILENT /LOG C:\vagrant\Logs\$PackageHumanName.txt"
    #$psi.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Minimized;

    Write-Host "Installing `'$PackageInstaller`'"
    $s = [System.Diagnostics.Process]::Start($psi);
    $s.WaitForExit();
    # if ($s.ExitCode -ne 0) {
    #   Write-Error ".NET Framework install failed with exit code `'$($s.ExitCode)`'."
    # }

    Write-Host "Copying basic LiClipse configuration"
    Copy-Item "C:\vagrant\Configs\LiClipse Workspace" C:\Users\IEUser\Documents -recurse
  } else {
    Write-Host "The package `'$PackageHumanName`' is already installed."
  }
}

Package_Install