set "powershell_call=@powershell -NoProfile -ExecutionPolicy Bypass -File"
set "notifu_call=START /B C:\Notifu\notifu.exe /w /p Provisioning /m"

echo Ensuring notifu is installed...
%powershell_call% "c:\vagrant\SetupScripts\install_notifu.ps1"

echo Ensuring Kivy is installed...
%notifu_call% "Ensuring Kivy is installed..."
%powershell_call% "c:\vagrant\SetupScripts\install_kivy.ps1"

echo Ensuring libtorrent-python is installed...
%notifu_call% "Ensuring libtorrent-python is installed..."
%powershell_call% "c:\vagrant\SetupScripts\install_libtorrent.ps1"

echo Ensuring LiClipse is installed...
%notifu_call% "Ensuring LiClipse is installed..."
%powershell_call% "c:\vagrant\SetupScripts\install_liclipse.ps1"

echo Ensuring msysgit is installed...
%notifu_call% "Ensuring msysgit is installed..."
%powershell_call% "c:\vagrant\SetupScripts\install_msysgit.ps1"

echo Ensuring Notepad++ is installed...
%notifu_call% "Ensuring Notepad++ is installed..."
%powershell_call% "c:\vagrant\SetupScripts\install_notepadpp.ps1"

echo Reloading environment variables for git to work
call C:\vagrant\SetupScripts\reload_env_variables.bat

echo Ensuring pyinstaller, futures, nose and pylzma are installed...
%notifu_call% "Ensuring pyinstaller, futures, nose, mock and pylzma are installed..."
cmd /c C:\Kivy-1.8.0-py2.7-win32\kivy.bat -m pip install -r c:\Vagrant\Configs\requirements.txt

copy c:\vagrant\SetupScripts\clone_tacbf_launcher.bat c:\

%notifu_call% "All the tools should be installed and working now" /p " complete!" /d 100000
msg IEUser " All the tools should be installed now. You may have to reboot your computer."
