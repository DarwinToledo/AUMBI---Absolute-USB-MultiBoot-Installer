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

; ------------ Uninstall Distros Macro -------------- 

!macro Uninstall_Distros  
; New Methods catch-all
 ${If} $DistroName != ""  
  ${DeleteMenuEntry} "$BootDir\${MB_DIR}\menu\$Config2Use" "#start $DistroName" "#end $DistroName" ; Remove entry from config file... I.E. linux.cfg, system.cfg, etc
  ${LineFind} "$BootDir\${MB_DIR}\Installed.txt" "$BootDir\${MB_DIR}\Installed.txt" "1:-1" "DeleteInstall" ; Remove the Installed entry
  ${LineFind} "$BootDir\${MB_DIR}\Installed.txt" "$BootDir\${MB_DIR}\Installed.txt" "1:-1" "DeleteEmptyLine" ; Remove any left over empty lines
  ${LineFind} "$BootDir\${MB_DIR}\menu\$Config2Use" "$BootDir\${MB_DIR}\menu\$Config2Use" "1:-1" "DeleteEmptyLine" ; Remove any left over empty lines
  Delete "$BootDir\${MB_DIR}\$DistroName\*.*" 
  
  ReadEnvStr $R0 COMSPEC
  nsExec::Exec '"$R0" /C rmdir /Q /S "$BootDir\${MB_DIR}\$DistroName"' 
  
  RMDir /R "$BootDir\${MB_DIR}\$DistroName"   ; make another pass using NSIS built in RMDir
  
   ${AndIf} ${FileExists} "$BootDir\${MB_DIR}\ISOS\$DistroName.iso"   
   Delete "$BootDir\${MB_DIR}\ISOS\$DistroName.iso" 
 ${EndIf}
 DetailPrint "$(DETAILPRINT_ISOREMOVED2)"
!macroend