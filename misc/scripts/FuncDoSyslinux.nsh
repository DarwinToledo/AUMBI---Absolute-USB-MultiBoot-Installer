Function DoSyslinux ; Install Syslinux on USB
  ${IfNot} ${FileExists} "$BootDir\${MB_DIR}\libcom32.c32"
  ${AndIf} ${FileExists} "$BootDir\${MB_DIR}\ldlinux.sys"
  MessageBox MB_ICONEXCLAMATION|MB_OK $(WarningSyslinuxOLD)
  Quit
  ${EndIf}

  IfFileExists "$BootDir\${MB_DIR}\libcom32.c32" SkipSyslinux CreateSyslinux ; checking for newer syslinux
  CreateSyslinux:
  CreateDirectory $BootDir\${MB_DIR}\menu ; recursively create the directory structure if it doesn't exist
  CreateDirectory $BootDir\${MB_DIR}\ISOS ; create ISOS folder
  DetailPrint $(ExecuteSyslinux)
  ;ExecWait '$PLUGINSDIR\syslinux.exe -maf -d /${MB_DIR} $BootDir' $R8
  ;DetailPrint "Syslinux Errors $R8"
  nsExec::Exec '"$PLUGINSDIR\syslinux.exe" -maf -d /${MB_DIR} $BootDir'
  ;nsExec::Exec '"$PLUGINSDIR\syslinux.exe" -maf -d /${MB_DIR} $BootDir $BootDir\${MB_DIR}\syslinux.bin'
  Pop $R8
  DetailPrint "Syslinux Errors $R8"

  ${If} $R8 != 0
  MessageBox MB_ICONEXCLAMATION|MB_OK $(WarningSyslinux)
  ${EndIf}
  DetailPrint "Creating Label ${MB_LAB} on $DestDisk"
  nsExec::ExecToLog '"cmd" /c "LABEL $DestDisk${MB_LAB}"'

  SkipSyslinux:
  DetailPrint $(SkipSyslinux)

   ${IfNot} ${FileExists} $BootDir\${MB_DIR}\linux.c32 ; need linux.c32 to launch wimboot from syslinux.
    DetailPrint "Adding wimboot and linux.c32."
    CopyFiles /SILENT "$PLUGINSDIR\wimboot" "$BootDir\${MB_DIR}\wimboot"
    CopyFiles /SILENT "$PLUGINSDIR\linux.c32" "$BootDir\${MB_DIR}\linux.c32"
   ${EndIf}

   ${IfNot} ${FileExists} $BootDir\${MB_DIR}\legacy-aumbi ; legacy-aumbi test file.
    DetailPrint "Adding legacy-aumbi test file."
    CopyFiles /SILENT "$PLUGINSDIR\legacy-aumbi" "$BootDir\${MB_DIR}\legacy-aumbi"
   ${EndIf}

  ${If} ${FileExists} $BootDir\${MB_DIR}\syslinux.cfg
   DetailPrint "$(DETAILPRINT_PREINST)"
   Call AddDir
  ${Else}
; Create and Copy files to your destination
  DetailPrint "Adding required files to the $BootDir\${MB_DIR} directory..."
  CopyFiles /SILENT "$PLUGINSDIR\syslinux.cfg" "$BootDir\${MB_DIR}\syslinux.cfg"
  CopyFiles /SILENT "$PLUGINSDIR\AUMBI.png" "$BootDir\${MB_DIR}\AUMBI.png"
  CopyFiles /SILENT "$PLUGINSDIR\AUMBI.png" "$BootDir\${MB_DIR}\menu\AUMBI.png"
  CopyFiles /SILENT "$PLUGINSDIR\AUMBI-Copying.txt" "$BootDir\${MB_DIR}\AUMBI-Copying.txt"
  CopyFiles /SILENT "$PLUGINSDIR\AUMBI-Readme.txt" "$BootDir\${MB_DIR}\AUMBI-Readme.txt"
  CopyFiles /SILENT "$PLUGINSDIR\license.txt" "$BootDir\${MB_DIR}\license.txt"
  CopyFiles /SILENT "$PLUGINSDIR\vesamenu.c32" "$BootDir\${MB_DIR}\vesamenu.c32"
  CopyFiles /SILENT "$PLUGINSDIR\menu.c32" "$BootDir\${MB_DIR}\menu.c32"
  CopyFiles /SILENT "$PLUGINSDIR\chain.c32" "$BootDir\${MB_DIR}\chain.c32"
  CopyFiles /SILENT "$PLUGINSDIR\libcom32.c32" "$BootDir\${MB_DIR}\libcom32.c32"
  CopyFiles /SILENT "$PLUGINSDIR\libutil.c32" "$BootDir\${MB_DIR}\libutil.c32"
  CopyFiles /SILENT "$PLUGINSDIR\memdisk" "$BootDir\${MB_DIR}\memdisk"

; Copy these files to ${MB_DIR}\menu
  ; DetailPrint "Adding required files to the $BootDir\${MB_DIR}\menu directory..."
  ; CopyFiles /SILENT "$PLUGINSDIR\vesamenu.c32" "$BootDir\${MB_DIR}\menu\vesamenu.c32"
  ; CopyFiles /SILENT "$PLUGINSDIR\menu.c32" "$BootDir\${MB_DIR}\menu\menu.c32"
  ; CopyFiles /SILENT "$PLUGINSDIR\chain.c32" "$BootDir\${MB_DIR}\menu\chain.c32"
  ; CopyFiles /SILENT "$PLUGINSDIR\libcom32.c32" "$BootDir\${MB_DIR}\menu\libcom32.c32"
  ; CopyFiles /SILENT "$PLUGINSDIR\libutil.c32" "$BootDir\${MB_DIR}\menu\libutil.c32"
  ; CopyFiles /SILENT "$PLUGINSDIR\memdisk" "$BootDir\${MB_DIR}\menu\memdisk"

  Call AddDir
  ${EndIf}

  ${IfNot} ${FileExists} $BootDir\${MB_DIR}\libutil.c32 ; Old Syslinux files need to be replaced
  DetailPrint "Adding required files to the $BootDir\${MB_DIR} directory..."
  CopyFiles /SILENT "$PLUGINSDIR\AUMBI.png" "$BootDir\${MB_DIR}\AUMBI.png"
  CopyFiles /SILENT "$PLUGINSDIR\AUMBI-Copying.txt" "$BootDir\${MB_DIR}\AUMBI-Copying.txt"
  CopyFiles /SILENT "$PLUGINSDIR\AUMBI-Readme.txt" "$BootDir\${MB_DIR}\AUMBI-Readme.txt"
  CopyFiles /SILENT "$PLUGINSDIR\license.txt" "$BootDir\${MB_DIR}\license.txt"
  CopyFiles /SILENT "$PLUGINSDIR\vesamenu.c32" "$BootDir\${MB_DIR}\vesamenu.c32"
  CopyFiles /SILENT "$PLUGINSDIR\menu.c32" "$BootDir\${MB_DIR}\menu.c32"
  CopyFiles /SILENT "$PLUGINSDIR\chain.c32" "$BootDir\${MB_DIR}\chain.c32"
  CopyFiles /SILENT "$PLUGINSDIR\libcom32.c32" "$BootDir\${MB_DIR}\libcom32.c32"
  CopyFiles /SILENT "$PLUGINSDIR\libutil.c32" "$BootDir\${MB_DIR}\libutil.c32"
  CopyFiles /SILENT "$PLUGINSDIR\memdisk" "$BootDir\${MB_DIR}\memdisk"
; Copy these files to ${MB_DIR}\menu
  ; DetailPrint "Adding required files to the $BootDir\${MB_DIR}\menu directory..."
  ; CopyFiles /SILENT "$PLUGINSDIR\vesamenu.c32" "$BootDir\${MB_DIR}\menu\vesamenu.c32"
  ; CopyFiles /SILENT "$PLUGINSDIR\menu.c32" "$BootDir\${MB_DIR}\menu\menu.c32"
  ; CopyFiles /SILENT "$PLUGINSDIR\chain.c32" "$BootDir\${MB_DIR}\menu\chain.c32"
  ; CopyFiles /SILENT "$PLUGINSDIR\libcom32.c32" "$BootDir\${MB_DIR}\menu\libcom32.c32"
  ; CopyFiles /SILENT "$PLUGINSDIR\libutil.c32" "$BootDir\${MB_DIR}\menu\libutil.c32"
  ; CopyFiles /SILENT "$PLUGINSDIR\memdisk" "$BootDir\${MB_DIR}\menu\memdisk"
 ${EndIf}

  ; ${IfNot} ${FileExists} $BootDir\${MB_DIR}\menu\vesamenu.c32
;; Copy these files to ${MB_DIR}\menu
  ; DetailPrint "Adding required files to the $BootDir\${MB_DIR}\menu directory..."
  ; CopyFiles /SILENT "$PLUGINSDIR\vesamenu.c32" "$BootDir\${MB_DIR}\menu\vesamenu.c32"
  ; CopyFiles /SILENT "$PLUGINSDIR\menu.c32" "$BootDir\${MB_DIR}\menu\menu.c32"
  ; CopyFiles /SILENT "$PLUGINSDIR\chain.c32" "$BootDir\${MB_DIR}\menu\chain.c32"
  ; CopyFiles /SILENT "$PLUGINSDIR\memdisk" "$BootDir\${MB_DIR}\menu\memdisk"
  ; ${EndIf}

; Check to ensure menu.c32 exists... now required for AUMBI V2
  ${IfNot} ${FileExists} $BootDir\${MB_DIR}\menu.c32
   DetailPrint "Adding menu.c32. Required for AUMBI V2"
   CopyFiles /SILENT "$PLUGINSDIR\menu.c32" "$BootDir\${MB_DIR}\menu.c32"
  ${EndIf}
FunctionEnd
