# ExileServerStart.bat

We all would love to see more Exile Mod servers, so why not create one?

This is .bat file for all your ARMA 3 Exile Server startup needs!

Created by: **Jstrow** and **DannyDorito** originally for CSG Exile, all are free to use and modify!

### Check out our Twitters!

https://twitter.com/DannyDorito_

https://twitter.com/CSG_Exile

## This file includes:

* Server startup - parameters, mods, optional arguments for potential performance increase
* Crash/Restart monitor - have had issues with ping function not working all of the time, this uses the Windows task manager
* Last start date and time of the server
* Profile.vars.Arma3Profile deleter, potential performance increase
* Database backup script - WORK IN PROGRESS
* Optional Arma 3 Launcher Mission Prefetch - Allows clients to download server file from A3Launcher, can reduce server load
* Optional Steam Automatic updater for ARMA 3
* Optional Steam Automatic updater for mods - WORK IN PROGRESS
* Detailed comments explaining what all of the script does

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

https://a3.launcher.eu/download

SteamCMD:

https://developer.valvesoftware.com/wiki/SteamCMD

ARMA Mods: 

http://steamcommunity.com/app/107410/workshop

### How do I add x mod?
If it is a serverside mod (9/10 times it is), then add it to your mod folder and goto the 'Start the Arma Server' section in this .bat

Add the mod to your mod parameter for example adding ``Mod3`` to ``"-mod=@Mod1; @Mod2;"``

You would do:
``"-mod=@Mod1; @Mod2; @Mod3;"``

If it is a client mod (e.g. JSRS) then there is **no need to add it to startup!**, just the .bikey into your BIKey folder

### Will you add this feature, why is x broken?
Create a new issue or send DannyDorito a message on Twitter and we can see what we can do!
