set patch="C:\Program Files\Git\bin\patch.exe"
set patches_dir=c:\vagrant\Patches
set python_dir=C:\Python27\Lib\site-packages

%patch% -p1 -N --input=%patches_dir%\0001_kivy_unicode_home_dir.patch %python_dir%\kivy\__init__.py

@rem Patch for Kivy-1.9.1 (should already be in 1.9.2)
@rem https://github.com/kivy/kivy/commit/b1b5da3f0dd38848302703d7c2347e22682c0649
@rem https://github.com/kivy/kivy/commit/e75575c2a58a71e9481628045111ddad94ed19e8
%patch% -p1 -N --input=%patches_dir%\0002_filechooser_dirselect.patch %python_dir%\kivy\uix\filechooser.py
