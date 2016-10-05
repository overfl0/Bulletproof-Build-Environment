@set "powershell_call=@powershell -NoProfile -ExecutionPolicy Bypass -File"

@rem Skip the following if running on an Appveyor instance (as they are already installed)
if "%APPVEYOR%" == "True" goto :APPVEYOR

@rem Run all the files from c:\vagrant\SetupScripts\%%s in that order:
@for %%s in (
    install_python.ps1
    install_liclipse.ps1
    install_msysgit.ps1
    install_notepadpp.ps1
    install_conemu.ps1
) do %powershell_call%  "c:\vagrant\SetupScripts\%%s"

@echo Reloading environment variables for git to work
call C:\vagrant\SetupScripts\reload_env_variables.bat

:APPVEYOR

@rem Run all the files from c:\vagrant\SetupScripts\%%s in that order:
@for %%s in (
    install_libtorrent.ps1
) do %powershell_call%  "c:\vagrant\SetupScripts\%%s"

@echo Ensuring all python required modules are installed...
cmd /c c:\Python27\python.exe -m pip install --upgrade -r c:\Vagrant\Configs\requirements.txt
cmd /c C:\vagrant\SetupScripts\patch_python.bat
copy c:\vagrant\SetupScripts\clone_bulletproof.bat c:\

rem msg IEUser " All the tools should be installed now. You may have to reboot your computer."
