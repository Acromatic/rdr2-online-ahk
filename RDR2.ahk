;#Warn   ;---------- For debugging

#NoEnv
SetTitleMatchMode, 2
#MaxThreadsPerHotkey 2
#SingleInstance, Force               
SetWorkingDir %A_ScriptDir% 

; Run as Admin to ensure the script will work
IF NOT A_IsAdmin
{
	;Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
	Run *RunAs "%A_ScriptFullPath%"
	ExitApp
}

SetScrollLockState, AlwaysOff
Global KeySendDelay := 1      	;----> Delay between send key commands.
Global KeyPressDuration := 90		;----> Duration each key press is held down.
setkeydelay, %KeySendDelay%, %KeyPressDuration%, true

CFG = config.ini

IsDebugActivated   			:= false	; Initial status should always be false
IsClickerActivated   		:= false	; Initial status should always be false
IsCookingActivated    		:= false	; Initial status should always be false
IsMissionFailSafeActivated    := false	; Initial status should always be false
MissionFailSafeType     		:= 0 	; Initial status should always be zero
IsTimerSet     			:= 0		; Initial status should always be zero
TimeMins     				:= 0		; Initial status should always be zero
TimeSecs     				:= 0 	; Initial status should always be zero
;loopcount				:= 0		; Initial status should always be zero

;////// Initialize the GUI for On Screen Display
CustomColor := "7F7F7F"  ; Can be any RGB color (it will be made transparent below).

;////////////////////////////////////////// GUI ONE //////////////////////////////////////
;/// gui window for a line of text 
Gui, guione: +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, guione: Color, %CustomColor%
Gui, guione: Font, s19  ; Set a large font size (32-point).
Gui, guione: Add, Text, Left vMyText cLime, 00:00  ; 00:00 serves to auto-size the window.
;////// Make all pixels of this color transparent and make the text itself translucent (150):
WinSet, TransColor, %CustomColor% 200
;WinSet, AlwaysOnTop, %CustomColor% 150

;////// Initialize the GUI for On Screen Display
Gui, guione: Show, x905 y70 w100 h60 NoActivate  ; NoActivate avoids deactivating the currently active window.

;////////////////////////////////////////// GUI TWO //////////////////////////////////////
;/// another gui window for another line of text 
Gui, guitwo: +LastFound +AlwaysOnTop -Caption +ToolWindow ;+ToolWindow avoids a taskbar button and alt-tab menuitem.
Gui, guitwo: Color, %CustomColor%
Gui, guitwo: margin, 5,10
Gui, guitwo: font, s19 bold cwhite, Courier
Gui, guitwo: Add, Text, Center vMyText2 cYellow, \_RedDead-2-Online-Macros-Enabled_/ ; serves to auto-size the window.
;////// Make all pixels of this color transparent and make the text itself translucent (150):
WinSet, TransColor, %CustomColor% 150
;WinSet, AlwaysOnTop, %CustomColor% 150
Gui, guitwo: Show, x670 y110 w700 h40 NoActivate  ; NoActivate avoids deactivating the currently active window.

;////////////////////////////////////////// GUI THREE //////////////////////////////////////
;/// yet another gui window for yet another line of text 
;Gui, guithree: Color, 339900
Gui, guithree: +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, guithree: Color, %CustomColor%
Gui, guithree: margin, 5,10
Gui, guithree: font, s19 bold cwhite, Courier
Gui, guithree: Add, Text, Center vMyText3 cWhite, \___-- By: Acromatic --___/ ; "        " serve to auto-size the window.
;////// Make all pixels of this color transparent and make the text itself translucent (150):
WinSet, TransColor, %CustomColor% 220
;WinSet, AlwaysOnTop, %CustomColor% 150
Gui, guithree: Show, x740 y150 w600 h40 NoActivate  ; NoActivate avoids deactivating the currently active window.
sleep, 600
Gui, guione: Hide   ; gui 1
sleep, 1000
Gui, guithree: Hide ; gui 3
sleep, 1000
Gui, guitwo: Hide   ; gui 2

msgbox % "Script Running"
;////// Automatic Anti-Away-From-Keyboard - Fires a timed Send {AppsKey} to disable in-game AFK Disconnects 
;////// Least destructive key, requires RedDead Active Window - 120000 equals every 2 minutes
;////// The game changes the screen at 3:20mins but the prompt is at 2:20
SetTimer, UpdateAntiAFK, 120000

;////// another gui script snippet
;Gui Color, 0xFF0000
;Gui +E0x20 -Caption +LastFound +ToolWindow +AlwaysOnTop
;WinSet, Transparent, 100
;Gui Show, w200 h200
;return

;///////////// Write config.ini (Script Configuration wHotkeys) /////////////
IfNotExist, %CFG%
{
;/////////////////   Settings     ///////////////
	IniWrite, 1, %CFG%, Settings, LoadEditorOnStart
	IniWrite, 1, %CFG%, Settings, AutoUpdateOnStart
	IniWrite, 0, %CFG%, Settings, SilentUpdateOnStart
	IniWrite, F7, %CFG%, Settings, ToggleDebug
	IniWrite, F2 , %CFG%, Settings, RunScriptEditor
	
;/////////////////// Singleplayer ONLY binds ///////////////
	IniWrite, F11 , %CFG%, SinglePlayerHotkeys, BeatPoker
	
;//////////////////  Other Macros  ////////////////////
	IniWrite, F8, %CFG%, Hotkeys, AutoCooking
	IniWrite, z, %CFG%, Hotkeys, AutoClicker
	IniWrite, F5, %CFG%, Hotkeys, ToggleDefensive
	IniWrite, F9, %CFG%, Hotkeys, CycleMissionFailSafe
	
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
	IniWrite, +Escape , %CFG%, Hotkeys, AbortScript
	
	IniWrite, i , %CFG%, Hotkeys, TimerAddMinutes
	IniWrite, k , %CFG%, Hotkeys, TimerSubMinutes
	IniWrite, u , %CFG%, Hotkeys, TimerResetMinutes
	IniWrite, o , %CFG%, Hotkeys, TimerResetSeconds
}

sleep, 2000

IfExist, %CFG%
{ 
	
;/////////////////   Settings     ///////////////
	IniRead, Read_LoadEditorOnStart, %CFG%, Settings,LoadEditorOnStart
	IniRead, Read_AutoUpdateOnStart, %CFG%, Settings,AutoUpdateOnStart
	IniRead, Read_SilentUpdateOnStart, %CFG%, Settings,SilentUpdateOnStart
	IniRead, Read_ToggleDebugKey, %CFG%, Settings,ToggleDebug
	IniRead, Read_RunScriptEditorKey, %CFG%, Settings,RunScriptEditor
	
;/////////////////// Singleplayer ONLY binds ///////////////
	
	IniRead, Read_BeatPokerKey, %CFG%, SinglePlayerHotkeys,BeatPoker
	
;//////////////////  Online Macros  ////////////////////
	IniRead, Read_AutoCookingKey, %CFG%,Hotkeys,AutoCooking
	IniRead, Read_AutoClickerKey, %CFG%,Hotkeys,AutoClicker
	IniRead, Read_ToggleDefensiveKey, %CFG%,Hotkeys,ToggleDefensive
	IniRead, Read_CycleMissionFailSafeKey, %CFG%,Hotkeys,CycleMissionFailSafe
	
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
	
	IniRead, Read_TimerAddMinutesKey, %CFG%, Hotkeys, TimerAddMinutes
	IniRead, Read_TimerSubMinutesKey, %CFG%, Hotkeys, TimerSubMinutes
	IniRead, Read_TimerResetMinutesKey, %CFG%, Hotkeys, TimerResetMinutes
	IniRead, Read_TimerResetSecondsKey, %CFG%, Hotkeys, TimerResetSeconds
}

Hotkey, %Read_ToggleDebugKey%, ToggleDebug
Hotkey, %Read_ToggleDebugKey%, RunScriptEditor

;/////////////////// Singleplayer ONLY binds ///////////////

Hotkey, %Read_BeatPokerKey%, BeatPoker

;/////////////////// Other binds ///////////////

Hotkey, %Read_AutoCookingKey%, AutoCooking
Hotkey, %Read_AutoClickerKey%, AutoClicker
Hotkey, %Read_ToggleDefensiveKey%, ToggleDefensive
Hotkey, %Read_CycleMissionFailSafeKey%, CycleMissionFailSafe

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

Hotkey, %Read_TimerAddMinutesKey%, TimerAddMinutes
Hotkey, %Read_TimerSubMinutesKey%, TimerSubMinutes
Hotkey, %Read_TimerResetMinutesKey%, TimerResetMinutes
Hotkey, %Read_TimerResetSecondsKey%, TimerResetSeconds

SetTimer, UpdateOSD, 200  
;Gosub, UpdateOSD

if(Read_AutoUpdateOnStart=1)
{
	Gui, guitwo: Show, x670 y110 w700 h40 NoActivate
	;Gui, guitwo: Show, x670 y110 w700 h40 NoActivate
	;if FileExist(Update.ahk){
	;	FileGetTime, FileTime, Update.ahk
	;	FormatTime, FileTime, %FileTime%, YWeek
	;	
	;	FormatTime, YearWeek, YWeek
	;	if(%FileTime%>=%YearWeek%)
	;		GuiControl, guitwo:, MyText2, %FileTime%:%YearWeek%
	;	sleep, 3000
	;	return
	;}
	;else{
		
	URLDownloadToFile,https://raw.githubusercontent.com/Acromatic/rdr2-online-ahk/main/Update.ahk,updatecheck.txt
	if (errorlevel) {
		GuiControl, guitwo:, MyText2, Error update was aborted. Please try again.
		FileDelete, updatecheck.txt
		return
	}	
	FileReadLine, updatecheck, updatecheck.txt, 1
	if !FileExist("Update.ahk") {
		FileCopy, updatecheck.txt, Update.ahk, 1
 	}
	FileReadLine, currentVersion, Update.ahk, 1
	
	if (updatecheck = currentVersion){
		GuiControl, guitwo:, MyText2, No new updates were found.
		Sleep, 4000
	}
	else {
		if (!SilentSuccess)
			GuiControl, guitwo:, MyText2, Update available do NOT interupt!
		
		FileCopy, update.txt, Update.ahk, 1
     	FileDelete, update.txt
		FileDelete, updatecheck.txt
		Sleep, 4000
		Run *RunAs "C:\Program Files\AutoHotkey\AutoHotkey.exe" "Update.ahk" Read_SilentUpdateOnStart
		ExitApp
		return
	}
	
	if !FileExist("RDR2Config.ahk") {
	GuiControl, guitwo:, MyText2, RDR2Config.ahk not detected, UPDATING....
	Sleep, 4000
	Run *RunAs "C:\Program Files\AutoHotkey\AutoHotkey.exe" "Update.ahk" Read_SilentUpdateOnStart
	ExitApp
	return
}

if FileExist("updatecheck.txt")
	FileDelete, updatecheck.txt
GuiControl, guitwo:, MyText2, Completed checking for updates!
sleep, 4000
Gui, guitwo: Hide   ; gui 2
return
}

if(Read_LoadEditorOnStart=1)
{
    	GuiControl, guitwo:, MyText2, Starting Configuration Editor...
	RunWait, RDR2Config.ahk
	return
}


;//// the main loop of the program 
;Loop
;{
	;///////////////////////////   Auto Keys   /////////////////////////////////////
if (WinActive("Red Dead Redemption 2")){
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
		Send {s down}
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

if (WinActive("Red Dead Redemption 2")){
	Gui, guitwo: Show, x670 y110 w700 h40 NoActivate
	GuiControl, guitwo:, MyText2, Unsuspended
	Suspend,Off
	Sleep, 2000
	Gui, guitwo: Hide
}
else {
	Gui, guitwo: Show, x670 y110 w700 h40 NoActivate
	GuiControl, guitwo:, MyText2, Suspended
	Suspend,On
	Sleep, 2000
	Gui, guitwo: Hide
}

;//////////////////////////   Toggle Debug Mode    /////////////////////////////
ToggleDebug:
{
	IsDebugActivated := !IsDebugActivated
	if (WinActive("Red Dead Redemption 2"))
		if (IsDebugActivated) {
			Loop {
				if (WinActive("ahk_exe RDR2.exe")){
					;Click
					Sleep 1
					
					if (!IsDebugActivated) {
						break
					}
				}
			}
		}
	return
}	


;//////////////////////////   Clicker Toggle     /////////////////////////////
; Toggle Rapid-Fire Clicker
AutoClicker:
{
	IsClickerActivated := !IsClickerActivated
	if (WinActive("Red Dead Redemption 2"))
		if (IsClickerActivated) {
			Loop {
				if (WinActive("ahk_exe RDR2.exe")){
					Click
					Sleep 1
					
					if (!IsClickerActivated) {
						break
					}
				}
			}
		}
	return
}
;//////////////////////////    Defensive Toggle     /////////////////////////////
ToggleDefensive:
{
	if (WinActive("Red Dead Redemption 2")){
		OpenPlayerMenu()
		Send {Up}
		SendEnter()
		Send {Up 4}
		Send {Left}
		
		ClosePlayerMenu()
	}
	return      
}
;///////////////////////////        Health Slot        ///////////////////////////////////
Health:
{
	if (WinActive("Red Dead Redemption 2")){
		OpenTabMenu()
		MouseMove, 766, 354
		CloseTabMenu()
	}
	return	
}
;///////////////////////////        Stamina Slot       ///////////////////////////////////
Stamina:
{
	if (WinActive("Red Dead Redemption 2")){
		OpenTabMenu()
		MouseMove, 954, 271
		CloseTabMenu()
	}
	return	
}
;///////////////////////////        Dead Eye Slot      ////////////////////////////////////
Deadeye:
{
	if (WinActive("Red Dead Redemption 2")){
		OpenTabMenu()
		MouseMove, 1147, 350
		CloseTabMenu()
	}
	return
}

;///////////////////////////        Heal Cores Slot    //////////////////////////////////////
HealCores:
{
	if (WinActive("Red Dead Redemption 2")){
		OpenTabMenu()
		MouseMove, 691, 550
		Send {q}
		CloseTabMenu()
	}
	return
}

;///////////////////////////        Wilderness Camp    //////////////////////////////////////
WildernessCamp:
{
	if (WinActive("Red Dead Redemption 2")){
		OpenTabMenu()
		MouseMove, 963, 815
		CloseTabMenu()
	}
	return	
}

;///////////////////////////        Item Slot    //////////////////////////////////////
ItemSlot:
{
	if (WinActive("Red Dead Redemption 2")){
		OpenTabMenu()
		MouseMove, 1231, 548
		Send {q 2}
		CloseTabMenu()
	}
	return	
}

;///////////////////////////     Hunting Wagon    //////////////////////////////////////
HuntingWagon:
{
	if (WinActive("Red Dead Redemption 2")){
		OpenPlayerMenu()
		LongDelay()
		Send {Down 7}
		SendEnter()
		Send {Down}
		ShortDelay()
		SendEnterEnter()
		SendEnter()
		ClosePlayerMenu()
	}
	return	
}

;///////////////////////////     Bounty Wagon    /////////////////////////////////
BountyWagon:
{
	if (WinActive("Red Dead Redemption 2")){
		OpenPlayerMenu()
		LongDelay()
		Send {Down 7}
		SendEnter()
		Send {Down}
		SendEnterEnter()
		Send {Down}
		ShortDelay()
		SendEnter()
		ClosePlayerMenu()
	}
	return	
}

;///////////////////////////     Dismiss Wagons    /////////////////////////////////
DismissWagons:
{
	if (WinActive("Red Dead Redemption 2")){
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
	}
	return	
}

;///////////////////////////     Feed Horse Slot    /////////////////////////////////
FeedHorse:
{
	if (WinActive("Red Dead Redemption 2")){
		OpenTabMenu()
		Send {r}
		MouseMove, 691, 550
		CloseTabMenu()
	}
	return	
}

;///////////////////////////     Open Posses List    ///////////////////////////
ShowPosses:
{
	if (WinActive("Red Dead Redemption 2")){
		OpenPlayerMenu()
		ShortDelay()
		Send {Down 5}
		SendEnter()
	}
	return	
}

;/////////////////////////          Form Posse       ////////////////////////////
;/ Name it with AAA's or something and keep it at the top of the list, joins last posse ( whatever is on top! )
FormPosse:
{     
	if (WinActive("Red Dead Redemption 2")){
		OpenPlayerMenu()
		LongDelay()
		Send {Down 5}
		SendEnterEnter()
		SendEnter()
		ClosePlayerMenu()
	}
	return	
}

;//////////////////////           Quick Race         //////////////////////////////
QuickRace:
{
	if (WinActive("Red Dead Redemption 2")){
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
	}
	return	
}

;///////////////////////          Menu Slot Two      ///////////////////////////
MenuSlotTwo:
{
	if (WinActive("Red Dead Redemption 2")){
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
	}
	return	
}

;///////////////////////          Menu Slot Four      ///////////////////////////
MenuSlotFour:
{
	if (WinActive("Red Dead Redemption 2")){
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
	}
	return	
}

;///////////////////////          Volume Down      ///////////////////////////
VolumeDown:
{
	if (WinActive("Red Dead Redemption 2")){
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
	}
	return	
}

;///////////////////////          Volume Up       ///////////////////////////
VolumeUp:
{
	if (WinActive("Red Dead Redemption 2")){
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
	}
	return	
}

;///////////////////////         Timer Keys       ///////////////////////////
TimerAddMinutes:
{
	if (WinActive("Red Dead Redemption 2"))
		TimeMins++
	return	
}
TimerSubMinutes:
{
	if (WinActive("Red Dead Redemption 2"))
		TimeMins--
	return	
}
TimerResetMinutes:
{
	if (WinActive("Red Dead Redemption 2"))
		TimeMins=1
	return	
}
TimerResetSeconds:
{
	if (WinActive("Red Dead Redemption 2"))
		TimeSecs=30
	return	
}

AutoCooking:
{
	IsCookingActivated := !IsCookingActivated
	if (WinActive("Red Dead Redemption 2"))
		if (IsCookingActivated) {
			Loop{
				if (WinActive("Red Dead Redemption 2")){
					LongDelay()
					Send {Enter up}
					Send {Enter}
					LongDelay()
					Send {Space down}  ;/// For single player
					LongDelay()
					Send {Space up}    ;/// For single player
					Send {r}           ;/// For single player
					Send {Space}
					SendEnter()
					Send {Enter down}
					LongDelay()
					Send {f}	   ;/// For cooking menus (must come after esc for crafting)
					ShortDelay()
					Send {f}
					ShortDelay()
					Send {Down}
					LongDelay()
				}
			}
		}
	return
}

;//////////////////////    Beat Poker ( Singleplayer )     /////////////////////

BeatPoker:
{
;// singleplayer
	IsBeatPokerActivated := !IsBeatPokerActivated
	
	if (IsBeatPokerActivated) {
		Loop{
			if (WinActive("Red Dead Redemption 2"))
			{
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
	}
	return	
}

RunScriptEditor:
{
	if FileExist("AHK-Studio.ahk") {
		GuiControl, guitwo:, MyText2, AHK-Studio.ahk Activated....
		Sleep, 4000
		Run *RunAs "C:\Program Files\AutoHotkey\AutoHotkey.exe" "AHK-Studio.ahk"
		ExitApp
	}
	return
}

ReloadScript:
{
	;////// Need a log file in here 
	TimeMins = 0
	TimeSecs = 0
	TimeMins1 = 0
	TimeMins2 = 0
	TimeSecz = 0
	MissionFailSafeType=0
	GuiControl,, MyText2, MissionFailSafe Mode: %MissionFailSafeType%
	sleep, 1000
	reload
	ExitApp
	return	
}

AbortScript:
{
	;////// Need a log file in here 
	ExitApp
	return	
}
;////// Delay-Functions
SuperShortDelay(){
	if (WinActive("Red Dead Redemption 2"))
		sleep, 20 
	return
}


ShortDelay(){
	if (WinActive("Red Dead Redemption 2"))
		sleep, 200 
	return
}

LongDelay(){
	if (WinActive("Red Dead Redemption 2"))
		sleep, 800
	return
}

SuperLongDelay(){
	if (WinActive("Red Dead Redemption 2"))
		sleep, 3200
	return
}
;////// a couple of code macros/functions for Send{Enter} w/proper delays and min/repeat typing functions
SendEnter(){
	if (WinActive("Red Dead Redemption 2")){
		LongDelay()
		Send {Enter}
		LongDelay()
	}
	return
}

SendEnterEnter(){
	if (WinActive("Red Dead Redemption 2")){
		LongDelay()
		Send {Enter}
		LongDelay()
		Send {Enter}
		LongDelay()
	}
	return
}

;////// Tab Menu is self explanitory. uses F4 to directly access the items dial-menu for speed
OpenTabMenu(){
	if (WinActive("Red Dead Redemption 2")){
		Send {F4 down}
		ShortDelay()
	}
	return
} 

CloseTabMenu(){
	if (WinActive("Red Dead Redemption 2"))
		Send {F4 up}
	return
}

;////// player menu - L menu on PC
OpenPlayerMenu(){
	if (WinActive("Red Dead Redemption 2")){
		turnCapslockOff()
		Send {l}
		LongDelay()
	}
	return
} 

ClosePlayerMenu(){
	Loop, 4
	{
		if (WinActive("Red Dead Redemption 2")){
			LongDelay()
			Send {ESC}
			Send {ESC up}
		}
	}
	return
}

;//// the escape menu in game
EscapeMenu(){
	if (WinActive("Red Dead Redemption 2")){
		Send {ESC}
		ShortDelay()
	}
	return
}

;//// currently not used
invertCapsLockState(){ 
	if (WinActive("Red Dead Redemption 2"))
		SetCapsLockState % !GetKeyState("CapsLock", "T") ;////////// requires [v1.1.30+]
	return
}

;///// This will lock it off for a moment, called each time it's used
turnCapslockOff() {
	if (WinActive("Red Dead Redemption 2")){
		if (GetKeyState("CapsLock", "T") = 1) {
			SetCapsLockState, off
		}
	}
	return
}

;/////////////////      Mission Failsafe Mode    ///////////////////////////
;/////// Cycle the Mission Failsafe Modes ///////
CycleMissionFailSafe:
{
	if (WinActive("Red Dead Redemption 2")){
		MissionFailSafeType++
		Gui, guitwo: Show, x670 y110 w700 h40 NoActivate
		Gui, guithree: Show, x740 y150 w600 h40 NoActivate
		if(MissionFailSafeType>=7){       ;////// off, drop-only, give-to-contact, and walk-in MissionFailSafe Types 4-6 respectively
			IsMissionFailSafeActivated := !IsMissionFailSafeActivated
			MissionFailSafeType=0
			GuiControl, guitwo:, MyText2, Mission Failsafe Mode: Disabled
		}
		else
		{
			IsMissionFailSafeActivated=true
			if(MissionFailSafeType=1){
				GuiControl, guitwo:, MyText2, Legendary Mission Failsafe: type-1
				GuiControl, guithree:, MyText3, Dead-Drop Mode 
			}
			if(MissionFailSafeType=2){
				GuiControl, guitwo:, MyText2, Legendary Mission Failsafe: type-2
				GuiControl, guithree:, MyText3, Contact-Drop Mode
			}
			if(MissionFailSafeType=3){
				GuiControl, guitwo:, MyText2, Legendary Mission Failsafe: type-3
				GuiControl, guithree:, MyText3, Walk-In/Drive-In Mode
			}
			if(MissionFailSafeType=4){
				GuiControl, guitwo:, MyText2, Timed Mission Failsafe Mode: type-4
				GuiControl, guithree:, MyText3, Dead-Drop Mode
			}
			if(MissionFailSafeType=5){
				GuiControl, guitwo:, MyText2, Timed Mission Failsafe Mode: type-5
				GuiControl, guithree:, MyText3, Contact-Drop Mode
			}
			if(MissionFailSafeType=6){
				GuiControl, guitwo:, MyText2, Timed Mission Failsafe Mode: type-6
				GuiControl, guithree:, MyText3, Walk-In/Drive-In Mode
			}
		}
		sleep, 800
		Gui, guitwo: Hide
		sleep, 500
		Gui, guithree: Hide
	}
	return
}	

;/////////////////      Update Passive Background Anti-AFK    ///////////////////////////
UpdateAntiAFK:
{
	if (WinActive("Red Dead Redemption 2"))
		Send {AppsKey}
	return
}

;/////// Capture, Syncronize the in-game-mission timer, than update OUR on-screen-display timer 
UpdateOSD:
{
	if WinActive("Red Dead Redemption 2")
	{
		if (IsMissionFailSafeActivated)
		{
			Gui, guione: Show, x905 y70 w100 h60 NoActivate
			if(MissionFailSafeType<=3)
			{
				if(IsTimerSet=0)
				{
					TimeMins = 13
					TimeSecs = 49
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
		;/// dead drop legendary variant 
						if(MissionFailSafeType=1){
							Send {r down}
							LongDelay()
							Send {r up}
							reload
						}
		;/// contact drop legendary variant 
						if(MissionFailSafeType=2){
							Send {RButton down}
							ShortDelay()
							Send {r down}
							LongDelay()
							Send {r up}
							Send {RButton up}
							reload
						}
		;/// drive in (bounty) legendary variant 
						if(MissionFailSafeType=3){
							Send {w down}
							Send {LShift down}
							SuperLongDelay()
							Send {w up}
							Send {LShift up}
							reload
						}
					}		
				}
;/// Digit Formatting
				TimeSecs := Format("{:02}", TimeSecs)
				TimeMins := Format("{:02}", TimeMins)
				GuiControl, guione:, MyText, %TimeMins%:%TimeSecs%
				
			}
			else
			{
				Gui, guitwo: Show, x670 y110 w700 h40 NoActivate
				Gui, guithree: Show, x740 y150 w600 h40 NoActivate
				
;////// Update the first Minutes digit - for some reason minutes don't detect as well as seconds
				Clip0 = %ClipBoardAll%
				Clipboard = ; Erase clipboard
				RunWait, C:\Program Files\Capture2Text\Capture2Text_CLI.exe --screen-rect "924 52 942 76" --clipboard --whitelist "0123456789",, hide
				ClipBoard = %ClipBoard%       ; Convert to text
				TimeMins1:= RegExReplace(ClipBoard, "\D")
				
;////// Update the second Minutes digit - for some reason minutes don't detect as well as seconds
				RunWait, C:\Program Files\Capture2Text\Capture2Text_CLI.exe --screen-rect "942 52 958 76" --clipboard --whitelist "0123456789",, hide
				ClipBoard = %ClipBoard%       ; Convert to text
				TimeMins2 := RegExReplace(ClipBoard, "\D")
				Clipboard = %Clip0%              ; Restore clipboard
				Clip0=    ; Clear our clipboard cache, doing this in two steps to reduce clipboard crossover hopefully
				
;//////	8 Minute bug fix
				if (!(TimeMins1="0") and !(TimeMins2="0")){
					if (TimeMins2=""){
						TimeMins2=8
					}
				}
;/////  Timer only needs to display under 1 minute
				if(TimeMins2>=1)
				{
					GuiControl, guithree:, MyText3,
					GuiControl, guitwo:, MyText2,
				}
				else{
					GuiControl, guithree:, MyText3, Countdown Activated!
					GuiControl, guitwo:, MyText2,  %TimeMins2%
				}
	;GuiControl, guithree:, MyText3, %loopcount%
				
	;if TimeMinz - LastTimeMinz is between 1 and 5
	;	break
	;else
	;{
	;	LastTimeMinz = TimeMinz
	;}
				
;////// MultiSampling to increase precision, decrease false reads, also allows us to remove the delays with runwait
				Loop, 3
				{
	;////// Now Update Seconds
					Clipboard = ; Erase clipboard
					RunWait, C:\Program Files\Capture2Text\Capture2Text_CLI.exe --screen-rect "962 52 993 76" --clipboard --whitelist "0123456789",, hide
					ClipBoard = %ClipBoard%       ; Just the text
					TimeSecz := RegExReplace(ClipBoard, "\D")   ; Filter only digits
					
					if LastTimeSecz - TimeSecz is between 1 and 5
						break
					else
						LastTimeSecz = TimeSecz
				}
				Clipboard = %Clip0%              ; Restore clipboard
				Clip0=    ; Clear our clipboard cache, doing this in two steps to reduce clipboard crossover hopefully
				
;//////  Subtract seconds we use to capture data, and also
;/// predict and manually replace timer when it reaches one or zero
;/// increase reliability, reduce false timer results
				if TimeSecz >= 0 
					TimeSecz -= 1
				else
					TimeSecz = 59
				
				if (TimeMins1 < 1 and TimeMins2 = 0)
				{
					if (TimeSecz <= 8) 
					{
		;/// Drop-only
						if MissionFailSafeType = 4 
						{
							Send {r down}
							LongDelay()
							Send {r up}
							reload
						}
		;/// Drop-to-Contact
						if MissionFailSafeType = 5 
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
						if MissionFailSafeType = 6 
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
;return
			}
;/// Digit Formatting
			TimeSecz := Format("{:02}", TimeSecz)
			if(TimeMins1="")
				TimeMinz2 := Format("{:02}", TimeMins2)
			GuiControl, guione:, MyText, %TimeMins1%%TimeMins2%:%TimeSecz%
		}
		else 
		{  			
			IsTimerSet=0
			TimeSecs = 0
			TimeMins = 0
			TimeMins1 = 0
			TimeMins2 = 0
			TimeSecz = 0
			Gui, guione: Hide
			Gui, guitwo: Hide
			Gui, guithree: Hide
		} 
	} ;//// end ifwin
	return
} ;//// end UpdateOSD
