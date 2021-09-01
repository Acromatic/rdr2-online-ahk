; v1.0.1
; ^ don't remove or alter this line (autoupdate)
;#Warn   ;---------- For debugging

#NoEnv
SetTitleMatchMode, 3
#MaxThreadsPerHotkey 2
#SingleInstance, Force               
SetWorkingDir %A_ScriptDir% 

; Run as Admin to ensure the script will work
IF NOT A_IsAdmin
{
	Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
	ExitApp
}

SetScrollLockState, AlwaysOff
Global KeySendDelay := 1      	;----> Delay between send key commands.
Global KeyPressDuration := 90		;----> Duration each key press is held down.
setkeydelay, %KeySendDelay%, %KeyPressDuration%, true

CFG = config.ini
; Check for updates?
CheckForUpdates    	     := true  ; Initial status IS OPTIONAL - if you change the code set this false until you change your update URL
IsEnhancedAFKActivated   := false ; Initial status should always be false ( Also mostly passive, don't rebind)
IsAFKActivated       	:= false ; Initial status should always be false
IsPatrolAFKActivated 	:= false ; Initial status should always be false
IsClickerActivated   	:= false ; Initial status should always be false
IsCookingActivated    	:= false ; Initial status should always be false
IsFinaleActivated    	:= false ; Initial status should always be false
FinaleType     := 0 	 ; Initial status should always be zero
IsTimerSet     := 0 	 ; Initial status should always be zero
TimeMins 		:= 0
TimeSecs 		:= 0
LoopCount      := 3     ; Number of times to multisample TimeSecz, values < 3 will break multisampling

;////// Initialize the GUI for On Screen Display
CustomColor := "AAAAAA"  ; Can be any RGB color (it will be made transparent below).
Gui +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Color, %CustomColor%
Gui, Font, s19  ; Set a large font size (32-point).
Gui, Add, Text, vMyText cLime, XXXXX YYYYY  ; XX & YY serve to auto-size the window.

; Make all pixels of this color transparent and make the text itself translucent (150):
WinSet, TransColor, %CustomColor% 150
SetTimer, UpdateOSD, 10  ; There are also delays in the function
Gosub, UpdateOSD
Gui, Show, x800 y50 NoActivate  ; NoActivate avoids deactivating the currently active window.

;////// another gui script snippet
;Gui Color, 0xFF0000
;Gui +E0x20 -Caption +LastFound +ToolWindow +AlwaysOnTop
;WinSet, Transparent, 100
;Gui Show, w200 h200
;return


;///////////// Write config.ini (Script Configuration w/Hotkeys) /////////////

IfNotExist,%CFG%
{

;/////////////////   Settings     ///////////////

IniWrite, 1, %CFG%, Settings, LoadEditorOnStart
IniWrite, 1, %CFG%, Settings, UpdateEditorOnStart
IniWrite, 1, %CFG%, Settings, AutoUpdateOnStart
IniWrite, 0, %CFG%, Settings, SilentUpdateOnStart

;/////////////////// Singleplayer ONLY binds ///////////////

IniWrite, F11 , %CFG%, SinglePlayerHotkeys, BeatPoker

;//////////////////  Online Macros  ////////////////////

IniWrite, ^Enter, %CFG%, Hotkeys, PassiveToggleCookingOn
IniWrite, x, %CFG%, Hotkeys, PassiveToggleCookingOff

IniWrite, j, %CFG%, Hotkeys, ToggleEnhancedAFK
IniWrite, o, %CFG%, Hotkeys, TogglePatrolAFK
IniWrite, k, %CFG%, Hotkeys, ToggleAFK

IniWrite, F5, %CFG%, Hotkeys, ToggleDefensive
IniWrite, z, %CFG%, Hotkeys, ToggleClicker
IniWrite, F9, %CFG%, Hotkeys, ToggleFinale

IniWrite, NumpadHome , %CFG%, Hotkeys, Health
IniWrite, NumpadUp , %CFG%, Hotkeys, Stamina
IniWrite, NumpadPgUp , %CFG%, Hotkeys, Deadeye
IniWrite, NumpadLeft , %CFG%, Hotkeys, HealCores

IniWrite, NumpadClear , %CFG%, Hotkeys, WildernessCamp
IniWrite, NumpadRight , %CFG%, Hotkeys, ItemSlot

IniWrite, NumpadEnd , %CFG%, Hotkeys, HuntingWagon
IniWrite, NumpadDown , %CFG%, Hotkeys, BountyWagon
IniWrite, NumpadPgDn , %CFG%, Hotkeys, DismissWagons
IniWrite, NumpadIns , %CFG%, Hotkeys, FeedHorse

IniWrite, t, %CFG%, Hotkeys, ShowPosses
IniWrite, y, %CFG%, Hotkeys, FormPosse
IniWrite, F6, %CFG%, Hotkeys, QuickRace
IniWrite, NumpadDiv , %CFG%, Hotkeys, MenuSlotTwo
IniWrite, NumpadMult , %CFG%, Hotkeys, MenuSlotFour

IniWrite, NumpadSub , %CFG%, Hotkeys, VolumeDown
IniWrite, NumpadAdd , %CFG%, Hotkeys, VolumeUp
IniWrite, F10 , %CFG%, Hotkeys, ReloadScript
IniWrite, +>Escape , %CFG%, Hotkeys, AbortScript

}

sleep, 2000

IfExist, %CFG%
{ 
;/////////////////   Settings     ///////////////
IniRead, Read_LoadEditorOnStart, %CFG%, Settings, LoadEditorOnStart
IniRead, Read_UpdateEditorOnStart, %CFG%, Settings, UpdateEditorOnStart
IniRead, Read_AutoUpdateOnStart, %CFG%, Settings, AutoUpdateOnStart
IniRead, Read_SilentUpdateOnStart, %CFG%, Settings, SilentUpdateOnStart

;/////////////////// Singleplayer ONLY binds ///////////////
IniRead, Read_BeatPokerKey, %CFG%, SinglePlayerHotkeys,BeatPoker

;//////////////////  Online Macros  ////////////////////
IniRead, Read_PassiveToggleCookingOnKey, %CFG%,Hotkeys,PassiveToggleCookingOn
IniRead, Read_PassiveToggleCookingOffKey, %CFG%,Hotkeys,PassiveToggleCookingOff

IniRead, Read_ToggleEnhancedAFKKey, %CFG%,Hotkeys,ToggleEnhancedAFK
IniRead, Read_TogglePatrolAFKKey, %CFG%,Hotkeys,TogglePatrolAFK
IniRead, Read_ToggleAFKKey, %CFG%,Hotkeys,ToggleAFK
IniRead, Read_ToggleDefensiveKey, %CFG%,Hotkeys,ToggleDefensive
IniRead, Read_ToggleClickerKey, %CFG%,Hotkeys,ToggleClicker
IniRead, Read_ToggleFinaleKey, %CFG%,Hotkeys,ToggleFinale

IniRead, Read_HealthKey, %CFG%, Hotkeys,Health
IniRead, Read_StaminaKey, %CFG%, Hotkeys,Stamina
IniRead, Read_DeadeyeKey, %CFG%, Hotkeys,Deadeye
IniRead, Read_HealCoresKey, %CFG%, Hotkeys,HealCores

IniRead, Read_WildernessCampKey, %CFG%, Hotkeys,WildernessCamp
IniRead, Read_ItemSlotKey, %CFG%, Hotkeys,ItemSlot

IniRead, Read_HuntingWagonKey, %CFG%, Hotkeys,HuntingWagon
IniRead, Read_BountyWagonKey, %CFG%, Hotkeys,BountyWagon
IniRead, Read_DismissWagonsKey, %CFG%, Hotkeys,DismissWagons
IniRead, Read_FeedHorseKey, %CFG%, Hotkeys,FeedHorse

IniRead, Read_ShowPossesKey, %CFG%, Hotkeys,ShowPosses
IniRead, Read_FormPosseKey, %CFG%, Hotkeys,FormPosse
IniRead, Read_QuickRaceKey, %CFG%, Hotkeys,QuickRace
IniRead, Read_MenuSlotTwoKey, %CFG%, Hotkeys,MenuSlotTwo
IniRead, Read_MenuSlotFourKey, %CFG%, Hotkeys,MenuSlotFour

IniRead, Read_VolumeDownKey, %CFG%, Hotkeys,VolumeDown
IniRead, Read_VolumeUpKey, %CFG%, Hotkeys,VolumeUp
IniRead, Read_ReloadScriptKey, %CFG%, Hotkeys,ReloadScript
IniRead, Read_AbortScriptKey, %CFG%, Hotkeys,AbortScript

}

if(Read_AutoUpdateOnStart=1)
{
	; Check for script updates on startup
	if (CheckForUpdates=true) {
	  performUpdateCheck(true)
	}
}

if(Read_LoadEditorOnStart=1)
{
	RunWait, RDR2Config.ahk
}

Hotkey, %Read_PassiveToggleCookingOnKey%, PassiveToggleCookingOn
Hotkey, %Read_PassiveToggleCookingOffKey%, PassiveToggleCookingOff

Hotkey, %Read_ToggleEnhancedAFKKey%, ToggleEnhancedAFK
Hotkey, %Read_TogglePatrolAFKKey%, TogglePatrolAFK
Hotkey, %Read_ToggleAFKKey%, ToggleAFK
Hotkey, %Read_ToggleDefensiveKey%, ToggleDefensive
Hotkey, %Read_ToggleClickerKey%, ToggleClicker
Hotkey, %Read_ToggleFinaleKey%, ToggleFinale

Hotkey, %Read_HealthKey%, Health
Hotkey, %Read_StaminaKey%, Stamina
Hotkey, %Read_DeadeyeKey%, Deadeye
Hotkey, %Read_HealCoresKey%, HealCores

Hotkey, %Read_WildernessCampKey%, WildernessCamp
Hotkey, %Read_ItemSlotKey%, ItemSlot

Hotkey, %Read_HuntingWagonKey%, HuntingWagon
Hotkey, %Read_BountyWagonKey%, BountyWagon
Hotkey, %Read_DismissWagonsKey%, DismissWagons
Hotkey, %Read_FeedHorseKey%, FeedHorse

Hotkey, %Read_ShowPossesKey%, ShowPosses
Hotkey, %Read_FormPosseKey%, FormPosse
Hotkey, %Read_QuickRaceKey%, QuickRace
Hotkey, %Read_MenuSlotTwoKey%, MenuSlotTwo
Hotkey, %Read_MenuSlotFourKey%, MenuSlotFour

Hotkey, %Read_VolumeDownKey%, VolumeDown
Hotkey, %Read_VolumeUpKey%, VolumeUp
Hotkey, %Read_ReloadScriptKey%, ReloadScript
Hotkey, %Read_AbortScriptKey%, AbortScript

;/////////////////// Singleplayer ONLY binds ///////////////

Hotkey, %Read_BeatPokerKey%, BeatPoker

; ==============
; === UPDATE ===
; ==============
performUpdateCheck(silentSuccess = false) {
  URLDownloadToFile,https://raw.githubusercontent.com/Acromatic/rdr2-online-ahk/main/RDR2.ahk,update.txt
  if (errorlevel) {
    msgbox, 0, Error - RDR2 Online AHK-Macros, Received error response from GitHub and update check was canceled.`nPlease retry later or check manually.`n`nHint: Set CheckForUpdates to false to disable automatic checking!
    FileDelete, update.txt
    return
  }

  FileReadLine, update, update.txt, 1
  FileReadLine, currentVersion, %A_ScriptName%, 1
  if (update = currentVersion) {
    FileDelete, update.txt
    if (!silentSuccess)
      msgbox, You are running the latest version!`n`n%update%`n`nIf something doesn't work please let me know!`n`nhttps://github.com/Acromatic/rdr2-online-ahk/
  } else if (InStr(update, "; v") = 1) {
    MsgBox, 4, Update available! - RDR2 Online AHK-Macros, A new version of RDR2 Online AHK-Macros has been released!`n`n%currentVersion% <-- your version`n%update% <-- available update`n`nWould you like to update?`n`nWarning: If you don't use config.ahk this might reset all your settings!
    IfMsgBox Yes
    {
      FileCopy, update.txt, %A_ScriptName%, 1
      FileDelete, update.txt
      FileDelete, README.md

	;/// Update the readme file
      UpdateReadMe()

      msgbox, 0, Update successful! - RDR2 Online AHK-Macros, Update successful, the script will now reload!`n`nHint: Check for new stuff `;)
      reload
    }
    IfMsgBox No
    {
      msgbox, This script will NOT be updated!`n`nHint: Set CheckForUpdates to false to disable automatic checking!
      FileDelete, update.txt
    }
  } else {
    msgbox, 0, Error - RDR2 Online AHK-Macros, Received invalid response from GitHub and update check was canceled.`nPlease retry later or check manually.`n`nHint: Set CheckForUpdates to false to disable automatic checking!
    FileDelete, update.txt
  }
}
return

CheckForUpdates:
  performUpdateCheck()
  return
  
UpdateReadMe()
{
;///////////////// Update Readme file  //////////////////////
URLDownloadToFile,https://raw.githubusercontent.com/Acromatic/rdr2-online-ahk/main/README.md,readme.txt
	  if (errorlevel) {
	    msgbox, 0, Error - RDR2-Online-AHK Macros, Received error response from GitHub and failed to download README.md.`nPlease retry later or check 				manually.`nHint: Set CheckForUpdates to false to disable automatic checking!
	    FileDelete, readme.txt
	    return
	  }
	
	  FileReadLine, readme, readme.txt, 1
	  FileReadLine, currentVersion, %A_ScriptName%, 1
	  if (readme = currentVersion) {
	    FileDelete, readme.txt
	    if (!silentSuccess)
	      msgbox, You have the latest version of README.md!`n%update%`nIf something doesn't work please let me know!`nhttps://github.com/Acromatic/rdr2-online-	ahk/
		  } 
		  else if (InStr(readme, "; v") = 1) {
		    MsgBox, 4, Update available! - RDR2-Online-AHK Macros, A new version of README.md has been released!`n%currentVersion% <-- your version`n%update% <-- available update`nWould you like to update?`nWarning: If you don't use config.ini this might delete your README.md!
		    IfMsgBox Yes
		    {
		      FileCopy, readme.txt, %A_ScriptName%, 1
		      FileDelete, readme.txt
		      FileDelete, README.md
		      msgbox, 0, Update successful! - README.md, Update successful!
		      reload
		    }
		    IfMsgBox No
		    {
		      msgbox, This script will NOT be updated!`nHint: Set CheckForUpdates to false to disable automatic checking!
		      FileDelete, readme.txt
		    }
		  } 
		  else {
		  msgbox, 0, Error - RDR2-Online-AHK Macros, Received invalid response from GitHub and failed to download README.md.`nPlease retry later or	check manually.`nHint: Set CheckForUpdates to false to disable automatic checking!
	    FileDelete, readme.txt
	  }
	}
return
;/////////////// End Update README.md //////////////////////////

;///////////////////////////   Auto Keys   /////////////////////////////////////
#IfWinActive, Red Dead Redemption 2      
{
turnCapslockOff()

	$j::
	KeyWait, j, T0.1
	
	if (ErrorLevel){
		LongDelay()
		Send {j down}
		LongDelay()
		Send {j up}
		ErrorLevel=0
	}

	$^s::
	KeyWait, s, T0.1
	
	if (ErrorLevel){
	;Send {s down}
	}

	
	$^w::
	KeyWait, w, T0.1
	
	if (ErrorLevel)
	{
		Send {w down}
		;Send {LShift down}  ;//// another way to autorun ( non-shift-independent )
	}

	$^LShift::
	KeyWait, LShift, T0.1
 
	if (ErrorLevel){
		Send {LShift down}  ;/// also this bind must come last
	}
return
}
;/////////////////////////////////////////////////////////////////////////////
;//////////////////////////   Enhanced Catalog and AFK     ///////////////////

; Toggle AFK - tap a key to avoid getting kicked, you can also use the catalog
; This one is passive, it makes holding j unnessary incase you need to go AFK quickly and easily the normal way
; only better! It automatically shuts off and uses the J key bind so you'll never even notice how awsome it is!

ToggleEnhancedAFK:
  IsEnhancedAFKActivated := !IsEnhancedAFKActivated

  if (IsEnhancedAFKActivated) {
    Loop {
   	;ToolTip, Enhanced AFK Mode Enabled,0,0
	Send {j down}
	LongDelay()
	LongDelay()
    	
   	;ToolTip, Enhanced AFK Mode Disabled,0,0
	Send {j}
        break
      }
    }
  return

;//////////////////////////    Patrol Toggle     /////////////////////////////

; Toggle Patrol AFK (move left/right in a loop to not get kicked)
; This one is for Horseback and Walking Patrols, mostly it just looks cool

TogglePatrolAFK:
  IsPatrolAFKActivated := !IsPatrolAFKActivated

  if (IsPatrolAFKActivated) {
    Loop {
   	;ToolTip, Patrol Mode Enabled,0,0

      	LongDelay()
	Send {d up}
	ShortDelay()
	Send {a down}

      if (!IsPatrolAFKActivated) {
   	;ToolTip, Patrol Mode Disabled,0,0
	ShortDelay()
	Send {a up}
        break
      }

      	LongDelay()
	Send {a up}
	ShortDelay()
	Send {d down}

      if (!IsPatrolAFKActivated) {
   	;ToolTip, Patrol Mode Disabled,0,0
	ShortDelay()
	Send {d up}
        break
      }
    }
  }
  return

;//////////////////////////   AFK Toggle     /////////////////////////////

; Toggle AFK - tap a key to avoid getting kicked, you can also use the catalog 
; This one is for carts (Bounty) and Stealth-AFK, it changes to reverse view to keep an eye on things

ToggleAFK:
  IsAFKActivated := !IsAFKActivated

  if (IsAFKActivated) {
    Loop {
   	;ToolTip, AFK Mode Enabled,0,0

      	SuperLongDelay()
	Send {c up}
      	SuperLongDelay()
	Send {c down}

      if (!IsAFKActivated) {
   	;ToolTip, AFK Mode Disabled,0,0
	Send {c up}
        break
      }
    }
  }
  return

;//////////////////////////   Clicker Toggle     /////////////////////////////

; Toggle Rapid-Fire Clicker

ToggleClicker:
  IsClickerActivated := !IsClickerActivated

  if (IsClickerActivated) {
    Loop {
      Click
      Sleep 1

      if (!IsClickerActivated) {
        break
      }
    }
}
return

;//////////////////////////    Defensive Toggle     /////////////////////////////

ToggleDefensive:
OpenPlayerMenu()
Send {Up}
SendEnter()
Send {Up 4}
Send {Left}

ClosePlayerMenu()
return      

;///////////////////////////        Health Slot        ///////////////////////////////////

Health:
OpenTabMenu()
MouseMove, 766, 354
;SendEnter()
CloseTabMenu()
return	

;///////////////////////////        Stamina Slot       ///////////////////////////////////

Stamina:
OpenTabMenu()
MouseMove, 954, 271
;SendEnter()
CloseTabMenu()
return				

;///////////////////////////        Dead Eye Slot      ////////////////////////////////////

Deadeye:
OpenTabMenu()
MouseMove, 1147, 350
;SendEnter()
CloseTabMenu()
return	

;///////////////////////////        Heal Cores Slot    //////////////////////////////////////

HealCores:
OpenTabMenu()
MouseMove, 691, 550
;SendEnter()
CloseTabMenu()
return	

;///////////////////////////        Wilderness Camp    //////////////////////////////////////

WildernessCamp:
OpenTabMenu()
MouseMove, 963, 815
CloseTabMenu()
return	

;///////////////////////////        Item Slot    //////////////////////////////////////

ItemSlot:
OpenTabMenu()
MouseMove, 1231, 548
Send {q 2}
CloseTabMenu()
return

;///////////////////////////     Hunting Wagon    //////////////////////////////////////

HuntingWagon:
OpenPlayerMenu()
LongDelay()
Send {Down 7}
SendEnter()
Send {Down}
SendEnterEnter()
SendEnter()
ClosePlayerMenu()
return		

;///////////////////////////     Bounty Wagon    /////////////////////////////////

BountyWagon:
OpenPlayerMenu()
LongDelay()
Send {Down 7}
SendEnter()
Send {Down}
SendEnterEnter()
Send {Down}
SendEnter()
ClosePlayerMenu()
return	

;///////////////////////////     Dismiss Wagons    /////////////////////////////////

DismissWagons:
OpenPlayerMenu()
SuperShortDelay() 
Send {e}
SuperShortDelay()
Send {Down 7}
SuperShortDelay()
Send {Enter}
LongDelay()
Send {Down}
SendEnterEnter()
ShortDelay()
Send {Space}
ShortDelay()
Send {Down}
ShortDelay()
Send {Space}
ClosePlayerMenu()
return	

;///////////////////////////     Feed Horse Slot    /////////////////////////////////

FeedHorse:
OpenTabMenu()
Send {r}
MouseMove, 691, 550
CloseTabMenu()
return	

;///////////////////////////     Open Posses List    ///////////////////////////

ShowPosses:
OpenPlayerMenu()
ShortDelay()
Send {Down 5}
SendEnter()
return	

;/////////////////////////          Form Posse       ////////////////////////////

FormPosse:     ;/ Name it with AAA's or something and keep it at the top of the list, joins last posse ( whatever is on top! )
OpenPlayerMenu()
LongDelay()
Send {Down 5}
SendEnterEnter()
SendEnter()
ClosePlayerMenu()
return	

;//////////////////////           Quick Race         //////////////////////////////

QuickRace:
OpenPlayerMenu()
ShortDelay()
Send {Up 2}{Enter}
ShortDelay()
Send {Up}
ShortDelay()
Send {Up}
ShortDelay()
Send {Up}
ShortDelay()
Send {Up}{Enter}
return	

;///////////////////////          Menu Slot Two      ///////////////////////////

MenuSlotTwo:
EscapeMenu()
ShortDelay()
MouseMove, 170, 852
ShortDelay()
Send {Enter}
sleep,2000
Send {Right}
ShortDelay()
Send {Enter}
LongDelay()
Send {Enter}
return	

;///////////////////////          Menu Slot Four      ///////////////////////////


MenuSlotFour:
EscapeMenu()
ShortDelay()
MouseMove, 170, 852
ShortDelay()
Send {Enter}
sleep,2000
Send {Right 2}
ShortDelay()
Send {Right}
ShortDelay()
Send {Enter}
LongDelay()
Send {Enter}
return	

;///////////////////////          Volume Down      ///////////////////////////

VolumeDown:
EscapeMenu()
ShortDelay()
MouseMove, 130, 960
LongDelay()
Send {Enter}
;MouseClick, left, 132, 965
ShortDelay()
Send {Enter}
ShortDelay()
Send {Right}
ShortDelay()
Send {Right}
ShortDelay()
Send {Enter}
ShortDelay()
ShortDelay()
Send {Left}
LongDelay()
Send {Left}
ShortDelay()
Send {ESC down}
return	

;///////////////////////          Volume Up       ///////////////////////////

VolumeUp:
EscapeMenu()
ShortDelay()
MouseMove, 131, 970
ShortDelay()
Send {Enter}
;MouseClick, left, 132, 965
ShortDelay()
Send {Enter}
ShortDelay()
Send {Right}
ShortDelay()
Send {Right}
ShortDelay()
Send {Enter}
LongDelay()
Send {Right}
LongDelay()
Send {Right}
ShortDelay()
Send {ESC down}
return	

;///////////////////////////       Experimental   /////////////////////////////
;//////////////////////////   Toggle Cooking     /////////////////////////////

; Toggle Cooking On - Ctrl+Enter to auto cook ( Last thing is brew coffee, x toggles off - reloads script)

PassiveToggleCookingOff:
if (IsCookingActivated) {
  IsCookingActivated := !IsCookingActivated
reload  ;////// bind with x failed, this is also good as a failsafe - We'll use the function instead and maybe write a log file :D
}
return

PassiveToggleCookingOn:
  IsCookingActivated := !IsCookingActivated

if (IsCookingActivated) {
	Loop{
		LongDelay()
		Send {Enter up}
		Send {Enter}
		LongDelay()
		Send {Space down}  ;/// For single player
		LongDelay()
		Send {Space up}    ;/// For single player
		Send {r}           ;/// For single player
		Send {Space}
		Send {Enter down}
		LongDelay()
		Send {f 2}	   ;/// For cooking menus (must come after esc for crafting)
		Send {Down}
		LongDelay()
		Send {Enter up}
	}
}
return

;//////////////////////    Beat Poker ( Singleplayer )     /////////////////////

BeatPoker:  ;// singleplayer
  IsBeatPokerActivated := !IsBeatPokerActivated

if (IsBeatPokerActivated) {
     Loop{
		ShortDelay()
		Send {Enter}
		LongDelay()
		Send {a down}
		ShortDelay()
		Send {Enter}
		Send {g}
		SuperLongDelay()
		Send {Enter}
		ShortDelay()
		Send {a up}
		Send {Up 30}
		ShortDelay()
		Send {RButton down}
		LongDelay()
		LongDelay()
		Send {Enter}
		ShortDelay()
		Send {RButton up}
		ShortDelay()
		
		if (!IsBeatPokerActivated) {
   	;ToolTip, BeatPoker Disabled,0,0
			break
		}
	}
}
return	

;//////////////////////////////////      Script Functions      ////////////////////////////////////////

ReloadScript:

	IsFinaleActivated=false
	IsTimerSet=0
	TimeMins = 00
	TimeSecs = 00
	TimeMinz = 00
	TimeSecz = 00
	FinaleType=0
	GuiControl,, MyText, Finale Mode: %FinaleType%
	sleep, 1000
	reload
return   

AbortScript:
	ExitApp
return 

;////// Delay-Functions
SuperShortDelay(){
sleep, 20 
}
return

ShortDelay(){
sleep, 200 
}
return

LongDelay(){
sleep, 800
}
return

SuperLongDelay(){
sleep, 3200
}
return

;////// a couple of code macros/functions for Send{Enter} w/proper delays and min/repeat typing functions
SendEnter(){
LongDelay()
Send {Enter}
}
return

SendEnterEnter(){
LongDelay()
Send {Enter}
LongDelay()
Send {Enter}
}
return

;////// Tab Menu is self explanitory. uses F4 to directly access the items dial-menu for speed
OpenTabMenu(){
Send {F4 down}
ShortDelay()
} 
return

CloseTabMenu(){
	Send {F4 up}
}
return

;////// player menu - L menu on PC
OpenPlayerMenu(){
	turnCapslockOff()
	Send {l}
	LongDelay()
} 
return

ClosePlayerMenu(){
	Loop, 4
	{
		LongDelay()
		Send {ESC}
		Send {ESC up}
	}
}
return

;//// the escape menu in game
EscapeMenu(){
;turnCapslockOff()
;ShortDelay()
Send {ESC}
SuperShortDelay()
}
return

;//// currently not used
invertCapsLockState(){ 
SetCapsLockState % !GetKeyState("CapsLock", "T") ;////////// requires [v1.1.30+]
}
return

;///// This will lock it off for a moment, called each time it's used
turnCapslockOff() {
  if (GetKeyState("CapsLock", "T") = 1) {
    SetCapsLockState, off
  }
}
return

;//////////////////      Mission Failsafe Mode    ///////////////////////////
;/////// Cycle the Mission Failsafe Modes ///////
ToggleFinale:
{
	if(FinaleType>=6){       ;////// off, drop-only, give-to-contact, and walk-in Finale Types 4-6 respectively
  	IsFinaleActivated := !IsFinaleActivated
    	FinaleType=0
	}
	else
	{
		if(!IsFinaleActivated){
		IsFinaleActivated=true
		Gui, Show, x910 y70 NoActivate
		}
	FinaleType++
	}
	GuiControl,, MyText, Finale Mode: %FinaleType%
}
return 

;/////// Capture, Syncronize the in-game-mission timer, than update OUR on-screen-display timer 
UpdateOSD:
{
	#IfWinActive, Red Dead Redemption 2 
	{
		if (IsFinaleActivated)
		{
			if(FinaleType<=3)
			{
				if(IsTimerSet=0)
				{
					TimeMins = 12
					TimeSecs = 54
					IsTimerSet=1
				}
				LongDelay()
				ShortDelay()
				TimeSecs--
				
				if(TimeSecs<1)
				{
					TimeMins--
					TimeSecs=59			
					
					if(TimeMins<0)
					{			
							;/// dead drop variant 
						if(FinaleType=1){
							Send {r down}
							LongDelay()
							Send {r up}
							reload
						}
							;/// contact drop variant 
						if(FinaleType=2){
							Send {RButton down}
							ShortDelay()
							Send {r down}
							LongDelay()
							Send {r up}
							Send {RButton up}
							reload
						}
							;/// drive in (bounty) variant 
						if(FinaleType=3){
							Send {w down}
							Send {LShift down}
							SuperLongDelay()
							Send {w up}
							Send {LShift up}
							reload
						}
					}		
				}
					;////// Anti-AFK
				if TimeSecs = 30 
				{
					Send {c down}
					LongDelay()
					Send {c up}
				}
					;/// Digit Formatting
				IfNotInString, TimeSecs, "0"
				{
					if TimeSecs < 10 
						TimeSecs = 0%TimeSecs%
				}			
				IfNotInString, TimeMins, "0"
				{
					if TimeMins < 10 
						TimeMins = 0%TimeMins%
				}			
				GuiControl,, MyText, %TimeMins%:%TimeSecs%
				return
			}
			else
			{
				;////// MultiSampling to increase precision, decrease false reads, also allows us to remove the delays with runwait
				Loop, 3
				{
						;////// Update Minutes
					Clip0 = %ClipBoardAll%
					Clipboard = ; Erase clipboard
					RunWait, C:\Program Files\Capture2Text\Capture2Text_CLI.exe --screen-rect "927 52 958 76" --clipboard --whitelist "0123456789",, hide
					ClipBoard = %ClipBoard%       ; Convert to text
					TimeMinz := RegExReplace(ClipBoard, "\D")
					Clipboard = %Clip0%              ; Restore clipboard
					Clip0=    ; Clear our clipboard cache, doing this in two steps to reduce clipboard crossover hopefully
					
					if TimeMinz - LastTimeMinz is between 1 and 5
						break
					else
						LastTimeMinz = TimeMinz
				}
				;////// MultiSampling to increase precision, decrease false reads, also allows us to remove the delays with runwait
				Loop, 3
				{
					;////// Now Update Seconds
					Clip0 = %ClipBoardAll%
					Clipboard = ; Erase clipboard
					RunWait, C:\Program Files\Capture2Text\Capture2Text_CLI.exe --screen-rect "962 52 993 76" --clipboard --whitelist "0123456789",, hide
					ClipBoard = %ClipBoard%       ; Just the text
					TimeSecz := RegExReplace(ClipBoard, "\D")   ; Filter only digits
					Clipboard = %Clip0%              ; Restore clipboard
					Clip0=    ; Clear our clipboard cache, doing this in two steps to reduce clipboard crossover hopefully
					
					if LastTimeSecz - TimeSecz is between 1 and 5
						break
					else
						LastTimeSecz = TimeSecz
				}
					;//////  Subtract seconds we use to capture data, and also
				;/// predict and manually replace timer when it reaches one or zero
				;/// increase reliability, reduce false timer results
				if TimeSecz >= 2 
					TimeSecz -= 2
				else
					TimeSecz = 59
				
				if TimeMinz < 1 
				{
					if TimeSecz <= 10 
					{
							;/// Drop-only
						if FinaleType = 4 
						{
							Send {r down}
							LongDelay()
							Send {r up}
							reload
						}
							;/// Drop-to-Contact
						if FinaleType = 5 
						{
							Send {RButton down}
							ShortDelay()
							Send {r down}
							LongDelay()
							Send {r up}
							Send {RButton up}
							reload
						}
							;/// Drive-in/Walk-in
						if FinaleType = 6 
						{
							Send {w down}
							Send {LShift down}
							SuperLongDelay()
							Send {w up}
							Send {LShift up}
							reload
						}
					}
				}
			}
				;////// Anti-AFK, again but different 
			;/// the catch-up timer skips some seconds we'll do a range instead
			if TimeSecz between 30 and 33
			{
				Send {c down}
				LongDelay()
				Send {c up}
			}
				;/// Digit Formatting
			IfNotInString, TimeSecz, "0" 
			{
				if(TimeSecz<10)
				{					
					TimeSecz=0%TimeSecz%
				}
			}				
			IfNotInString, TimeMinz, "0" 
			{
				if(TimeMinz<10)
				{
					TimeMinz=0%TimeMinz%
				}
			}			
			GuiControl,, MyText, %TimeMinz%:%TimeSecz%
			return
		}
		else 
		{  			
			FinaleType=0
			IsTimerSet=0
			TimeMins = 0
			TimeSecs = 0
			TimeMinz = 0
			TimeSecz = 0
			Gui, Hide
		} 
	} ;//// end ifwin
	return
} ;//// end UpdateOSD


