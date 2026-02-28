@echo off

net session >nul 2>&1
if %errorlevel% neq 0 (
   echo 
   powershell -Command "Start-Process '%~f0' -Verb RunAs"
   exit
)

start %~dp0main.exe