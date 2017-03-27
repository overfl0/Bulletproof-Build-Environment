@echo off
set "psCommand=powershell -Command "$pword = read-host 'Enter Password' -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
        [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set password=%%p

@rem Get signtool at: https://www.microsoft.com/en-us/download/details.aspx?id=8279
signtool.exe sign /f Signature.p12 /p %password% /t http://time.certum.pl Frontline.exe
timeout 2
signtool.exe sign /f Signature.p12 /p %password% /t http://time.certum.pl TB_Launcher.exe
