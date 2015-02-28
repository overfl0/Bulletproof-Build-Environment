rem Copy the script to a place that can be accessed both by the user and the administrator
rem and then run it with powershell
rem ================================================

set directory="%homedrive%%homepath%\Documents"
set script_name="enable_winrm.ps1"

copy "%cd%\%script_name%" "%directory%"
Powershell.exe -ExecutionPolicy bypass -File "%directory%\\%script_name%"
pause
