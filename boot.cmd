REM This file was created by Lance @ https://www.pendrivelinux.com for YUMI
@echo off
cls
 cd VHDDISK:\windows\system32
 bcdboot VHDDISK:\windows /s VHDDISK: /f ALL
exit