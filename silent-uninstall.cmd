@echo off
setlocal EnableDelayedExpansion
set path=%path%;%~dp0
set sw=HKLM\SOFTWARE
set u=Microsoft\Windows\CurrentVersion\Uninstall
set n=PDFCreator
set k={0001B4FD-9EA3-4D90-A79E-FD14BA3AB01D}
reg query "%sw%\%u%\%k%" > nul 2>&1
if !errorlevel!==0 (
echo %n% found at version:
reg query "%sw%\%u%\%k%" /v DisplayVersion | find "DisplayVersion"
echo Now uninstalling..
for /f "tokens=*" %%a in ('^
reg query "%sw%\%u%\%k%" /v UninstallString ^|
findstr "UninstallString" ^|
sed "s/UninstallString\|REG_SZ//g" ^|
sed "s/^[ \t]*//g" ^|
sed "s/\d034//g"') do (
echo Uninstalling %n%..
start /wait "" "%%a" /VERYSILENT /NORESTART
)
)
:CheckUninstallKey
reg query "%sw%\%u%\%k%" > nul 2>&1
if !errorlevel!==0 goto CheckUninstallKey
endlocal
