Var DPIsize
Var DPI

!macro GETDPI UN

          Function ${UN}GetDPI
                  ;System::Call USER32::SetDpiForSystem()i.r0
                  System::Call USER32::GetDpiForSystem()i.r0
                  ${If} $0 U<= 0
                        System::Call USER32::GetDC(i0)i.r1
                        System::Call GDI32::GetDeviceCaps(ir1,i88)i.r0
                        System::Call USER32::ReleaseDC(i0,ir1)
                        ${EndIf}

                        StrCpy $R9 $0

                        ${Unless} $0 == 120
                        ${AndUnless} $0 == 144
                        ${AndUnless} $0 == 168
                        ${AndUnless} $0 == 192
                        StrCpy $0 96
                        ${EndIf}

                        Strcpy $DPIsize $0
                  ${If} $DPIsize == 96
                        Strcpy $DPI "100p"
                  ${ElseIf} $DPIsize == 120
                        Strcpy $DPI "125p"
                  ${ElseIf} $DPIsize == 144
                        Strcpy $DPI "150p"
                  ${ElseIf} $DPIsize == 168
                        Strcpy $DPI "175p"
                  ${ElseIf} $DPIsize == 192
                        Strcpy $DPI "200p"
                  ${EndIf}
          FunctionEnd
!macroend
!define GETDPI "!insertmacro GETDPI "
