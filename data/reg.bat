@echo off


net session >nul 2>&1
if %errorlevel% neq 0 (
   echo 
   powershell -Command "Start-Process '%~f0' -Verb RunAs"
   exit
)
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\ /t REG_SZ /v TrynDPI /d %~dp0osnov.bat /f
