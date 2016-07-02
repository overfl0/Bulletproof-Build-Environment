set "powershell_call=@powershell -NoProfile -ExecutionPolicy Bypass -File"

echo Ensuring python is installed...
%powershell_call% "c:\vagrant\SetupScripts\install_python.ps1"

echo Ensuring libtorrent-python is installed...
%powershell_call% "c:\vagrant\SetupScripts\install_libtorrent.ps1"

echo Ensuring LiClipse is installed...
%powershell_call% "c:\vagrant\SetupScripts\install_liclipse.ps1"

echo Ensuring msysgit is installed...
%powershell_call% "c:\vagrant\SetupScripts\install_msysgit.ps1"

echo Ensuring Notepad++ is installed...
%powershell_call% "c:\vagrant\SetupScripts\install_notepadpp.ps1"

echo Reloading environment variables for git to work
call C:\vagrant\SetupScripts\reload_env_variables.bat

echo Ensuring all python required modules are installed...
cmd /c c:\Python27\python.exe -m pip install --upgrade -r c:\Vagrant\Configs\requirements.txt

cmd /c C:\vagrant\SetupScripts\patch_python.bat

copy c:\vagrant\SetupScripts\clone_tacbf_launcher.bat c:\

msg IEUser " All the tools should be installed now. You may have to reboot your computer."
