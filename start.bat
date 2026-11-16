@echo off
chcp 65001 >nul
cd /d "%~dp0"
title ULan
if exist "%~dp0icon.ico" start "" /b powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0set_console_icon.ps1" "%~dp0icon.ico"
if /I "%~1"=="--elevated" goto runserver
net session >nul 2>&1
if not errorlevel 1 goto runserver
set "ULAN_START_BAT=%~f0"
set "ULAN_START_DIR=%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Start-Process -FilePath $env:ULAN_START_BAT -ArgumentList '--elevated' -WorkingDirectory $env:ULAN_START_DIR -Verb RunAs -ErrorAction Stop; exit 0 } catch { exit 1 }"
if errorlevel 1 (
  echo ULan was not started because administrator permission was not granted.
  pause
)
exit /b
:runserver
title ULan (Administrator)
where python >nul 2>nul
if errorlevel 1 goto checkpy
set "ULAN_PYTHON=python"
goto haspython
:checkpy
where py >nul 2>nul
if errorlevel 1 goto nopython
set "ULAN_PYTHON=py -3"
goto haspython
:nopython
echo Python 3 wurde nicht gefunden. Bitte von python.org installieren
echo und den Haken bei "Add python.exe to PATH" setzen.
goto ende
:haspython
%ULAN_PYTHON% server.py
:ende
echo.
echo Server beendet. Taste druecken zum Schliessen.
pause >nul
