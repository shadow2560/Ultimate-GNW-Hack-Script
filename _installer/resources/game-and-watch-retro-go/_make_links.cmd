@echo off
mklink /D retro-go-stm32\nofrendo-go\components\nofrendo\cpu\build "%CD%\build" 1>NUL
mklink /D prosystem-go\Core\build "%CD%\build" 1>NUL
mklink /D ..\tmp "%CD%\..\msys2\tmp" 1>NUL