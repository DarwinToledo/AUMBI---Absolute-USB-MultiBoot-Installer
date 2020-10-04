#===========================================================
# AUMBI
# (c)Copyleft 2016-2020 by Darwin Toledo
#
#===========================================================

#===========================================================
# INCLUDES
#===========================================================
;         Unicode true

         !execute "misc\Scripts\Build Counter v1.0.exe"

         !addincludedir "misc\Scripts"
         !addplugindir  "plugins"
         !addplugindir  "misc\Plugins"

         !include "misc\scripts\defines.nsh"

         !define MB_DIR "multiboot"
         !define MB_LAB "MULTIBOOT"
         !include GenDiskPartFile.nsh
         !include GenMenuFile.nsh
         ;!error
         !include "misc\scripts\Macros.nsh"
         !include WordFunc.nsh
         !include nsDialogs.nsh
         !include MUI2.nsh
         !include FileFunc.nsh
         !include LogicLib.nsh
;        !include TextFunc.nsh

         RequestExecutionLevel admin ;highest
         SetCompressor /SOLID /FINAL LZMA
         CRCCheck On
         XPStyle on

         ManifestDPIAware True
         ManifestSupportedOS All


#===========================================================
# MoreInfo Plugin - Adds Version Tab fields to Properties. Plugin created by onad http://nsis.sourceforge.net/MoreInfo_plug-in
#===========================================================
         VIProductVersion "${VERSION}"
         VIAddVersionKey CompanyName "usbwithlinux.com"
         VIAddVersionKey LegalCopyright "Copyleft �2020 Darwin Toledo usbwithlinux.com"
         VIAddVersionKey FileVersion "${VERSION}"
         VIAddVersionKey FileDescription "AUMBI"
         VIAddVersionKey License "GPL Version 2"

#===========================================================
# Installer Atrrib
#===========================================================

         Name "${NAME} ${VERSION}"
         !ifdef BUILD_STABLE
         Caption "${NAME} - ${VERSION_TIME} - ${PRODUCT_WEBSITE}"
         OutFile "..\${FILENAME}-${VERSION_TIME}.exe"
         BrandingText "${NAME} ${VERSION} - ${PRODUCT_WEBSITE}"
         !else
         Caption "${NAME} beta - ${VERSION_TIME} - ${PRODUCT_WEBSITE}"
         OutFile "..\${FILENAME}-${VERSION_TIME}-beta.exe"
         BrandingText "${NAME} ${VERSION} Beta - ${PRODUCT_WEBSITE}"
         !endif

         ShowInstDetails show
         CompletedText "$(COMPLETED_TEXT)"
         InstallButtonText "$(Create_Button)"


!include "misc\scripts\Variables.nsh"
!include DiskVoodoo.nsh

; Interface settings
         !define MUI_CUSTOMFUNCTION_GUIINIT AUMBIInit
!define MUI_FINISHPAGE_NOAUTOCLOSE
;!define MUI_HEADERIMAGE
;!define MUI_HEADERIMAGE_BITMAP "images\usb-logo-nsis.bmp"
;!define MUI_HEADERIMAGE_BITMAP_NOSTRETCH
;!define MUI_HEADERIMAGE_RIGHT
   !define MUI_HEADERIMAGE
   !define MUI_HEADERIMAGE_BITMAP "Resources\images\AUMBI_BKG.bmp"
   !define MUI_UI_HEADERIMAGE "Resources\UI\AUMBI_UI.exe"

; License Agreement Page
         !define MUI_TEXT_LICENSE_SUBTITLE $(License_Subtitle)
         !define MUI_LICENSEPAGE_TEXT_TOP $(License_Text_Top)
         !define MUI_LICENSEPAGE_TEXT_BOTTOM $(License_Text_Bottom)
         !define MUI_PAGE_CUSTOMFUNCTION_PRE License_PreFunction
         !define MUI_PAGE_CUSTOMFUNCTION_SHOW License_ShowFunction
         !insertmacro MUI_PAGE_LICENSE "AUMBI.rtf"

; Distro Selection Page
Page custom SelectionsPage_Show

; Install Files Page
!define MUI_INSTFILESPAGE_COLORS "00FF00 000000" ;Green and Black
!define MUI_INSTFILESPAGE_FINISHHEADER_TEXT $(Finish_Install)
!define MUI_TEXT_INSTALLING_TITLE $(Install_Title)
!define MUI_TEXT_INSTALLING_SUBTITLE $(Install_SubTitle)
!define MUI_TEXT_FINISH_SUBTITLE $(Install_Finish_Sucess)
!define MUI_PAGE_CUSTOMFUNCTION_PRE InstFiles_PreFunction
!define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFiles_ShowFunction
!insertmacro MUI_PAGE_INSTFILES

; Finish page
!define MUI_FINISHPAGE_TITLE $(Finish_Title)
!define MUI_FINISHPAGE_TEXT $(Finish_Text)
!define MUI_FINISHPAGE_LINK $(Finish_Link)
!define MUI_FINISHPAGE_LINK_LOCATION "${PRODUCT_WEBSITE_B}"
;!define MUI_WELCOMEFINISHPAGE_BITMAP "images\finish.bmp"
!define MUI_PAGE_CUSTOMFUNCTION_PRE Finish_PreFunction
;!insertmacro MUI_PAGE_FINISH
         Page custom fnc_AUMBI_FINISH_Show

; Language files
         !insertmacro MUI_LANGUAGE "English" ; first language is the default language
         !include     "misc\Languages\Language_English.nsh"
         !insertmacro MUI_LANGUAGE "SpanishInternational"
         !include     "misc\Languages\Language_SpanishInternational.nsh"
         !insertmacro MUI_LANGUAGE "PortugueseBR"
         !include     "misc\Languages\Language_PortugueseBR.nsh"
;         !insertmacro MUI_LANGUAGE "Italian"
;         !include     "misc\Languages\Language_Italian.nsh"

  !insertmacro MUI_RESERVEFILE_LANGDLL

!include FileManipulation.nsh ; Text File Manipulation
!include FileNames.nsh ; Macro for FileNames
!include DistroList.nsh ; List of Distributions
!include "CasperScript.nsh" ; For creation of Persistent Casper-rw files
!include ReplaceInFile.nsh


!include "misc\scripts\PageFunctionDPIsize.nsh" ;CustonDPI Function
!insertmacro GETDPI ""
!include "misc\scripts\PageFunctionLicense.nsh" ;Custom Function for License (Transparency)
!include "misc\scripts\PageFunctionSelections.nsh" ;Custom Function for Selections page (Transparency)
!include "misc\scripts\PageFunctionInit.nsh" ;Custom Function for Init GUI


; Function OnClickDonate
;   ExecShell "open" "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=T6K3C62LC5TCG"
; FunctionEnd 

!include "misc\scripts\PageFunctionInstFiles.nsh"
!include "misc\scripts\PageFunctionFinish.nsh"


Function ListAllDrives ; Set to Display All Drives
  SendMessage $DestDriveTxt ${CB_RESETCONTENT} 0 0 
  ${NSD_GetState} $AllDriveOption $DisplayAll
  ${If} $DisplayAll == ${BST_CHECKED}
  ${NSD_Check} $AllDriveOption
  ${NSD_SetText} $AllDriveOption "$(RL2_SHOWING)"
   StrCpy $ShowAll "YES"
   ${GetDrives} "FDD+HDD" DrivesList ; All Drives Listed  
  ${ElseIf} $DisplayAll == ${BST_UNCHECKED}
  ${NSD_Uncheck} $AllDriveOption
  ${NSD_SetText} $AllDriveOption "$(SHOW_ALL_DRIVES)"
	 ${GetDrives} "FDD" DrivesList ; FDD+HDD reduced to FDD for removable media only
	StrCpy $ShowAll "NO"
  ${EndIf}
FunctionEnd

Function onClickMyLink
  Pop $Links ; pop something to prevent corruption
  ExecShell "open" "${PRODUCT_WEBSITE_C}"
FunctionEnd

Function onClickMyLinkFAQ
  Pop $Links1 ; pop something to prevent corruption
  ExecShell "open" "${PRODUCT_WEBSITE_D}"
FunctionEnd

Function onClickMyLinkUSB
  Pop $Links2 ; pop something to prevent corruption
  ExecShell "open" "${PRODUCT_WEBSITE_E}"
FunctionEnd

Function onClickLinuxSite
  Pop $OfficialSite 
  ExecShell "open" "$Homepage"
FunctionEnd

Function DownloadIt ; Set Download Option
  ${NSD_GetState} $DownloadISO $DownloadMe
  ${If} $DownloadMe == ${BST_CHECKED}
  ${NSD_Check} $DownloadISO
  ${NSD_SetText} $DownloadISO "$(RL_ODL)"
  Call DownloadLinks
  ${ElseIf} $DownloadMe == ${BST_UNCHECKED}
  ${NSD_Uncheck} $DownloadISO 
  ${NSD_SetText} $DownloadISO "$(RL_DL1)"
  ${EndIf}  
FunctionEnd

Function EnableNext ; Enable Install Button
  ;${If} $Blocksize >= 4 
  ${If} $Removal != "Yes"
  ${AndIf} $HDDUSB != "HDD"
    ${If} $FormatMe == "YES" 
    ShowWindow $Format 1 
    ${EndIf}
    ${If} $FormatMeFat == "YES" 
    ShowWindow $FormatFat 1 
    ${EndIf}
  ${Else}
  ShowWindow $Format 0
  ShowWindow $FormatFat 0
  ${NSD_UnCheck} $Format
  StrCpy $FormatMe ""  
  ${EndIf}
  ${If} $Removal != "Yes"    
   ${AndIf} $ISOFileName != ""
    ${AndIf} $ISOFile != ""
     ${AndIf} $DestDrive != "" 
	  ${AndIf} $ISOTest != ""
  StrCpy $InUnStall "Add"	
   StrCpy $InUnStalling "Adding"	
    StrCpy $InUnStalled "Added"	
  StrCpy $OnFrom "to"
  StrCpy $InUnName "$JustISOName"
  GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
   SendMessage $6 ${WM_SETTEXT} 0 "STR:$(BUTTON_CREATE_TEXT)"
    EnableWindow $6 1 ; Enable "Install" control button

  ${ElseIf} $Removal == "Yes"
   ${AndIf} $ISOFileName != ""
     ${AndIf} $DestDrive != "" 
	  ${AndIf} $ISOTest != ""
  StrCpy $InUnStall "Remove"	
   StrCpy $InUnStalling "Removing"	
    StrCpy $InUnStalled "Removed"	  
  StrCpy $OnFrom "from"	
  StrCpy $InUnName "$DistroName"
  GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
   SendMessage $6 ${WM_SETTEXT} 0 "STR:$(BUTTON_REMOVE_TEXT)"
    EnableWindow $6 1 ; Enable "Install" control button
  ${EndIf}
  
; Test if ISO has been Selected. If not, disable Install Button
  ${If} $ISOTest == ""
  GetDlgItem $6 $HWNDPARENT 1
  EnableWindow $6 0 ; Disable "Install" if ISO not set 
  ${EndIf}
  
; Show Steps in progression
  ${If} $DestDrive != ""  
  EnableWindow $LinuxDistroSelection 1
  EnableWindow $Distro 1
  ${EndIf}  
  
  ${If} $ISOFileName != "" 
  ${AndIf} $Removal != "Yes"
  EnableWindow $LabelISOSelection 1 
  EnableWindow $ISOFileTxt 1  
  ShowWindow $ISOSelection 1
  
  ${AndIf} $Removal == "Yes"
  EnableWindow $LabelISOSelection 0  
  EnableWindow $ISOFileTxt 0 
  ShowWindow $ISOSelection 0
  ${EndIf}  
  
; Disable Window if ISO was downloaded
  ${If} $TheISO == "$EXEDIR\$ISOFileName"
  ${AndIf} $ISOTest != ""  
  EnableWindow $ISOSelection 0
  SetCtlColors $ISOFileTxt 009900 FFFFFF  
  ${EndIf}

; If using Casper Persistence...  
  ${If} $Persistence == "casper" ; If can use Casper Persistence... 
  ${AndIf} $TheISO != ""
  ${AndIf} $BootDir != "" 
  ;${AndIf} $FSType != "NTFS" ; prevent casper if NTFS... implement fix for this later.
  ShowWindow $CasperSelection 1
  ShowWindow $CasperSlider 1
  ShowWindow $SlideSpot 1
   ${If} $DistroName == "Windows to Go (Virtual Hard Disk)"
     SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 20000 ; Min Range Value
    ${NSD_SetText} $CasperSelection "$(STEP_4_SETTHESIZE)"
	${Else} 
	 SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 0 ; Min Range Value 0
	${NSD_SetText} $CasperSelection "$(STEP_4_SETPERSIST)"
   ${EndIf}
  ;${NSD_SetText} $Format "Format $JustDrive Drive (Erases Content)"  
	
; Else If not using Casper Persistence...  
  ${ElseIf} $Persistence != "casper" ; Eventually change to "NULL"
   ${OrIf} $Removal == "Yes"  
  ShowWindow $CasperSelection 0
  ShowWindow $CasperSlider 0 
  ShowWindow $SlideSpot 0
  ;${NSD_SetText} $Format "Format $JustDrive Drive (Erases Content)" 
  ${EndIf}    
FunctionEnd

Function DownloadLinks
MessageBox MB_YESNO|MB_ICONQUESTION "$(MB_DL2)" IDYES DownloadIt IDNO Skip
  Skip: ; Reset Download Checkbox Options 
  ${NSD_Uncheck} $DownloadISO 
  ${NSD_SetText} $DownloadISO "$(RL_DL1)"
  EnableWindow $DownloadISO 1
  Goto end
  DownloadIt:
  ${NSD_SetText} $LabelISOSelection "$(RL2_STEP3)"
  EnableWindow $DownloadISO 0
  ExecShell "open" "$DownLink"    
  end:
FunctionEnd

Function LocalISODetected ; The script autodetected the ISO, so let's do the following
 ${If} $DownloadMe != ${BST_CHECKED}
 ${AndIf} $LocalSelection != "Yes"
 StrCpy $ISOFile "$EXEDIR\$ISOFileName"
 ${EndIf}
FunctionEnd

; get only the filename
Function GrabNameOnly
  Exch $4 ; count to get part
  Exch
  Exch $0 ; input string
  Push $1
  Push $2
  Push $3
  StrCpy $1 0
  StrCpy $3 1
  loop:
    IntOp $1 $1 - 1
    StrCpy $2 $0 1 $1
    StrCmp $2 "" exit2
    StrCmp $2 "\" next ; grab text to the right of "\"
    Goto loop
  next:
    StrCmp $3 $4 exit
    IntOp $3 $3 + 1
  Goto loop
  exit2:
    IntOp $1 $1 - 1
  exit:
    IntOp $1 $1 + 1
    StrCpy $0 $0 "" $1
    Pop $3
    Pop $2
    Pop $1
    Exch $0 ; output string
FunctionEnd

 !include StrContains.nsh ; Let's check if a * wildcard exists
 
; On Selection of Linux Distro
Function OnSelectDistro
  Pop $Distro
  
  ${If} $Removal == "Yes"
   ShowWindow $ForceShowAll 0
  ${Else}
   ShowWindow $ForceShowAll 1
  ${EndIf}
  
  ${NSD_GetText} $Distro $DistroName ; Was ${NSD_LB_GetSelection} $Distro $DistroName 
  StrCpy $DistroName "$DistroName"   
  StrCpy $Checker "No" 
  ${If} $Removal == "Yes"
  StrCpy $ISOFileName "$DistroName" 
  StrCpy $ISOTest "$DistroName"  
  ${Else} 
  Call SetISOFileName
  StrCpy $ISOFileName "$ISOFileName" 
  StrCpy $SomeFileExt "$ISOFileName" "" -3 ; Grabs the last 3 characters of the file name... zip or iso?
  StrCpy $FileFormat "$SomeFileExt" ; Set file type to look for zip, tar, iso etc...
  ${NSD_SetText} $LabelISOSelection "$(BW2_STEP3)"
  ${NSD_SetText} $ISOFileTxt "$(BW_ISO_1)"
  SetCtlColors $ISOFileTxt FF0000 FFFFFF  
  StrCpy $ISOTest "" ; Set to null until a new ISO selection is made
  ${EndIf}
  
; Redraw Home page Links as necessary
  ${NSD_SetText} $DistroLink "$(VTO_HOME1)"
  ShowWindow $DistroLink 0
  ${If} $OfficialName == ""
   ${OrIf} $Removal == "Yes"
  ShowWindow $DistroLink 0
  ${Else}
  ShowWindow $DistroLink 1
  ${EndIf}    
  
  ${If} $DistroName != ""
  ${NSD_SetText} $LinuxDistroSelection "$(STEP_2_SELADISTRNA)"
  ${Else}
  ${NSD_SetText} $LinuxDistroSelection "$(STEP_2_SELADISTRIB)"
  ${EndIf}    
  
; Autodetect ISO's in same folder and select if they exist  
 ${If} ${FileExists} "$EXEDIR\$ISOFileName"
 ${AndIf} $Removal != "Yes"
 ${StrContains} $WILD "*" "$ISOFileName" ; Check for Wildcard and force Browse if * exists.
 ${AndIf} $WILD != "*"  
  StrCpy $TheISO "$EXEDIR\$ISOFileName"
  StrCpy $ISOFile "$TheISO"  
  ${GetFileName} "$TheISO" $JustISO
  ${StrRep} '$JustISO' '$JustISO' ' ' '-'  
  ${GetBaseName} "$JustISO" $JustISOName
  ${StrRep} '$JustISOName' '$JustISOName' ' ' '-'
;MessageBox MB_OK $JustISOName 
  ${GetParent} "$TheISO" $JustISOPath  
  EnableWindow $DownloadISO 0
  ${NSD_SetText} $DownloadISO "$(WE_SELECT1)"
  EnableWindow $ISOSelection 0 
  SetCtlColors $ISOFileTxt 009900 FFFFFF  
  ${NSD_SetText} $ISOFileTxt $ISOFile 
  ${NSD_SetText} $LabelISOSelection "$(DONE_STEP3)"
  StrCpy $ISOTest "$TheISO" ; Populate ISOTest so we can enable Next    
  Call EnableNext  
  
 ${ElseIf} ${FileExists} "$EXEDIR\$ISOFileName"
 ${AndIf} $Removal != "Yes"
 ${AndIf} $WILD == "*" 
  EnableWindow $DownloadISO 1
  EnableWindow $ISOSelection 1
  ${NSD_Uncheck} $DownloadISO  
  ${NSD_SetText} $DownloadISO "$(RL_DL1)"
  SetCtlColors $ISOFileTxt FF9B00 FFFFFF  
  ${NSD_SetText} $ISOFileTxt "$(BW_ISO_2)"
  ${NSD_SetText} $LabelISOSelection "$(PEND_STEP3)"
  Call EnableNext  
  
 ${Else}
  Call EnableNext
  EnableWindow $DownloadISO 1
  EnableWindow $ISOSelection 1
  ${NSD_Uncheck} $DownloadISO  
  ${NSD_SetText} $DownloadISO "$(RL_DL1)"
 ${EndIf}  
 
 ${If} $DownLink == "NONE"
  ${OrIf} $Removal == "Yes"
  ShowWindow $DownloadISO 0
 ${Else}
  ShowWindow $DownloadISO 1
 ${EndIf}
FunctionEnd 

; On Selection of ISO File
Function ISOBrowse
 ${If} $ShowingAll == "Yes"
  StrCpy $ISOFileName "*.iso" 
 ${ElseIf} $ShowingAll != "Yes"
  Call SetISOFileName
 ${EndIf}
 
 nsDialogs::SelectFileDialog open "" $(IsoFile)
 Pop $TheISO  
 ${NSD_SetText} $ISOFileTxt $TheISO
 SetCtlColors $ISOFileTxt 009900 FFFFFF
 EnableWindow $DownloadISO 0
 ${NSD_SetText} $DownloadISO "$(LOCAL_SOMEFILE_SEL)"
 StrCpy $ISOTest "$TheISO" ; Populate ISOTest so we can enable Next 
 StrCpy $ISOFile "$TheISO" 
 ${GetFileName} "$TheISO" $JustISO
 ${StrRep} '$JustISO' '$JustISO' ' ' '-'
 ${GetBaseName} "$JustISO" $JustISOName
 ${StrRep} '$JustISOName' '$JustISOName' ' ' '-'
;MessageBox MB_OK $JustISOName 
 ${GetParent} "$TheISO" $JustISOPath
 StrCpy $LocalSelection "Yes"
  Call SetISOSize
  Call SetSpace
  Call CheckSpace
  Call HaveSpacePre
 ${If} $JustISOName == "" 
 StrCpy $JustISOName "NULL" ; Set to NULL until something is selected
 ${EndIf}
 
 ${If} $JustISO != ""
 ${NSD_SetText} $LabelISOSelection "$(STEP_3_JUSTISOSEL)"
 ${Else}
 ${NSD_SetText} $LabelISOSelection "$(STEP_3_SELYOURISO)"
 ${EndIf} 
 
 ${If} ${FileExists} "$BootDir\${MB_DIR}\$JustISOName\*.*"
 ${AndIf} $JustISOName != ""
 ${AndIf} $FormatMe != "Yes"
 ${AndIf} $FormatMeFat != "Yes"
 MessageBox MB_OK "$(JUST_ISONAME_ALREDY)"
 ${Else}
 ${EndIf}
 Call EnableNext
 ; Uncomment for Testing --> MessageBox MB_ICONQUESTION|MB_OK 'Removal: "$Removal"  ISOFileName: "$ISOFileName" ISOFile "$ISOFile" BootDir: "$BootDir" DestDisk: "$DestDisk" DestDrive: "$DestDrive" ISOTest: "$ISOTest"'
  
  ${If} $FSType != "NTFS"
  ${AndIf} $FormatMe != "Yes"
  ${AndIf} $DistroName == "Windows to Go (Virtual Hard Disk)"
  MessageBox MB_ICONSTOP|MB_OK "WARNING! ($DestDisk) is not NTFS formatted. NTFS is required for the Windows to Go option to work."
  ${EndIf}  
 FunctionEnd

Function ClearAll
StrCpy $ISOTest ""
StrCpy $DistroName "" ; Clear Distro Name
StrCpy $ISOFileName "" ; Clear ISO Selection
StrCpy $SomeFileExt ""
StrCpy $FileFormat ""
FunctionEnd

Function InstallorRemove ; Populate DistroName based on Install/Removal option
  ${If} $Removal == "Yes" 
  Call RemovalList
  ${Else}
    ${If} $DistroName == ""
    ${NSD_SetText} $LinuxDistroSelection "$(STEP2_SELECTADISTRO)"
	${EndIf}
  SendMessage $Distro ${CB_RESETCONTENT} 0 0
  Call SetISOFileName
  ${EndIf}
FunctionEnd  

#Include Uninstall Function
         !include "misc\scripts\PageFuncUninstall.nsh"

; On Selection of USB Drive
Function OnSelectDrive
  Pop $DestDriveTxt
  ${NSD_GetText} $DestDriveTxt $Letters
  StrCpy $DestDrive "$Letters"
  StrCpy $JustDrive $DestDrive 3  
  StrCpy $BootDir $DestDrive 2 ;was -1 
  StrCpy $DestDisk $DestDrive 2 ;was -1
  StrCpy $HDDUSB $Letters "" -3 
  
  StrCpy $9 $JustDrive
  Call GetFSType
  Call PhysDrive
  ${NSD_SetText} $LabelDrivePage "$(STEP1_DESTUSBDEV)"
  ;MessageBox MB_ICONSTOP|MB_OK " $9 $FSType" 

  ${NSD_GetState} $Wipe $WipeIt
  ${If} $WipeIt == ${BST_CHECKED}
  ${NSD_Check} $Wipe
   StrCpy $WipeMe "Yes"
  ${NSD_SetText} $Wipe "$(DISK_LABEL1)"
  ${ElseIf} $WipeIt == ${BST_UNCHECKED}
  ${NSD_Uncheck} $Wipe
   StrCpy $WipeMe "No"
  ${NSD_SetText} $Wipe "$(DISK_LABEL2)"
  ; ShowWindow $Uninstaller 1 ; Re-enable Uninstaller option.
  ${EndIf}


  SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; was ${NSD_LB_Clear} $Distro "" ; Clear all distro entries because a new drive may have been chosen ; Enable for DropBox
  StrCpy $Checker "Yes" 
  Call InstallorRemove
  Call SetSpace
  Call CheckSpace
  Call FormatIt  
  Call EnableNext

  ${If} $FSType == "exFAT"
  MessageBox MB_ICONSTOP|MB_OK "WARNING! Syslinux won't work on exFAT formatted devices. Please format $DestDisk Fat32 or NTFS."
  ${EndIf} 
  
  ${If} ${FileExists} "$BootDir\boot\grub\AUMBI.png"
   ${AndIf} ${FileExists} "$BootDir\boot\grub\lnxboot.img"
    ${AndIf} ${FileExists} "$BootDir\boot\grub\core.img" 
     ${AndIf} ${FileExists} "$BootDir\boot\grub\grub.cfg"  
     MessageBox MB_ICONSTOP|MB_OK "WARNING! ($DestDisk) contains a UEFI AUMBI or GRUB2 based Installation which is not compatible with this version.$\r$\n$\r$\nYou'll need to format this drive if you plan to use this version of AUMBI."
  ${EndIf} 
FunctionEnd

Function GetDiskVolumeName
;Pop $1 ; get parameter
System::Alloc 1024 ; Allocate string body
Pop $0 ; Get the allocated string's address

!define GetVolumeInformation "Kernel32::GetVolumeInformation(t,t,i,*i,*i,*i,t,i) i"
System::Call '${GetVolumeInformation}("$9",.r0,1024,,,,.r2,1024)' ;

;Sort drive types and display only fixed and removable
!define GetDriveType "Kernel32::GetDriveType(t) i"
System::Call '${GetDriveType}("$8")' ; 1024

;Push $0 ; Push result
${If} $0 != ""
 StrCpy $VolName "$0"
${Else}
 StrCpy $VolName ""
${EndIf}

StrCpy $2 "$2"
FunctionEnd 

Function DiskSpace
${DriveSpace} "$9" "/D=T /S=G" $1 ; used to find total space of each drive
${If} $1 > "0"
 StrCpy $Capacity "$1GB"
${Else}
 StrCpy $Capacity ""
${EndIf}
FunctionEnd

Function DrivesList
 StrCpy $JustDrive $9
 Call PhysDrive
 Call GetDiskVolumeName
 Call DiskSpace
 Call GetFSType
 
;Prevent System Drive from being selected
 StrCpy $7 $WINDIR 3
 ${If} $9 != "$7" 
 SendMessage $DestDriveTxt ${CB_ADDSTRING} 0 "STR:$9 ($(Disk_LabelS) $DiskNum) $VolName $Capacity $FSType $8"
 ;SendMessage $DestDriveTxt ${CB_ADDSTRING} 0 "STR:$9 $VolName $Capacity $2 $8" 
 ${EndIf}
 Push 1 ; must push something - see GetDrives documentation
FunctionEnd

Function WipeIt ; Set Wipe Disk Option
  ${NSD_GetState} $Wipe $WipeIt
  ${If} $WipeIt == ${BST_CHECKED}
  ${NSD_Check} $Wipe
   StrCpy $WipeMe "Yes"
  ${NSD_SetText} $Wipe "$(DISK_LABEL1)"
  ${ElseIf} $WipeIt == ${BST_UNCHECKED}
  ${NSD_Uncheck} $Wipe
   StrCpy $WipeMe "No"
  ${NSD_SetText} $Wipe "$(DISK_LABEL2)"
  ; ShowWindow $Uninstaller 1 ; Re-enable Uninstaller option.
  ${EndIf}
FunctionEnd

Function FormatYes ; If Format is checked, do something

  File /oname=$PLUGINSDIR\diskpartformat.txt "diskpartformat.txt"
  File /oname=$PLUGINSDIR\diskpartwipe1.txt "diskpartwipe1.txt"
  File /oname=$PLUGINSDIR\diskpartwipe2.txt "diskpartwipe2.txt"

  !insertmacro ReplaceInFile "DISKNUM" "$DiskNum" "all" "all" "$PLUGINSDIR\diskpartwipe1.txt"
  !insertmacro ReplaceInFile "DSK" "$DestDisk" "all" "all" "$PLUGINSDIR\diskpartwipe2.txt"
  !insertmacro ReplaceInFile "DISKNUM" "$DiskNum" "all" "all" "$PLUGINSDIR\diskpartwipe2.txt"
  !insertmacro ReplaceInFile "DSK" "$DestDisk" "all" "all" "$PLUGINSDIR\diskpartformat.txt"

; For NTFS Format ---
  ${If} $FormatMe == "Yes"
   ${AndIf} $WipeMe == "Yes"
; Wipes the Entire Disk and reformats it with one NTFS Partition
    ;ToDO - Need to make a checkpoint here to test if is greater than Win XP (Vista or later OS?). XP doesn't support Diskpart on removable disks.
    nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\diskpartwipe1.txt'
	Sleep 3000
	nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\diskpartwipe2.txt'

   ${ElseIf} $FormatMe == "Yes"
	${AndIf} $WipeMe != "Yes"
; Just format the selected Drive Letter (Volume or Partition) NTFS
    ;ToDO - Need to make a checkpoint here to test if is greater than Win XP (Vista or later OS?). XP doesn't support Diskpart on removable disks.
    nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\diskpartformat.txt'

; For Fat32 Format ---
  ${ElseIf} $FormatMeFat == "Yes"
   ${AndIf} $WipeMe == "Yes"
; Wipes the Entire Disk and reformats it with one Fat32 Partition
   ;ToDO - Need to make a checkpoint here to test if is greater than Win XP (Vista or later OS?). XP doesn't support Diskpart on removable disks.
   nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\diskpartwipe1.txt'
   Sleep 3000
   nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\diskpartwipe2.txt'
   Sleep 3000
   DetailPrint "Formatting $DestDisk as Fat32. This may take a while, please be patient..."
   nsExec::ExecToLog '"cmd" /c "echo y|$PLUGINSDIR\fat32format $DestDisk"' ;/Q /y

  ${ElseIf} $FormatMeFat == "Yes"
   ${AndIf} $WipeMe != "Yes"
; Just Fat32 format the selected Drive Letter (Volume or Partition)
   Call Lock_Only ; Just get a lock on the Volume
   Sleep 3000
   nsExec::ExecToLog '"cmd" /c "echo y|$PLUGINSDIR\fat32format $DestDisk"' ;/Q /y
   Call UnLockVol ; Unlock to allow Access
  ${EndIf}
FunctionEnd

Function FormatIt ; Set Format Option

  ${NSD_GetState} $FormatFat $FormatMeFat
  ${If} $FormatMeFat == ${BST_CHECKED}
  ${NSD_Check} $FormatFat
  ${NSD_SetText} $FormatFat "$(RL_WEWILLFAT)"
   ShowWindow $Format 0
   StrCpy $FormatMeFat "Yes"
  ${ElseIf} $FormatMeFat == ${BST_UNCHECKED}
  ${NSD_Uncheck} $FormatFat
  ${NSD_SetText} $FormatFat "$(RL2_FORMATFAT)"
   ShowWindow $Format 1
   StrCpy $FormatMeFat "No"

  ;${NSD_Uncheck} $Wipe
  ;${NSD_SetText} $Wipe "Wipe Disk $DiskNum"
  ; StrCpy $WipeMe "No"

   ShowWindow $Uninstaller 1 ; Re-enable Uninstaller option.
   StrCpy $Checker "Yes"
   ;Call SetSpace
  ${EndIf}

  ${NSD_GetState} $Format $FormatMe
  ${If} $FormatMe == ${BST_CHECKED}
  ${NSD_Check} $Format
  ${NSD_SetText} $Format "$(RL_WEWILLNTFS)"
   ShowWindow $FormatFat 0
   StrCpy $FormatMe "Yes"
  ${ElseIf} $FormatMe == ${BST_UNCHECKED}
  ${NSD_Uncheck} $Format
  ${NSD_SetText} $Format "$(RL2_FORMAT)"
   ShowWindow $FormatFat 1
   StrCpy $FormatMe "No"

  ;${NSD_Uncheck} $Wipe ; Set Wipe Disk options
  ;${NSD_SetText} $Wipe "Wipe Disk $DiskNum"
  ; StrCpy $WipeMe "No"

    ShowWindow $Uninstaller 1 ; Re-enable Uninstaller option.
	StrCpy $Checker "Yes"
	;Call SetSpace
  ${EndIf}

  ${If} $FormatMe == "Yes"
   ${OrIf} $FormatMeFat == "Yes"
    ShowWindow $Wipe 1
	ShowWindow $Uninstaller 0 ; Disable Uninstaller option because we will be formatting the drive.
    StrCpy $Checker "Yes"
	;Call SetSpace
  ${Else}
   ${NSD_Uncheck} $Wipe
   ${NSD_SetText} $Wipe "$(DISK_LABEL2)"
    StrCpy $WipeMe "No"

	ShowWindow $Wipe 0
  ${EndIf}

    Call SetSpace
    Call InstallorRemove
FunctionEnd

Function ShowAllISOs ; Set Show All ISOs Option
  ${NSD_GetState} $ForceShowAll $ShowingAll
  ${If} $ShowingAll == ${BST_CHECKED}
  ${NSD_Check} $ForceShowAll
  StrCpy $ShowingAll "Yes"
  ${NSD_SetText} $ForceShowAll "$(S_SHOW_ALLISOS)"
    SendMessage $ISOSelection ${CB_RESETCONTENT} 0 0 
 
  ${ElseIf} $ShowingAll == ${BST_UNCHECKED}
  ${NSD_Uncheck} $ForceShowAll
  ${NSD_SetText} $ForceShowAll "$(SHOW_ALL_ISOS)"
    SendMessage $ISOSelection ${CB_RESETCONTENT} 0 0 
  ${EndIf}  
FunctionEnd

Function CheckSpace ; Check total available space so we can set block size
  Call TotalSpace
  ${If} $1 <= 511
  StrCpy $BlockSize 1
  ${ElseIf} $1 >= 512
  ${AndIf} $1 <= 8191
  StrCpy $BlockSize 4
  ${ElseIf} $1 >= 8192 
  ${AndIf} $1 <= 16383
  StrCpy $BlockSize 8
  ${ElseIf} $1 >= 16384
  ${AndIf} $1 <= 32767
  StrCpy $BlockSize 16
  ${ElseIf} $1 > 32768
  StrCpy $BlockSize 32
  ${EndIf}
 ; MessageBox MB_ICONSTOP|MB_OK "$0 Drive is $1 MB in size, blocksize = $BlockSize KB."  
FunctionEnd

Function TotalSpace
${DriveSpace} "$JustDrive" "/D=T /S=M" $1 ; used to find total space of select disk
 StrCpy $Capacity "$1"
FunctionEnd

Function FreeDiskSpace
${If} $FormatMe == "Yes"
${OrIf} $FormatMeFat == "Yes"
${DriveSpace} "$JustDrive" "/D=T /S=M" $1
${Else}
${DriveSpace} "$JustDrive" "/D=F /S=M" $1
${EndIf}
FunctionEnd

Function SetSpace ; Set space available for persistence
 ${If} $FSType != "NTFS"
 ${OrIf} $FormatMeFat == "Yes"
 ${AndIf} $FormatMe != "Yes"
 
  ;MessageBox MB_ICONSTOP|MB_OK "$Casper - $FormatMeFat"
  Call FreeDiskSpace
  IntOp $MaxPersist 4090 + $CasperSize ; Space required for distro and 4GB max persistent file
  ${If} $1 > $MaxPersist ; Check if more space is available than we need for distro + 4GB persistent file
  StrCpy $RemainingSpace 4090 ; Set maximum possible value to 4090 MB (any larger wont work on fat32 Filesystem)
  ${Else}
  StrCpy $RemainingSpace "$1"
  IntOp $RemainingSpace $RemainingSpace - $SizeOfCasper ; Remaining space minus distro size
  ${EndIf}
  IntOp $RemainingSpace $RemainingSpace - 1 ; Subtract 1MB so that we don't error for not having enough space
  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Re-Setting Max Value
  
 ${Else}  
  Call FreeDiskSpace
  StrCpy $RemainingSpace "$1"
  IntOp $RemainingSpace $RemainingSpace - $SizeOfCasper ; Remaining space minus distro size
  IntOp $RemainingSpace $RemainingSpace - 1 ; Subtract 1MB so that we don't error for not having enough space
  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Re-Setting Max Value 
 ${EndIf} 
FunctionEnd

Function HaveSpacePre ; Check space required
 ${If} $FormatMe != "Yes" ; FIXME: Need to find a better method to check disk space when the drive appears unformatted (I.E. after it's been dd'd, etc).
 ${AndIf} $FormatMeFat != "Yes"
  Call CasperSize
  Call FreeDiskSpace
  System::Int64Op $1 > $SizeOfCasper ; Compare the space available > space required
  Pop $3 ; Get the result ...
  IntCmp $3 1 okay ; ... and compare it
  MessageBox MB_ICONSTOP|MB_OK "Oops: There is not enough disk space! $1 MB Free, $SizeOfCasper MB Needed on $JustDrive Drive. Do you need to format it?"
  okay: ; Proceed to execute...
 ${EndIf}
FunctionEnd

Function HaveSpace ; Check space required
  Call CasperSize
  Call FreeDiskSpace
  System::Int64Op $1 > $SizeOfCasper ; Compare the space available > space required
  Pop $3 ; Get the result ...
  IntCmp $3 1 okay ; ... and compare it
  MessageBox MB_ICONSTOP|MB_OK "Not enough free space remains. Closing AUMBI!"
  quit ; Close the program if the disk space was too small...
  okay: ; Proceed to execute...
  ;MessageBox MB_OK "ISO + Persistence will use $SizeOfCasper MB of the $1 MB Free disk space on $JustDrive Drive."  
  ;quit ; enable for testing message above
FunctionEnd

!macro DeleteMenuEntry file start stop
Push "${FILE}" ; File to search in
Push "${START}$\r$\n" ; text to start deleting from 
Push "${STOP}$\r$\n" ; text to stop at
Call DeleteMenuEntry
!macroend
!define DeleteMenuEntry "!insertmacro DeleteMenuEntry"

; DeleteMenuEntry function is based on RemoveAfterLine function, by Afrow UK http://nsis.sourceforge.net/Delete_lines_from_one_line_to_another_line_inclusive.
Function DeleteMenuEntry
 Exch $1 ;end string
 Exch
 Exch $2 ;begin string
 Exch 2
 Exch $3 ;file
 Exch 2
 Push $R0
 Push $R1
 Push $R2
 Push $R3
  GetTempFileName $R2
  FileOpen $R1 $R2 w
  FileOpen $R0 $3 r
  ClearErrors
  FileRead $R0 $R3
  IfErrors Done
  StrCmp $R3 $2 +3
  FileWrite $R1 $R3
  Goto -5
  ClearErrors
  FileRead $R0 $R3
  IfErrors Done
  StrCmp $R3 $1 +4 -3
  FileRead $R0 $R3
  IfErrors Done
  FileWrite $R1 $R3
  ClearErrors
  Goto -4
Done:
   FileClose $R0
   FileClose $R1
   SetDetailsPrint none
   Delete $3
   Rename $R2 $3
   SetDetailsPrint both
 Pop $R3
 Pop $R2
 Pop $R1
 Pop $R0
 Pop $3
 Pop $2
 Pop $1
FunctionEnd

; Custom Distros Installer - Uninstaller Include
!include "InstallDistro.nsh" ; ##################################### ADD NEW DISTRO ########################################
!include "RemoveDistro.nsh" ; ##################################### REM DISTRO ########################################

#include DoSyslinux Function
         !include "misc\scripts\FuncDoSyslinux.nsh"

Function AddDir ; changes to check if user had a version prior to 0.0.0.3. Newer AUMBI includes grub.exe
 ${IfNotThen} ${FileExists} "$BootDir\${MB_DIR}\grub.exe" 'CopyFiles /SILENT "$PLUGINSDIR\grub.exe" "$BootDir\${MB_DIR}\grub.exe"' 
; Windows/Ubuntu SOURCES conflict fix
 ;${IfNot} ${FileExists} $BootDir\.disk\info 
  ; CreateDirectory $BootDir\.disk 
  ; CopyFiles /SILENT "$PLUGINSDIR\info" "$BootDir\.disk\info"
 ;${EndIf} 
FunctionEnd

#Include the AUMBI sections
         !include "misc\scripts\ProgramSections.nsh"
#Include ConfigRemoveand Config2Write functions
         !include "misc\scripts\ConfigRemoveWrite.nsh"

Function NoQuit
MessageBox MB_YESNO "$(ADD_MORE_DISTRO_MB_TEXT)" IDYES noskip
    StrCmp $R8 3 0 End ;Compare $R8 variable with current page #
    StrCpy $R9 1 ; Goes to finish page
    Call RelGotoPage
    Abort
noskip:
;StrCpy $ShowAll "$ShowAll" ; Retain Display All Drives
StrCpy $DestDrive "$DestDrive" ; Retain previously selected Drive Letter
StrCpy $RepeatInstall "YES" ; Set Repeat Install Option to YES
StrCpy $ISOTest "" ; Reset
StrCpy $ISOFile "" ; Reset
StrCpy $Removal "" ; Reset
StrCpy $Persistence "NULL" ; Reset
StrCpy $NameThatISO "" ; Reset NameThatISO ISO Name
StrCpy $ConfigFile "" ; Clear ConfigFile 
StrCpy $Config2Use "" ; Clear Config File to create and write to
StrCpy $DistroName "" ; Clear Distro Name
StrCpy $ISOFileName "" ; Clear ISO Selection
StrCpy $FileFormat "" ; Clear File Format
StrCpy $DownloadMe 0 ; Ensure Uncheck of Download Option
StrCpy $LocalSelection "" ; Reset Local Selection
StrCpy $ShowingAll ""
StrCpy $FormatMe "" ; Reset Format Option
StrCpy $FormatMeFat "" ; Reset FormatMeFat Option
StrCpy $WipeMe "" ; Reset WipeMe Option
;StrCpy $DisMounted ""
    StrCmp $R8 4 0 End ;Compare $R8 variable with current page #
    StrCpy $R9 -3 ; Goes back to selections page
    Call RelGotoPage ; change pages
    Abort
End:
FunctionEnd

Function RelGotoPage
  IntCmp $R9 0 0 Move Move
    StrCmp $R9 "X" 0 Move
      StrCpy $R9 "120"
Move:
  SendMessage $HWNDPARENT "0x408" "$R9" ""
FunctionEnd

!include misc\scripts\FuncOnInit.nsh

Function onNotify_CasperSlider
 Pop $Casper
 SendMessage $CasperSlider ${TBM_GETPOS} 0 0 $Casper ; Get Trackbar position
 ${NSD_SetText} $SlideSpot "$Casper MB"
FunctionEnd

Function SetISOSize ; Get size of ISO
 System::Call 'kernel32::CreateFile(t "$TheISO", i 0x80000000, i 1, i 0, i 3, i 0, i 0) i .r0'
 System::Call "kernel32::GetFileSizeEx(i r0, *l .r1) i .r2"
 System::Alloc $1
 System::Int64Op $1 / 1048576 ; convert to MB
 Pop $1
 StrCpy $SizeOfCasper "$1"
 ;MessageBox MB_OK|MB_ICONINFORMATION "ISO Size: $SizeOfCasper"
 System::Call 'kernel32::CloseHandle(i r0)'
FunctionEnd

Function GetFSType
System::Call 'Kernel32::GetVolumeInformation(t "$9",t,i ${NSIS_MAX_STRLEN},*i,*i,*i,t .r1" ,i ${NSIS_MAX_STRLEN}) i.r0'
 StrCpy $FSType "$1"
FunctionEnd