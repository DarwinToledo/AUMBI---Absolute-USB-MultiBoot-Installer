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

; ------------ Casper Script --------------

Function CasperScriptAlt1
${If} $Casper != "0"
${AndIf} $DistroName != "Windows to Go (Virtual Hard Disk)"
 Call GetCaspTools
 
  ${If} $DistroName == "Debian Live"
  StrCpy $CasperName "live-rw"
  ${Else}
  StrCpy $CasperName "casper-rw"
  ${EndIf} 
  
 SetShellVarContext all
 InitPluginsDir
 ExpandEnvStrings $COMSPEC "%COMSPEC%"
 ExecShell "" '"$COMSPEC"' '/C if 1==1 "dd.exe" if=/dev/zero of=$PLUGINSDIR\$CasperName bs=1M count=$Casper --progress 2>$PLUGINSDIR\ddlog.txt' SW_HIDE
 Banner::show /set 76 "Creating a Persistent File."
 Banner::getWindow
 Pop $1  
 DetailPrint "Creating a persistent file. Progress will not move until finished..."
 Call ddProgress
 Banner::destroy
 
 nsExec::ExecToLog '"$PLUGINSDIR\mke2fs.exe" -L $CasperName $PLUGINSDIR\$CasperName'
 CopyFiles $PLUGINSDIR\$CasperName "$BootDir\${MB_DIR}\$JustISOName\$CasperName" ; Copy casper-rw to USB
 Delete "$PLUGINSDIR\$CasperName"
${EndIf}
FunctionEnd

Function CasperSize
 IntOp $SizeOfCasper $SizeOfCasper + $Casper
FunctionEnd

Function GetCaspTools
SetShellVarContext all
InitPluginsDir
File /oname=$PLUGINSDIR\dd.exe "dd.exe"
File /oname=$PLUGINSDIR\mke2fs.exe "mke2fs.exe"
DetailPrint "Now Creating a Casper RW File" 
DetailPrint "Creating the Persistent File: The progress bar will not move until finished. Please be patient..." 
FunctionEnd