# ARMA 3 (Exile) Startup & Restart Script

Originally created for the Exile Mod, but can be used for any ARMA 3 Server

This is .bat file for **all** your ARMA 3 Server startup needs!

Created by: **Jstrow** and **DannyDorito** originally for [CSG Exile](https://csgcommunity.com)

Forking this repo will be public, **do not** put sensitive information such as passwords into your **public** repo.
A better alternative is a private repo, which GitHub now offers free for all users, so download a copy of this one and create your own!

Click [Here](https://github.com/DannyDorito/DayZ-Startup-and-Restart-Script) for the DayZ Version!

## Check out our Twitter

[@JohnAllis0n](https://twitter.com/JohnAllis0n)

[@CSG_Exile](https://twitter.com/CSG_Exile)

## Features

* Server startup - parameters, mods, server mods, optional arguments for potential performance increase
* Crash/Restart monitor - this uses the Task Manager and not address pinging
* The last start date & time of the server
* Support for 64bit servers
* Optional Profile.vars.Arma3Profile delete with potential performance increase
* Optional Database backup script, with option to move to another cloud synced directory
* Optional Steam Automatic updater for ARMA 3

## Features to be added

* Optional Steam automatic updater for mods
* Optional A3Launcher automatic updater for mods
* Automatic PBO packer with Mikero's tools support

## FAQ

### How do I use this

1. Forking this repo will be public, **do not** put sensitive information such as passwords into your **public** repo. A better alternative is a private repo, which GitHub now offers free for all users, so download a copy of this one and create your own!
2. Download the latest version
3. Place in a suitable directory, for example your Desktop
4. Replace all of the variables that you require, e.g. ![set path_to_ServervarsArma3Profile=changeme](https://i.imgur.com/svri9W0.png) to: ![set path_to_ServervarsArma3Profile=C:\arma\CSG\Users\CSG\CSG.vars.Arma3Profile](https://i.imgur.com/p27kTKK.png)
5. Enabling some features, for example to enable Steam auto updates find: ![set use_steam_updater=false](https://i.imgur.com/dnlZHqs.png) and change it to: ![set use_steam_updater=true](https://i.imgur.com/7OPRUDR.png) Some features require more variables to be set, if unsure run the ``ARMAServerStart.bat`` file and see if there are any errors **if so**, repeat step 3 and 4.
6. Run the ``ARMAServerStart.bat`` fill and see if there are any errors, **if so**, repeat step 3 and 4.
7. To shutdown the server, close the console window first (and all other windows e.g BattleEye or MissionPrefetchServer), **then** shutdown the server or it will automatically restart.

### How do I add x mod

If it is a **server side** mod, then add it to your mod folder and goto the 'Start the ARMA Server' section in ARMAServerStart.bat

**Please check the mod page before installing all mods!**

Add the mod to ``modlist`` for example adding ``Mod3`` to ![set modlist=@Mod1; @Mod2;](https://i.imgur.com/i9fSMkk.png)

You would do:
![set modlist=@Mod1; @Mod2; @Mod3;](https://i.imgur.com/xNzbMm6.png)

If it is a client mod (e.g. JSRS or Blastcore) then there is **no need to add it to startup!**
**However,** this is not always the case, **please check the mod page before installing all mods!**

### How do I backup my server with this

* Head to MySQL Backup linked below
* Follow the installation instructions on the website **carefully!**
* Fill in the: ![path_to_sql_backup=changeme](https://i.imgur.com/ndWtJdn.png) with the full directory of **your** .bat location. e.g. ![path_to_sql_backup=C:arma\backup.bat](https://i.imgur.com/2wRNtDV.png)
* This will create a backup of your database every time you start the server.

It is **strongly** advised to move these off the system your server runs on.

Google Drive Sync can be used to automatically upload the files to a external cloud, but other solutions are available!

### Where do I download x

#### Exile Mod client & server files

[Exile Mod Download](https://exilemod.com/downloads)

#### SteamCMD

[SteamCMD Wiki](https://developer.valvesoftware.com/wiki/SteamCMD)

#### ARMA Mods

[Steam Workshop](https://steamcommunity.com/app/107410/workshop/)

[ModDB Link](https://www.moddb.com/games/arma-3/mods)

[Bohemia's Forum](https://forums.bohemia.net/forums/forum/156-arma-3-addons-mods-complete)

[Nexus Mods](https://www.nexusmods.com/arma3)

#### MySQL Backup

[MySQL Backup](https://www.redolive.com/utah-web-designers-blog/automated-mysql-backup-for-windows)
