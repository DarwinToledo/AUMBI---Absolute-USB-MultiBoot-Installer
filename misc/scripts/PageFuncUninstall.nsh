
; On Selection of Uninstaller Option
Function Uninstall
  ${NSD_GetState} $Uninstaller $Removal
  ${If} $Removal == ${BST_CHECKED}
  ShowWindow $Format 0
  ShowWindow $FormatFat 0
  ShowWindow $Wipe 0
    ShowWindow $LabelISOSelection 0
	Call ClearAll
    EnableWindow $ISOFileTxt 0
	ShowWindow $ISOFileTxt 0
	ShowWindow $ISOSelection 0
    ShowWindow $ForceShowAll 0
    ShowWindow $CasperSelection 0
    ShowWindow $CasperSlider 0
    ShowWindow $SlideSpot 0
	StrCpy $Persistence "NULL"

  ${NSD_Check} $Uninstaller
  StrCpy $Removal "Yes"
  ShowWindow $DistroLink 0
  ShowWindow $DownloadISO 0
   GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
	SendMessage $6 ${WM_SETTEXT} 0 "STR:Remove"
	EnableWindow $6 0 ; Disable "Install" control button
  ${NSD_SetText} $Uninstaller "$(YOURE_UNISTALLERMODE)"
    SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; was ${NSD_LB_Clear} $Distro "" ; Clear all distro entries because a new option may have been chosen ; Enable for DropBox
     StrCpy $Checker "Yes"
	 Call RemovalList

  ${ElseIf} $Removal == ${BST_UNCHECKED}
   ShowWindow $Format 1
   ShowWindow $FormatFat 1
    ShowWindow $LabelISOSelection 1
    ShowWindow $ISOFileTxt 1
	ShowWindow $ISOSelection 0
	ShowWindow $Wipe 1
	Call ClearAll
    ${NSD_SetText} $LabelISOSelection "$(STEP3_SELECTISOFILEVAR)"
	${NSD_SetText} $ISOFileTxt "$(DISABLE_AFTER_STEP2)"
     GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
	  SendMessage $6 ${WM_SETTEXT} 0 "STR:Create"
	  EnableWindow $6 0 ; Disable "Install" control button
  ${NSD_Uncheck} $Uninstaller
  StrCpy $Removal "No"
  ${NSD_SetText} $Uninstaller "$(VIEWREM_DISTROS)"
   ${NSD_SetText} $LinuxDistroSelection "$(STEP2_SELECTADISTRO)"
     SendMessage $Distro ${CB_RESETCONTENT} 0 0  ; was ${NSD_LB_Clear} $Distro "" ; Clear all distro entries because a new option may have been chosen ; Enable for DropBox
     StrCpy $Checker "Yes"
     Call SetISOFileName
  ${EndIf}
FunctionEnd