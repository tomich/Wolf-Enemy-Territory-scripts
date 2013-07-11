# name the installer
outFile "ET Tom Server Plus.exe"
installDir "$PROGRAMFILES\Enemy Territory\"

 Name "Wolf:ET Server Cordoba"
 RequestExecutionLevel admin
Caption "Wolf:ET Server Cordoba"
ShowInstDetails show
XPStyle on
CompletedText "Instalado!"


 #Page license
 Page components
 Page directory
 Page instfiles
!addplugindir ".\plugins"
!include LogicLib.nsh
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
section "ETPub mod 20100628 + sonidos"
SetOutPath "$INSTDIR"
File /r "tom-server\"
sectionEnd

section "Accesos directos al server"
SetOutPath "$INSTDIR"
#Exec '"cd $INSTDIR" && "ET.exe" +pb_cl_enable;+pb_system 1;+pb_writecfg;'

#lalala
SetShellVarContext current
createShortCut "$INSTDIR\ET Server Cordoba.lnk" "$INSTDIR\ET.exe" "+connect xxxxxx.dyndns-home.com"
createShortCut "$DESKTOP\ET Server Cordoba.lnk" "$INSTDIR\ET.exe" "+connect xxxxxx.dyndns-home.com"
SetShellVarContext all
createShortCut "$SMPROGRAMS\ET Server Cordoba.lnk" "$INSTDIR\ET.exe" "+connect xxxxxx.dyndns-home.com"

sectionEnd

section /o "Download ALL Base Maps(~63MB)"
AddSize 63796
NSISdl::download http://webtomich.com.ar/wolf/etmain/caen.pk3 $INSTDIR\etmain\caen.pk3
NSISdl::download http://webtomich.com.ar/wolf/etmain/Frostbite.pk3 $INSTDIR\etmain\Frostbite.pk3
NSISdl::download http://webtomich.com.ar/wolf/etmain/et_beach.pk3 $INSTDIR\etmain\et_beach.pk3
NSISdl::download http://webtomich.com.ar/wolf/etmain/venice.pk3 $INSTDIR\etmain\venice.pk3
NSISdl::download http://webtomich.com.ar/wolf/etmain/stalingrad.pk3 $INSTDIR\etmain\stalingrad.pk3

sectionEnd

section /o "Download ALL Extra Maps(~54MB)"
 AddSize 55092
NSISdl::download http://webtomich.com.ar/wolf/etmain/adlernest.pk3 $INSTDIR\etmain\adlernest.pk3
NSISdl::download http://webtomich.com.ar/wolf/etmain/bunker_rsr_b1.pk3 $INSTDIR\etmain\bunker_rsr_b1.pk3
NSISdl::download http://webtomich.com.ar/wolf/etmain/desertrats.pk3$INSTDIR\etmain\desertrats.pk3
NSISdl::download http://webtomich.com.ar/wolf/etmain/et_ice.pk3 $INSTDIR\etmain\et_ice.pk3
NSISdl::download http://webtomich.com.ar/wolf/etmain/missile_b3.pk3 $INSTDIR\etmain\missile_b3.pk3
NSISdl::download http://webtomich.com.ar/wolf/etmain/oasis_winter.pk3 $INSTDIR\etmain\oasis_winter.pk3
NSISdl::download http://webtomich.com.ar/wolf/etmain/reactor_final.pk3 $INSTDIR\etmain\reactor_final.pk3
NSISdl::download http://webtomich.com.ar/wolf/etmain/te_valhalla.pk3 $INSTDIR\etmain\te_valhalla.pk3

sectionEnd

section /o "Download ALL Sniper Maps(~20MB)"
AddSize 20276
NSISdl::download http://webtomich.com.ar/wolf/etmain/UJE_hospital_sniper_b1.pk3 $INSTDIR\etmain\UJE_hospital_sniper_b1.pk3
NSISdl::download http://webtomich.com.ar/wolf/etmain/UJE_oldskool_sniper_fixed.pk3 $INSTDIR\etmain\UJE_oldskool_sniper_fixed.pk3
NSISdl::download http://webtomich.com.ar/wolf/etmain/ron_sniper_ruine_b1.pk3 $INSTDIR\etmain\ron_sniper_ruine_b1.pk3

sectionEnd
