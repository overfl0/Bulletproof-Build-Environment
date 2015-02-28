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

echo Ensuring msysgit is installed...
%notifu_call% "Ensuring msysgit is installed..."
%powershell_call% "c:\vagrant\SetupScripts\install_msysgit.ps1"

echo Ensuring Notepad++ is installed...
%notifu_call% "Ensuring Notepad++ is installed..."
%powershell_call% "c:\vagrant\SetupScripts\install_notepadpp.ps1"

echo Ensuring pyinstaller, futures and pylzma are installed...
%notifu_call% "Ensuring pyinstaller, futures and pylzma are installed..."
cmd /c C:\Kivy-1.8.0-py2.7-win32\kivy.bat -m pip install pyinstaller futures "c:\\vagrant\\Downloads\\pylzma-0.4.6-cp27-none-win32.whl"

msg IEUser " All the tools should be installed now."
%notifu_call% "All the tools should be installed and working now" /p " complete!" /d 100000
