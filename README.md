# RDR2-Online-AHK Macros
RDR2 Online AHK-Macros on GitHub ([DOWNLOAD](https://github.com/Acromatic/rdr2-online-ahk/))
*provides hotkeys for several useful features in RDR2:Online, see list further down.

*I tested this with my account. If something doesn't work, ask by opening an issue
*I evidently do big missions most of the time so if you have ideas for useful macros, let me know or just send them in!

IF you delete your README and let the script generate one it'll display your autokey version in the new README below:

Your AutoHotkey Version: v 1.1.33.02
Midnight’s AutoHotkey Version: v 1.1.33.02
Original AutoHotkey Version: v 1.1.26.00

Language: English Platform: Windows 10 Home (64 bit)

Started by KeyMash , Sep 17 2015 06:33 PM
Original Author: twentyafterfour First Modified by: StArL0rd84
Posted by u/REDR0VER68 years ago (2017) Modified by: OriginalEmpire

Updated to 2020-21 by: Midnight ( January 2021 ) Rewritten for RDR2 by: Midnight ( August 2021 )

Introduction: Everthing in this script can be modified to your needs. BUT BE CAREFUL!
The Player Menu, Escape Menu, and Tab Menu have different delay times due to various reasons, 
so be sure to remember this if you are going to change the delay settings. 
Everything is dialed in so the macro’s are executed as fast and reliable as posible, 
maybe even faster than you will be able to do manually.
(Delays are measured in milliseconds) (1000 milliseconds in 1 second)

## Updates

Since v1.0 the script includes a simple auto updater. By default it will check for a new version on GitHub every time you launch the script.
If a new (or actually different) version is found it will prompt you to proceed or cancel.
See the readme section about using config.ahk if you plan on changing settings as the update will replace the main script file!

You can disable the automatic check in the configuration (`CheckForUpdates`).

* Updated to v6.7 (Example only)
* Added
* Fixed
* Removed

## Installation

  * Step 1 - Download the .ahk file (or clone the repo)
  * You can manually change the code but there is not much need the NEW CONFIG EDITOR WILL DO STEP 2!, 
  * runs at launch after the update check, if it does not open do the following
  * (open RDR2Quick.ini in a text editor and change UpdateCheck=0 to UpdateCheck=1)
  * 
  * Step 2 - Open it in a text editor (e.g. notepad++ with AutoIT syntax highlighting) and change the hotkeys ([key list](https://www.autohotkey.com/docs/KeyList.htm))
  * Step 3 - Install Dependencies - instructions below
  * Step 4 - You can now run the script - Doubleclick your .ahk file (open with AHK) Note: On Windows 10 right click -> run as admin

## Dependencies

  * [AutoHotkey](https://www.autohotkey.com/)
  * [Capture2Text](http://capture2text.sourceforge.net/) This is used to read text from the screen and capture the timer to reconstruct our own for finale mode
  * [pssuspend.exe and pskill.exe](https://docs.microsoft.com/en-us/sysinternals/downloads/pssuspend) in your path (for force disconnect and process killing, see instructions below)

## Dependencies Installation (pssuspend.exe / pskill.exe)

pssuspend.exe and pskill.exe are tools from the sysinternals collection. You can download the whole package (~3MB) [directly from Microsoft](https://docs.microsoft.com/en-us/sysinternals/downloads/pssuspend).
You can copy them all but we only need pssuspend and pskill so go ahead and extract/copy `pssuspend.exe` `pskill.exe` to ANY of the following:

capture2text.exe is an open source image to text capture program using the tesseract engine, you can download it [directly from sourceforge](http://capture2text.sourceforge.net/)

* in the same location where the .ahk file is
* or
* C:\Windows
* or
* C:\Windows\system32

**NOTE:** Start the pssuspend.exe AND pskill.exe once by double clicking on it and accept the license agreement or it will silently fail.
----------------------------------------------------------------------------------------------------------
## Will I get banned?

I'm not aware of any bans issued by Rockstar following the usage of AHK-scripts. I personally use AHK-scripts within
RDR2:O since 2020 and did not get banned. This is also not the only AHK-script available, I'm sure many are using them.
At the end it's your call but I'm 99% certain that it wont get you banned.

This Script doesn't do anything that an expensive mouse doesn't do but with less mouse clutter and more keyboard keys,
it also does next to nothing for controller users so there's that. Kind of a big deal with Red Dead
----------------------------------------------------------------------------------------------------------
## Usage

* On Windows 10 you have to start the AHK script as administrator (right click -> Run as administator)
* You should run the game in windowed or some functions will not work properly
* You will have to toggle some modes manually since the game will change and some functions need to be aware of that.
* The interaction menu is often delayed the first time it's opened after loading screens or cutscenes.
  Alternatively you can increase the IntMenuDelay setting for more accuracy but making the process slower in general.
* Some inputs will work and some will not depending on what is taking place, mostly failsafe, just reload script if problems occur
* Sometimes you might find that the script doesn't appear to do anything. This might happen if you start
  the game after the AHK script. Reloading it (right click on systray icon -> reload script) fixes that usually.

## Available macros

* **ToggleAutoRun** – Auto run/drive mode, combine this with walk to run/drive at proper full speed
* **ToggleAutoWalk** – Auto walk/trot mode, ctrl+w to walk, then ctrl+shift to run, tap each to disable seperately (shift and w)
* **ToggleAutoReverse** – Auto backwards mode, ctrl+s to reverse, tap s to disable (was more useful when I wrote it)

   -------------------------------------------------------------------------
* **ToggleCooking** – Auto Cooking mode
* **ToggleEnhancedAFK** – Enhanced AFK mode (this is mostly passive, speeds up j key)
* **TogglePatrolAFK** – Toggle Patrol mode (this is like gtav macros AFK, just moves left and right, circles on horseback)
* **ToggleDefensive** – Toggle Defensive mode
* **ToggleAFK** – Toggle AFK mode (my own version of AFK, uses look-behind to be AFK on carts and stealthly, no more catalog griefers!)
* **ToggleClicker** – Toggle Auto Clicker mode
* **ToggleFinale** – Cycle Auto Finish Missions mode

   -------------------------------------------------------------------------
* **Health** – Self Explainitory
* **Stamina** – Self Explainitory
* **Deadeye** – Self Explainitory
* **HealCores** – Self Explainitory
* **WildernessCamp** – Self Explainitory
* **ItemSlot** – use item from the ITEMS SLOT, such as metal detector, binoculars, or whatever else you select in that slot

   -------------------------------------------------------------------
* **HuntingWagon** – Calls the Hunting Cart (nice when it doesn't want to spawn)
* **BountyWagon** – Calls the Bounty Cart (nice when it doesn't want to spawn)
* **DismissWagons** – Dismisses both Hunting, and Bounty carts
* **FeedHorse** – Feeds Horse if you're riding one, if not pulls out your left rifle slot

   ------------------------------------------------------------
* **ShowPossesWindow** – Self Explainitory
* **FormPosse** – Form up the top-most posse, mine is named AAA Team but starting with numbers may also work
* **QuickRace** – Self Explainitory
* **MenuSlotTwo** – Opens the Online Menu, Chooses Row 1, Slot 2 (Load to Crimes currently, rockstar changes online menu)
* **MenuSlotFour** – Opens the Online Menu, Chooses Row 1, Slot 4 (Load to Camp currently, rockstar changes online menu)

   -------------------------------------------------------
* **VolumeUp** – Opens the settings, Turns the Volume Up
* **VolumeDown** – Opens the settings, Turns the Volume Down
* **ReloadScript** – Reloads the Script
* **AbortScript** – Exit / Shutdown the Script
* **SoloSession** – Force disconnect the game by freezing the process for 10 seconds (requires pssuspend.exe)
* **KillGame** – Kill the game process immediately (requires pskill.exe)

----------- Singleplayer ONLY binds -----------

* **BeatPoker** - This is a half working poker beating bot!
* **SPCooking** - cooking also works in SP, using same function in script as of v1.0

## Planned Features

* **CycleOutfit** – Cycle through your saved outfits

* **More single player binds** - possibly a seperate script

* **Merge with two other projects** - firstly this started as GTAV-Online-AHK Macros, so I want to merge that and update it, because it can share functions
and because this is AutoHotKey it makes sense to only have to run a single script (which will rebuild itself if needed). It'll also make development easier IMO
the other project is another macro that uses gosubs and seems to be faster, even though mine would beat his in an auto-clicker war his items are superior

## Config

This script features a new configuration editor script. You can also manually edit the RDR2Quick.ini with a text editor (adding features? Read Contributing below!)
----------------------------------------------------------------------------------------------------------
## Miscellaneous

#### modifier keys for hotkeys

If it's not clear enough from the key list. You can use [these symbols](https://autohotkey.com/docs/Hotkeys.htm#Symbols) in
combination with keys. For example `F1` could heal and `+F1` (shift+F1) could healcores.

Also you can not bind keys that are already used in the game, there is a certain part of my script that will, it's the part with (error) that is used to trigger
the cooking, autorun, autowalk, and enhanced AFK. Generally speaking double binding a game hotkey will fail. Here's a list of keys known to not work.

* The numpad has keys with special properties that AHK has problems dealing with, CTRL, ALT, Windows Key, are all like this
* Social Club uses home key, binding shift+any number will cause you not to be able to run with a horse and pull a weapon properly
* F1, F4, F12 are all used by the game
* F, C, V, B, N, M, L, H, G, R, E, are all used in game, you'll get issues binding these and more
* Generally speaking don't bind any of these, or with shift because of run, will also toggle the autorun off

## Contributing

  Contributions are very welcome! Either report errors, bugs and propose features or directly submit code:

  1. Fork it
  2. Create your feature branch (`git checkout -b my-new-feature`)
  3. Commit your changes (`git commit -am 'Added some feature'`)
  4. Push to the branch (`git push origin my-new-feature`)
  5. Create new Pull Request

## Legal

This repository is licensed under the MIT license.
