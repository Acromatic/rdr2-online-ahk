;///////////////////////////////////  TOP  ////////////////////////////////////////

; Run as Admin to ensure the script will work
IF NOT A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
  ExitApp
}

;#Warn   ;---------- For debugging

#NoEnv
#SingleInstance, Force               
SetWorkingDir %A_ScriptDir%

;/////////////////////////     Create Ini file    //////////////////////////////////

CFG = RDR2Quick.ini

IfExist, %CFG%
{ 
;/////////////////   Settings     ///////////////
IniRead, Read_LoadConfigOnStart, %CFG%, Settings, LoadConfigOnStart
IniRead, Read_AutoUpdateOnStart, %CFG%, Settings, AutoUpdateOnStart

;/////////////////// Singleplayer ONLY binds ///////////////
IniRead,Read_BeatPokerKey, %CFG%, SinglePlayerHotkeys,BeatPoker

;//////////////////  Online Macros  ////////////////////
IniRead,Read_PassiveToggleCookingOnKey, %CFG%,Hotkeys,PassiveToggleCookingOn
IniRead,Read_PassiveToggleCookingOffKey, %CFG%,Hotkeys,PassiveToggleCookingOff

IniRead,Read_ToggleEnhancedAFKKey, %CFG%,Hotkeys,ToggleEnhancedAFK
IniRead,Read_TogglePatrolAFKKey, %CFG%,Hotkeys,TogglePatrolAFK
IniRead,Read_ToggleAFKKey, %CFG%,Hotkeys,ToggleAFK
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

;////// GuiControls

GuiControl,,PassiveToggleCookingOn,%Read_PassiveToggleCookingOnKey%
GuiControl,,PassiveToggleCookingOff,%Read_PassiveToggleCookingOffKey%

GuiControl,,ToggleEnhancedAFK,%Read_ToggleEnhancedAFKKey%
GuiControl,,TogglePatrolAFK,%Read_TogglePatrolAFKKey%
GuiControl,,ToggleAFK,%Read_ToggleAFKKey%
GuiControl,,ToggleDefensive,%Read_ToggleDefensiveKey%
GuiControl,,ToggleClicker,%Read_ToggleClickerKey%
GuiControl,,ToggleFinale,%Read_ToggleFinaleKey%

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

GuiControl,,BeatPoker,%Read_BeatPokerKey%
}

Gui, Add, Text, x10 y10 w150 h20,PassiveToggleCookingOnKey:
Gui, Add, Text, x10 y40 w150 h20,PassiveToggleCookingOff Key:

Gui, Add, Text, x10 y70 w150 h20,ToggleEnhancedAFK Key:
Gui, Add, Text, x10 y100 w150 h20,TogglePatrolAFK Key:
Gui, Add, Text, x10 y130 w150 h20,ToggleAFK Key:

Gui, Add, Text, x10 y160 w150 h20,ToggleDefensive Key:
Gui, Add, Text, x10 y190 w150 h20,ToggleClicker Key:
Gui, Add, Text, x10 y220 w150 h20,ToggleFinale Key:

Gui, Add, Text, x10 y250 w150 h20,Health Key:
Gui, Add, Text, x10 y280 w150 h20,Stamina Key:
Gui, Add, Text, x10 y310 w150 h20,Deadeye Key:
Gui, Add, Text, x10 y340 w150 h20,HealCores Key:

Gui, Add, Text, x10 y370 w150 h20,WildernessCamp Key:
Gui, Add, Text, x10 y400 w150 h20,ItemSlot Key:

Gui, Add, Text, x320 y10 w150 h20,HuntingWagon Key:
Gui, Add, Text, x320 y40 w150 h20,BountyWagon Key:
Gui, Add, Text, x320 y70 w150 h20,DismissWagons Key:
Gui, Add, Text, x320 y100 w150 h20,FeedHorse Key:

Gui, Add, Text, x320 y130 w150 h20,ShowPosses Key:
Gui, Add, Text, x320 y160 w150 h20,FormPosse Key:
Gui, Add, Text, x320 y190 w150 h20,QuickRace Key:
Gui, Add, Text, x320 y220 w150 h20,MenuSlotTwo Key:
Gui, Add, Text, x320 y250 w150 h20,MenuSlotFour Key:

Gui, Add, Text, x320 y280 w150 h20,VolumeDown Key:
Gui, Add, Text, x320 y310 w150 h20,VolumeUp Key:
Gui, Add, Text, x320 y340 w150 h20,ReloadScript Key:
Gui, Add, Text, x320 y370 w150 h20,AbortScript Key:
Gui, Add, Text, x320 y400 w150 h20,BeatPoker Key:

;///////// HotKey Edit Boxes
Gui, Add, Hotkey, x160 y10 w150 h20 vPassiveToggleCookingOnKey,^Enter
Gui, Add, Hotkey, x160 y40 w150 h20 vPassiveToggleCookingOffKey,x

Gui, Add, Hotkey, x160 y70 w150 h20 vToggleEnhancedAFKKey,j
Gui, Add, Hotkey, x160 y100 w150 h20 vTogglePatrolAFKKey,o
Gui, Add, Hotkey, x160 y130 w150 h20 vToggleAFKKey,k

Gui, Add, Hotkey, x160 y160 w150 h20 vToggleDefensiveKey,F5
Gui, Add, Hotkey, x160 y190 w150 h20 vToggleClickerKey,z
Gui, Add, Hotkey, x160 y220 w150 h20 vToggleFinaleKey,F9

Gui, Add, Hotkey, x160 y250 w150 h20 vHealthKey,NumpadHome
Gui, Add, Hotkey,x160 y280 w150 h20 vStaminaKey,NumpadUp
Gui, Add, Hotkey,x160 y310 w150 h20 vDeadeyeKey,NumpadPgUp
Gui, Add, Hotkey,x160 y340 w150 h20 vHealCoresKey,NumpadLeft

Gui, Add, Hotkey,x160 y370 w150 h20 vWildernessCampKey,NumpadClear 
Gui, Add, Hotkey,x160 y400 w150 h20 vItemSlotKey,NumpadRight 

Gui, Add, Hotkey,x480 y10 w150 h20 vHuntingWagonKey,NumpadEnd 
Gui, Add, Hotkey,x480 y40 w150 h20 vBountyWagonKey,NumpadDown 
Gui, Add, Hotkey,x480 y70 w150 h20 vDismissWagonsKey,NumpadPgDn
Gui, Add, Hotkey,x480 y100 w150 h20 vFeedHorseKey,NumpadIns

Gui, Add, Hotkey,x480 y130 w150 h20 vShowPossesKey,t
Gui, Add, Hotkey,x480 y160 w150 h20 vFormPosseKey,y
Gui, Add, Hotkey,x480 y190 w150 h20 vQuickRaceKey,F6
Gui, Add, Hotkey, x480 y220 w150 h20 vMenuSlotTwoKey,NumpadDiv 
Gui, Add, Hotkey,x480 y250 w150 h20 vMenuSlotFourKey,NumpadMult 

Gui, Add, Hotkey,x480 y280 w150 h20 vVolumeDownKey,NumpadSub
Gui, Add, Hotkey,x480 y310 w150 h20 vVolumeUpKey,NumpadAdd
Gui, Add, Hotkey, x480 y340 w150 h20 vReloadScriptKey,+Escape
Gui, Add, Hotkey,x480 y370 w150 h20 vAbortScriptKey,^Escape
Gui, Add, Hotkey,x480 y400 w150 h20 vBeatPokerKey,F11

Gui, Add, CheckBox, x20 y450 w150 h20 vLoadConfigOnStart, Run Config Editor on start?
Gui, Add, CheckBox, x320 y450 w150 h20 vAutoUpdateOnStart, Auto Update on start?

Gui, Add, Button, x12 y500 w200 h50 gButtonExit, Exit
Gui, Add, Button, x302 y500 w200 h50 gsave, save

;///////////////////////////////////////////////////////////////////

Gui, Show, w620 h620, RDR Online Quick Macros
return 

;/////////////////////  Functions /////////////////

ButtonExit:
ExitApp
return

save:
{
Gui, Submit, NoHide ;this command submits the guis' datas' state
If Opt1 = 1
    MsgBox, you checked the first box
If Opt1 = 0
    MsgBox, you didnt check the first box
If Opt2 = 1
    MsgBox, you checked the second box
If Opt2 = 0
    MsgBox, you didnt check the second box
Gui, Submit

;/////////////////   Settings     ///////////////

IniWrite, %LoadConfigOnStart%, %CFG%, Settings, LoadConfigOnStart
IniWrite, %AutoUpdateOnStart%, %CFG%, Settings, AutoUpdateOnStart

;/////////////////// Singleplayer Only Binds ///////////////

IniWrite, %BeatPokerKey%, %CFG%, SinglePlayerHotkeys, BeatPoker

;//////////////////  Online Macros  ////////////////////

IniWrite, %PassiveToggleCookingOnKey%, %CFG%, Hotkeys, PassiveToggleCookingOn
IniWrite, %PassiveToggleCookingOffKey%, %CFG%, Hotkeys, PassiveToggleCookingOff

IniWrite, %ToggleEnhancedAFKKey%, %CFG%, Hotkeys, ToggleEnhancedAFK
IniWrite, %TogglePatrolAFKKey%, %CFG%, Hotkeys, TogglePatrolAFK
IniWrite, %ToggleAFKKey%, %CFG%, Hotkeys, ToggleAFK

IniWrite, %ToggleDefensiveKey%, %CFG%, Hotkeys, ToggleDefensive
IniWrite, %ToggleClickerKey%, %CFG%, Hotkeys, ToggleClicker
IniWrite, %ToggleFinaleKey%, %CFG%, Hotkeys, ToggleFinale

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
}
return
ExitApp