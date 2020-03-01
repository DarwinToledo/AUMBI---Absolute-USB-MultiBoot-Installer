#===========================================================
# 
#===========================================================

Function ConfigRemove ; Find and Set Removal Configuration file
  ${If} ${FileExists} "$BootDir\${MB_DIR}\$DistroName\AUMBI\linux.cfg"
  StrCpy $Config2Use "linux.cfg"
  ${ElseIf} ${FileExists} "$BootDir\${MB_DIR}\$DistroName\AUMBI\anon.cfg"
  StrCpy $Config2Use "anon.cfg"
  ${ElseIf} ${FileExists} "$BootDir\${MB_DIR}\$DistroName\AUMBI\system.cfg"
  StrCpy $Config2Use "system.cfg"
  ${ElseIf} ${FileExists} "$BootDir\${MB_DIR}\$DistroName\AUMBI\antivirus.cfg"
  StrCpy $Config2Use "antivirus.cfg"
  ${ElseIf} ${FileExists} "$BootDir\${MB_DIR}\$DistroName\AUMBI\netbook.cfg"
  StrCpy $Config2Use "netbook.cfg"
  ${ElseIf} ${FileExists} "$BootDir\${MB_DIR}\$DistroName\AUMBI\other.cfg"
  StrCpy $Config2Use "other.cfg"
  ${ElseIf} ${FileExists} "$BootDir\${MB_DIR}\$DistroName\AUMBI\pe.cfg"
  StrCpy $Config2Use "pe.cfg"
  ${ElseIf} ${FileExists} "$BootDir\${MB_DIR}\$DistroName\AUMBI\unlisted.cfg"
  StrCpy $Config2Use "unlisted.cfg"
  ${ElseIf} ${FileExists} "$BootDir\${MB_DIR}\$DistroName\AUMBI\menu.lst"
  StrCpy $Config2Use "menu.lst"
  ${ElseIf} ${FileExists} "$BootDir\${MB_DIR}\$DistroName\AUMBI\vhd.lst"
  StrCpy $Config2Use "vhd.lst"
  ${ElseIf} ${FileExists} "$BootDir\${MB_DIR}\$DistroName\AUMBI\grubpart4.lst"
  StrCpy $Config2Use "grubpart4.lst"
  ${ElseIf} ${FileExists} "$BootDir\${MB_DIR}\$DistroName\AUMBI\grubram.lst"
  StrCpy $Config2Use "grubram.lst"
  ${ElseIf} ${FileExists} "$BootDir\${MB_DIR}\$DistroName\AUMBI\win.lst"
  StrCpy $Config2Use "win.lst"
  ${ElseIf} ${FileExists} "$BootDir\${MB_DIR}\$DistroName\AUMBI\win2go.lst"
  StrCpy $Config2Use "win2go.lst"
  ${ElseIf} ${FileExists} "$BootDir\${MB_DIR}\$DistroName\AUMBI\pe.lst"
  StrCpy $Config2Use "pe.lst"
  ${ElseIf} ${FileExists} "$BootDir\${MB_DIR}\$DistroName\AUMBI\hirens.lst"
  StrCpy $Config2Use "hirens.lst"
  ${EndIf}
  ; MessageBox MB_OK "$Config2Use"
FunctionEnd

Function Config2Write
 ${If} $Config2Use == "linux.cfg"
  ${WriteToSysFile} "label $(MENU_LABEL_LUNIX_DIST)$\r$\nmenu label $(MENU_LABEL_LUNIX_DIST) ->$\r$\nMENU INDENT 1$\r$\nCONFIG /${MB_DIR}/menu/linux.cfg" $R0
 ${ElseIf} $Config2Use == "anon.cfg"
  ${WriteToSysFile} "label $(MENU_LABEL_SYS_TOOLS)$\r$\nmenu label $(MENU_LABEL_SYS_ANONY) ->$\r$\nMENU INDENT 1$\r$\nCONFIG /${MB_DIR}/menu/anon.cfg" $R0
 ${ElseIf} $Config2Use == "system.cfg"
  ${WriteToSysFile} "label $(MENU_LABEL_SYS_TOOLS)$\r$\nmenu label $(MENU_LABEL_SYS_TOOLS) ->$\r$\nMENU INDENT 1$\r$\nCONFIG /${MB_DIR}/menu/system.cfg" $R0
 ${ElseIf} $Config2Use == "antivirus.cfg"
  ${WriteToSysFile} "label $(MENU_LABEL_ANTIVIR)$\r$\nmenu label $(MENU_LABEL_ANTIVIR) ->$\r$\nMENU INDENT 1$\r$\nCONFIG /${MB_DIR}/menu/antivirus.cfg" $R0
 ${ElseIf} $Config2Use == "netbook.cfg"
  ${WriteToSysFile} "label $(MENU_LABEL_NETBOOK)$\r$\nmenu label $(MENU_LABEL_NETBOOK) ->$\r$\nMENU INDENT 1$\r$\nCONFIG /${MB_DIR}/menu/netbook.cfg" $R0
 ${ElseIf} $Config2Use == "other.cfg"
  ${WriteToSysFile} "label $(MENU_LABEL_OTHER_OS)$\r$\nmenu label $(MENU_LABEL_OTHER_OS) ->$\r$\nMENU INDENT 1$\r$\nCONFIG /${MB_DIR}/menu/other.cfg" $R0
 ${ElseIf} $Config2Use == "pe.cfg"
  ${WriteToSysFile} "label Windows PE$\r$\nmenu label Windows PE ->$\r$\nMENU INDENT 1$\r$\nCONFIG /${MB_DIR}/menu/pe.cfg" $R0
 ${ElseIf} $Config2Use == "pe.lst"
  ${WriteToSysFile} "label Windows PE$\r$\nmenu label Windows PE ->$\r$\nMENU INDENT 1$\r$\nKERNEL /${MB_DIR}/grub.exe$\r$\nAPPEND --config-file=/${MB_DIR}/menu/pe.lst" $R0
 ${ElseIf} $Config2Use == "hirens.lst"
  ${WriteToSysFile} "label Hiren's Boot CD PE$\r$\nmenu label Hiren's Boot CD PE ->$\r$\nMENU INDENT 1$\r$\nKERNEL /${MB_DIR}/grub.exe$\r$\nAPPEND --config-file=/${MB_DIR}/menu/hirens.lst" $R0
 ${ElseIf} $Config2Use == "unlisted.cfg"
  ${WriteToSysFile} "label $(MENU_LABEL_UNLISTED)$\r$\nmenu label  $(MENU_LABEL_UNLISTED) ->$\r$\nMENU INDENT 1$\r$\nCONFIG /${MB_DIR}/menu/unlisted.cfg" $R0
 ${ElseIf} $Config2Use == "menu.lst"
  ${WriteToSysFile} "label $(MENU_LABEL_UNLISTED2)$\r$\nmenu label $(MENU_LABEL_UNLISTED2) ->$\r$\nMENU INDENT 1$\r$\nKERNEL /${MB_DIR}/grub.exe$\r$\nAPPEND --config-file=/${MB_DIR}/menu/menu.lst" $R0
 ${ElseIf} $Config2Use == "vhd.lst"
  ${WriteToSysFile} "label $(MENU_LABEL_UNLISTED3)$\r$\nmenu label $(MENU_LABEL_UNLISTED3) ->$\r$\nMENU INDENT 1$\r$\nKERNEL /${MB_DIR}/grub.exe$\r$\nAPPEND --config-file=/${MB_DIR}/menu/vhd.lst" $R0
 ${ElseIf} $Config2Use == "grubpart4.lst"
  ${WriteToSysFile} "label $(MENU_LABEL_UNLISTED4)$\r$\nmenu label $(MENU_LABEL_UNLISTED4) ->$\r$\nMENU INDENT 1$\r$\nKERNEL /${MB_DIR}/grub.exe$\r$\nAPPEND --config-file=/${MB_DIR}/menu/grubpart4.lst" $R0
 ${ElseIf} $Config2Use == "grubram.lst"
  ${WriteToSysFile} "label $(MENU_LABEL_UNLISTED5)$\r$\nmenu label $(MENU_LABEL_UNLISTED5) ->$\r$\nMENU INDENT 1$\r$\nKERNEL /${MB_DIR}/grub.exe$\r$\nAPPEND --config-file=/${MB_DIR}/menu/grubram.lst" $R0
 ${ElseIf} $Config2Use == "win.lst"
  ${WriteToSysFile} "label $(MENU_LABEL_WINDOWS)$\r$\nmenu label $(MENU_LABEL_WINDOWS) ->$\r$\nMENU INDENT 1$\r$\nKERNEL /${MB_DIR}/grub.exe$\r$\nAPPEND --config-file=/${MB_DIR}/menu/win.lst" $R0
 ${ElseIf} $Config2Use == "win2go.lst"
  ${WriteToSysFile} "label $(MENU_LABEL_WINTOGO)$\r$\nmenu label $(MENU_LABEL_WINTOGO) ->$\r$\nMENU INDENT 1$\r$\nKERNEL /${MB_DIR}/grub.exe$\r$\nAPPEND --config-file=/${MB_DIR}/menu/win2go.lst" $R0
 ${EndIf}
FunctionEnd
