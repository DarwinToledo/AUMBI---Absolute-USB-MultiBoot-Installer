REM This file was created by Lance @ https://www.pendrivelinux.com for YUMI
@echo off
cls

 Set Distroname=ISONAMESLUG
 echo %Distroname%
 subst Z: "%~d0\multiboot\%Distroname%"
 echo mounted "%~d0\multiboot\%Distroname%" as Z:
 REM pause
exit