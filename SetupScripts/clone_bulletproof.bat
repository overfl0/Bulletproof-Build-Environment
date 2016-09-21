@echo off

echo "Preparing to clone the repository"
set /P username="Enter your Github username: "

"C:\Program Files\Git\bin\git.exe" clone https://%username%@github.com/overfl0/Bulletproof-Arma-Launcher.git Bulletproof
pause
