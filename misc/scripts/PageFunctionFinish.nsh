Function Finish_PreFunction
  StrCpy $R8 4
  Call NoQuit
FunctionEnd

         Var AUMBI_FINISH
         Var AUMBI_FINISH_Link1
         Var AUMBI_FINISH_Label2

         Function InstFinish_ShowFunction

                  GetDlgItem $R0 $HWNDPARENT 9116
                  SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(FINISH_AUMBI_TEXT)"
                  SetCtlColors $R0 0xc9c9c9 transparent

                  CreateFont $1 "Segoe UI" "16" "1000"
                  SendMessage $R0 ${WM_SETFONT} $1 1

         FunctionEnd


         Function fnc_AUMBI_FINISH_Create

                  nsDialogs::Create 1044
                  Pop $AUMBI_FINISH
                  ${If} $AUMBI_FINISH == error
                        Abort
                  ${EndIf}
                  SetCtlColors $AUMBI_FINISH 0x000000 transparent

                  ${NSD_CreateLink} 17.11u 172.31u 200.1u 12.31u "$(Finish_Link)"
                  Pop $AUMBI_FINISH_Link1
                  SetCtlColors $AUMBI_FINISH_Link1 0x000000 transparent
                  ${NSD_OnClick} $AUMBI_FINISH_Link1 onClickMyLink

                  ${NSD_CreateLabel} 26.99u 54.77u 273.82u 47.38u "$(Finish_Text)"
                  Pop $AUMBI_FINISH_Label2
                  SetCtlColors $AUMBI_FINISH_Label2 0x000000 transparent

         FunctionEnd


         Function fnc_AUMBI_FINISH_Show
                  Call Finish_PreFunction
                  Call PageRefreshPre
                  Call fnc_AUMBI_FINISH_Create
                  Call InstFinish_ShowFunction
                  nsDialogs::Show
         FunctionEnd

  Function .onInstSuccess
           ExecShell "open" "${PRODUCT_WEBSITE}"
  FunctionEnd
