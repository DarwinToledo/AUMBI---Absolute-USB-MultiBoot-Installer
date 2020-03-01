=========================================================================
A.U.M.B.I. - Absolute USB MultiBoot Installer
=========================================================================

©Copyleft 2016-2020 Darwin Toledo https://www.usbwithlinux.com/



Based on YUMI

=========================================================================

YUMI ©2011-2019 https://www.pendrivelinux.com (covered under GNU GPL License) - see YUMI-Copying

Background of YUMI (Your Universal Multiboot Integrator):

YUMI is an easy to use tool created using NSIS. The purpose of YUMI is to help automate the creation of a bootable USB Flash Drive that can be used to boot multiple Linux based distributions (one at a time).
The end result should be a bootable USB Flash drive that will get you up and running with your chosen Live Distributions, all without having to do the research and perform the steps by hand. 

How YUMI Works:

YUMI utilizes a Syslinux MBR to make the chosen drive bootable. Distributions are extracted using 7zip to the multiboot folder on the USB device, and a custom syslinux.cfg file along with distro independant configuration files are used to boot each distribution. Grub4DOS grub.exe may also be used to boot ISO files directly. 

Credits, Resources, and Third Party Tools used:

* Remnants of Cedric Tissieres's Tazusb.exe for Slitaz (slitaz@objectif-securite.ch) may reside in the YUMI script, as it was derived from UUI, which was inspired by Tazusb.exe. 
* Built using the NSIS Installer © Contributors http://nsis.sourceforge.net (use to compile the .nsi script) - http://nsis.sourceforge.net/License
* Syslinux © H. Peter Anvin http://syslinux.zytor.com (unmodified binary used)
* grub.exe Grub4DOS © the Gna! people + Chenall https://code.google.com/p/grub4dos-chenall/ (unmodified binary used) : Official Grub4DOS: http://gna.org/projects/grub4dos/
* 7-Zip is © Igor Pavlovis http://7-zip.org (unmodified binaries were used)
* Fat32format.exe © Tom Thornhill Ridgecorp Consultants http://www.ridgecrop.demon.co.uk (unmodified binary used)
* Firadisk.img © Panot Joonkhiaw Karyonix http://reboot.pro/8804/ (unmodified binary used)
* dd.exe © John Newbigin http://www.chrysocome.net/ (unmodified binary used)
* mke2fs © Matt <mattwu@163.com> http://www.ext2fsd.com (unmodified binary used)
* Tuffy Font © Thatcher Ulrich http://tulrich.com/fonts/ (unmodified binary used)
* iPXE wimboot © Michael Brown and the iPXE project team http://ipxe.org/wimboot (unmodified binary used)
* Wimlib Copyright © Eric Biggers https://wimlib.net/ (unmodified binary used)

Additional information for YUMI can be found HERE: https://www.pendrivelinux.com/yumi-multiboot-usb-creator/

Changelog:

01/16/19 Version 2.0.6.3: Fix broken bootloader from version 2.0.6.2. Version 2.0.6.2 was broken and did not work for fresh flashdrive installs.
01/10/19 Version 2.0.6.2: Update Fedora boot method. Remove changing of generic.lst to $ISOFileName.lst as sometimes the filename becomes too long to detect. Consolidate generic.lst entries into basic.lst. Create syslinux.bin file to be used for chainloading.
12/02/18 Version 2.0.6.1a: Update to support newer Ubuntu and derivatives using initrd instead of initrd.lz,.gz, etc.
11/30/18 Version 2.0.6.1: Include ability to see which Disk the drive letter of volume/partition is on. Improve DiskWipe option - rescan during Diskpart before creating a new partition.
11/28/18 Version 2.0.6.0: Set Fat32 and NTFS Format options to format only the selected Volume Drive Letter. Include a new option to Wipe Entire Disk (including all attached Volumes/Partitions). The Wipe Entire Disk option can be used to Restore USB drives made bootable with DD, or to convert them back to use a single partition with a bootable MBR.
10/31/18 Version 2.0.5.9: Update to support Pearl Linux. Fix some broken links. Fix Solus entry. 
07/20/18 Version 2.0.5.8: Update to support Norton Bootable Recovery Tool, Quick Save Live, Hiren's Boot CD PE, and newer CentOS 7 Live.
06/19/18 Version 2.0.5.7: Update to support Kodachi, and newer Kaspersky Rescue Disk.
05/06/18 Version 2.0.5.6: Update to support GeckoLinux and newer Porteus.
04/25/18 Version 2.0.5.5: Fix various broken links.
03/07/18 Version 2.0.5.4: Added initial support for KaOS, VyOS, Bluestar Linux, Raspberry Pi Desktop, and XenialPup. Medicat now extracts to the root folder until I find a fix for lost paths.
01/09/18 Version 2.0.5.3: Added support for Super Grub2 Disk, Trisquel, newer LXLE, and Medicat.
12/18/17 Version 2.0.5.2: Added support for MX Linux and Feren OS.
10/28/17 Version 2.0.5.1: Added support for Parrot, Vinux (for the blind and visually impaired), POP!_OS, and WifiWay 3.5.
09/26/17 Version 2.0.5.0: Added support for Antergos, PureOS, CentOS Installer, Ubuntu Mini (Netboot Installer), and recent Debian Live and Tails Images. Corrected broken Debian homepage link and Lubuntu, Xubuntu download links.
05/06/17 Version 2.0.4.9: Fixed recently broken Debian Live entry. Added option to set Windows to Go VHD file size.
05/01/17 Version 2.0.4.8: Update to support Neon, Finnix, Devuan, and Vinari OS. Added compatibility test file.
04/19/17 Version 2.0.4.7: Update to support newer Manjaro and Archlinux. Address potential missing Configfile errors when subsequently adding distributions.
03/27/17 Version 2.0.4.6: Quick fix to correct the double Distro list during step 2.
03/22/17 Version 2.0.4.5: Add ability to create larger than 4GB casper-rw persistent file if using NTFS format for Ubuntu and Linux Mint - (creates 4th partition table). Added casper-rw creation progress banner.
03/13/17 Version 2.0.4.4: Add filesystem type to drivelist. Include messagebox to notify of NTFS filesystem requirement for Windows to Go option.
03/03/17 Version 2.0.4.3: Add Windows to Go VHD option. Added more info for syslinux warning. Added Diskpart NTFS format option.
02/22/17 Version 2.0.4.2: Temporarily limit format option to removable media.
02/16/17 Version 2.0.4.1: Quick fix to address broken format option.
02/12/17 Version 2.0.4.0: Temporarily add back Single Windows Vista/7/8/10 Installer option (which extracts all files from ISO to root). Add lock and dismount capability.
02/02/17 Version 2.0.3.9: Update to support OSFClone, newer WifiSlax, and NetRunner. Correct AntiX entry to use bdir=. Update to replace empty spaces in iso file with dashes. Correction to GRUB Partition 4 option.
01/30/17 Version 2.0.3.8: Quick fix for singular and multiple Win PE builds. 
01/28/17 Version 2.0.3.7: Update to support various Win PE builds. Modified distribution removal process. Corrected font size for Show All ISOs option.
01/14/17 Version 2.0.3.6: Update to support multiple Windows Vista/7/8/10 Installers. -wimboot option stores the extracted Windows Installers in their own directory. -bootmgr option moves only bootmgr and bcd to root of drive. (note: -bootmgr option does require a Windows Vista or later host to run bcdedit).
12/27/16 Version 2.0.3.5: Fix to replace empty spaces in Distro filename with dashes. Add Windows PE (WIM) boot options (unfinished). Implement wimboot capabilities, Switch to newer Grub4Dos. Update labels.
12/22/16 Version 2.0.3.4: Quick fix to correct the double Distro list during step 2.
12/19/16 Version 2.0.3.3: Update Get Drives function to ignore system and network drives on subsequent YUMI installs. Corrected UI vesamenu paths.
12/12/16 Version 2.0.3.2: Update to support Solus. Reinclude show all drives option and disable FSCTL lock, dismount, and unlock volume features until a better solution is found.
12/10/16 Version 2.0.3.1: Update Get Drives function to ignore system and network drives. Add filesystem and drive type to drive list. Add lock, dismount, and unlock features.
12/02/16 Version 2.0.3.0: Update to support ChaletOS and Bunsenlabs. Support newer Fedora Workstation Live and Zorin Core ISOs. Fix CentOS Link. Create a trk3 directory at the root of USB before copying files (necessary for Windows XP copyfiles).
10/03/16 Version 2.0.2.9: Switch back to 7-Zip 9.20.
09/14/16 Version 2.0.2.8: Fix menu entries for boot repair, and elementary OS. Upgrade to 7-Zip 16.02.
08/17/16 Version 2.0.2.7: Add support for Arch Bang, Skywave Linux, and Cyborg Linux.
07/07/16 Version 2.0.2.6: Add support for Android-x86. Fix broken Manjaro entry. Update credits and sources.
07/01/16 Version 2.0.2.5: Fix Eset, avira, and Dr.Web menu entries which became broken in build 2.0.2.4. 
06/28/16 Version 2.0.2.4: Update to support Cub Linux. Fix broken WifiSlax entry. Switch to use alternate method for old Ubuntu derivitives with conflicting syslinux gfxboot.
06/01/16 Version 2.0.2.3: Fixed bug: calculating remaining space on USB drive. Switch back to using vesamenu for sub-menu config files. Remove unused Prompt 0 from config. Re-enable Ubuntu gfxboot.
04/14/16 Version 2.0.2.2: Update to support Linux Kid X, Linux Lite, Subgraph OS, and Calculate Linux Desktop. Re-enable entry for Offline NT Password and Registry Editor.
04/06/16 Version 2.0.2.1: Added support for WattOS, update SLAX option, update links, disable feature to close all open explorer windows when format option is selected. Update Fat32Format.
12/28/15 Version 2.0.2.0: Add GRUB (partition 4) option. Update to support Xioapan, Windows 10, Bitdefender Rescue CD options. Update DBan option.
10/28/15 Version 2.0.1.9: Remove distributions that are no longer being developed. Fix broken links.
06/17/15 Version 2.0.1.8: Update to support newer GRML 2014-11, CentOS 7, Clonezilla 2.4.2-10, and Ultimate Edition 4.
05/14/15 Version 2.0.1.7: Update links.
03/18/15 Version 2.0.1.6: Add support for Tahrpup 6.0, Debian Live 7.8.0, and OpenSuSe 3.2.
01/20/15 Version 2.0.1.5: Fix broken 64bit option for 2015_01_13 Parted Magic entry
01/15/15 Version 2.0.1.4: Update to support 2015_01_13 Parted Magic.
01/13/15 Version 2.0.1.3: Remove Acronis True Image entry (Use Try Unlisted ISO GRUB for Acronis). Updated links.
10/30/14 Version 2.0.1.2: Enable checkbox option to forcefully Show All ISO Files.
10/29/14 Version 2.0.1.1: Update to support Linpus Lite, mintyMac, and ESET SysRescue Live. Fix AntiX boot issue. 
09/19/14 Version 2.0.1.0: Switch to use Syslinux 6.0.3 to address ERR: Couldn't read the first sector issues.
09/11/14 Version 2.0.0.9: Add Dr.Web LiveDisk. Fix broken System Rescue CD, and HDT option. Update Ubuntu download options.
08/14/14 Version 2.0.0.8: Fix Windows Vista/7/8 and Hiren's options.
07/31/14 Version 2.0.0.7: Switch to use NEW Syslinux version 6.02.
07/29/14 Version 2.0.0.6: Update to support Peach OSI
05/29/14 Version 2.0.0.5: Update Ubuntu, CentOS, and Debian Download Links. Remove Backtrack - superseded by Kali.
04/29/14 Version 2.0.0.4: Update to support CAINE and Puppy Arcade.
04/17/14 Version 2.0.0.3: Update to support Tails 0.23 and Rescatux 0.30.2 (must manually extract and use Rescatux.iso from the ISO). Correct OpenSuse links.
03/18/14 Version 2.0.0.2: Update to support newer version of Offline Windows Password & Registry Editor, LuninuX OS, Pear Linux, and Konboot 2.3 Pro.
02/20/14 Version 2.0.0.1: Fixed Linux Mint 16 Live Installer Crash!
01/30/14 Version 2.0.0.0: Added support for JustBrowsing, Mythbuntu, Bugtraq II, and older pmagic_2013_05_01.iso.
01/10/14 Version 1.9.9.9B: Added support for Fedora 20, LXLE Desktop. Fixed source compilation bug.
12/11/13 Version 1.9.9.9: Re-enabled Dr.Web, Trinity, and RIP Linux. Support Elementary 32 bit.
12/09/13 Version 1.9.9.8B: Added Acronis True Image, Sparky Linux, and SolydX
12/06/13 Version 1.9.9.8: Add option for Paid version of Kon-Boot. Added Manjaro Linux.
12/04/13 Version 1.9.9.7B: Correct ISO Name for Desinfect. Correct OpenSUSE ISO copy failed when using Windows XP. Add support for Rescatux ISO (can't use sg2d version).
11/24/13 Version 1.9.9.7: Modify chain.c32 to address Insane Primary (MBR) partition error. Correct Kaspersky Rescue Disk (Antivirus Scanner) syslinux directory coping issue on Win XP
11/22/13 Version 1.9.9.6B: Added OpenSUSE. Corrected Desinfec't misspelling.
11/20/13 Version 1.9.9.6: Add Desinfec't 2013 (German Antivirus). Fix broken older Parted Magic menu entries.
11/13/13 Version 1.9.9.5B: Add WifiSlax. Thanks to Geminis Demon for helping finish the entry!
11/12/13 Version 1.9.9.5: Added provision to ensure menu.32 exists. Fixed Falcon4 and Hiren menu creation.
11/11/13 Version 1.9.9.4: Added Persistent Option for Ubuntu and some Derivatives. Fix Kon-Boot free entry. Switch to AutoDetect Size of ISO.
11/08/13 Version 1.9.9.3: Add Liberte Linux. Fixed a menu scrolling bug (vesamenu.c32 incompatible with boot.msg?) that occurred with distros like Puppy and KNOPPIX
11/07/13 Version 1.9.9.2: Add support for TAILS, and Ultimate Boot CD
11/05/13 Version 1.9.9.1: Quick fix to support older versions of Knoppix
11/04/13 Version 1.9.9.0: Beta release of YUMI version 2