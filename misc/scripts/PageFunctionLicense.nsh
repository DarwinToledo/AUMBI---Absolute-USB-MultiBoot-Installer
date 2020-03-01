#===========================================================
# LICENSE PAGE FUNCTION
#===========================================================

         Function License_PreFunction
             StrCpy $R8 1 ;This is the 1st page
         FunctionEnd

         Function License_ShowFunction
                  Call PageRefreshPre

                  GetDlgItem $R0 $HWNDPARENT 9116
                  SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(LICENSE_AUMBI_TOP_TEXT)"
                  SetCtlColors $R0 0xc9c9c9 transparent

                  CreateFont $1 "Segoe UI" "16" "1000"
                  SendMessage $R0 ${WM_SETFONT} $1 1

                  SetCtlColors $mui.LicensePage 0xFFFFFF transparent
                  SetCtlColors $mui.LicensePage.TopText 0x000000 transparent
                  SetCtlColors $mui.LicensePage.Text 0x000000 transparent

                  Call PageRefreshShow

         FunctionEnd

         Function PageRefreshPre
/*
         !ifdef NOIMGSCALE
                    SetBrandingImage /IMGID=1046 "$PLUGINSDIR\AUMBI_BKG.bmp"
         !else
                    SetBrandingImage /IMGID=1046 /RESIZETOFIT "$PLUGINSDIR\AUMBI_BKG.bmp"
         !endif
*/
                  GetDlgItem $R0 $HWNDPARENT 9116
                  ShowWindow $R0 ${SW_HIDE}
         FunctionEnd
         