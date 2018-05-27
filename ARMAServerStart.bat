::
::  ExileServerStart.bat
::  By: Jstrow and Danny Dorito originally for CSG Exile
::

:: Command window name, does not affect anything else
SET server_name=Server #1

:: Path to the ARMA 3 server executable
SET path_to_server_executable=changeme
:: Path to server.vars.Arma3Profile, for example C:\arma\CSG\Users\CSG\CSG.vars.Arma3Profile
SET path_to_ServervarsArma3Profile=changeme
:: Path to battleye folder, for example C:ARMA\battleye
SET path_to_battleye=changeme
:: Set the port number of the ARMA server
SET server_port_number=0
:: Name of server profile
SET profile_name=changeme
:: List of server side mods, for example @Mod1; @Mod2; @Mod3;
SET modlist=@Mod1; @Mod2; @Mod3;
:: basic.cfg location
SET path_to_basic_cfg=changeme
:: server.cfg location
SET path_to_server_cfg=changeme
:: Extra launch parameters
:: For more info see: https://community.bistudio.com/wiki/ArmA:_Server_configuration
:: We used -autoinit -enableHT -loadMissionToMemory -high -filePatching -hugepages -bandwidthAlg=2 however your mileage may vary
SET extra_launch_parameters=""

:: If you are using the SQL backup:
:: Set backup=true
SET backup=false
:: Set the directory to the .bat filePatching
SET path_to_sql_backup=changeme

:: If you are using a 64bit server, set 64bit_server=true
SET 64bit_server=false
:: name of executable, this will be changed to arma3server_x64.exe if 64bit_server=true
SET exe_name=arma3server.exe

:: If you are using the MissionPrefetchServer:
:: Set mission_prefetch=true
SET mission_prefetch=false
:: Set the path to the MissionPrefetchServer executable
SET path_to_mission_prefetch_server_executable=changeme
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
SET error=""
SET loops=0

echo Pre startup initialised
echo .
title %server_name%

if "%path_to_server_executable%" == "changeme" (
	SET error=path_to_server_executable
	goto error
)
if "%path_to_ServervarsArma3Profile%" == "changeme" (
	SET error=path_to_ServervarsArma3Profile
	goto error
)
if "%server_port_number%" == "0" (
	SET error=server_port_number
	goto error
)
if "%profile_name%" == "changeme" (
	SET error=profile_name
	goto error
)
if "%path_to_battleye%" == "changeme" (
	SET error=path_to_battleye
	goto error
)
if "%modlist%" == "@Mod1; @Mod2; @Mod3;" (
	SET error=modlist
	goto error
)
if "%path_to_basic_cfg%" == "changeme" (
	SET error=path_to_basic_cfg
	goto error
)
if "%path_to_server_cfg%" == "changeme" (
	SET error=path_to_server_cfg
	goto error
)
if "%64bit_server%" == "true" (
	SET exe_name=arma3server_x64.exe
)

if "%mission_prefetch%" == "true" (
  if "%server_ip_address%" == "0.0.0.0" (
	SET error=server_ip_address
	goto error
	)
  if "%wait_time_in_seconds%" == "0" (
	SET error=wait_time_in_seconds
	goto error
	)
  if "%mission_prefetch_server_port%" == "0" (
	SET error=mission_prefetch_server_port
	goto error
	)
  if "%path_to_mission_pbo%" == "changeme" (
	SET error=path_to_server_executable
	goto error
	)
)

if "%use_steam_updater%" == "true" (
	if "%path_to_steamcmd_executable%" == "changeme" (
	SET error=path_to_steamcmd_executable
	goto error
	)
	if "%account_name%" == "changeme" (
	SET error=account_name
	goto error
	)
	if "%account_password%" == "changeme" (
	SET error=account_password
	goto error
	)
)

:loop
C:\Windows\System32\tasklist /FI %path_to_server_executable% 2>NUL | C:\Windows\System32\find /I /N %exe_name%>NUL
if "%ERRORLEVEL%" == "0" goto loop

echo Deleting %profile_name%
del /Q /F %path_to_ServervarsArma3Profile%
echo Delete complete

::Uses https://www.redolive.com/utah-web-designers-blog/automated-mysql-backup-for-windows
if "%backup%" == "true" (
	echo Starting Database Backup
	start %path_to_sql_backup%
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
cd %path_to_server_executable%
start %profile_name% /min /wait %exe_name% "-mod=%modlist%" "-config=%path_to_server_cfg%" -port=%server_port_number% "-profiles=%profile_name%" "-cfg=%path_to_basic_cfg%" "-bepath=%path_to_battleye%" -name=%profile_name% -autoinit %extra_launch_parameters%
echo To stop the server, close ExileServerStart.bat then the other tasks, otherwise it will restart
goto looping

:loop
::Monitoring Loop
cls
echo Server is already running, running monitoring loop

:looping
::Restart/Crash Handler
set /A crashes+=1
C:\Windows\System32\timeout /t 5
C:\Windows\System32\tasklist /FI "%path_to_server_executable% eq %exe_name%" 2>NUL | C:\Windows\System32\find /I /N %exe_name%>NUL
if "%mission_prefetch%"=="true" (
	taskkill /F /IM MissionPrefetchServer.exe
)
if "%ERRORLEVEL%"=="0" goto loop
cls
goto loop
pause

:error
cls
echo ERROR: "%error%" not set correctly
pause