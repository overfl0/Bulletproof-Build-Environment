function Package_Install {
  Write-Host "***** Ensuring `'$PackageHumanName`' is installed... *****"

  if(!(test-path "$PackageInstalledCheck")) {
    # Check if the download directory is present
    if (!(Test-Path $PackageDownloadPath)) {
      Write-Host "Creating folder `'$PackageDownloadPath`'"
      $null = New-Item -Path "$PackageDownloadPath" -ItemType Directory
    }

    # Download the file
    if (!(Test-Path $PackageInstallerFilePath)) {
      Write-Host "Downloading `'$PackageUrl`' to `'$PackageInstallerFilePath`'"
      (New-Object Net.WebClient).DownloadFile("$PackageUrl","$PackageInstallerFilePath")
    } else {
      Write-Host "NOT downloading `'$PackageHumanName`'  as it already is downloaded in `'$PackageInstallerFilePath`'"
    }

    # Run the actual installer
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.WorkingDirectory = "$PackageDownloadPath"
    $psi.FileName = "$PackageInstallerExecutable"
    $psi.Arguments = "$PackageInstallerArguments"
    #$psi.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Minimized;

    Write-Host "Installing `'$PackageInstallerFilePath`'"
    $s = [System.Diagnostics.Process]::Start($psi);
    $s.WaitForExit();
    # if ($s.ExitCode -ne 0) {
    #   Write-Error ".NET Framework install failed with exit code `'$($s.ExitCode)`'."
    # }

    Package_Postinstall_Hook

  } else {
    Write-Host "The package `'$PackageHumanName`' is already installed."
  }
}
