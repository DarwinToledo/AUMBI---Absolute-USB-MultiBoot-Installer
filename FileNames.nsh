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

; ------------ SetISOFilenames Macro -------------- 

!macro SetISOFileNames Distro2Check ISO2Check2 Download2Get Persistent Write2File Homepage OfficialName
 ${If} $Checker == "No" 
 ${AndIf} $DistroName == "${Distro2Check}" 
 StrCpy $ISOFileName "${ISO2Check2}"
 StrCpy $DownLink "${Download2Get}"   
 StrCpy $Persistence "${Persistent}"
 StrCpy $Config2Use "${Write2File}"
 StrCpy $Homepage "${Homepage}" ; Linux Distro Homepage
 StrCpy $OfficialName "${OfficialName}" ; Linux Distro Name for Home Page Anchor

 ${ElseIf} $Checker == "Yes"  
 ${AndIf} $Removal != "Yes" 
 ${AndIf} $FormatMe != "Yes"
 ;${AndIfNot} ${FileExists} $BootDir\${File2Check}  ; If Distro File exists, don't show Distro because it must already be installed.
 ${NSD_CB_AddString} $Distro "${Distro2Check}" ; was ${NSD_LB_AddString} $Distro "${Distro2Check}" ; Enable for Dropbox
  
 ${ElseIf} $Checker == "Yes"   
 ${AndIf} $Removal != "Yes"  
 ${AndIf} $FormatMe == "Yes" 
 ${NSD_CB_AddString} $Distro "${Distro2Check}" ; was ${NSD_LB_AddString} $Distro "${Distro2Check}" ; Enable for Dropbox
 ${EndIf}
!macroend