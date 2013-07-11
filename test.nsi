# name the installer
outFile "ET_UPDATE_BY_TOM.exe"
installDir "$PROGRAMFILES\Enemy Territory\"

 #Page license
Name "Wolf:ET Updater by Tomich"
RequestExecutionLevel user
Caption "Wolf:ET Updater by Tomich"
ShowInstDetails show
XPStyle on
CompletedText "Installed!"

 Page components
 Page directory
 Page instfiles
!addplugindir ".\plugins"
!include LogicLib.nsh
#Start UAC
!include UAC.nsh
 
!macro Init thing
uac_tryagain:
!insertmacro UAC_RunElevated
${Switch} $0
${Case} 0
	${IfThen} $1 = 1 ${|} Quit ${|} ;we are the outer process, the inner process has done its work, we are done
	${IfThen} $3 <> 0 ${|} ${Break} ${|} ;we are admin, let the show go on
	${If} $1 = 3 ;RunAs completed successfully, but with a non-admin user
		MessageBox mb_YesNo|mb_IconExclamation|mb_TopMost|mb_SetForeground "This ${thing} requires admin privileges, try again" /SD IDNO IDYES uac_tryagain IDNO 0
	${EndIf}
	;fall-through and die
${Case} 1223
	MessageBox mb_IconStop|mb_TopMost|mb_SetForeground "This ${thing} requires admin privileges, aborting!"
	Quit
${Case} 1062
	MessageBox mb_IconStop|mb_TopMost|mb_SetForeground "Logon service not running, aborting!"
	Quit
${Default}
	MessageBox mb_IconStop|mb_TopMost|mb_SetForeground "Unable to elevate , error $0"
	Quit
${EndSwitch}
 
SetShellVarContext all
!macroend
#END UAC


Function .onInit
ReadRegStr $0 HKLM "SOFTWARE\Activision\Wolfenstein - Enemy Territory" "InstallPath"
ReadRegStr $1 HKLM "SOFTWARE\Wow6432Node\Activision\Wolfenstein - Enemy Territory" "InstallPath"
ReadRegStr $2 HKLM "SOFTWARE\Activision\Enemy Territory" "InstallPath"
ReadRegStr $3 HKLM "SOFTWARE\Wow6432Node\Activision\Enemy Territory" "InstallPath"
${If} $0 != ""
  StrCpy $INSTDIR "$0" 
 ${Elseif} $1 != ""
	StrCpy $INSTDIR "$1" 
 ${Elseif} $1 != ""
	StrCpy $INSTDIR "$2" 
 ${Elseif} $1 != ""
	StrCpy $INSTDIR "$3" 
 ${Elseif} $1 != ""
	StrCpy $INSTDIR "$4"
${Else}
	StrCpy $INSTDIR "$PROGRAMFILES\Enemy Territory\"
${EndIf}
FunctionEnd
# default section start; every NSIS script has at least one section.
section "Update 2.60"
File /oname=260.zip 260.zip
#File /oname=260b\ET.exe ET.exe
#File /oname=260b\ETDED.exe ETDED.exe

InitPluginsDir
; Call plug-in. Push filename to ZIP first, and the dest. folder last.
nsisunz::UnzipToLog "260.zip" "$INSTDIR"
 
; Always check result on stack
Pop $0
StrCmp $0 "success" ok
  DetailPrint "$0" ;print error message to log
ok:
sectionEnd


section "Update 2.60b"
File /oname=260b.zip 260b.zip

nsisunz::UnzipToLog "260b.zip" "$INSTDIR"
 
; Always check result on stack
Pop $0
StrCmp $0 "success" ok
  DetailPrint "$0" ;print error message to log
ok:

sectionEnd

section "Update Punkbuster & ETKey"
File /oname=pbet.exe pbet.exe

ExecWait pbet.exe $0

StrCmp $0 "0" si no
no:
  DetailPrint "$0" ;print error message to log
si:
#lalala
sectionEnd

section "Fix PB issues"
SetOutPath "$INSTDIR"
#Exec '"cd $INSTDIR" && "ET.exe" +pb_cl_enable;+pb_system 1;+pb_writecfg;'

#lalala
SetShellVarContext all
createShortCut "$INSTDIR\Fix_GUID.lnk" "$INSTDIR\ET.exe" "+pb_cl_enable +pb_system 1 +pb_writecfg +exit"
createShortCut "$SMPROGRAMS\Enemy Territory Fix GUID issue.lnk" "$INSTDIR\ET.exe" "+pb_cl_enable +pb_system 1 +pb_writecfg +exit"


sectionEnd
