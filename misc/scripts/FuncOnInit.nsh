; --- Stuff to do at startup of script ---
Function .onInit
InitPluginsDir
;  !insertmacro MUI_LANGDLL_DISPLAY ;Show Multilanguagebox

StrCpy $R9 0 ; we start on page 0
;StrCpy $InstallButton ""
 StrCpy $FileFormat "ISO"
 userInfo::getAccountType
 Pop $Auth
 strCmp $Auth "Admin" done
 Messagebox MB_OK|MB_ICONINFORMATION "Currently you're trying to run this program as: $Auth$\r$\n$\r$\nYou must run this program with administrative rights...$\r$\n$\r$\nRight click the file and select Run As Administrator or Run As (and select an administrative account)!"
 Abort
 done:
 SetShellVarContext all
 InitPluginsDir
 Call CFGWriteFile
  ${FILEONAME} "dskvol.txt"
  ${FILEONAME} "diskpart.txt"
  ${FILEONAME} "w2gdiskpart.txt"
  ${FILEONAME} "dd-diskpart.txt"
  ${FILEONAME} "diskpartdetach.txt"
  ${FILEONAME} "autounattend.xml"
  ${FILEONAME} "syslinux.exe"
;  ${FILEONAME} "syslinux.cfg"
  ${FILEONAME2} "legacy-aumbi"
  ${FILEONAME2} "menu.lst"
  ${FILEONAME2} "vhd.lst"
  ${FILEONAME2} "grubpart4.lst"
  ${FILEONAME2} "grubram.lst"
#  ${FILEONAME2} "win.lst"
#  ${FILEONAME2} "win2go.lst"
  ${FILEONAME} "grub.exe"
  ${FILEONAME2} "info"
  ;${FILEONAME2} "antivirus.cfg"
  ;${FILEONAME2} "system.cfg"
  ;${FILEONAME2} "netbook.cfg"
  ;${FILEONAME2} "linux.cfg"
  ;${FILEONAME2} "anon.cfg"
  ;${FILEONAME2} "other.cfg"
  ;${FILEONAME2} "pe.cfg"
  ${FILEONAME2} "pe.lst"
  ;${FILEONAME2} "unlisted.cfg"
  ${FILEONAME} "liveusb"
  ${FILEONAME} "7zG.exe"
  ${FILEONAME} "7z.dll"
  ${FILEONAMERES} "AUMBI.png"
  ${FILEONAME} "AUMBI-Copying.txt"
  ${FILEONAME} "AUMBI-Readme.txt"
  ${FILEONAME} "license.txt"
  ${FILEONAME} "vesamenu.c32"
  ${FILEONAME} "menu.c32"
  ${FILEONAME} "memdisk"
  ${FILEONAME} "chain.c32"
  ${FILEONAME} "libcom32.c32"
  ${FILEONAME} "libutil.c32"
  ${FILEONAME} "linux.c32"
  ${FILEONAME} "wimboot"
  ${FILEONAME} "ifcpu64.c32"
  ${FILEONAME} "remount.cmd"
  ${FILEONAME} "boot.cmd"
  ${FILEONAME} "vhdremount.cmd"
  ${FILEONAME} "ei.cfg"
  ${FILEONAME} "dd.exe"
  ${FILEONAME} "fat32format.exe"
  SetOutPath "$PLUGINSDIR"
  File /r "wimlib"
  SetOutPath ""
FunctionEnd