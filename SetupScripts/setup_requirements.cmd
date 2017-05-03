@set "powershell_call=@powershell -NoProfile -ExecutionPolicy Bypass -File"
@set "pip=cmd /c c:\Python27\python.exe -m pip"

@rem Run all the files from c:\vagrant\SetupScripts\%%s in that order:
@for %%s in (
    install_python.ps1
    install_libtorrent.ps1
    install_liclipse.ps1
    install_msysgit.ps1
    install_notepadpp.ps1
    install_conemu.ps1
) do %powershell_call%  "c:\vagrant\SetupScripts\%%s"

@echo Reloading environment variables for git to work
call C:\vagrant\SetupScripts\reload_env_variables.bat

@echo Ensuring all python required modules are installed...



@rem Requirements for compiling Kivy 1.9.2
%pip% install wheel setuptools

copy c:\vagrant\Configs\compiling_kivy\distutils.cfg c:\Python27\Lib\distutils\distutils.cfg
%pip% install -i https://pypi.anaconda.org/carlkl/simple mingwpy

set USE_SDL2=1
set USE_GSTREAMER=0
%pip% install cython docutils pygments pypiwin32 kivy.deps.sdl2 kivy.deps.glew kivy.deps.glew_dev kivy.deps.sdl2_dev
@rem End of requirements for compiling Kivy 1.9.2


@rem Compiling own Kivy 1.9.2 (from 2017-05-03 with own patches)
%pip% install git+git://github.com/overfl0/kivy@1c039664cffa2b0974a75dddc6e3ea51273faa66

%pip% install --upgrade -r c:\Vagrant\Configs\requirements.txt
@rem cmd /c C:\vagrant\SetupScripts\patch_python.bat
copy c:\vagrant\SetupScripts\clone_bulletproof.bat c:\

msg IEUser "All the tools should be installed now. Look at the vagrant window and MAKE SURE THERE WAS NO ERROR IN THE PROCESS!!! You may have to reboot your computer."
