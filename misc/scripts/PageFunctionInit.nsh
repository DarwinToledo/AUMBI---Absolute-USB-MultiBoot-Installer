Function AUMBIInit

    Call GetDPI
    Call LoadBg
    Call SetBGImage

  ;Aero::Apply
    FindWindow $R0 "#32770" "" $HWNDPARENT
    GetDlgItem $R0 $HWNDPARENT 9116
          SendMessage $R0 ${WM_SETTEXT} 0 "STR:"
          SetCtlColors $R0 0xc9c9c9 transparent

          CreateFont $1 "Segoe UI" "16" "1000"
          SendMessage $R0 ${WM_SETFONT} $1 1

          GetDlgItem $R8 $HWNDPARENT 1256
          ShowWindow $R8 ${SW_HIDE}

          GetDlgItem $R7 $HWNDPARENT 1028
          ShowWindow $R7 ${SW_HIDE}
          GetDlgItem $R6 $HWNDPARENT 1035
          ShowWindow $R6 ${SW_HIDE}

FunctionEnd

Function LoadBG

         ${If} $DPI == "100p"
               File /oname=$PLUGINSDIR\AUMBI_BKG.bmp "Resources\images\AUMBI_BKG.bmp"
               File /oname=$PLUGINSDIR\AUMBI_ND_BKG.bmp "Resources\images\AUMBI_ND_BKG.bmp"
         ${ElseIf} $DPI == "125p"
               File /oname=$PLUGINSDIR\AUMBI_BKG.bmp "Resources\images\AUMBI_BKG_125.bmp"
               File /oname=$PLUGINSDIR\AUMBI_ND_BKG.bmp "Resources\images\AUMBI_ND_BKG_125.bmp"
         ${ElseIf} $DPI == "150p"
               File /oname=$PLUGINSDIR\AUMBI_BKG.bmp "Resources\images\AUMBI_BKG_125.bmp"
               File /oname=$PLUGINSDIR\AUMBI_ND_BKG.bmp "Resources\images\AUMBI_ND_BKG_125.bmp"
         ${ElseIf} $DPI == "175p"
               File /oname=$PLUGINSDIR\AUMBI_BKG.bmp "Resources\images\AUMBI_BKG_125.bmp"
               File /oname=$PLUGINSDIR\AUMBI_ND_BKG.bmp "Resources\images\AUMBI_ND_BKG_125.bmp"
         ${ElseIf} $DPI == "200p"
               File /oname=$PLUGINSDIR\AUMBI_BKG.bmp "Resources\images\AUMBI_BKG_125.bmp"
               File /oname=$PLUGINSDIR\AUMBI_ND_BKG.bmp "Resources\images\AUMBI_ND_BKG_125.bmp"
         ${Else}
               File /oname=$PLUGINSDIR\AUMBI_BKG.bmp "Resources\images\AUMBI_BKG_125.bmp"
               File /oname=$PLUGINSDIR\AUMBI_ND_BKG.bmp "Resources\images\AUMBI_ND_BKG_125.bmp"
         ${EndIf}

         ;Messagebox MB_OK "SIZE $DPIsize . DPI $DPI  . $R9"

FunctionEnd


Function SetBGImage
/*
         !ifdef NOIMGSCALE
                    SetBrandingImage /IMGID=1046 "$PLUGINSDIR\AUMBI_BKG.bmp"
         !else
                    SetBrandingImage /IMGID=1046 /RESIZETOFIT "$PLUGINSDIR\AUMBI_BKG.bmp"
         !endif
*/

         ${If} $DPI == "100p"
                    SetBrandingImage /IMGID=1046 "$PLUGINSDIR\AUMBI_BKG.bmp"
         ${Else}
                    SetBrandingImage /IMGID=1046 /RESIZETOFIT "$PLUGINSDIR\AUMBI_BKG.bmp"
         ${EndIf}


FunctionEnd