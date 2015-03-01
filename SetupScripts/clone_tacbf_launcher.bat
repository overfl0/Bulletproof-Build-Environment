@echo off

echo "Preparing to clone the repository"
set /P username="Enter your bitbucket username: "

"C:\Program Files\Git\bin\git.exe" clone https://%username%@bitbucket.org/sighter/tacbf-launcher.git
pause
