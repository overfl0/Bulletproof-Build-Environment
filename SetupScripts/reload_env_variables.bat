@rem http://stackoverflow.com/questions/171588/is-there-a-command-to-refresh-environment-variables-from-the-command-prompt-in-w

call C:\vagrant\SetupScripts\create_path_reloading_script.vbs
call "%TEMP%\resetvars.bat"
