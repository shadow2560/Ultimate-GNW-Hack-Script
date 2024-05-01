@echo off
IF NOT EXIST "external\*.*" (
	rmdir retro-go-stm32\nofrendo-go\components\nofrendo\cpu\build 1>NUL
	rmdir prosystem-go\Core\build 1>NUL
	rmdir %CD:~0,3%tmp 1>NUL
)