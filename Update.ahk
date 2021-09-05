﻿; v1.1.1
; ^ don't remove or alter this line (autoupdate)
;#Warn   ;---------- For debugging

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force               
SetWorkingDir %A_ScriptDir% 

; Run as Admin to ensure the script will work
IF NOT A_IsAdmin
{
        Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%",, UseErrorLevel
        if !ErrorLevel
            ExitApp
}

;////////////////////////////////////////// GUI //////////////////////////////////////
;////// Initialize the GUI for On Screen Display
CustomColor := "7F7F7F"  ; Can be any RGB color (it will be made transparent below).

;/// GUI window for a line of text 
Gui, guione: +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, guione: Color, %CustomColor%
Gui, guione: Font, s19  ; Set a large font size (32-point).

Gui, guione: Add, Text, Left vMyText cLime, Checking for Update of RDR2 Online AHK-Macros, If a new version of RDR2 Online AHK-Macros has been released this will overwrite scripts and reset them!

;////// Make all pixels of this color transparent and make the text itself translucent (150):
WinSet, TransColor, %CustomColor% 200
;WinSet, AlwaysOnTop, %CustomColor% 150

;////// Initialize the GUI for On Screen Display
Gui, guione: Show, x905 y70 w100 h60 NoActivate  ; NoActivate avoids deactivating the currently active window.

if %1%
SilentSuccess := %1%
else
SilentSuccess := false

UpdateScriptMain(SilentSuccess)
UpdateScriptConfig(SilentSuccess)
UpdateReadMe(SilentSuccess)

Run, RDR2.ahk
ExitApp
return

;//////////////////////  Update Script Main File  ////////////////
UpdateScriptMain(SilentSuccess=false){
URLDownloadToFile,https://raw.githubusercontent.com/Acromatic/rdr2-online-ahk/main/RDR2.ahk,RDR2.txt
	if (errorlevel) {
    	GuiControl, guione:, MyText, Error response from GitHub, update was aborted.`nPlease try again 		later`nHint: Uncheck "autoupdate on start?" in the Configuration Editor to disable automatic checking.
	FileDelete, RDR2.txt
	return
  	}
	FileCopy, RDR2.txt, RDR2.ahk, 1
	FileDelete, RDR2.txt

    if (!SilentSuccess)
      	GuiControl, guione:, MyText, RDR2-Online-AHK Macros Update Success, the RDR2.ahk script was updated!
	return
}

;//////////////////////  Update Script Config File  ////////////////
UpdateScriptConfig(SilentSuccess=false){
URLDownloadToFile,https://raw.githubusercontent.com/Acromatic/rdr2-online-ahk/main/RDR2Config.ahk,RDR2Config.txt
	if (errorlevel) {
    	GuiControl, guione:, MyText, Error response from GitHub on RDR2Config.ahk, update was aborted. Please try again 		later Hint: Uncheck "autoupdate on start?" in the Configuration Editor to disable automatic checking.
	FileDelete, RDR2Config.txt
	return
  	}
	FileCopy, RDR2Config.txt, RDR2Config.ahk, 1
	FileDelete, RDR2Config.txt

    if (!SilentSuccess)
      	GuiControl, guione:, MyText, RDR2-Online-AHK Macros Update Success, the RDR2Config.ahk script was updated!
	return
}

;//////////////////////  Update Read Me File  ////////////////
UpdateReadMe(SilentSuccess=false){
URLDownloadToFile,https://raw.githubusercontent.com/Acromatic/rdr2-online-ahk/main/README.md,README.txt
	if (errorlevel) {
    	GuiControl, guione:, MyText, Error response from GitHub on README.md, update was aborted. Please try again 		later Hint: Uncheck "autoupdate on start?" in the Configuration Editor to disable automatic checking.
	FileDelete, README.txt
	return
  	}
	FileCopy, README.txt, README.md, 1
	FileDelete, README.txt

    if (!SilentSuccess)
      	GuiControl, guione:, MyText, RDR2-Online-AHK Macros Update Success, the README.md script was updated!
	return
}







  
