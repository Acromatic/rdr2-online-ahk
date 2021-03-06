;#Warn   ;---------- For debugging

#NoEnv
#SingleInstance, Force               
SetWorkingDir %A_ScriptDir%

; Run as Admin to ensure the script will work
IF NOT A_IsAdmin
{
	Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
	ExitApp
}

;/////////////////////////     Create Ini file    //////////////////////////////////

CFG = config.ini

IfExist, %CFG%
{ 
	;/////////////////   Settings     ///////////////
	IniRead, Read_LoadEditorOnStart, %CFG%, Settings, LoadEditorOnStart
	IniRead, Read_AutoUpdateOnStart, %CFG%, Settings, AutoUpdateOnStart
	IniRead, Read_SilentUpdateOnStart, %CFG%, Settings, SilentUpdateOnStart
	IniRead,Read_ToggleDebugKey, %CFG%, Settings, ToggleDebug
	IniRead,Read_RunScriptEditorKey, %CFG%, Settings, RunScriptEditor
	
	;/////////////////// Singleplayer ONLY binds ///////////////
	IniRead,Read_BeatPokerKey, %CFG%, SinglePlayerHotkeys,BeatPoker
	
	;//////////////////  Online Macros  ////////////////////
	IniRead,Read_AutoCookingKey, %CFG%,Hotkeys,AutoCooking
	IniRead,Read_ToggleDefensiveKey, %CFG%,Hotkeys,ToggleDefensive
	IniRead,Read_ToggleClickerKey, %CFG%,Hotkeys,ToggleClicker
	IniRead,Read_ToggleFinaleKey, %CFG%,Hotkeys,ToggleFinale
	
	IniRead,Read_HealthKey, %CFG%, Hotkeys,Health
	IniRead,Read_StaminaKey, %CFG%, Hotkeys,Stamina
	IniRead,Read_DeadeyeKey, %CFG%, Hotkeys,Deadeye
	IniRead,Read_HealCoresKey, %CFG%, Hotkeys,HealCores
	
	IniRead,Read_WildernessCampKey, %CFG%, Hotkeys,WildernessCamp
	IniRead,Read_ItemSlotKey, %CFG%, Hotkeys,ItemSlot
	
	IniRead,Read_HuntingWagonKey, %CFG%, Hotkeys,HuntingWagon
	IniRead,Read_BountyWagonKey, %CFG%, Hotkeys,BountyWagon
	IniRead,Read_DismissWagonsKey, %CFG%, Hotkeys,DismissWagons
	IniRead,Read_FeedHorseKey, %CFG%, Hotkeys,FeedHorse
	
	IniRead,Read_ShowPossesKey, %CFG%, Hotkeys,ShowPosses
	IniRead,Read_FormPosseKey, %CFG%, Hotkeys,FormPosse
	IniRead,Read_QuickRaceKey, %CFG%, Hotkeys,QuickRace
	IniRead,Read_MenuSlotTwoKey, %CFG%, Hotkeys,MenuSlotTwo
	IniRead,Read_MenuSlotFourKey, %CFG%, Hotkeys,MenuSlotFour
	
	IniRead,Read_VolumeDownKey, %CFG%, Hotkeys,VolumeDown
	IniRead,Read_VolumeUpKey, %CFG%, Hotkeys,VolumeUp
	IniRead,Read_ReloadScriptKey, %CFG%, Hotkeys,ReloadScript
	IniRead,Read_AbortScriptKey, %CFG%, Hotkeys,AbortScript
	
	IniRead, Read_TimerAddMinutesKey, %CFG%, Hotkeys,TimerAddMinutes
	IniRead, Read_TimerSubMinutesKey, %CFG%, Hotkeys,TimerSubMinutes
	IniRead, Read_TimerResetMinutesKey, %CFG%, Hotkeys,TimerResetMinutes
	IniRead, Read_TimerResetSecondsKey, %CFG%, Hotkeys,TimerResetSeconds
	
		;////// GuiControls
	GuiControl,,ToggleDebug,%Read_ToggleDebugKey%
	GuiControl,,RunScriptEditor,%Read_RunScriptEditorKey%
	
	GuiControl,,BeatPoker,%Read_BeatPokerKey%
	
	GuiControl,,AutoCooking,%Read_AutoCookingKey%
	GuiControl,,AutoClicker,%Read_AutoClickerKey%
	GuiControl,,ToggleDefensive,%Read_ToggleDefensiveKey%
	GuiControl,,CycleMissionFailSafe,%Read_CycleMissionFailSafeKey%
	
	GuiControl,,Health,%Read_HealthKey%
	GuiControl,,Stamina,%Read_StaminaKey%
	GuiControl,,Deadeye,%Read_DeadeyeKey%
	GuiControl,,HealCores,%Read_HealCoresKey%
	
	GuiControl,,WildernessCamp,%Read_WildernessCampKey%
	GuiControl,,ItemSlot,%Read_ItemSlotKey%
	
	GuiControl,,HuntingWagon,%Read_HuntingWagonKey%
	GuiControl,,BountyWagon,%Read_BountyWagonKey%
	GuiControl,,DismissWagons,%Read_DismissWagonsKey%
	GuiControl,,FeedHorse,%Read_FeedHorseKey%
	
	GuiControl,,ShowPosses,%Read_ShowPossesKey%
	GuiControl,,FormPosse,%Read_FormPosseKey%
	GuiControl,,QuickRace,%Read_QuickRaceKey%
	GuiControl,,MenuSlotTwo,%Read_MenuSlotTwoKey%
	GuiControl,,MenuSlotFour,%Read_MenuSlotFourKey%
	
	GuiControl,,VolumeDown,%Read_VolumeDownKey%
	GuiControl,,VolumeUp,%Read_VolumeUpKey%
	GuiControl,,ReloadScript,%Read_ReloadScriptKey%
	GuiControl,,AbortScript,%Read_AbortScriptKey%
	
	GuiControl,,TimerAddMinutes,%Read_TimerAddMinutesKey%
	GuiControl,,TimerSubMinutes,%Read_TimerSubMinutesKey%
	GuiControl,,TimerResetMinutes,%Read_TimerResetMinutesKey% 
	GuiControl,,TimerResetSeconds,%Read_TimerResetSecondsKey%
}

Gui, Add, Text,x10 y20 w150 h20,ToggleDebug Key:
Gui, Add, Text,x10 y50 w150 h20,RunScriptEditor Key:

Gui, Add, Text,x10 y80 w150 h20,BeatPoker Key:

Gui, Add, Text,x10 y110 w150 h20,AutoCooking Key:
Gui, Add, Text,x10 y140 w150 h20,AutoClicker Key:
Gui, Add, Text,x10 y170 w150 h20,ToggleDefensive Key:
Gui, Add, Text,x10 y200 w150 h20,CycleMissionFailSafe Key:

Gui, Add, Text,x10 y230 w150 h20,Health Key:
Gui, Add, Text,x10 y260 w150 h20,Stamina Key:
Gui, Add, Text,x10 y290 w150 h20,Deadeye Key:
Gui, Add, Text,x10 y320 w150 h20,HealCores Key:

Gui, Add, Text,x10 y350 w150 h20,WildernessCamp Key:
Gui, Add, Text,x10 y380 w150 h20,ItemSlot Key:

Gui, Add, Text,x10 y410 w150 h20,HuntingWagon Key:
Gui, Add, Text,x10 y440 w150 h20,BountyWagon Key:
Gui, Add, Text,x320 y20 w150 h20,DismissWagons Key:
Gui, Add, Text,x320 y50 w150 h20,FeedHorse Key:

Gui, Add, Text,x320 y80 w150 h20,ShowPosses Key:
Gui, Add, Text,x320 y110 w150 h20,FormPosse Key:
Gui, Add, Text,x320 y140 w150 h20,QuickRace Key:
Gui, Add, Text,x320 y170 w150 h20,MenuSlotTwo Key:
Gui, Add, Text,x320 y200 w150 h20,MenuSlotFour Key:

Gui, Add, Text,x320 y230 w150 h20,VolumeDown Key:
Gui, Add, Text,x320 y260 w150 h20,VolumeUp Key:
Gui, Add, Text,x320 y290 w150 h20,ReloadScript Key:
Gui, Add, Text,x320 y320 w150 h20,AbortScript Key:

Gui, Add, Text,x320 y350 w150 h20,TimerAddMinutes Key:
Gui, Add, Text,x320 y380 w150 h20,TimerSubMinutes Key:
Gui, Add, Text,x320 y410 w150 h20,TimerResetMinutes Key:
Gui, Add, Text,x320 y440 w150 h20,TimerResetSeconds Key:

;///////// HotKey Edit Boxes

Gui, Add, Hotkey,x160 y20 w150 h20 vToggleDebugKey,F3
Gui, Add, Hotkey,x160 y50 w150 h20 vRunScriptEditorKey,F2

Gui, Add, Hotkey,x160 y80 w150 h20 vBeatPokerKey,F11

Gui, Add, Hotkey,x160 y110 w150 h20 vAutoCookingKey,F8
Gui, Add, Hotkey,x160 y140 w150 h20 vAutoClickerKey,z
Gui, Add, Hotkey,x160 y170 w150 h20 vToggleDefensiveKey,F5
Gui, Add, Hotkey,x160 y200 w150 h20 vCycleMissionFailSafeKey,F9

Gui, Add, Hotkey,x160 y230 w150 h20 vHealthKey,NumpadHome
Gui, Add, Hotkey,x160 y260 w150 h20 vStaminaKey,NumpadUp
Gui, Add, Hotkey,x160 y290 w150 h20 vDeadeyeKey,NumpadPgUp
Gui, Add, Hotkey,x160 y320 w150 h20 vHealCoresKey,NumpadLeft

Gui, Add, Hotkey,x160 y350 w150 h20 vWildernessCampKey,NumpadClear 
Gui, Add, Hotkey,x160 y380 w150 h20 vItemSlotKey,NumpadRight 

Gui, Add, Hotkey,x160 y410 w150 h20 vHuntingWagonKey,NumpadEnd 
Gui, Add, Hotkey,x160 y440 w150 h20 vBountyWagonKey,NumpadDown 
Gui, Add, Hotkey,x480 y20 w150 h20 vDismissWagonsKey,NumpadPgDn
Gui, Add, Hotkey,x480 y50 w150 h20 vFeedHorseKey,NumpadIns

Gui, Add, Hotkey,x480 y80 w150 h20 vShowPossesKey,t
Gui, Add, Hotkey,x480 y110 w150 h20 vFormPosseKey,y
Gui, Add, Hotkey,x480 y140 w150 h20 vQuickRaceKey,F6
Gui, Add, Hotkey,x480 y170 w150 h20 vMenuSlotTwoKey,NumpadDiv 
Gui, Add, Hotkey,x480 y200 w150 h20 vMenuSlotFourKey,NumpadMult 

Gui, Add, Hotkey,x480 y230 w150 h20 vVolumeDownKey,NumpadSub
Gui, Add, Hotkey,x480 y260 w150 h20 vVolumeUpKey,NumpadAdd
Gui, Add, Hotkey,x480 y290 w150 h20 vReloadScriptKey,F10
Gui, Add, Hotkey,x480 y320 w150 h20 vAbortScriptKey,^Escape

Gui, Add, Hotkey,x480 y350 w150 h20 vTimerAddMinutesKey,i
Gui, Add, Hotkey,x480 y380 w150 h20 vTimerSubMinutesKey,k
Gui, Add, Hotkey,x480 y410 w150 h20 vTimerResetMinutesKey,u
Gui, Add, Hotkey,x480 y440 w150 h20 vTimerResetSecondsKey,o


if Read_LoadEditorOnStart = 1
	Gui, Add, CheckBox, x60 y540 w150 h20 Checked vLoadEditorOnStart, Run Config Editor on start?
else Gui, Add, CheckBox, x60 y540 w150 h20 vLoadEditorOnStart, Run Config Editor on start?
	
if Read_AutoUpdateOnStart = 1
	Gui, Add, CheckBox, x360 y540 w150 h20 Checked vAutoUpdateOnStart, Auto Update on start?
else Gui, Add, CheckBox, x360 y540 w150 h20 vAutoUpdateOnStart, Auto Update on start?
	
if Read_SilentUpdateOnStart = 1 
	Gui, Add, CheckBox, x370 y560 w150 h20 Checked vSilentUpdateOnStart, Silent Updates?
else Gui, Add, CheckBox, x370 y560 w150 h20 vSilentUpdateOnStart, Silent Updates?
	
Gui, Add, Button, x50 y580 w200 h50 gButtonExit, Exit
Gui, Add, Button, x350 y580 w200 h50 gSave, Save and Run

Gui, Show, w640 h700, RDR Online Quick Macros
return 

;/////////////////////  Functions   /////////////////

ButtonExit:
ExitApp
return

Save:
{
	Gui, Submit
	
	IfExist, %CFG%
	{ 
		FileDelete, config.ini
	}
	
	;/////////////////   Settings     ///////////////
	IniWrite, %LoadEditorOnStart%, %CFG%, Settings, LoadEditorOnStart
	IniWrite, %AutoUpdateOnStart%, %CFG%, Settings, AutoUpdateOnStart
	IniWrite, %SilentUpdateOnStart%, %CFG%, Settings, SilentUpdateOnStart
	IniWrite, %ToggleDebugKey%, %CFG%, Settings, ToggleDebug
	IniWrite, %RunScriptEditorKey%, %CFG%, Settings, RunScriptEditor
	
	;/////////////////// Singleplayer Only Binds ///////////////
	IniWrite, %BeatPokerKey%, %CFG%, SinglePlayerHotkeys, BeatPoker
	
	;//////////////////  Online Macros  ////////////////////
	IniWrite, %AutoCookingKey%, %CFG%, Hotkeys, AutoCooking
	IniWrite, %ToggleClickerKey%, %CFG%, Hotkeys, AutoClicker
	IniWrite, %ToggleDefensiveKey%, %CFG%, Hotkeys, ToggleDefensive
	IniWrite, %CycleMissionFailSafeKey%, %CFG%, Hotkeys, CycleMissionFailSafe
	
	IniWrite, %HealthKey%, %CFG%, Hotkeys, Health
	IniWrite, %StaminaKey%, %CFG%, Hotkeys, Stamina
	IniWrite, %DeadeyeKey%, %CFG%, Hotkeys, Deadeye
	IniWrite, %HealCoresKey%, %CFG%, Hotkeys, HealCores
	
	IniWrite, %WildernessCampKey%, %CFG%, Hotkeys, WildernessCamp
	IniWrite, %ItemSlotKey%, %CFG%, Hotkeys, ItemSlot
	
	IniWrite, %HuntingWagonKey%, %CFG%, Hotkeys, HuntingWagon
	IniWrite, %BountyWagonKey%, %CFG%, Hotkeys, BountyWagon
	IniWrite, %DismissWagonsKey%, %CFG%, Hotkeys, DismissWagons
	IniWrite, %FeedHorseKey%, %CFG%, Hotkeys, FeedHorse
	
	IniWrite, %ShowPossesKey%, %CFG%, Hotkeys, ShowPosses
	IniWrite, %FormPosseKey%, %CFG%, Hotkeys, FormPosse
	IniWrite, %QuickRaceKey%, %CFG%, Hotkeys, QuickRace
	IniWrite, %MenuSlotTwoKey%, %CFG%, Hotkeys, MenuSlotTwo
	IniWrite, %MenuSlotFourKey%, %CFG%, Hotkeys, MenuSlotFour
	
	IniWrite, %VolumeDownKey%, %CFG%, Hotkeys, VolumeDown
	IniWrite, %VolumeUpKey%, %CFG%, Hotkeys, VolumeUp
	IniWrite, %ReloadScriptKey%, %CFG%, Hotkeys, ReloadScript
	IniWrite, %AbortScriptKey%, %CFG%, Hotkeys, AbortScript
	
	IniWrite, %TimerAddMinutesKey%, %CFG%, Hotkeys,TimerAddMinutes
	IniWrite, %TimerSubMinutesKey%, %CFG%, Hotkeys,TimerSubMinutes
	IniWrite, %TimerResetMinutesKey% , %CFG%, Hotkeys,TimerResetMinutes
	IniWrite, %TimerResetSecondsKey%, %CFG%, Hotkeys,TimerResetSeconds
	
	ExitApp
	return
}
