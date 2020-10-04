/*
 * This file is part of AUMBI
 *
 * AUMBI is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * any later version.
 *
 * AUMBI is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with AUMBI.  If not, see <http://www.gnu.org/licenses/>.
 */

; -------- Configuration and Text File Manipulation Stuff! --------

Function FindFiles ; <- FindFiles function written by KiCHik http://nsis.sourceforge.net/Search_For_a_File
  Exch $R5 # callback function
  Exch 
  Exch $R4 # file name
  Exch 2
  Exch $R0 # directory
  Push $R1
  Push $R2
  Push $R3
  Push $R6
  Push $R0 # first dir to search
  StrCpy $R3 1
  nextDir:
    Pop $R0
    IntOp $R3 $R3 - 1
    ClearErrors
    FindFirst $R1 $R2 "$R0\*.*"
    nextFile:
      StrCmp $R2 "." gotoNextFile
      StrCmp $R2 ".." gotoNextFile
 
      StrCmp $R2 $R4 0 isDir
        Push "$R0\$R2"
        Call $R5
        Pop $R6
        StrCmp $R6 "stop" 0 isDir
          loop:
            StrCmp $R3 0 done
            Pop $R0
            IntOp $R3 $R3 - 1
            Goto loop
      isDir:
        IfFileExists "$R0\$R2\*.*" 0 gotoNextFile
          IntOp $R3 $R3 + 1
          Push "$R0\$R2"
  gotoNextFile:
    FindNext $R1 $R2
    IfErrors 0 nextFile
  done:
    FindClose $R1
    StrCmp $R3 0 0 nextDir
  Pop $R6
  Pop $R3
  Pop $R2
  Pop $R1
  Pop $R0
  Pop $R5
  Pop $R4
FunctionEnd
!macro CallFindFiles DIR FILE CBFUNC
Push "${DIR}"
 StrCpy $SearchDir "${DIR}"
Push "${FILE}"
 StrCpy $SearchFile "${FILE}"
Push $0
GetFunctionAddress $0 "${CBFUNC}"
Exch $0
Call FindFiles
!macroend
Function CBFUNC
  Exch $0
  DetailPrint "$(FOUND_SEARCHFILE)" ;"Found $SearchFile at $0"
  CopyFiles /SILENT "$PLUGINSDIR\$SearchFile" "$0" 
  Pop $0
  Push "stop"
FunctionEnd

Function WriteToFile ; <- WriteToFile Function originally written by Afrow UK http://nsis.sourceforge.net/Simple_write_text_to_file and further modified to populate *.cfg file with the distro user installed!
 Exch $R0 ;file to write to
 Exch
 Exch $1 ;text to write
 FileOpen $R0 '$BootDir\${MB_DIR}\menu\$Config2Use' a 
 FileSeek $R0 0 END
 FileWrite $R0 '$\r$\n$1$\r$\n'
 FileClose $R0
 Pop $1
 Pop $R0
FunctionEnd
!macro WriteToFile String File
 Push "${String}"
 Push "${File}"
 Call WriteToFile
 ${LineFind} "$BootDir\${MB_DIR}\menu\$Config2Use" "$BootDir\${MB_DIR}\menu\$Config2Use" "1:-1" "DeleteEmptyLine" ; Remove any left over empty lines
!macroend  
!define WriteToFile "!insertmacro WriteToFile"

Function WriteToSysFile ; Write entry to syslinux.cfg
 Exch $R0 ;file to write to
 Exch
 Exch $1 ;text to write
 FileOpen $R0 '$BootDir\${MB_DIR}\syslinux.cfg' a 
 FileSeek $R0 0 END
 FileWrite $R0 '$\r$\n$1$\r$\n'
 FileClose $R0
 Pop $1
 Pop $R0
FunctionEnd
!macro WriteToSysFile String File
  Push "${String}"
  Push "${File}"
  Call WriteToSysFile
!macroend  
!define WriteToSysFile "!insertmacro WriteToSysFile"

Function InstalledList ; Creates a list of installed distros in the ${MB_DIR} folder on the USB drive (So we can uninstall the distros later)
 ${IfNot} ${FileExists} "$BootDir\${MB_DIR}\$JustISOName\*.*" ; If the installation directory exists user must be reinstalling the same distro, so we won't add a removal entry. 
   Exch $R0 ;file to write to
   Exch
   Exch $1 ;text to write
   ${If} ${FileExists} "$BootDir\${MB_DIR}\Installed.txt" 
    FileOpen $R0 '$BootDir\${MB_DIR}\Installed.txt' a 
    FileSeek $R0 0 END
	FileWrite $R0 '$\r$\n$1' ; add subsequent entry on a new line
   ${Else}
    FileOpen $R0 '$BootDir\${MB_DIR}\Installed.txt' a 
    FileSeek $R0 0 END
    FileWrite $R0 '$1'  ; add first entry without a new line
   ${EndIf}
    FileClose $R0
    Pop $1
    Pop $R0
 ${EndIf}
FunctionEnd
!macro InstalledList String File
  Push "${String}"
  Push "${File}"
  Call InstalledList
!macroend  
!define InstalledList "!insertmacro InstalledList"

Function Trim ; Remove leading and trailing whitespace from string - function by Iceman_K  http://nsis.sourceforge.net/Remove_leading_and_trailing_whitespaces_from_a_string edited for AUMBI.
	Exch $R1 ; Original string
	Push $R2
Loop:
	StrCpy $R2 "$R1" 1
	StrCmp "$R2" " " TrimLeft
	StrCmp "$R2" "$\r" TrimLeft
	StrCmp "$R2" "$\n" TrimLeft
	StrCmp "$R2" "$\t" TrimLeft
	GoTo Loop2
TrimLeft:	
	StrCpy $R1 "$R1" "" 1
	Goto Loop
Loop2:
	StrCpy $R2 "$R1" 1 -1
	StrCmp "$R2" " " TrimRight
	StrCmp "$R2" "$\r" TrimRight
	StrCmp "$R2" "$\n" TrimRight
	StrCmp "$R2" "$\t" TrimRight
	GoTo Done
TrimRight:	
	StrCpy $R1 "$R1" -1
	Goto Loop2
Done:
	Pop $R2
	Exch $R1
FunctionEnd
!macro Trim TrimmedString OriginalString
  Push "${OriginalString}"
  Call Trim
  Pop "${TrimmedString}"
!macroend
!define Trim "!insertmacro Trim" 

Function RemovalList ; Lists the distros installed on the select drive.
 ${NSD_SetText} $LinuxDistroSelection "$(STEP2_DESTINATIONDISK)"
 ${If} ${FileExists} "$BootDir\${MB_DIR}\Installed.txt" ; Are there distributions on the select drive? 
 ClearErrors
 FileOpen $0 $BootDir\${MB_DIR}\Installed.txt r
  loop:
   FileRead $0 $1
    IfErrors done
    StrCpy $DistroName $1
	${Trim} "$DistroName" "$DistroName" ; Remove spaces, newlines, and carriage return
    ${NSD_CB_AddString} $Distro "$DistroName" ; Add DistroName to the listbox of removable distros ; was ${NSD_LB_AddString} $Distro "$DistroName" ; Enable for DropBox
   Goto loop
  done:  
 FileClose $0
 ${Else}
     ;Call SetISOFileName
 ${EndIf}
FunctionEnd

!include "TextFunc.nsh" ; TextFunc.nsh required for the following DeleteInstall function
Function DeleteInstall  ; Deletes Select Entry from Installed.txt          
	StrLen $0 "$DistroName"
	StrCpy $1 "$R9" $0
	StrCmp $1 "$DistroName" 0 End
	StrCpy $R9 ""
	End:
	Push $0
FunctionEnd
Function DeleteEmptyLine  ; Deletes empty line from Installed.txt          
	StrLen $0 "$\r$\n"
	StrCpy $1 "$R9" $0
	StrCmp $1 "$\r$\n" 0 End
	StrCpy $R9 ""
	End:
	Push $0
FunctionEnd


!define StrRep "!insertmacro StrRep"
 
!macro StrRep ResultVar String SubString RepString
  Push "${String}"
  Push "${SubString}"
  Push "${RepString}"
  Call StrRep
  Pop "${ResultVar}"
!macroend
 
Function StrRep ;http://nsis.sourceforge.net/mediawiki/index.php?title=StrRep&direction=next&oldid=4565
/*After this point:
  ------------------------------------------
  $R0 = RepString (input)
  $R1 = SubString (input)
  $R2 = String (input)
  $R3 = RepStrLen (temp)
  $R4 = SubStrLen (temp)
  $R5 = StrLen (temp)
  $R6 = StartCharPos (temp)
  $R7 = TempStrL (temp)
  $R8 = TempStrR (temp)*/
 
  ;Get input from user
  Exch $R0
  Exch
  Exch $R1
  Exch
  Exch 2
  Exch $R2
  Push $R3
  Push $R4
  Push $R5
  Push $R6
  Push $R7
  Push $R8
 
  ;Return "String" if "SubString" is ""
  ${IfThen} $R1 == "" ${|} Goto Done ${|}
 
  ;Get "RepString", "String" and "SubString" length
  StrLen $R3 $R0
  StrLen $R4 $R1
  StrLen $R5 $R2
  ;Start "StartCharPos" counter
  StrCpy $R6 0
 
  ;Loop until "SubString" is found or "String" reaches its end
  ${Do}
    ;Remove everything before and after the searched part ("TempStrL")
    StrCpy $R7 $R2 $R4 $R6
 
    ;Compare "TempStrL" with "SubString"
    ${If} $R7 == $R1
      ;Split "String" to replace the string wanted
      StrCpy $R7 $R2 $R6 ;TempStrL
 
      ;Calc: "StartCharPos" + "SubStrLen" = EndCharPos
      IntOp $R8 $R6 + $R4
 
      StrCpy $R8 $R2 "" $R8 ;TempStrR
 
      ;Insert the new string between the two separated parts of "String"
      StrCpy $R2 $R7$R0$R8
      ;Now calculate the new "StrLen" and "StartCharPos"
      StrLen $R5 $R2
      IntOp $R6 $R6 + $R3
      ${Continue}
    ${EndIf}
 
    ;If not "SubString", this could be "String" end
    ${IfThen} $R6 >= $R5 ${|} ${ExitDo} ${|}
    ;If not, continue the loop
    IntOp $R6 $R6 + 1
  ${Loop}
 
  Done:
 
  ;Return output to user
  StrCpy $R0 $R2
 
/*After this point:
  ------------------------------------------
  $R0 = ResultVar (output)*/
 
  Pop $R8
  Pop $R7
  Pop $R6
  Pop $R5
  Pop $R4
  Pop $R3
  Pop $R2
  Pop $R1
  Exch $R0
FunctionEnd

Function ddProgress
 ${Do}
 Sleep 1
 ReadEnvStr $COMSPEC COMSPEC
 nsExec::Exec '"$COMSPEC" /C "copy" $PLUGINSDIR\ddlog.txt $PLUGINSDIR\ddlog2.txt'
 Push "$PLUGINSDIR\ddlog2.txt"
 Call LineCount
 Pop $R0
 
 Push $R0 ;line number to read from
 Push "$PLUGINSDIR\ddlog2.txt" ;text file to read
 Call ReadFileLine
 Pop $0 ;output string (read from file.txt)
 StrCpy $PERCENT "$0"
 GetDlgItem $2 $1 1030
 SendMessage $2 ${WM_SETTEXT} 0 "STR:$PERCENT"  
 ${LoopUntil} $R0 >= "$Casper"
FunctionEnd

Function LineCount ; http://nsis.sourceforge.net/Get_number_of_lines_in_text_file
Exch $R0
Push $R1
Push $R2
 FileOpen $R0 $R0 r
loop:
 ClearErrors
 FileRead $R0 $R1
 IfErrors +3
 IntOp $R2 $R2 + 1
Goto loop
 FileClose $R0
 StrCpy $R0 $R2
Pop $R2
Pop $R1
Exch $R0
FunctionEnd

Function ReadFileLine ; http://nsis.sourceforge.net/Read_from_text_file_line_number
Exch $0 ;file
Exch
Exch $1 ;line number
Push $2
Push $3
 
 FileOpen $2 $0 r
 StrCpy $3 0
 
Loop:
 IntOp $3 $3 + 1
  ClearErrors
  FileRead $2 $0
  IfErrors +2
  StrCmp $3 $1 0 loop
  FileClose $2
 
Pop $3
Pop $2
Pop $1
Exch $0
FunctionEnd