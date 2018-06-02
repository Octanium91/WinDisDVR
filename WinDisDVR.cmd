@echo off

:LANG
for /f "tokens=3" %%a in ('reg query "HKEY_CURRENT_USER\Control Panel\International" /v Locale') do set "LANGKB=%%a"
if %LANGKB% == 00000409 goto LANG_ENG
if %LANGKB% == 00000419 goto LANG_RUS
if %LANGKB% == 00000422 goto LANG_RUS
goto LANG_ENG
:LANG_END

:ACCESS
set "RMA=%RANDOM%"
set "RMB=%RANDOM%"
mkdir "%WINDIR%\CHECK_ADMIN_ACCESS_%RMA%%RMB%"
if %ERRORLEVEL% == 1 (set ADMIN_AC=1) else (set ADMIN_AC=0&rmdir "%WINDIR%\CHECK_ADMIN_ACCESS_%RMA%%RMB%" /s /q)
cls
if %ADMIN_AC% == 1 (
title=Windows DVR Disabeler [%MES_NOACCESS%]
echo.
echo  %MES_ADMIN%
echo.
pause
exit
)

:BEGIN
color F0
title=Windows DVR Disabeler (by Octanium)
echo.
echo  %LLOADING%
echo.
set "regbackUpFile=%~dp0RegBackUpFile.reg"
set "regbackUpTEMPFile=%temp%RegBackUpFile.tmp"
set "DVR_ENEBELED=0"
set "regAppCaptureEnable=null"
set "regGameDVR=null"
set "regAllowgameDVR=null"
for /f "tokens=2*" %%a in ('REG QUERY HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR /v AppCaptureEnabled') do set "regAppCaptureEnable=%%b"
for /f "tokens=2*" %%a in ('REG QUERY HKCU\System\GameConfigStore /v GameDVR_Enabled') do set "regGameDVR=%%b"
for /f "tokens=2*" %%a in ('REG QUERY HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR /v value') do set "regAllowgameDVR=%%b"

rem if %regAppCaptureEnable% == null GOTO ERROR18404
if %regGameDVR% == null GOTO ERROR18404
if %regAllowgameDVR% == null set GOTO ERROR18404

if %regAppCaptureEnable% == 0x1 set "DVR_ENEBELED=1"
if %regGameDVR% == 0x1 set "DVR_ENEBELED=1"
if %regAllowgameDVR% == 0x1 set "DVR_ENEBELED=1"

if %DVR_ENEBELED% == 1 (
	GOTO IsENABELED
) else (
	GOTO IsDISABELED
)

:ERROR18404
cls
echo.
echo   Sorry but script can not be applied in this system!
echo   ERROR #18404
echo.
echo  %LPAKFE%
echo.
pause
exit

:IsENABELED
cls
echo.
echo   %LNWDVREN%
echo.
echo  %LPAKFDD%
echo.
pause
GOTO DISDVR
exit

:IsDISABELED
cls
color F2
echo.
echo   %LNWDVRDIS%
echo.
echo  %LPAKFE%
echo.
pause 
exit

:DISDVR
cls
echo.
echo  %LLDWD%
echo.
echo  [*] %LCBF%
if exist "%regbackUpFile%" set "regbackUpFile=%~dp0RegBackUpFile_%RANDOM%%RANDOM%%RANDOM%%RANDOM%.reg"
echo Windows Registry Editor Version 5.00>>"%regbackUpFile%"&echo.>>"%regbackUpFile%"&echo ; Registry file generated in WinDisDVR.cmd>>"%regbackUpFile%"&echo.>>"%regbackUpFile%"
if not %regAppCaptureEnable% == null (
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR]>>"%regbackUpFile%"
reg export HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR "%regbackUpTEMPFile%" /y&& type "%regbackUpTEMPFile%" | findstr "AppCaptureEnabled">>"%regbackUpFile%"&echo.>>"%regbackUpFile%"
)
echo [HKEY_CURRENT_USER\System\GameConfigStore]>>"%regbackUpFile%"
reg export HKCU\System\GameConfigStore "%regbackUpTEMPFile%" /y&& type "%regbackUpTEMPFile%" | findstr "GameDVR_Enabled">>"%regbackUpFile%"&echo.>>"%regbackUpFile%"
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR]>>"%regbackUpFile%"
reg export HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR "%regbackUpTEMPFile%" /y&& type "%regbackUpTEMPFile%" | findstr "value">>"%regbackUpFile%"&echo.>>"%regbackUpFile%"
echo  [*] %LLDWD%
if not %regAppCaptureEnable% == null (
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR /v AppCaptureEnabled /t REG_DWORD /d 0 /f
)
REG ADD HKCU\System\GameConfigStore /v GameDVR_Enabled /t REG_DWORD /d 0 /f
REG ADD HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR /v value /t REG_DWORD /d 0 /f
echo.
echo  [*] %LLC%
set "CDVR_ENEBELED=0"
if not %regAppCaptureEnable% == null (
for /f "tokens=2*" %%a in ('REG QUERY HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR /v AppCaptureEnabled') do set "cregAppCaptureEnable=%%b"
)
for /f "tokens=2*" %%a in ('REG QUERY HKCU\System\GameConfigStore /v GameDVR_Enabled') do set "cregGameDVR=%%b"
for /f "tokens=2*" %%a in ('REG QUERY HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR /v value') do set "cregAllowgameDVR=%%b"

if %cregAppCaptureEnable% == 0x1 set "CDVR_ENEBELED=1"
if %cregGameDVR% == 0x1 set "CDVR_ENEBELED=1"
if %cregAllowgameDVR% == 0x1 set "CDVR_ENEBELED=1"

if %CDVR_ENEBELED% == 0 (
	GOTO DONEOK
) else (
	GOTO DONENOTOK
)

:DONEOK
cls
color F2
echo.
echo   %LWDSD%
echo.
echo  %LPAKFE%
echo.
pause
exit

:DONENOTOK
cls
color F4
echo.
echo   %LWDCNBD%
echo.
echo  %LPAKFTA%
echo.
pause
GOTO BEGIN
exit

:LANG_ENG
set "LANG_C=en-us"
set "LANG=English"
set "LLOADING=Loading..."
set "LNWDVREN=Now DVR in Windows Enabeled!"
set "LNWDVRDIS=Now DVR in Windows Disabled!"
set "LPAKFE=Press any key for exit =)"
set "LWDSD=Windows DVR successfully disabled!"
set "LWDCNBD=Windows DVR could not be disabled!!!"
set "LPAKFTA=Press any key for try again =)"
set "LPAKFDD=Press any key for disable Windows DVR =)"
set "LLDWD=Disabling Windows DVR..."
set "LCBF=Creating backup file..."
set "LLC=Checking..."
set "MES_NOACCESS=NO ACCESS"
set "MES_ADMIN=Please, run application as Administrator!"
goto LANG_END

:LANG_RUS
set "LANG_C=ru-ru"
set "LANG=Русский"
set "LLOADING=Загрузка..."
set "LNWDVREN=Windows DVR включен!"
set "LNWDVRDIS=Windows DVR отключен!"
set "LPAKFE=Нажмите любую клавишу для выхода =)"
set "LWDSD=Windows DVR успешно отключен!"
set "LWDCNBD=Windows DVR не получилось отключить!!!"
set "LPAKFTA=Нажмите любую клавишу чтобы попробовать еще раз =)"
set "LPAKFDD=Нажмите любую клавишу для отключения Windows DVR =)"
set "LLDWD=Отключение Windows DVR..."
set "LCBF=Создание резервной копии данных..."
set "LLC=Проверка..."
set "MES_NOACCESS=НЕТ ДОСТУПА"
set "MES_ADMIN=Пойжайлуста, запустите приложение от имени администратора!"
goto LANG_END

