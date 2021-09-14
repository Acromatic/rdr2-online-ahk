; v1.2.4
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
Gui, guitwo: +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, guitwo: Color, %CustomColor%
Gui, guitwo: Font, s19  ; Set a large font size (32-point).

Gui, guitwo: Add, Text, Left vMyText2 cLime, Checking for Update of RDR2 Online AHK-Macros, If a new version of RDR2 Online AHK-Macros has been released this will overwrite scripts and reset them!

;////// Make all pixels of this color transparent and make the text itself translucent (150):
WinSet, TransColor, %CustomColor% 200
;WinSet, AlwaysOnTop, %CustomColor% 150

;////// Initialize the GUI for On Screen Display
Gui, guitwo: Show, x500 y110 w1000 h80 NoActivate  ; NoActivate avoids deactivating the currently active window.

if %1%
	SilentSuccess := %1%
else
	SilentSuccess := false

UpdateScriptMain()
UpdateScriptConfig()
UpdateReadMe()

Run, RDR2.ahk
ExitApp
return

;//////////////////////  Update Script Main File  ////////////////
UpdateScriptMain(){
	URLDownloadToFile,https://raw.githubusercontent.com/Acromatic/rdr2-online-ahk/main/RDR2.ahk,RDR2.txt
	if (errorlevel) {
		GuiControl, guitwo:, MyText2, Error response from GitHub, update was aborted. Please try again later Hint: Uncheck "autoupdate on start?" in the Configuration Editor to disable automatic checking.
		FileDelete, RDR2.txt
		Sleep, 4000
		return
  	}
	FileCopy, RDR2.txt, RDR2.ahk, 1
	FileDelete, RDR2.txt
	
	if (!SilentSuccess)
      	GuiControl, guitwo:, MyText2, RDR2-Online-AHK Macros Update Success, the RDR2.ahk script was updated!
	Sleep, 4000
	return
}

;//////////////////////  Update Script Config File  ////////////////
UpdateScriptConfig(){
	URLDownloadToFile,https://raw.githubusercontent.com/Acromatic/rdr2-online-ahk/main/RDR2Config.ahk,RDR2Config.txt
	if (errorlevel) {
		GuiControl, guitwo:, MyText2, Error response from GitHub on RDR2Config.ahk, update was aborted. Please try again later Hint: Uncheck "autoupdate on start?" in the Configuration Editor to disable automatic checking.
		FileDelete, RDR2Config.txt
		Sleep, 4000
		return
  	}
	FileCopy, RDR2Config.txt, RDR2Config.ahk, 1
	FileDelete, RDR2Config.txt
	
	if (!SilentSuccess)
      	GuiControl, guitwo:, MyText2, RDR2-Online-AHK Macros Update Success, the RDR2Config.ahk script was updated!
	Sleep, 4000
	return
}

;//////////////////////  Update Script Mission Failsafe ////////////////
UpdateScriptMissionFailsafe(){
	URLDownloadToFile,https://raw.githubusercontent.com/Acromatic/rdr2-online-ahk/main/RDR2MissionFailsafe.ahk,RDR2MissionFailsafe.txt
	if (errorlevel) {
		GuiControl, guitwo:, MyText2, Error response from GitHub on RDR2Config.ahk, update was aborted. Please try again later Hint: Uncheck "autoupdate on start?" in the Configuration Editor to disable automatic checking.
		FileDelete, RDR2Config.txt
		Sleep, 4000
		return
  	}
	FileCopy, RDR2MissionFailsafe.txt, RDR2MissionFailsafe.ahk, 1
	FileDelete, RDR2MissionFailsafe.txt
	
	if (!SilentSuccess)
      	GuiControl, guitwo:, MyText2, RDR2-Online-AHK Macros Update Success, the RDR2MissionFailsafe.ahk script was updated!
	Sleep, 4000
	return
}

;//////////////////////  Update Read Me File  ////////////////
UpdateReadMe(){
	URLDownloadToFile,https://raw.githubusercontent.com/Acromatic/rdr2-online-ahk/main/README.md,README.txt
	if (errorlevel) {
		GuiControl, guitwo:, MyText2, Error response from GitHub on README.md, update was aborted. Please try again later Hint: Uncheck "autoupdate on start?" in the Configuration Editor to disable automatic checking.
		FileDelete, README.txt
		Sleep, 4000
		return
  	}
	FileCopy, README.txt, README.md, 1
	FileDelete, README.txt
	
	if (!SilentSuccess)
      	GuiControl, guitwo:, MyText2, RDR2-Online-AHK Macros Update Success, the README.md script was updated!
	Sleep, 4000
	return
}







  
