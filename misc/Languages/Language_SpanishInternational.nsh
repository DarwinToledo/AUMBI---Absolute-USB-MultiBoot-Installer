#===========================================================
# Spanish International Language File
# (c)2016-2020 by Darwin Toledo - www.darwintoledo.com
#===========================================================

!define RODRILANG ${LANG_SPANISHINTERNATIONAL}

        LangString LICENSE_AUMBI_TOP_TEXT   ${RODRILANG} "Acuerdo de Licencia"
        LangString SELECTION_AUMBI_TOP_TEXT ${RODRILANG} "Opciones de Distro e ISO"
        LangString INSTALL_AUMBI_TOP_TEXT   ${RODRILANG} "Procesando ISO en USB"
        LangString COMPLETED_TEXT           ${RODRILANG} "Todo terminado, Proceso Completado!"
        LangString ADD_MORE_DISTRO_MB_TEXT  ${RODRILANG} "¿Le gustaría añadir más ISOs/Distros en $DestDisk Ahora?"
        LangString FINISH_AUMBI_TEXT        ${RODRILANG} "Proceso Finalizado"

        LangString License_Subtitle         ${RODRILANG} "Por favor, revise los términos de la licencia antes de continuar"
        LangString License_Text_Top         ${RODRILANG} "El software dentro de este programa se divide en las siguientes licencias."
        LangString License_Text_Bottom      ${RODRILANG} "Debe aceptar los términos de este acuerdo de licencia para ejecutar ${NAME}. Si está de acuerdo, haga clic en Acepto para continuar."
        LangString SelectDist_Title         ${RODRILANG} "Selección de unidad y opciones de Distro."
        LangString SelectDist_Subtitle      ${RODRILANG} "Elija una unidad USB, y una Distribución, archivo ISO/ZIP.$\r$\nSe pueden añadir distribuciones adicionales cada vez."
        LangString DrivePage_Text           ${RODRILANG} "Paso 1: Seleccione la letra de su dispositivo USB."
        LangString Distro_Text              ${RODRILANG} "Paso 2: Seleccione una distribución de la lista."
        LangString IsoPage_Text             ${RODRILANG} "Paso 3: Seleccionar $FileFormat (el nombre debe ser similar al anterior)."
        LangString IsoPage_Title            ${RODRILANG} "Seleccione su $FileFormat"
        LangString Casper_Text              ${RODRILANG} "Paso 4: Establecer el tamaño del archivo persistente (opcional)."
        LangString IsoFile                  ${RODRILANG} "$FileFormat file|$ISOFileName" ;$ISOFileName variable previously *.iso
        LangString Extract                  ${RODRILANG} "Extrayendo el $FileFormat: The progress bar will not move until finished. Please be patient..."
        LangString CreateSysConfig          ${RODRILANG} "Creando archivo de configuración para $DestDisk"
        LangString ExecuteSyslinux          ${RODRILANG} "Ejecutando syslinux en $BootDir"
        LangString SkipSyslinux             ${RODRILANG} "Bueno Syslinux Existe..."
        LangString WarningSyslinux          ${RODRILANG} "An error ($R8) occurred while executing syslinux.$\r$\nYour USB drive won't be bootable..."
        LangString WarningSyslinuxOLD       ${RODRILANG} "This YUMI revision uses a newer Syslinux version that is not compatible with earlier revisions.$\r$\nPlease ensure your USB drive doesn't contain earlier revision installs."
        LangString Install_Title            ${RODRILANG} "$InUnStall $ISOFileName"
        LangString Install_SubTitle         ${RODRILANG} "Please wait while we $InUnStall $DistroName on $JustDrive"
        LangString Install_Finish_Sucess    ${RODRILANG} "${NAME} sucessfully $InUnStalled $DistroName on $JustDrive"
        LangString Finish_Install           ${RODRILANG} "$InUnStallation Completa."
        LangString Finish_Title             ${RODRILANG} "${NAME} has completed the $InUnStallation."
        LangString Finish_Text              ${RODRILANG} "Su selección ha sido procesada en la unidad USB.$\r$\n$\r$\nSiéntase libre de utilizar esta herramienta para añadir o quitar más distros.$\r$\n$\r$\n${NAME} hará un seguimiento de las selecciones procesadas"
        LangString Finish_Link              ${RODRILANG} "Haga clic aquí para visitar la web de ${NAME} para Ayuda!"

        LangString Create_Button            ${RODRILANG} "Crear"

        LangString VIEWREM_DISTROS          ${RODRILANG} "¿Ver o quitar distros instaladas?"
        LangString DOWNLOAD_ISOOP           ${RODRILANG} "Descargar ISO (opcional)."
        LangString SHOW_ALL_ISOS            ${RODRILANG} "¿Ver ISOs?"
        LangString S_SHOW_ALLISOS           ${RODRILANG} "ISOs!"
        LangString RL_BROWSE                ${RODRILANG} "Examinar"
        LangString RL_VISIT_HOME            ${RODRILANG} "Visitar la web de $OfficialName"
        LangString BROW_AND_SELFORM         ${RODRILANG} "Busque y seleccione la $FileFormat"
        LangString RL1_STEP1                ${RODRILANG} "Paso 1: ${NAME} Invocó $DestDisk como su dispositivo USB"
        LangString SHOW_ALL_DRIVES          ${RODRILANG} "¿Ver unidades?"
        ;LangString CLICK_TO_ONLINEHELP      ${RODRILANG} "Haga clic aquí para visitar la web de ${NAME} para Ayuda!"
        ;LangString CLICK_TO_ONLINEHELP2     ${RODRILANG} "Click HERE to visit the ${NAME} page for additional Help!"

        LangString RL2_STEP1                ${RODRILANG} "Paso 1: Seleccione la letra de la unidad USB."
        LangString RL2_FORMAT               ${RODRILANG} "Formato NTFS $DestDisk"
        LangString RL2_FORMATFAT            ${RODRILANG} "Formato FAT32 $DestDisk"
        LangString RL2_FORMATW              ${RODRILANG} "Formato NTFS $DestDisk"
        LangString RL2_FORMATFATW           ${RODRILANG} "Formato FAT32 $DestDisk"
        LangString RL2_SHOWING              ${RODRILANG} "Unidades"
        LangString RL_ODL                   ${RODRILANG} "Enlace abierto"
        LangString RL_DL1                   ${RODRILANG} "Enlace de Descarga"
        LangString RL_WEWILLFAT             ${RODRILANG} "Formaremos $DestDisk en Fat32"
        LangString RL_WEWILLNTFS            ${RODRILANG} "Formaremos $DestDisk en NTFS"

        LangString MENU_LABEL_LUNIX_DIST    ${RODRILANG} "Distribuciones Linux"
        LangString MENU_LABEL_SYS_TOOLS     ${RODRILANG} "Herramientas de Sistema"
        LangString MENU_LABEL_SYS_ANONY     ${RODRILANG} "Anonymous Browsers"
        LangString MENU_LABEL_ANTIVIR       ${RODRILANG} "Herramientas Antivirus"
        LangString MENU_LABEL_NETBOOK       ${RODRILANG} "Distribuciones para Netbook"
        LangString MENU_LABEL_OTHER_OS      ${RODRILANG} "Otros Sistemas Operativos y Herramientas"
        LangString MENU_LABEL_UNLISTED      ${RODRILANG} "ISO no listado(via SYSLINUX)"
        LangString MENU_LABEL_UNLISTED2     ${RODRILANG} "Unlisted ISOs (via GRUB)"
        LangString MENU_LABEL_UNLISTED3     ${RODRILANG} "Unlisted ISOs (via Virtual Hard Disk)"
        LangString MENU_LABEL_UNLISTED4     ${RODRILANG} "Unlisted ISOs (via GRUB Partition 4)"
        LangString MENU_LABEL_UNLISTED5     ${RODRILANG} "Unlisted ISOs (via GRUB from RAM)"
        LangString MENU_LABEL_WINDOWS       ${RODRILANG} "Instaladores Windows"
        LangString MENU_LABEL_WINTOGO       ${RODRILANG} "Windows to Go"
        ;LangString MENU_LABEL_GRUB          ${RODRILANG} "GRUB Bootable ISOs"
        ;LangString MENU_LABEL_GRUB_LARGE    ${RODRILANG} "GRUB Bootable ISOs and Windows XP/7/8"
        LangString MENU_BACKTOMAIN          ${RODRILANG} "Regresar al Menu Principal"
        LangString GEN_CREDITS_FILE         ${RODRILANG} "# Menu Generado por ${NAME} ${PRODUCT_WEBSITE}"

        LangString MB_DL2                   ${RODRILANG} "¿Lanzar el Enlace de descarga?$\r$\nPermitir que finalice la descarga antes de pasar al paso 2."
        LangString RL2_STEP3                ${RODRILANG} "Paso 3: Finalizada la descarga, examinar y seleccionar ISO."
        LangString BW2_STEP3                ${RODRILANG} "Paso 3: Examinar y seleccionar $ISOFileName"
        LangString BW_ISO_1                 ${RODRILANG} "Examinar para buscar $ISOFileName  -->"
        LangString VTO_HOME1                ${RODRILANG} "Visitar la web de $OfficialName"
        LangString WE_SELECT1               ${RODRILANG} "$SomeFileExt Encontrado y seleccionado."
        LangString DONE_STEP3               ${RODRILANG} "Paso 3 TERMINADO: $ISOFileName Encontrado y seleccionado!"

        LangString BW_ISO_2                 ${RODRILANG} "Examinar y seleccionar $ISOFileName"
        LangString PEND_STEP3               ${RODRILANG} "Paso 3 PENDIENTE: Examine para $ISOFileName"


        LangString LOCAL_SOMEFILE_SEL       ${RODRILANG} "Seleccionado $SomeFileExt local."
        LangString JUST_ISONAME_ALREDY      ${RODRILANG} "$JustISOName is already on $DestDisk$\r$\nPlease Remove it first!$\r$\n$\r$\nNOTE: If you have already removed it using AUMBI,$\r$\nmanually delete the $BootDir\multiboot\$JustISOName\ folder."
        LangString STEP_2_SELADISTRNA       ${RODRILANG} "Paso 2: $DistroName Seleccionada"
        LangString STEP_2_SELADISTRIB       ${RODRILANG} "Paso 2: Seleccione una distribución para $DestDisk"
        LangString BUTTON_REMOVE_TEXT       ${RODRILANG} "Quitar"
        LangString YOURE_UNISTALLERMODE     ${RODRILANG} "Usted esta en modo desinstalador!"
        LangString STEP2_DESTINATIONDISK    ${RODRILANG} "Paso 2: Seleccione una distribución para quitar de $DestDisk"
        LangString STEP3_SELECTISOFILEVAR   ${RODRILANG} "Paso 3: Seleccione $ISOFileName"
        LangString DISABLE_AFTER_STEP2      ${RODRILANG} "Deshabilitado hasta completar el paso 2"
        LangString BUTTON_CREATE_TEXT       ${RODRILANG} "Crear"
        LangString STEP2_SELECTADISTRO      ${RODRILANG} "Paso 2: Seleccione una distribución para $DestDisk"

        LangString STEP1_DESTUSBDEV         ${RODRILANG} "Paso 1: Seleccionó $DestDisk en (Disco $DiskNum) como su dispositivo USB"
        ;LangString FORMATING_TEXTDISK       ${RODRILANG} "Formatting $DestDisk as Fat32 using Fat32format.exe"
        ;LangString WEWILL_FAT32             ${RODRILANG} "We Will Fat32 Format $DestDisk Drive!"
        ;LangString FORMAT_DESTDIST_DRIVE    ${RODRILANG} "Format $DestDisk Drive (Erase Content)?"

        ;LangString STEP_2_REMOVEFROMLIST    ${RODRILANG} "Step 2: Select a Distribution from the list to remove from $DestDisk"

        LangString STEP_3_JUSTISOSEL         ${RODRILANG} "Paso 3: $JustISO seleccionado"
        LangString STEP_3_SELYOURISO         ${RODRILANG} "Paso 3: Seleccione su $ISOFileName"

        LangString STEP_4_SETTHESIZE         ${RODRILANG} "Paso 4: Establezca el tamaño del archivo Win2Go VHD. Mínimo 20,000 MB"
        LangString STEP_4_SETPERSIST         ${RODRILANG} "Paso 4: Establezca un tamaño de archivo para almacenar los cambios (opcional)."

        LangString DISK_LABEL1               ${RODRILANG} "Limpiaremos (Disco $DiskNum)"
        LangString DISK_LABEL2               ${RODRILANG} "Limpiar todo (Disco $DiskNum)"
        LangString Disk_LabelS               ${RODRILANG} "Disco"

        LangString MAIN_BOOT_HDD             ${RODRILANG} "Boot from first Hard Drive"
        LangString MAIN_BOOT_HDD2            ${RODRILANG} "Continuar desde la primera unidad (^Predeterminado)"

        LangString DETAILPRINT_PREINST       ${RODRILANG} "Instalación MultiBoot anterior detectada... procediendo a agregar sus nuevas selecciones."
        LangString FOUND_SEARCHFILE          ${RODRILANG} "Encontrado $SearchFile en $0"
        LangString DETAILPRINT_CHECKING      ${RODRILANG} "Comprobando si necesitamos reemplazar vesamenu.c32, menu.c32, y chain.c32, libutil.c32, libcom32.c32, memdisk"
        LangString DETAILPRINT_ISOADDED      ${RODRILANG} "$DistroName ($JustISOName) y su entrada de menú ¡fueron agregados!"
        LangString MBOX_OK_CONFIG            ${RODRILANG} "AUMBI couldn't find a configuration file.$\r$\n'$JustISO' not supported, please report the exact steps taken to arrive at this message!$\r$\nAUMBI will now remove this entry."
        LangString DETAILPRINT_ISOREMOVED    ${RODRILANG} "$JustISOName y su entrada de menú ¡fueron quitados!"
        LangString DETAILPRINT_ISOREMOVED2   ${RODRILANG} "$DistroName y su entrada de menú ¡fueron quitados!"

;        LangString MBOX_FOURTABLE            ${RODRILANG} "Esta opción crea una cuarta tabla de partición en ($DestDisk)$\r$\n$\r$\nDepende de usted asegurarse de que ya no exista una cuarta partición en ($DestDisk). Si existe, podría sobrescribirse.$\r$\n$\r$\n¡Haga clic en SÍ para aceptar estas acciones o en NO para volver!"
        LangString MBOX_FOURTABLE            ${RODRILANG} "Esta opción crea una entrada en una cuarta tabla de partición en ($DestDisk)$\r$\n$\r$\nAunque es poco probable que ya exista una cuarta tabla de particiones en ($DestDisk), depende de usted asegurarse de que no exista, ya que podría sobrescribirse una vez que se inicie este sistema operativo.$\r$\n$\r$\n¡Haga clic en SÍ para aceptar estas acciones o en NO para volver!"

        LangString MBOX_WARNING01            ${RODRILANG} "ADVERTENCIA: ¡Haga una copia de seguridad de cualquier información que desee conservar antes de continuar! Todos los datos en (Disco $DiskNum), incluidas las letras de unidad, particiones y volúmenes adjuntos, incluso si están ocultos, se borrarán.$\r$\n$\r$\n${NAME} está listo para realizar las siguientes acciones:$\r$\n$\r$\n1.) Borrar (Disco $DiskNum) - ¡Los datos se eliminarán de forma irrecuperable!$\r$\n$\r$\n2.) Recrear la letra de la unidad ($DestDisk) con una sola partición NTFS.$\r$\n$\r$\n3.) Crear un MBR de Syslinux en ($DestDisk) - ¡Se sobrescribirá el MBR existente!$\r$\n$\r$\n4.) Crear la etiqueta ${MB_LAB} en ($DestDisk) - ¡Se sobrescribirá la etiqueta existente!$\r$\n$\r$\n5.) Instalar ($DistroName) en ($DestDisk)$\r$\n$\r$\n¿Está absolutamente seguro que (Disco $DiskNum) es el disco correcto?$\r$\n¡Verifique dos veces con Windows diskmgmt para asegurarse!$\r$\n$\r$\n¡Haga clic en SÍ para realizar estas acciones o en NO para cancelar!"
        LangString MBOX_WARNING02            ${RODRILANG} "ADVERTENCIA: ¡Haga una copia de seguridad de cualquier información que desee conservar antes de continuar! Todos los datos en (Disco $DiskNum), incluidas las letras de unidad, particiones y volúmenes adjuntos, incluso si están ocultos, se borrarán.$\r$\n$\r$\n${NAME} está listo para realizar las siguientes acciones:$\r$\n$\r$\n1.) Borrar (Disco $DiskNum) - ¡Los datos se eliminarán de forma irrecuperable!$\r$\n$\r$\n2.) Recrear la letra de la unidad ($DestDisk) con una sola partición Fat32.$\r$\n$\r$\n3.) Crear un MBR de Syslinux en ($DestDisk) - ¡Se sobrescribirá el MBR existente!$\r$\n$\r$\n4.) Crear la etiqueta ${MB_LAB} en ($DestDisk) - ¡Se sobrescribirá la etiqueta existente!$\r$\n$\r$\n5.) Instalar ($DistroName) en ($DestDisk)$\r$\n$\r$\n¿Está absolutamente seguro que (Disco $DiskNum) es el dispositivo USB correcto?$\r$\n¡Verifique dos veces con Windows diskmgmt para asegurarse!$\r$\n$\r$\n¡Haga clic en SÍ para realizar estas acciones o en NO para cancelar!"
        LangString MBOX_WARNING03            ${RODRILANG} "ADVERTENCIA: ¡Haga una copia de seguridad de cualquier información que desee conservar antes de continuar! Todos los datos en la letra de unidad ($DestDisk) se eliminarán.$\r$\n$\r$\n${NAME} está listo para realizar las siguientes acciones:$\r$\n$\r$\n1.) Bloquear y desmontar letra de unidad ($DestDisk).$\r$\n$\r$\n2.) Formatear ($DestDisk) en NTFS - ¡Los datos en ($DestDisk) se eliminarán de forma irrecuperable!$\r$\n$\r$\n3.) Crear un MBR de Syslinux en ($DestDisk) - ¡Se sobrescribirá el MBR existente!$\r$\n$\r$\n4.) Crear la etiqueta ${MB_LAB} en ($DestDisk) - ¡Se sobrescribirá la etiqueta existente!$\r$\n$\r$\n5.) Instalar ($DistroName) en ($DestDisk)$\r$\n$\r$\n¿Está absolutamente seguro de que ($DestDisk) en (Disco $DiskNum) es su dispositivo USB?$\r$\n¡Verifique dos veces con Windows y diskmgmt para asegurarse!$\r$\n$\r$\n¡Haga clic en SÍ para realizar estas acciones o en NO para cancelar!"
        LangString MBOX_WARNING04            ${RODRILANG} "ADVERTENCIA: ¡Haga una copia de seguridad de cualquier información que desee conservar antes de continuar! Todos los datos en la letra de unidad ($DestDisk) se eliminarán.$\r$\n$\r$\n${NAME} está listo para realizar las siguientes acciones:$\r$\n$\r$\n1.) Bloquear y desmontar letra de unidad ($DestDisk).$\r$\n$\r$\n2.) Formatear ($DestDisk) en Fat32 - ¡Los datos en ($DestDisk) se eliminarán de forma irrecuperable!$\r$\n$\r$\n3.) Crear un MBR de Syslinux en ($DestDisk) - ¡Se sobrescribirá el MBR existente!$\r$\n$\r$\n4.) Crear la etiqueta ${MB_LAB} en ($DestDisk) - ¡Se sobrescribirá la etiqueta existente!$\r$\n$\r$\n5.) Instalar ($DistroName) en ($DestDisk)$\r$\n$\r$\n¿Está absolutamente seguro de que ($DestDisk) en (Disco $DiskNum) es su dispositivo USB?$\r$\n¡Verifique dos veces con Windows y diskmgmt para asegurarse!$\r$\n$\r$\n¡Haga clic en SÍ para realizar estas acciones o en NO para cancelar!"
        LangString MBOX_READYTOPERFORM       ${RODRILANG} "${NAME} está listo para realizar las siguientes acciones:$\r$\n$\r$\n1. Crear un MBR de Syslinux en ($DestDisk) - ¡Se sobrescribirá el MBR existente!$\r$\n$\r$\n2. Crear la etiqueta ${MB_LAB} en ($DestDisk) - ¡Se sobrescribirá la etiqueta existente!$\r$\n$\r$\n3. Instalar ($DistroName) en ($DestDisk)$\r$\n$\r$\n¿Está absolutamente seguro de que la letra de unidad ($DestDisk) en (Disco $DiskNum) es su dispositivo USB?$\r$\n¡Verifique dos veces con Windows para asegurarse!$\r$\n$\r$\n¡Haga clic en SÍ para realizar estas acciones en ($DestDisk) o en NO para volver!"

!undef RODRILANG