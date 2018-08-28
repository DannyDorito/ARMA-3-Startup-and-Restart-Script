::
:: ARMAServerStart.bat
:: By: Jstrow and Danny Dorito, originally for CSG Exile
::
@echo off
color F
:: Command window name, does not affect anything else
:: Default is: ARMA Server #1
set server_name=ARMA Server #1

:: Path to the ARMA 3 server executable, for example C:ARMA\arma3server.exe
set path_to_server_executable=changeme
:: Name of executable
:: Default 32bit is arma3server.exe, default 64bit is arma3server_x64.exe
set exe_name=arma3server.exe
:: Path to battleye folder, for example C:ARMA\battleye
set path_to_battleye=changeme
:: If you are  using battleye then battleye=true, default is false
set battleye=false
:: set the port number of the ARMA server, default ARMA is 2302
set server_port_number=0
:: Name of server profile, for example CSG
set profile_name=changeme
:: List of server side mods, Add the mod to modlist for example adding Mod3 to set modlist=@Mod1; @Mod2;
:: You would do: set modlist=@Mod1; @Mod2; @Mod3;
set modlist=@Mod1; @Mod2; @Mod3;
:: List of server side mods, Add the mod to servermodlist for example adding ServerMod3 to set servermodlist=@ServerMod1; @ServerMod2;
:: You would do: set servermodlist=@ServerMod1; @ServerMod2; @ServerMod3;
set servermodlist=@ServerMod1; @ServerMod2; @ServerMod3;
:: basic.cfg location, for example C:ARMA\basic.cfg
set path_to_basic_cfg=changeme
:: server.cfg/config.cfg location, for example C:ARMA\server.cfg
set path_to_server_cfg=changeme
:: Path to the ARMA directory, for example C:ARMA\
set path_to_arma_directory=changeme
:: Extra launch parameters
:: For more info see: https://community.bistudio.com/wiki/ArmA:_Server_configuration
:: We used: -autoinit -enableHT -loadMissionToMemory -high -filePatching -hugepages -bandwidthAlg=2, however your mileage may vary
set extra_launch_parameters=""

:: If you want to use the profile deleter for possible performance increase
:: set the path to server.vars.Arma3Profile, for example C:\ARMA\CSG\Users\CSG.vars.Arma3Profile
set path_to_ServervarsArma3Profile=changeme

:: For more info see: https://community.bistudio.com/wiki/Arma_3:_Custom_Memory_Allocator
:: Default is tbb4malloc_bi
set malloc_name=tbb4malloc_bi

:: If you are using the SQL backup set backup=true
:: Default is false
set backup=false
:: set the directory to the .bat filePatching, for example C:ARMA\backup.bat
set path_to_sql_backup=changeme

:: For more info see: https://a3.launcher.eu/download
:: If you are using the MissionPrefetchServer, set mission_prefetch=true
:: Default is false
set mission_prefetch=false
:: set the path to the MissionPrefetchServer executable, for example C:ARMA\MissionPrefetchServer.exe
set path_to_mission_prefetch_server_executable=changeme
:: set the mission prefetch executable name, for example MissionPrefetchServer.exe
set mission_prefetch_exe_name=MissionPrefetchServer.exe
:: if you don't want GetIP.exe to get the server ip, set auto_find_ip=false and set server_ip_address= your ip
:: Default is true
set auto_find_ip=true
:: set the IP address of the MissionPrefetchServer, uses GetIP.exe
set server_ip_address="null"
if "%auto_find_ip%" == "true" (
	:: set the IP address of the MissionPrefetchServer, uses GetIP.exe
	for /f %%a in ('GetIP.exe -public -v4') do set "server_ip_address=%%a"
)
:: set the wait time of the MissionPrefetchServer
set wait_time_in_seconds=0
:: set the port of the MissionPrefetchServer (different to the ARMA server)
set mission_prefetch_server_port=0
:: set the path of the mission pbo that you wish to use the MissionPrefetchServer with
set path_to_mission_pbo=changeme

:: If you are using the SteamCMD updater:
:: set use_steam_updater=true
:: Default is false
set use_steam_updater=false
:: set the path to the SteamCMD executable
set path_to_steamcmd_executable=changeme
:: set the Steam account name that you want to use to update the server
set account_name=changeme
:: set the above Steam account password
set account_password=changeme
::
:: DO NOT CHANGE ANYTHING BELOW THIS POINT#
:: UNLESS YOU KNOW WHAT YOU ARE DOING
::
set error=""

echo Pre startup initialised
echo Starting vars checks
title %server_name%

if "%path_to_server_executable%" == "changeme" (
	set error=path_to_server_executable
	goto error
)
if "%server_port_number%" == "0" (
	set error=server_port_number
	goto error
)
if "%profile_name%" == "changeme" (
	set error=profile_name
	goto error
)
if "%battleye%" == "true" (
	if "%path_to_battleye%" == "changeme" (
		set error=path_to_battleye
		goto error
	)
)
if "%modlist%" == "@Mod1; @Mod2; @Mod3;" (
	set error=modlist
	goto error
)
if "%servermodlist%" == "@ServerMod1; @ServerMod2; @ServerMod3;" (
	set error=servermodlist=
	goto error
)
if "%path_to_basic_cfg%" == "changeme" (
	set error=path_to_basic_cfg
	goto error
)
if "%path_to_server_cfg%" == "changeme" (
	set error=path_to_server_cfg
	goto error
)
if "%path_to_arma_directory%" == "changeme" (
	set error=path_to_arma_directory
	goto error
)
if "%mission_prefetch%" == "true" (
	if "%server_ip_address%" == "null" (
		set error=server_ip_address
		goto error
	)
	if "%wait_time_in_seconds%" == "0" (
		set error=wait_time_in_seconds
		goto error
	)
	if "%mission_prefetch_server_port%" == "0" (
		set error=mission_prefetch_server_port
		goto error
	)
	if "%path_to_mission_pbo%" == "changeme" (
		set error=path_to_server_executable
		goto error
	)
)
if "%use_steam_updater%" == "true" (
	if "%path_to_steamcmd_executable%" == "changeme" (
		set error=path_to_steamcmd_executable
		goto error
	)
	if "%account_name%" == "changeme" (
		set error=account_name
		goto error
	)
	if "%account_password%" == "changeme" (
		set error=account_password
		goto error
	)
)
echo Variable checks completed
set loops=0

:loop
C:\Windows\System32\tasklist /FI %path_to_server_executable% 2>NUL | C:\Windows\System32\find /I /N %exe_name%>NUL
if "%ERRORLEVEL%" == "0" goto loop
if "%path_to_ServervarsArma3Profile%" != "changeme" (
	echo Deleting %profile_name%
	del /Q /F %path_to_ServervarsArma3Profile%
	echo Delete complete
)

:: Uses https://www.redolive.com/utah-web-designers-blog/automated-mysql-backup-for-windows
if "%backup%" == "true" (
	echo Starting Database Backup
	start /wait %path_to_sql_backup%
	echo Database backup complete
)

:: Get from here https://a3.launcher.eu/download
:: If you use the optional ARMA 3 Launcher Mission Prefetch
if "%mission_prefetch%" == "true" (
	echo Starting MissionPrefetchServer
	start /wait %path_to_mission_prefetch_server_executable% %server_port_number% %path_to_mission_pbo% %server_ip_address% %mission_prefetch_server_port% %wait_time_in_seconds%
	echo MissionPrefetchServer Started
)

:: Steam automatic update for the server files
:: Get from here https://developer.valvesoftware.com/wiki/SteamCMD
if "%use_steam_updater%" == "true" (
	echo Steam Automatic Update Starting
	start /wait %path_to_steamcmd_executable% +login %account_name% %account_password% +force_install_dir %path_to_arma_directory% +app_update 233780 validate +quit
	echo Steam Automatic Update Completed
)

echo.
echo Pre startup complete
echo.
echo Starting server at: %date%,%time%
echo Restarts: %loops%

:: Start the ARMA Server
cd %path_to_server_executable%
if "%battleye%" == "true" (
	start "%profile_name%" /min /wait %exe_name% "-mod=%modlist%" "-config=%path_to_server_cfg%" -port=%server_port_number% "-profiles=%profile_name%" "-cfg=%path_to_basic_cfg%" "-bepath=%path_to_battleye%" -name=%profile_name% -high -autoInit -malloc=%malloc_name% %extra_launch_parameters% -serverMod=%servermodlist%
)
if "%battleye%" == "false" (
	start "%profile_name%" /min /wait %exe_name% "-mod=%modlist%" "-config=%path_to_server_cfg%" -port=%server_port_number% "-profiles=%profile_name%" "-cfg=%path_to_basic_cfg%" -name=%profile_name% -high -autoInit -malloc=%malloc_name% %extra_launch_parameters% -serverMod=%servermodlist%
)
echo To stop the server, close ARMAServerStart.bat then the other tasks, otherwise it will restart
echo.
goto looping

:loop
:: Monitoring Loop
echo Server is already running, running monitoring loop

:looping
:: Restart/Crash Handler
set /A crashes+=1
C:\Windows\System32\timeout /t 5
C:\Windows\System32\tasklist /FI "%path_to_server_executable% eq %exe_name%" 2>NUL | C:\Windows\System32\find /I /N %exe_name%>NUL
if "%mission_prefetch%"=="true" (
	taskkill /F /IM "%mission_prefetch_exe_name%"
)
if "%ERRORLEVEL%"=="0" goto loop
goto loop

:error
:: Generic error catching
cls
color C
echo ERROR: %error% not set correctly, please check the config
pause
