#GenDiskPartFile
#Copyleft (c)2019 Darwin Toledo

!macro GenDiskPartFile FILE_N FILE_TEXT
       !delfile "${FILE_N}"
       !appendfile "${FILE_N}" "${FILE_TEXT}"

!macroend
;$\n
!define GenDiskPartFile "!insertmacro GenDiskPartFile "
${GenDiskPartFile} "dd-diskpart.txt" "create vdisk file=DSK\SLUG.vhd type=fixed maximum=VHDSIZE\
                   $\nexit"
${GenDiskPartFile} "diskpart.txt" "create vdisk file=DSK\SLUG.vhd type=fixed maximum=VHDSIZE\
                                  $\nselect vdisk file=DSK\SLUG.vhd\
                                  $\nattach vdisk\
                                  $\ncreate par pri\
                                  $\nformat fs=VHDFMT quick label=VHD override\
                                  $\nactive\
                                  $\nassign letter v\
                                  $\nexit"
${GenDiskPartFile} "diskpartdetach.txt" "select vdisk file=DSK\SLUG.vhd\
                                        $\ndetach vdisk\
                                        $\nexit"
${GenDiskPartFile} "diskpartformat.txt" "list volume\
                                        $\nselect volume DSK\
                                        $\nformat fs=NTFS quick label=${MB_LAB} override\
                                        $\nassign letter DSK\
                                        $\nlist volume\
                                        $\nexit"
${GenDiskPartFile} "diskpartwipe.txt" "list disk\
                                      $\nselect disk DISKNUM\
                                      $\nclean\
                                      $\nconvert mbr\
                                      $\ncreate partition primary\
                                      $\nselect partition 1\
                                      $\nactive\
                                      $\nformat fs=NTFS quick label=${MB_LAB} override\
                                      $\nassign letter DSK\
                                      $\nlist volume\
                                      $\nexit"
${GenDiskPartFile} "diskpartwipe1.txt" "select disk DISKNUM\
                                       $\nlist disk\
                                       $\nclean\
                                       $\nexit"
${GenDiskPartFile} "diskpartwipe2.txt" "select disk DISKNUM\
                                       $\nclean\
                                       $\nconvert mbr\
                                       $\nrescan\
                                       $\ncreate partition primary\
                                       $\nselect partition 1\
                                       $\nactive\
                                       $\nformat fs=NTFS quick label=${MB_LAB} override\
                                       $\nassign letter DSK\
                                       $\nrescan\
                                       $\nlist volume\
                                       $\nexit"
${GenDiskPartFile} "dskvol.txt" ""
${GenDiskPartFile} "w2gdiskpart.txt" "create vdisk file=DSK\SLUG.vhd type=expandable maximum=VHDSIZE\
                                     $\nselect vdisk file=DSK\SLUG.vhd\
                                     $\nattach vdisk\
                                     $\ncreate par pri\
                                     $\nformat fs=VHDFMT quick label=VHDLBL override\
                                     $\nactive\
                                     $\nassign\
                                     $\nexit"
