# ARMA 3 (Exile) Startup & Restart Script

Originally created for the Exile Mod, but can be used for any ARMA 3 Server

This is .bat file for **all** your ARMA 3 Server startup needs!

Created by: **Jstrow** and **DannyDorito** originally for [CSG Exile](https://www.csgcommunity.com)

## Check out our Twitter

[@DannyDorito_](https://twitter.com/DannyDorito_)

[@CSG_Exile](https://twitter.com/CSG_Exile)

## Features

* Server startup - parameters, mods, server mods, optional arguments for potential performance increase
* Crash/Restart monitor - this uses the Windows Task Manager and not local address pinging
* The last start date & time of the server
* Support for 64bit servers
* Optional Profile.vars.Arma3Profile deleter, potential performance increase
* Optional Database backup script
* Optional ARMA 3 Launcher Mission Prefetch from - Allows clients to download server file from A3Launcher
* Optional Steam Automatic updater for ARMA 3

## Features to be added

* Optional Steam automatic updater for mods
* Optional A3Launcher automatic updater for mods
* Database file sync to cloud storage
* Automatic PBO packer with Mikero's tools support

## FAQ

### How do I use this

1. Download the latest version
2. Place in a suitable directory, for example your Desktop
3. Replace all of the variables that you require, e.g. ``SET path_to_ServervarsArma3Profile=changeme`` to ``SET path_to_ServervarsArma3Profile=C:\arma\CSG\Users\CSG\CSG.vars.Arma3Profile``.
4. Enabling some features, for example ``SET use_steam_updater=false`` to ``SET use_steam_updater=true``, require more variables to be set, if unsure run the ``ARMAServerStart.bat`` file and see if there is any errors.
5. Run the ``ARMAServerStart.bat`` fill and see if there is any errors, **if so**, repeat step 3 and 4.
6. To shutdown the server close the console window first (and all other windows e.g BattleEye or MissionPrefetchServer), **then** shutdown the server.

### How do I add x mod

If it is a **server side** mod, then add it to your mod folder and goto the 'Start the ARMA Server' section in ARMAServerStart.bat

**Please check the mod page before installing all mods!**

Add the mod to ``modlist`` for example adding ``Mod3`` to ``SET modlist=@Mod1; @Mod2;``

You would do:
``SET modlist=@Mod1; @Mod2; @Mod3;``

If it is a client mod (e.g. JSRS or Blastcore) then there is **no need to add it to startup!** Usually just the .bikey into your BIKey folder.

**However** this is not always the case, **please check the mod page before installing all mods!**

### How do I backup my server with this

* Head to MySQL Backup linked above
* Follow the installation instructions on the website **carefully!**
* Fill in the ``sql_backup_directory`` with the full directory of **your** .bat location.
* This will create a backup of your database every time you start the server.

It is **strongly** advised to move these off the system your server runs on.

Google Drive Sync can be used to automatically upload the files to a external cloud, but other solutions are available!

### Where do I download x

#### Exile Mod client & server files

[Exile Mod Download](https://exilemod.com/downloads)

#### ARMA 3 Launcher Server Prefetch

[ARMA 3 Launcher Server Prefetch Download](https://a3.launcher.eu/download)

#### SteamCMD

[SteamCMD Wiki](https://developer.valvesoftware.com/wiki/SteamCMD)

#### ARMA Mods

[Steam Workshop](https://developer.valvesoftware.com/wiki/SteamCMD)

[Armaholic Link](http://www.armaholic.com)

[ModDB Link](https://www.moddb.com/games/arma-3/mods)

[Bohemia's Forum](https://forums.bohemia.net/forums/forum/156-arma-3-addons-mods-complete)

[Nexus Mods](https://www.nexusmods.com/arma3)

#### MySQL Backup

[MySQL Backup](https://www.redolive.com/utah-web-designers-blog/automated-mysql-backup-for-windows)

### Will you add x feature, why is x broken

Create a new issue or send Danny Dorito a message on Twitter and we can see what we can do!
