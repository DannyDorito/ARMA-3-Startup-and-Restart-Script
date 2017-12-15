# ExileServerStart.bat

We all would love to see more Exile Mod servers, so why not create one?

This is .bat file for all your ARMA 3 Exile Server startup needs!

Created by: **Jstrow** and **DannyDorito** originally for CSG Exile
Under the GNU General Public License v3.0
[LICENSE](https://github.com/DannyDorito/Exile-Server-Startup/blob/master/LICENSE)

## Check out our Twitter!
[@DannyDorito_](https://twitter.com/DannyDorito_)

[@CSG_Exile](https://twitter.com/CSG_Exile)

## This file includes:
* Server startup - parameters, mods, optional arguments for potential performance increase
* Crash/Restart monitor - have had issues with local ping function not working, this uses the Windows Task Manager
* Last start date and time of the server
* Profile.vars.Arma3Profile deleter, potential performance increase
* Optional Database backup script
* Optional ARMA 3 Launcher Mission Prefetch from  - Allows clients to download server file from A3Launcher, can reduce server load
* Optional Steam Automatic updater for ARMA 3
* Plus detailed comments explaining what all of the script does

## Features to be added:
* Optional Steam Automatic updater for mods
* Database file sync to cloud storage
* Automatic PBO packer with Mikero's tools support

## FAQ

### How do I use this?
1. Download the latest version
2. Place in a suitable directory, for example your Desktop
3. Replace all the text in the file like **REPLACE.WITH.FULL.SERVER.PATH** with the corresponding path
   - For example, ``del /Q /F "REPLACE WITH server.vars.Arma3Profile"``
   - Would will look like this: ``del /Q /F "C:\arma\CSG\Users\CSG\CSG.vars.Arma3Profile"``
4. Run the ExileServerStart.bat file, if there is an error reattempt step 3
5. To shutdown the server close the console window first, **then** shutdown the server

### Where do I download x?
Exile Mod client & server files:

http://www.exilemod.com/downloads

ARMA 3 Launcher Server Prefetch:

https://a3.launcher.eu/MissionPrefetchServer.zip

SteamCMD:

https://developer.valvesoftware.com/wiki/SteamCMD

ARMA Mods: 

http://steamcommunity.com/app/107410/workshop

MySQL Backup:

https://www.redolive.com/utah-web-designers-blog/automated-mysql-backup-for-windows

### How do I add x mod?
If it is a server mod, then add it to your mod folder and goto the 'Start the Arma Server' section in ExileServerStart.bat

**Please check the mod page before installing all mods!**

Add the mod to your mod parameter for example adding ``Mod3`` to ``"-mod=@Mod1; @Mod2;"``

You would do:
``"-mod=@Mod1; @Mod2; @Mod3;"``

If it is a client mod (e.g. JSRS) then there is **no need to add it to startup!** Just the .bikey into your BIKey folder

**However** this is not always the case, **please check the mod page before installing all mods!**

### How do I backup my server with this?
Head to MySQL Backup:
https://www.redolive.com/utah-web-designers-blog/automated-mysql-backup-for-windows

Follow the installation instructions on the website **carefully!**

Then in ExileServerStart.bat go to the Database backup script section and **remove** the :: from the bottom 3 lines

Fill in the ``FULL\DIRECTORY\TO\mysqlbackup.bat`` with the full directory of **your** .bat location.

This will create a backup of your database every time you start the server.

It is **strongly** advised to move these off the system your server runs on.

Google Drive sync can be used to automatically upload the files to a external cloud, but other solutions are available!

### Will you add x feature, why is x broken?
Create a new issue or send Danny Dorito a message on Twitter and we can see what we can do!