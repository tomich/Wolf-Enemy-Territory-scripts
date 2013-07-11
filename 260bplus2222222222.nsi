# name the installer
outFile "ET_Update Plus.exe"
installDir "$PROGRAMFILES\Enemy Territory\"

 #Page license
Name "Wolf:ET Updater by Tomich"
RequestExecutionLevel admin
Caption "Wolf:ET Updater by Tomich"
ShowInstDetails show
XPStyle on
CompletedText "Actualizado!"
;--------------------------------

; Pages
Page components
Page directory
Page instfiles
!addplugindir ".\plugins"
!include LogicLib.nsh
;--------------------------------

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

; The stuff to install
Section "Update 2.60 + 2.60b" ;No components page, name is not important

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File /r "260bplus\"
  
SectionEnd ; end the section

section "Update Punkbuster & ETKey"
File /oname=pbet.exe pbet.exe

ExecWait pbet.exe $0

StrCmp $0 "0" si no
no:
  DetailPrint "$0" ;print error message to log
si:
#lalala
sectionEnd

section "Fix PB/Arreglos varios"
SetOutPath "$INSTDIR"
#Exec '"cd $INSTDIR" && "ET.exe" +pb_cl_enable;+pb_system 1;+pb_writecfg;'

#lalala
SetShellVarContext all
createShortCut "$INSTDIR\Fix_GUID.lnk" "$INSTDIR\ET.exe" "+pb_cl_enable +pb_system 1 +pb_writecfg +exit"
createShortCut "$SMPROGRAMS\Enemy Territory Fix GUID issue.lnk" "$INSTDIR\ET.exe" "+pb_cl_enable +pb_system 1 +pb_writecfg +exit"


sectionEnd
