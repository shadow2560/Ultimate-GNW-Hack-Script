@echo off
mklink /D retro-go-stm32\nofrendo-go\components\nofrendo\cpu\build "%CD%\build" 1>NUL
mklink /D prosystem-go\Core\build "%CD%\build" 1>NUL
mklink /D %CD:~0,3%tmp "%~1\msys2\tmp" 1>NUL