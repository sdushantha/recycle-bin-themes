@echo off
set /p Input=write theme name and press enter 

cd ..\themes\%Input%\
IF ERRORLEVEL 1 (
    echo sorry, this theme does not exist
    pause>nul
    exit
)

reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon /v full /f /t REG_EXPAND_SZ /d %CD%\%Input%-full.ico
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon /v empty /f /t REG_EXPAND_SZ /d %CD%\%Input%-empty.ico

taskkill /f /im explorer.exe
start explorer.exe