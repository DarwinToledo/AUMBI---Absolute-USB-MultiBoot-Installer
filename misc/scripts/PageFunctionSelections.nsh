#===========================================================
# SELECTIONS PAGE FUNCTION
#===========================================================

Function SelectionsPage
  StrCpy $R8 2
 !insertmacro MUI_HEADER_TEXT $(SelectDist_Title) $(SelectDist_Subtitle)
  nsDialogs::Create 1018
  Pop $Dialog

 ${If} $RepeatInstall == "YES"
 ${NSD_SetText} $DestDriveTxt "$DestDrive"

; To Install or Uninstall? That is the question!
  ${NSD_CreateCheckBox} 60% 0 44% 15 "$(VIEWREM_DISTROS)"
  Pop $Uninstaller
  ${NSD_OnClick} $Uninstaller Uninstall

; Alt Wipe Disk and all Partitions, Volumes.
  ${NSD_CreateCheckBox} 60% 0 44% 15 "$(DISK_LABEL2)"
  Pop $Wipe
  ${NSD_OnClick} $Wipe WipeIt

; Distro Selection Starts
  ${NSD_CreateLabel} 0 50 50% 15 $(Distro_Text)
  Pop $LinuxDistroSelection

  ${NSD_CreateDroplist} 0 70 58% 95 "" ; was  ${NSD_CreateListBox} ; Enable For DropBox
  Pop $Distro
  ${NSD_OnChange} $Distro OnSelectDistro
  ${NSD_CB_SelectString} $Distro $DistroName ; Was ${NSD_LB_SelectString} $Distro $DistroName  ; Enable For DropBox

; Force Show All ISO Option
  ${NSD_CreateCheckBox} 80% 100 20% 9u "$(SHOW_ALL_ISOS)"
  Pop $ForceShowAll
  ${NSD_OnClick} $ForceShowAll ShowAllISOs

; ISO Download Option
  ${NSD_CreateCheckBox} 60% 60 40% 15 "$(DOWNLOAD_ISOOP)"
  Pop $DownloadISO
  ${NSD_OnClick} $DownloadISO DownloadIt

; Clickable Link to Distribution Homepage
  ${NSD_CreateLink} 60% 80 40% 15 "$(RL_VISIT_HOME)"
  Pop $DistroLink
  ${NSD_OnClick} $DistroLink onClickLinuxSite

; ISO Selection Starts
  ${NSD_CreateLabel} 0 100 100% 15 $(IsoPage_Text)
  Pop $LabelISOSelection
  ${NSD_CreateText} 0 120 78% 20 "$(BROW_AND_SELFORM)"
  Pop $ISOFileTxt
  ${NSD_CreateBrowseButton} 85% 120 60 20 "$(RL_BROWSE)"
  Pop $ISOSelection
  ${NSD_OnClick} $ISOSelection ISOBrowse

; Casper-RW Selection Starts
  ${NSD_CreateLabel} 0 150 75% 15 ""
  Pop $CasperSelection

; CasperSlider - TrackBar
  !undef TBM_SETPOS
  !undef TBM_GETPOS
  !undef TBM_SETRANGEMIN
  !undef TBM_SETRANGEMAX

  !define TBM_SETPOS 0x0405
  !define TBM_GETPOS 0x0400
  !define TBM_SETRANGEMIN 0x0407
  !define TBM_SETRANGEMAX 0x0408

  ${NSD_CreateLabel} 52% 178 25% 25 ""
  Pop $SlideSpot

  nsDialogs::CreateControl "msctls_trackbar32" "0x50010000|0x00000018" "" 0 174 50% 25 ""
  Pop $CasperSlider
  SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 0 ; Min Range Value 0
  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Max Range Value $RemainingSpace
  ${NSD_OnNotify} $CasperSlider onNotify_CasperSlider

; Drive Pre-Selection
  ${NSD_CreateLabel} 0 0 58% 15 ""
  Pop $LabelDrivePage
  ${NSD_SetText} $LabelDrivePage "$(RL1_STEP1)"
; Droplist for Drive Selection
  ${NSD_CreateDropList} 0 20 35% 15 "" ; was 0 20 28% 15
  Pop $DestDriveTxt

   ${If} $ShowAll == "YES"
   ${GetDrives} "FDD+HDD" DrivesList ; All Drives Listed
   ${ElseIf} $ShowAll == "NO"
   ${GetDrives} "FDD" DrivesList ; FDD+HDD reduced to FDD for removable media only
   ${EndIf}

  ${NSD_CB_SelectString} $DestDriveTxt "$DestDrive"
  StrCpy $JustDrive $DestDrive 3
  StrCpy $BootDir $DestDrive 2 ;was -1
  StrCpy $DestDisk $DestDrive 2 ;was -1
  SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; was ${NSD_LB_Clear} $Distro "" ; Clear all distro entries because a new drive may have been chosen ; Enable for DropBox
  StrCpy $Checker "Yes"
  Call InstallorRemove
  Call CheckSpace
  Call FormatIt
  Call EnableNext
  ${NSD_OnChange} $DestDriveTxt OnSelectDrive

; All Drives Option
  ${NSD_CreateCheckBox} 36% 23 23% 15 "$(SHOW_ALL_DRIVES)" ; was 30% 23 30% 15
  Pop $AllDriveOption
  ${NSD_OnClick} $AllDriveOption ListAllDrives

; Format Drive Option
  ${NSD_CreateCheckBox} 60% 23 100% 15 "$(RL2_FORMAT)"
  Pop $Format
  ${NSD_OnClick} $Format FormatIt

; Format Fat32 Option
  ${NSD_CreateCheckBox} 60% 40 100% 15 "$(RL2_FORMAT)"
  Pop $FormatFat
  ${NSD_OnClick} $FormatFat FormatIt

; Add Home Link
  ${NSD_CreateLink} 0 215 16% 15 "Home Page"
  Pop $Link
  ${NSD_OnClick} $LINK onClickMyLink

; Add Help Link
  ${NSD_CreateLink} 16% 215 9% 15 "FAQ"
  Pop $Link1
  ${NSD_OnClick} $LINK1 onClickMyLinkFAQ

; Add Giveback Link
  ${NSD_CreateLink} 25% 215 30% 15 "Recommended Flash Drives"
  Pop $Link2
  ${NSD_OnClick} $LINK2 onClickMyLinkUSB

  Call BKG_BITMAP ;Background transparency for custom page ;niwrad

; Disable Next Button until a selection is made for all
  GetDlgItem $6 $HWNDPARENT 1
  EnableWindow $6 0
; Remove Back Button
  GetDlgItem $6 $HWNDPARENT 3
  ShowWindow $6 0
; Hide or disable steps until we state to display them
  EnableWindow $LabelISOSelection 0
  EnableWindow $ISOFileTxt 0
  ShowWindow $ISOSelection 0
  EnableWindow $DownloadISO 0
  ShowWindow $DistroLink 0
  StrCpy $JustISOName "NULL" ; Set to NULL until something is selected
  ;nsDialogs::Show ;disabled by niwrad

 ${Else}

; To Install or Uninstall? That is the question!
  ${NSD_CreateCheckBox} 60% 0 44% 15 "$(VIEWREM_DISTROS)"
  Pop $Uninstaller
  ${NSD_OnClick} $Uninstaller Uninstall

; Alt Wipe Disk and all Partitions, Volumes.
  ${NSD_CreateCheckBox} 60% 0 44% 15 "$(DISK_LABEL2)"
  Pop $Wipe
  ${NSD_OnClick} $Wipe WipeIt

; Drive Selection Starts
  ${NSD_CreateLabel} 0 0 58% 15 ""
  Pop $LabelDrivePage
  ${NSD_SetText} $LabelDrivePage "$(RL2_STEP1)"

; Droplist for Drive Selection
  ${NSD_CreateDropList} 0 20 35% 15 "" ; was 0 20 28% 15
  Pop $DestDriveTxt
  Call ListAllDrives
  ${NSD_OnChange} $DestDriveTxt OnSelectDrive

; All Drives Option
 ${NSD_CreateCheckBox} 36% 23 23% 15 "$(SHOW_ALL_DRIVES)" ; was 30% 23 30% 15
 Pop $AllDriveOption
 ${NSD_OnClick} $AllDriveOption ListAllDrives

; Format Drive Option
  ${NSD_CreateCheckBox} 60% 23 100% 15 "$(RL2_FORMATW)"
  Pop $Format
  ${NSD_OnClick} $Format FormatIt

; Format Fat32 Option
  ${NSD_CreateCheckBox} 60% 40 100% 15 "$(RL2_FORMATFATW)"
  Pop $FormatFat
  ${NSD_OnClick} $FormatFat FormatIt

; Distro Selection Starts
  ${NSD_CreateLabel} 0 50 50% 15 $(Distro_Text)
  Pop $LinuxDistroSelection

  ${NSD_CreateDropList} 0 70 58% 95 "" ; was ${NSD_CreateListBox} ; Enable for Dropbox
  Pop $Distro
  ${NSD_OnChange} $Distro OnSelectDistro
  ${NSD_CB_SelectString} $Distro $DistroName ; Was ${NSD_LB_SelectString} $Distro $DistroName  ; Enable For DropBox

; Force Show All ISO Option
  ${NSD_CreateCheckBox} 80% 100 20% 9u "$(SHOW_ALL_ISOS)"
  Pop $ForceShowAll
  ${NSD_OnClick} $ForceShowAll ShowAllISOs

; ISO Download Option
  ${NSD_CreateCheckBox} 60% 60 40% 15 "$(DOWNLOAD_ISOOP)"
  Pop $DownloadISO
  ${NSD_OnClick} $DownloadISO DownloadIt

; Clickable Link to Distribution Homepage
  ${NSD_CreateLink} 60% 80 40% 15 "$(RL_VISIT_HOME)"
  Pop $DistroLink
  ${NSD_OnClick} $DistroLink onClickLinuxSite

; ISO Selection Starts
  ${NSD_CreateLabel} 0 100 100% 15 $(IsoPage_Text)
  Pop $LabelISOSelection
  ${NSD_CreateText} 0 120 78% 20 "$(BROW_AND_SELFORM)"
  Pop $ISOFileTxt
  ${NSD_CreateBrowseButton} 85% 120 60 20 "$(RL_BROWSE)"
  Pop $ISOSelection
  ${NSD_OnClick} $ISOSelection ISOBrowse

; Casper-RW Selection Starts
  ${NSD_CreateLabel} 0 150 75% 15 "" ;$(Casper_Text)
  Pop $CasperSelection

; CasperSlider - TrackBar
  ; !define TBM_SETPOS 0x0405
  ; !define TBM_GETPOS 0x0400
  ; !define TBM_SETRANGEMIN 0x0407
  ; !define TBM_SETRANGEMAX 0x0408

  ${NSD_CreateLabel} 52% 178 25% 25 ""
  Pop $SlideSpot

  nsDialogs::CreateControl "msctls_trackbar32" "0x50010000|0x00000018" "" 0 174 50% 25 ""
  Pop $CasperSlider

  SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 0 ; Min Range Value 0
  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Max Range Value $RemainingSpace
  ${NSD_OnNotify} $CasperSlider onNotify_CasperSlider

; Add Home Link
  ${NSD_CreateLink} 0 215 16% 15 "Home Page"
  Pop $Link
  ${NSD_OnClick} $LINK onClickMyLink

; Add Help Link
  ${NSD_CreateLink} 16% 215 9% 15 "FAQ"
  Pop $Link1
  ${NSD_OnClick} $LINK1 onClickMyLinkFAQ

; Add Giveback Link
  ${NSD_CreateLink} 25% 215 30% 15 "Recommended Flash Drives"
  Pop $Link2
  ${NSD_OnClick} $LINK2 onClickMyLinkUSB

  Call BKG_BITMAP ;Background transparency for custom page ;niwrad

;; Add a custom donate button
;   ${NSD_CreateBitmap} 80% 125 20% 50 "PayPal Donation"
;   Var /Global Donate
;   Var /Global DonateHandle
;   Pop $Donate
;   ${NSD_SetImage} $Donate $PLUGINSDIR\paypal.bmp $DonateHandle
;  GetFunctionAddress $DonateHandle OnClickDonate
;  nsDialogs::OnClick $Donate $DonateHandle

; Disable Next Button until a selection is made for all
  GetDlgItem $6 $HWNDPARENT 1
  EnableWindow $6 0
; Remove Back Button
  GetDlgItem $6 $HWNDPARENT 3
  ShowWindow $6 0
; Hide or disable steps until we state to display them
  EnableWindow $LabelISOSelection 0
  EnableWindow $ISOFileTxt 0
  ShowWindow $ISOSelection 0
  EnableWindow $LinuxDistroSelection 0
  EnableWindow $Distro 0
  EnableWindow $DownloadISO 0
  ShowWindow $DistroLink 0
  ShowWindow $CasperSelection 0
  ShowWindow $CasperSlider 0
  ShowWindow $SlideSpot 0
  ShowWindow $Format 0
  ShowWindow $FormatFat 0
  ShowWindow $ForceShowAll 0
  ShowWindow $Uninstaller 0
  ShowWindow $Wipe 0
  ;nsDialogs::Show ;disabled by niwrad
;  ${NSD_FreeImage} $DonateHandle
 ${EndIf}
FunctionEnd

         Function SelectionsPage_Color_Title

                  Call PageRefreshPre
                  GetDlgItem $R0 $HWNDPARENT 9116
                  SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(SELECTION_AUMBI_TOP_TEXT)"
                  SetCtlColors $R0 0xc9c9c9 transparent

                  CreateFont $1 "Segoe UI" "16" "1000"
                  SendMessage $R0 ${WM_SETFONT} $1 1

                  SetCtlColors $mui.LicensePage 0xFFFFFF transparent
                  SetCtlColors $mui.LicensePage.TopText 0x000000 transparent
                  SetCtlColors $mui.LicensePage.Text 0x000000 transparent
                  SetCtlColors $HWNDPARENT 0xFFFFFF transparent
                  Call PageRefreshShow
         FunctionEnd


         Function PageRefreshShow
                    GetDlgItem $0 $HWNDPARENT 1
                    ShowWindow $0 ${SW_HIDE}
                    GetDlgItem $0 $HWNDPARENT 2
                    ShowWindow $0 ${SW_HIDE}
                    GetDlgItem $0 $HWNDPARENT 1
                    ShowWindow $0 ${SW_SHOW}
                    GetDlgItem $0 $HWNDPARENT 2
                    ShowWindow $0 ${SW_SHOW}
                    #TITLEPAGE SHOW / RELOAD
                    GetDlgItem $R0 $HWNDPARENT 9116
                    ShowWindow $R0 ${SW_SHOW}

         FunctionEnd


         Var AUMBI_CST_Bitmap1
         Var AUMBI_CST_Bitmap1_hImage
         Function BKG_BITMAP
                  ${NSD_CreateBitmap} 0u 0u 297.52u 141.54u ""
                  Pop $AUMBI_CST_Bitmap1

         ${If} $DPI == "100p"
                  ${NSD_SetImage} $AUMBI_CST_Bitmap1 "$PLUGINSDIR\AUMBI_ND_BKG.bmp" $AUMBI_CST_Bitmap1_hImage
         ${ElseIf} $DPI == "125p"
                  ${NSD_SetImage} $AUMBI_CST_Bitmap1 "$PLUGINSDIR\AUMBI_ND_BKG.bmp" $AUMBI_CST_Bitmap1_hImage
         ${Else}
                  ${NSD_SetStretchedImage} $AUMBI_CST_Bitmap1 "$PLUGINSDIR\AUMBI_ND_BKG.bmp" $AUMBI_CST_Bitmap1_hImage
         ${EndIf}
         
         FunctionEnd


        Function SelectionsPage_Show
                  Call SelectionsPage
                  Call SelectionsPage_Color_Title
                  nsDialogs::Show
        FunctionEnd