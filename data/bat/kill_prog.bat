@echo off


net session >nul 2>&1
if %errorlevel% neq 0 (
   echo 
   powershell -Command "Start-Process '%~f0' -Verb RunAs"
   exit
)

taskkill /f /im:TrynDPI.exe 
taskkill /f /im:winws.exe 