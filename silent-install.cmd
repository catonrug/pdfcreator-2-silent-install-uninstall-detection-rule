@echo off
set path=%path%;%~dp0
setlocal EnableDelayedExpansion
set sw=HKLM\SOFTWARE
set u=Microsoft\Windows\CurrentVersion\Uninstall
set n=PDFCreator
set k={0001B4FD-9EA3-4D90-A79E-FD14BA3AB01D}
reg query "%sw%\%u%\%k%" > nul 2>&1
if not !errorlevel!==0 (
for /f %%a in ('^
dir /b "%~dp0%n%*.exe" ^|
tail -1') do (
echo using file %%a as source
"%~dp0%%a" /ForceInstall /VERYSILENT /LANG=English /COMPONENTS="program,ghostscript" /NORESTART
)
) else echo %n% is already installed
endlocal
pause
