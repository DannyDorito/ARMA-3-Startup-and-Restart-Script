::
::  ExileServerStart.bat
::  By: Jstrow and Danny Dorito originally for CSG Exile
::

:: Command window name, does not affect anything else
SET server_name=Exile Server #1

:: Path to the ARMA 3 server executable
SET path_to_server_executable=changeme

:: Path to server.vars.Arma3Profile, for example C:\arma\CSG\Users\CSG\CSG.vars.Arma3Profile
SET path_to_ServervarsArma3Profile=changeme

:: If you are using the SQL backup:
:: Set backup=true
SET backup=false
:: Set the directory to the .bat filePatching
SET sql_backup_directory=changeme

:: If you are using a 64bit server, set 64bit_server=true
SET 64bit_server=false

SET exe_name=arma3server.exe

:: If you are using the MissionPrefetchServer:
:: Set mission_prefetch=true
SET mission_prefetch=false
:: Set the path to the MissionPrefetchServer executable
SET path_to_mission_prefetch_server_executable=changeme
:: Set the port number of the ARMA server
SET server_port_number=0
:: Set the IP address of the MissionPrefetchServer
SET server_ip_address=0.0.0.0
:: Set the wait time of the MissionPrefetchServer
SET wait_time_in_seconds=0
:: Set the port of the MissionPrefetchServer (different to the ARMA server)
SET mission_prefetch_server_port=0
:: Set the path of the mission pbo that you wish to use the MissionPrefetchServer with
SET path_to_mission_pbo=changeme

:: If you are using the SteamCMD updater:
:: Set use_steam_updater=true
SET use_steam_updater=false
:: Set the path to the SteamCMD executable
SET path_to_steamcmd_executable=changeme
:: Set the Steam account name that you want to use to update the server
SET account_name=changeme
:: Set the above Steam account password
SET account_password=changeme
:: Set the wait time of the update service in seconds, default is 40 seconds
SET updater_wait_time=40 
::
::  DO NOT CHANGE ANYTHING BELOW THIS POINT
::
@echo off
SET loops=0

echo Pre startup initialised
echo .
title %server_name%

if "%path_to_server_executable%" == "changeme" goto error_server_path
if "%path_to_ServervarsArma3Profile%" == "changeme" goto error_vars_path
if "%64bit_server%" == "true" (
  SET exe_name=arma3server_x64.exe
)

if "%mission_prefetch%" == "true" (
  if "%server_port_number%" == "0" goto error_server_port
  if "%server_ip_address%" == "0.0.0.0" goto error_server_ip
  if "%wait_time_in_seconds%" == "0" goto error_timeout
  if "%mission_prefetch_server_port%" == "0" goto error_prefetch_port
  if "%path_to_mission_pbo%" == "changeme" goto error_pbo_path
)

if "%use_steam_updater%" == "true" (
  if "%path_to_steamcmd_executable%" == "changeme" goto error_steamcmd
  if "%account_name%" == "changeme" goto error_account_name
  if "%account_password%" == "changeme" goto error_account_password
)
:start

C:\Windows\System32\tasklist /FI %path_to_server_executable% 2>NUL | C:\Windows\System32\find /I /N %exe_name%>NUL
if "%ERRORLEVEL%" == "0" goto loop

echo Deleting Server.vars.Arma3Profile
del /Q /F %path_to_ServervarsArma3Profile%
echo Delete complete

::Uses https://www.redolive.com/utah-web-designers-blog/automated-mysql-backup-for-windows
if "%backup%" == "true" (
  echo Starting Database Backup
  start %sql_backup_directory%
  echo Database backup complete
)

::Get from here https://a3.launcher.eu/download
::If you use the optional Arma 3 Launcher Mission Prefetch
::Remove :: from the lines below to use, also remove from Restart/Crash Hander section
if "%mission_prefetch%" == "true" (
  echo Starting MissionPrefetchServer
  start %path_to_mission_prefetch_server_executable% %server_port_number% %path_to_mission_pbo% %server_ip_address% %mission_prefetch_server_port% %wait_time_in_seconds%
  echo MissionPrefetchServer Started
)

::Steam automatic update for the server files
::Get from here https://developer.valvesoftware.com/wiki/SteamCMD
if "%use_steam_updater%" == "true" (
  echo Steam Automatic Update Starting
  start %path_to_steamcmd_executable% +login %account_name% %account_password% +force_install_dir c:\arma\ +app_update 233780 validate +quit
  TIMEOUT /T %updater_wait_time%
  echo Steam Automatic Update Completed
)

echo.
echo Pre startup complete
echo.
echo Starting server at: %date%,%time%
echo Restarts/Crashes: %loops%

::Start the Arma Server
cd "C:\arma"
::For more info see: https://community.bistudio.com/wiki/ArmA:_Server_configuration
::We used -autoinit -enableHT -loadMissionToMemory -high -filePatching -hugepages -bandwidthAlg=2 however your mileage may vary
start "CSG" /min /wait arma3server.exe "-mod=@Mod1; @mod;" "-config=C:\arma\config.cfg" -port=SERVER.PORT "-profiles=PROFILE.NAME" "-cfg=PATH.TO.CFG.FILE" "-bepath=PATH.TO.BATTLEEYE" -name=PROFILE.NAME -autoinit
echo To stop the server, close ExileServerStart.bat then the other tasks, otherwise it will restart
goto started

:loop

::Monitoring Loop
cls
echo Server is already running, running monitoring loop

:started

::Restart/Crash Handler
set /A crashes+=1
C:\Windows\System32\timeout /t 5
C:\Windows\System32\tasklist /FI "C:\arma eq %exe_name%" 2>NUL | C:\Windows\System32\find /I /N %exe_name%>NUL
if "%mission_prefetch%"=="true" (
  taskkill /F /IM MissionPrefetchServer.exe
)
if "%ERRORLEVEL%"=="0" goto loop
cls
goto start
pause

:error_server_path
cls
echo ERROR: Server path "path_to_server_executable" not set correctly
goto end

:error_vars_path
cls
echo ERROR: Vars path "path_to_ServervarsArma3Profile" not set correctly
goto end

:error_server_port
cls
echo ERROR: Server port "server_port_number" not set correctly,
echo if you intend to use the mission prefetch server this has to be set
goto end

:error_server_ip
cls
echo ERROR: Server ip address "server_ip_address" not set correctly,
echo if you intend to use the mission prefetch server this has to be set
goto end

:error_timeout
cls
echo ERROR: Wait time "wait_time_in_seconds" not set correctly,
echo if you intend to use the mission prefetch server this has to be set
goto end

:error_prefetch_port
cls
echo ERROR: Mission prefetch port "mission_prefetch_server_port" not set correctly,
echo if you intend to use the mission prefetch server this has to be set
goto end

:error_pbo_path
cls
echo ERROR: PBO path "path_to_mission_pbo" not set correctly,
echo if you intend to use the mission prefetch server this has to be set
goto end

:error_steamcmd
cls
echo ERROR: SteamCMD exeutable path "path_to_steamcmd_executable" not set correctly,
echo if you intend to use the steam updater this has to be set
goto end

:error_account_name
cls
echo ERROR: Account name "account_name" not set correctly,
echo if you intend to use the steam updater this has to be set
goto end

:error_account_password
cls
echo ERROR: Account password "account_password" not set correctly,
echo if you intend to use the steam updater this has to be set
goto end

:end
pause
