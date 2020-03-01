#GenMenuFile
#Copyleft (c)2019 Darwin Toledo

!macro AppendGenMenuFile FILE_N FILE_TEXT
       !delfile "${FILE_N}"
       !appendfile "${FILE_N}" "${GenCreditsFile}$\n${FILE_TEXT}"
!macroend
!define AppendGenMenuFile "!insertmacro AppendGenMenuFile "

!define DefaultMenuColor "MENU color disabled   	1;30;44 #000000 #000000 std\
                         $\nMENU color hotsel       30;47   #C00000 #DDDDDD std\
                         $\nMENU color scrollbar    30;44   #000000 #000000 std\
                         $\nMENU color border       30;44   #D00000 #000000 std\
                         $\nMENU color title        1;36;44 #66A0FF #000000 std\
                         $\nMENU color sel          7;37;40 #000000 #FFFFFF all\
                         $\nMENU color unsel        37;44   #FFFFFF #000000 std\
                         $\nMENU color help         37;40   #FFFFFF #000000 std\
                         $\nMENU color timeout_msg  37;40   #FFFFFF #000000 std\
                         $\nMENU color timeout      1;37;40 #FFFFFF #000000 std\
                         $\nMENU color tabmsg       31;40   #FFFF00 #000000 std\
                         $\nMENU color screen       37;40   #000000 #000000 std"

!define MainMenuColor "menu color title 1;36;44 #66A0FF #00000000 none\
                      $\nmenu color hotsel 30;47 #C00000 #DDDDDDDD\
                      $\nmenu color sel 30;47 #000000 #FFFFFFFF\
                      $\nmenu color border 30;44	#D00000 #00000000 std\
                      $\nmenu color scrollbar 30;44 #DDDDDDDD #00000000 none"


var A0
!macro GenMenuFile FILE_N FILE_EXT FILE_TEXT
       !define UL ${__LINE__}
       Function Gen_${FILE_N}
                ClearErrors
                FileOpen $A0 "$PLUGINSDIR\${FILE_N}.${FILE_EXT}" w
                IfErrors END_${UL}
                FileWrite $A0 "$(GEN_CREDITS_FILE)$\n${FILE_TEXT}"
                FileClose $A0
                END_${UL}:
       FunctionEnd
       !undef UL
!macroend
!define GenMenuFile "!insertmacro GenMenuFile "


!macro GenDefaultMenuFile FILE_N MENU_TITLE MENU_TEXT
       ${GenMenuFile} ${FILE_N} "cfg" "UI /${MB_DIR}/vesamenu.c32\
                                   $\nMENU TITLE ${MENU_TITLE}\
                                   $\nMENU BACKGROUND ${NAME}.png\
                                   $\nMENU TABMSG  ${PRODUCT_WEBSITE}\
                                   $\nMENU WIDTH 72\
                                   $\nMENU MARGIN 10\
                                   $\nMENU VSHIFT 3\
                                   $\nMENU HSHIFT 6\
                                   $\nMENU ROWS 15\
                                   $\nMENU TABMSGROW 20\
                                   $\nMENU TIMEOUTROW 22\
                                   $\n\
                                   $\n${MainMenuColor}$\n\
                                   $\nLABEL <-- $(MENU_BACKTOMAIN)\
                                   $\nCONFIG /${MB_DIR}/syslinux.cfg\
                                   $\nMENU SEPARATOR${MENU_TEXT}"
!macroend
!define GenDefaultMenuFile "!insertmacro GenDefaultMenuFile "


!define GenCreditsFile            "# Menu Created by ${NAME}"
!define MENU_LABEL_ACRONIS        "Acronis True Image"
!define MENU_TITLE_ACRONIS        "Acronis True Image Boot Menu"

${GenMenuFile} "syslinux" "cfg" "UI vesamenu.c32\
                                $\nTIMEOUT 300\
                                $\nMENU TITLE AUMBI\
                                $\nMENU BACKGROUND AUMBI.png\
                                $\nMENU TABMSG  https://www.usbwithlinux.com\
                                $\nMENU WIDTH 72\
                                $\nMENU MARGIN 10\
                                $\nMENU VSHIFT 3\
                                $\nMENU HSHIFT 6\
                                $\nMENU ROWS 15\
                                $\nMENU TABMSGROW 20\
                                $\nMENU TIMEOUTROW 22\
                                $\n${MainMenuColor}\
                                $\n\
                                $\nLABEL $(MAIN_BOOT_HDD)\
                                $\nMENU LABEL $(MAIN_BOOT_HDD2)\
                                $\nKERNEL chain.c32\
                                $\nAPPEND hd1\
                                $\nMENU DEFAULT"

${GenMenuFile} "acronisti" "cfg" "UI /${MB_DIR}/menu/vesamenu.c32\
                               $\nmenu title ${MENU_TITLE_ACRONIS}\
                               $\n\
                               $\nMENU MARGIN 10\
                               $\nMENU VSHIFT 4\
                               $\n\
                               $\n${DefaultMenuColor}$\n\
                               $\nLABEL 32bit\
                               $\nMENU LABEL ^${MENU_LABEL_ACRONIS} 32bit\
                               $\nMENU INDENT 1\
                               $\nKERNEL kernel.dat\
                               $\nAPPEND initrd=ramdisk.dat vga=0x314 ramdisk_size=40000 quiet\
                               $\n\
                               $\nLABEL 64bit\
                               $\nMENU LABEL ${MENU_LABEL_ACRONIS} 64bit\
                               $\nMENU INDENT 1\
                               $\nKERNEL kernel64.dat\
                               $\nAPPEND initrd=ramdisk64.dat vga=0x314 ramdisk_size=40000 quiet\
                               $\n\
                               $\nMENU SEPARATOR\
                               $\nLABEL <-- $(MENU_BACKTOMAIN)\
                               $\nKERNEL vesamenu.c32\
                               $\nAPPEND /${MB_DIR}/syslinux.cfg"

${GenDefaultMenuFile} "unlisted" "$(MENU_LABEL_UNLISTED)" ""
${GenDefaultMenuFile} "system" "$(MENU_LABEL_SYS_TOOLS)" ""
${GenDefaultMenuFile} "pe" "Windows PE" ""
${GenDefaultMenuFile} "other" "$(MENU_LABEL_OTHER_OS)" ""
${GenDefaultMenuFile} "netbook" "$(MENU_LABEL_NETBOOK)" ""
${GenDefaultMenuFile} "antivirus" "$(MENU_LABEL_ANTIVIR)" ""
${GenDefaultMenuFile} "linux" "$(MENU_LABEL_LUNIX_DIST)" ""

${GenDefaultMenuFile} "konbootpaid" "Konboot - Admin login without a Password" "$\n\
                                          $\nlabel Boot Konboot Paid Version\
                                          $\nmenu label ^Boot Konboot\
                                          $\nMENU INDENT 1\
                                          $\nkernel /${MB_DIR}/memdisk\
                                          $\nappend initrd=/${MB_DIR}/SLUG/konbootpaid.img floppy\
                                          $\n\
                                          $\nTEXT HELP\
                                          $\nKonboot Instructions:\
                                          $\n (1) Run Konboot, you will be returned to the YUMI Menu.\
                                          $\n (2) Select the option to $\"Continue to Boot from first HD$\" \
                                          $\nENDTEXT\
                                          $\n\
                                          $\nMENU SEPARATOR\
                                          $\n\
                                          $\nlabel Boot from first Hard Drive\
                                          $\nmenu label Boot from ^First Hard Drive\
                                          $\nMENU INDENT 1\
                                          $\nKERNEL chain.c32\
                                          $\nAPPEND hd1\
                                          $\n\
                                          $\nTEXT HELP\
                                          $\nPost Konboot Instructions:\
                                          $\n Choose this option after running Konboot, if the System\
                                          $\n you want to try to boot is located on the first hard drive\
                                          $\nENDTEXT\
                                          $\n\
                                          $\nlabel Boot from second Hard Drive\
                                          $\nmenu label Boot from ^Second Hard Drive\
                                          $\nMENU INDENT 1\
                                          $\nKERNEL chain.c32\
                                          $\nAPPEND hd2\
                                          $\n\
                                          $\nTEXT HELP\
                                          $\nPost Konboot Instructions:\
                                          $\n Choose this option after running Konboot, if the System\
                                          $\n you want to try to boot is located on the second hard drive\
                                          $\nENDTEXT\
                                          $\n\
                                          $\nlabel Boot from third Hard Drive\
                                          $\nmenu label Boot from ^Third Hard Drive\
                                          $\nMENU INDENT 1\
                                          $\nKERNEL chain.c32\
                                          $\nAPPEND hd3\
                                          $\n\
                                          $\nTEXT HELP\
                                          $\nPost Konboot Instructions:\
                                          $\n Choose this option after running Konboot, if the System\
                                          $\n you want to try to boot is located on the third hard drive\
                                          $\nENDTEXT"

${GenDefaultMenuFile} "konboot" "Konboot - Admin login without a Password" "$\n\
                                          $\nlabel Boot Konboot FREE Version\
                                          $\nmenu label ^Boot Konboot\
                                          $\nMENU INDENT 1\
                                          $\nkernel /${MB_DIR}/memdisk\
                                          $\nappend initrd=/${MB_DIR}/SLUG/konboot.img floppy\
                                          $\n\
                                          $\nTEXT HELP\
                                          $\nKonboot Instructions:\
                                          $\n (1) Run Konboot, you will be returned to the YUMI Menu.\
                                          $\n (2) Select the option to $\"Continue to Boot from first HD$\" \
                                          $\nENDTEXT\
                                          $\n\
                                          $\nMENU SEPARATOR\
                                          $\n\
                                          $\nlabel Boot from first Hard Drive\
                                          $\nmenu label Boot from ^First Hard Drive\
                                          $\nMENU INDENT 1\
                                          $\nKERNEL chain.c32\
                                          $\nAPPEND hd1\
                                          $\n\
                                          $\nTEXT HELP\
                                          $\nPost Konboot Instructions:\
                                          $\n Choose this option after running Konboot, if the System\
                                          $\n you want to try to boot is located on the first hard drive\
                                          $\nENDTEXT\
                                          $\n\
                                          $\nlabel Boot from second Hard Drive\
                                          $\nmenu label Boot from ^Second Hard Drive\
                                          $\nMENU INDENT 1\
                                          $\nKERNEL chain.c32\
                                          $\nAPPEND hd2\
                                          $\n\
                                          $\nTEXT HELP\
                                          $\nPost Konboot Instructions:\
                                          $\n Choose this option after running Konboot, if the System\
                                          $\n you want to try to boot is located on the second hard drive\
                                          $\nENDTEXT\
                                          $\n\
                                          $\nlabel Boot from third Hard Drive\
                                          $\nmenu label Boot from ^Third Hard Drive\
                                          $\nMENU INDENT 1\
                                          $\nKERNEL chain.c32\
                                          $\nAPPEND hd3\
                                          $\n\
                                          $\nTEXT HELP\
                                          $\nPost Konboot Instructions:\
                                          $\n Choose this option after running Konboot, if the System\
                                          $\n you want to try to boot is located on the third hard drive\
                                          $\nENDTEXT"


;${GenDefaultMenuFile} "Testacronisti.cfg" "Rodrii Distributions" ""
${GenDefaultMenuFile} "anon" "$(MENU_LABEL_SYS_ANONY)" ""


#======================================================================
# GEN LST FILE
#======================================================================

!macro GenDefaultLSTFile FILE_N MENU_TITLE
       ${GenMenuFile} ${FILE_N} "lst" "default 1\
                                $\ntimeout 30\
                                $\ncolor NORMAL HIGHLIGHT HELPTEXT HEADING\
                                $\nforeground=FFFFFF\
                                $\nbackground=000000\
                                $\n\
                                $\ntitle --- ${MENU_TITLE} ---\
                                $\nroot\
                                $\n\
                                $\ntitle <-- $(MENU_BACKTOMAIN)\
                                $\nroot (hd0,0)\
                                $\nchainloader (hd0)+1\
                                $\nrootnoverify (hd0)"
!macroend
!define GenDefaultLSTFile "!insertmacro GenDefaultLSTFile "


${GenDefaultLSTFile} "win2go" "Windows to Go"
${GenDefaultLSTFile} "win" "Windows Installers"

;${GenDefaultLSTFile} "" ""

/*
${GenMenuFile} "FILE" "\
                   $\n"

${GenMenuFile} "FILE" "\
                   $\n"
*/


#======================================================================
# CALL GEN MENU FILES
#======================================================================

Function CFGWriteFile
         #CALL MENU FILES
         Call Gen_acronisti
         Call Gen_unlisted
         Call Gen_system
         Call Gen_pe
         Call Gen_other
         Call Gen_netbook
         Call Gen_antivirus
         Call Gen_linux
         Call Gen_konbootpaid
         Call Gen_konboot
         Call Gen_anon
         Call Gen_syslinux
         #CALL GEN LST FILES
         Call Gen_win2go
         Call Gen_win
FunctionEnd
