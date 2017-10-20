@echo off
%windir%\system32\reg.exe query "HKU\S-1-5-19" 1>nul 2>nul || (set MESSAGE=ERROR: Run %~nx0 as administrator&goto :END)
if exist "%windir%\winsxs\pending.xml" (set MESSAGE=pending update operation detected, restart the system first to clear it&goto :END)

pushd "%~dp0" 

dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~3*.mum >list_temp.txt 
dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~3*.mum >>list_temp.txt 

for /f %%i in ('findstr /i . list_temp.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"
del list_temp.txt

:END
echo Press any key to exit.
pause >nul
goto :EOF
