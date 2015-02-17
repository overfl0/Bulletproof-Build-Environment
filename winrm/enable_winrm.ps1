##################################################################################################
# Run as Administrator
##################################################################################################
# http://blogs.msdn.com/b/virtual_pc_guy/archive/2010/09/23/a-self-elevating-powershell-script.aspx

# Get the ID and security principal of the current user account
$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
 
# Get the security principal for the Administrator role
$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator
 
# Check to see if we are currently running "as Administrator"
if ($myWindowsPrincipal.IsInRole($adminRole))
   {
   # We are running "as Administrator" - so change the title and background color to indicate this
   $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)"
   $Host.UI.RawUI.BackgroundColor = "DarkBlue"
   clear-host
   }
else
   {
   # We are not running "as Administrator" - so relaunch as administrator
   
   # Create a new process object that starts PowerShell
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   
   # Specify the current script path and name as a parameter
   $newProcess.Arguments = "-noexit -ExecutionPolicy bypass " + $myInvocation.MyCommand.Definition;
   
   # Indicate that the process should be elevated
   $newProcess.Verb = "runas";
   
   # Start the new process
   [System.Diagnostics.Process]::Start($newProcess);
   
   # Exit from the current, unelevated, process
   exit
   }
##################################################################################################


# make all networks private
# Needed to enable WinRM
$nlm = [Activator]::CreateInstance([Type]::GetTypeFromCLSID([Guid]"{DCB00C01-570F-4A9B-8D69-199FDBA5723B}"))
$connections = $nlm.getnetworkconnections()
$connections |foreach {
  if ($_.getnetwork().getcategory() -eq 0)
  {
      $_.getnetwork().setcategory(1)
  }
}

# Enable WinRm
Enable-PSRemoting -Force


# Configure WinRM
get-service winrm
Enable-PSRemoting -force
winrm qc -q  
winrm set winrm/config/client '@{TrustedHosts="*"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="2048"}'
winrm set winrm/config/winrs '@{MaxConcurrentUsers="100"}'
winrm set winrm/config/winrs '@{AllowRemoteShellAccess="True"}'
winrm set winrm/config '@{MaxTimeoutms="604800000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'


# Set Windows Remoting service to start "Automatic" and not "Automatic (delayed)"
cmd /c "sc config winrm start= auto"


# Restarting the computer so provisioning can start through WinRM
# Write-Host ""
# Write-Host ""
# Write-Host "*******************************************"
# Write-Host "Restarting the computer in 10 seconds"
# Write-Host "Press Ctrl+C if you want to prevent restart"
# Write-Host "*******************************************"
# sleep 10; Restart-Computer
