        Function InstFiles_PreFunction
                 StrCpy $R8 3
        FunctionEnd

         Function InstFiles_ShowFunction
                  Call PageRefreshPre
                  GetDlgItem $R0 $HWNDPARENT 9116
                  SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(INSTALL_AUMBI_TOP_TEXT)"
                  SetCtlColors $R0 0xc9c9c9 transparent

                  CreateFont $1 "Segoe UI" "16" "1000"
                  SendMessage $R0 ${WM_SETFONT} $1 1

                  SetCtlColors $mui.InstFilesPage      0xFFFFFF transparent
                  ;SetCtlColors $mui.InstFilesPage.Text 0x000000 transparent

                  Call PageRefreshShow
         FunctionEnd

