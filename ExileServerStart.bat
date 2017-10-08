::
::	ExileServerStart.bat
::	By: Jstrow and Danny Dorito originally for CSG Exile, all are free to use and modify
::  To stop the server with this running, close this first!
::
@echo off

:: The title of the console
title Exile Server #1

:: Vairable declaration for the amount of crashes
SET crashes=0

:start

C:\Windows\System32\tasklist /FI "REPLACE.WITH.FULL.ERVER.PATH" 2>NUL | C:\Windows\System32\find /I /N "arma3server.exe">NUL
if "%ERRORLEVEL%"=="0" goto loop
echo Pre startup initailzed
echo.

::Delete vars.Arma3Profile for performance gains
echo Deleting Server.vars.Arma3Profile
:: For example: C:\arma\CSG\Users\CSG\CSG.vars.Arma3Profile
del /Q /F "REPLACE WITH server.vars.Arma3Profile"
echo Delete complete

::Database backup script
::Remove :: from the lines below to use
::echo Starting Database Backup
::start C:\Heidi\MySQLBackups\mysqlbackup.bat
::echo Database Backup Complete

::Get from here https://a3.launcher.eu/download
::If you use the optional Arma 3 Launcher Mission Prefetch
::Remove :: from the lines below to use, also remove from Restart/Crash Hander section
::echo Starting Mission Prefetch Server
::start C:\arma\MissionPrefetchServer.exe SERVER.PORT.NUMBER PATH.TO.PBO SERVER.IP.ADDRESS PREFETCH.SERVER.PORT WAIT.TIME.IN.SECONDS
::echo Mission Prefetch Server Started

::Steam automatic update for the server files
::Get from here https://developer.valvesoftware.com/wiki/SteamCMD
::Remove :: from the lines below to use
::echo Steam Automatic Update Starting
::start C:\Steam\steamcmd.exe +login "account" "password" +force_install_dir c:\arma\ +app_update 233780 validate +quit
::TIMEOUT /T 40
::echo Steam Automatic Update Completed

echo.
echo Pre startup complete
echo.
::Outputs the start time of the server
echo Starting server at: %date%,%time%
::Outputs the amount of crashes or restarts since the bat has been started
echo Restarts/Crashes: %crashes%

::Start the Arma Server
cd "C:\arma"
::For more info see: https://community.bistudio.com/wiki/ArmA:_Server_configuration
::We used -autoinit -enableHT -loadMissionToMemory -high -filePatching -hugepages however your mileage may vary
start "CSG" /min /wait arma3server.exe "-mod=@Mod1; @mod;" "-config=C:\arma\config.cfg" -port=SERVER.PORT "-profiles=PROFILE.NAME" "-cfg=PATH.TO.CFG.FILE" "-bepath=PATH.TO.BATTLEEYE" -name=PROFILE.NAME -autoinit
goto started

:loop

::Monitorting Loop
cls
echo Server is already running, running monitoring loop

:started

::Restart/Crash Hander
set /A crashes=crashes+1
C:\Windows\System32\timeout /t 5
C:\Windows\System32\tasklist /FI "C:\arma eq arma3server.exe" 2>NUL | C:\Windows\System32\find /I /N "arma3server.exe">NUL
::taskkill /F /IM MissionPrefetchServer.exe
if "%ERRORLEVEL%"=="0" goto loop

::Clears the console
cls

goto start

pause