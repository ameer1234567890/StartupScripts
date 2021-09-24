@ECHO OFF

SET IS_SILENT=0
IF "%1"=="/S" SET IS_SILENT=1

SET SPATH=K:\StartupScripts\Ameer\
powershell -Command "Write-EventLog -LogName Application -Source SysAdmin -EntryType Information -Message 'Running startup scripts from %SPATH%' -EventId 1"
ECHO Running startup scripts from %SPATH%

rem Run all bat (CMD) scripts
FOR /f %%i IN ('dir /b %SPATH%*.bat') DO (
  powershell -Command "Write-EventLog -LogName Application -Source SysAdmin -EntryType Information -Message 'Running %%i' -EventId 1"
  call %SPATH%%%i
)

rem Run all ps1 (Powershell) scripts
FOR /f %%i IN ('dir /b %SPATH%*.ps1') DO (
  powershell -Command "Write-EventLog -LogName Application -Source SysAdmin -EntryType Information -Message 'Running %%i' -EventId 1"
  powershell -NoProfile -ExecutionPolicy Bypass -Command %SPATH%\%%i
)

IF %IS_SILENT% EQU 1 EXIT
PAUSE
