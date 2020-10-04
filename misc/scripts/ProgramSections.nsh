#===========================================================
#
#===========================================================
; ---- Let's Do This Stuff ----
Section  ; This is the only section that exists
; Get just the name of the ISO file
Push "$ISOFile"
Push 1
Call GrabNameOnly
Pop $NameThatISO

 ${If} ${FileExists} "$BootDir\windows\system32" ; Additional safeguard to prevent installation to a Windows partition.
 MessageBox MB_ICONSTOP|MB_OK "ABORTING! ($DestDisk) contains a WINDOWS/SYSTEM32 Directory."
 Quit
 ${EndIf}

 ; The following checkpoint should not be necessary as a preventative measure is in place to check for a fourth partition table entry once the OS is launched. If it exists a warning is displayed and the process is paused.
 /* ${If} $DistroName == "Try Unlisted ISO (GRUB Partition 4)"
 ${OrIf} $DistroName == "Antergos"
 ${OrIf} $DistroName == "Bitdefender Rescue CD"
 ${OrIf} $DistroName == "CentOS Installer"
 ${OrIf} $DistroName == "CentOS Live"
 ${OrIf} $DistroName == "Deepin"
 ${OrIf} $DistroName == "Debian Live"
 ${OrIf} $DistroName == "Linux Mint"
 ${OrIf} $DistroName == "Linux Mint Debian Edition"  
 ${OrIf} $DistroName == "Q4OS"
 ${OrIf} $DistroName == "Rescuezilla"
 ${OrIf} $DistroName == "Slackel"
 ${OrIf} $DistroName == "Archlinux"
 ${OrIf} $DistroName == "Ubuntu Mini (Netboot Installer)"
 ${OrIf} $DistroName == "Wifislax (Wireless Penetration Testing)"
 ${OrIf} $DistroName == "OSFClone (Disk Cloning Tool)"
 ${OrIf} $DistroName == "NetRunner"
 ${OrIf} $DistroName == "Quick Save Live (Recovery Tool)"
 ${OrIf} $DistroName == "Norton Bootable Recovery Tool"
 ${OrIf} $DistroName == "Manjaro"
 ${OrIf} $DistroName == "OpenSUSE"
 ${OrIf} $DistroName == "Dr.Web LiveDisk"
 ${OrIf} $DistroName == "BionicPup"
 ${OrIf} $DistroName == "Emmabuntus"
 ${OrIf} $DistroName == "Solus"
 ${OrIf} $DistroName == "GeckoLinux"
 ${OrIf} $DistroName == "Kaspersky Rescue Disk (Antivirus Scanner)"
 ${OrIf} $DistroName == "Kodachi (Anonymous Browsing)"
 ${OrIf} $DistroName == "WifiWay (Wireless Penetration Testing)"
 ${OrIf} $DistroName == "Pop!_OS"
 ${OrIf} $DistroName == "KaOS"
 ${OrIf} $DistroName == "VyOS (Router OS)"
 ${OrIf} $DistroName == "Raspberry Pi Desktop"
 ${OrIf} $DistroName == "Fedora"
 ${OrIf} $DistroName == "Devuan"
 ${OrIf} $DistroName == "Vinari OS"
 ${OrIf} $DistroName == "Finnix"
 ${OrIf} $DistroName == "KDE Neon"
 ${OrIf} $DistroName == "OpenMandriva"
 ${OrIf} $DistroName == "Clonezilla (Backup + Clone Tool)"
 ${OrIf} $DistroName == "Parrot OS"
 ${OrIf} $DistroName == "Clear Linux"
 ${OrIf} $DistroName == "Alpine Linux"

 MessageBox MB_YESNO|MB_ICONEXCLAMATION "$(MBOX_FOURTABLE)" IDYES checkpoint
 Quit
 ${EndIf}

checkpoint: */

; Wipe and Format ---
 ${If} $FormatMe == "Yes"
  ${AndIf} $WipeMe == "Yes"
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "$(MBOX_WARNING01)" IDYES proceed
  Quit
 ${ElseIf} $FormatMeFat == "Yes"
  ${AndIf} $WipeMe == "Yes"
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "$(MBOX_WARNING02)" IDYES proceed
  Quit

; Format Only ---
 ${ElseIf} $FormatMe == "Yes"
  ${AndIf} $WipeMe == "No"
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "$(MBOX_WARNING03)" IDYES proceed
  Quit
 ${ElseIf} $FormatMeFat == "Yes"
  ${AndIf} $WipeMe == "No"
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "$(MBOX_WARNING04)" IDYES proceed
  Quit

; Don't Wipe or Format ---
 ${ElseIf} $FormatMe != "Yes"
  ${AndIf} $FormatMeFat != "Yes"
  ${AndIfNot} ${FileExists} $BootDir\${MB_DIR}\syslinux.cfg
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "$(MBOX_READYTOPERFORM)" IDYES proceed
  Quit
 ${EndIf}

proceed:
 ${IfThen} $Removal == "Yes" ${|} Goto removeonly ${|}
 Call FormatYes ; Format the Drive?
 Call HaveSpace ; Got enough Space? Lets Check!
 Call DoSyslinux ; Run Syslinux on the Drive to make it bootable
 Call LocalISODetected

; Copy the config file if it doesn't exist and create the entry in syslinux.cfg
 ${IfNot} ${FileExists} "$BootDir\${MB_DIR}\menu\$Config2Use"
 CopyFiles /SILENT "$PLUGINSDIR\$Config2Use" "$BootDir\${MB_DIR}\menu\$Config2Use"
 Call Config2Write
 ${EndIf}

removeonly:
 ${If} $Removal != "Yes"
 !insertmacro Install_Distros ; Install those distros
 ${ElseIf} $Removal == "Yes"
  Call ConfigRemove
 !insertmacro Uninstall_Distros ; Remove those distros
 ${EndIf}

SectionEnd
