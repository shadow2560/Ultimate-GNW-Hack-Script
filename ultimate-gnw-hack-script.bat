::Script by Shadow256
@echo off
:: BatchGotAdmin, see https://sites.google.com/site/eneerge/scripts/batchgotadmin
::-------------------------------------
REM --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
	echo Requesting administrative privileges...
	goto UACPrompt
) else (
	goto gotAdmin
)

:UACPrompt
	echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
	echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
	"%temp%\getadmin.vbs"
	exit /B

:gotAdmin
	if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
	pushd "%CD%"
	cd /D "%~dp0"
::--------------------------------------

rem ------------ START OF ACTUAL SCRIPT ------------------------------------------------
chcp 65001 >nul
setlocal EnableDelayedExpansion

set base_script_path=%~dp0
set base_script_slash_path=%base_script_path:\=/%
set mingw64_path=%base_script_path%\msys2\mingw64.exe
set gnwmanager_path=%base_script_slash_path%_installer/python/tools/scripts/gnwmanager.exe
set path=%base_script_path%_installer\resources\openocd;%path%
set project_base_download_path=https://raw.githubusercontent.com/shadow2560/Ultimate-GNW-Hack-Script/refs/heads/main/

set system=zelda
set storage_meg=64
set adapter=stlink
set boot_type=1
set clean_build=1
set force_pyocd=1
set gnwmanager_debug=0
set proc_number=1
if not "%NUMBER_OF_PROCESSORS%"=="" set proc_number=%NUMBER_OF_PROCESSORS%

set retrogo_savestate=1
set retrogo_lng=1252
set retrogo_coverflows=0
set retrogo_screenshots=0
set retrogo_cheats=0
set retrogo_shared_hibernate_savestate=0
set retrogo_splash_screen=0
set retrogo_old_nes_emulator=0
set retrogo_old_gb_emulator=0
set retrogo_single_font=0
set retrogo_filesystem_size=10

set zelda3_lng=us
set zelda3_savestate=0

IF EXIST params.bat call params.bat

if "%language%"=="" (
	call :set_language
	goto:update_ressources
) else (
	set language_path=%base_script_path%languages\%language%.bat
	if NOT EXIST "!language_path!" (
		call :set_language
		goto:update_ressources
	)
)

goto:update_ressources

:set_language
cls
echo - Select script language -----------------------
echo.
echo Note that only the batch will be translated, not the compilation process.
echo.
echo Choose language:
echo 1. English
echo 2. French
echo.
set lng_choice=
set /p lng_choice=Make your choice: 
if "%lng_choice%"=="1" (
	set language=EN_us
) else if "%lng_choice%"=="2" (
	set language=FR_fr
) else (
	echo You must choose a language.
	pause
	goto:set_language
)
set language_path=%base_script_path%languages\%language%.bat
if NOT EXIST "%language_path%" (
	echo Language file doesn't exist, you probably need to re-download the program, the script will exit.
	pause
	exit
)
call :record_params
exit /b

:header
	CLS
	call "%language_path%" "set_title"
	call "%language_path%" "display_header"
exit /b

:update_ressources
set /a try_update_count=0
:update_ressources_start
set /a try_update_count=%try_update_count%+1
set update_error=0
if "%~0"=="%base_script_path%ultimate-gnw-hack-script-update.bat" (
	call "%language_path%" "script_ressources_downloading"
	if not exist "_installer\*.*" mkdir "_installer"
	if not exist "_installer\resources\*.*" mkdir "_installer\resources"
	if not exist "_installer\resources\game-and-watch-backup\*.*" mkdir "_installer\resources\game-and-watch-backup"
	if not exist "_installer\resources\game-and-watch-backup\backups\*.*" mkdir "_installer\resources\game-and-watch-backup\backups"
	if not exist "_installer\resources\game-and-watch-backup\interface\*.*" mkdir "_installer\resources\game-and-watch-backup\interface"
	if not exist "_installer\resources\game-and-watch-backup\openocd\*.*" mkdir "_installer\resources\game-and-watch-backup\openocd"
	if not exist "_installer\resources\game-and-watch-backup\target\*.*" mkdir "_installer\resources\game-and-watch-backup\target"
	if not exist "_installer\resources\game-and-watch-patch\*.*" mkdir "_installer\resources\game-and-watch-patch"
	if not exist "_installer\resources\game-and-watch-patch\interface\*.*" mkdir "_installer\resources\game-and-watch-patch\interface"
	if not exist "_installer\resources\game-and-watch-patch\openocd\*.*" mkdir "_installer\resources\game-and-watch-patch\openocd"
	if not exist "_installer\resources\game-and-watch-patch\target\*.*" mkdir "_installer\resources\game-and-watch-patch\target"
	if not exist "_installer\resources\game-and-watch-patch-old_method\*.*" mkdir "_installer\resources\game-and-watch-patch-old_method"
	if not exist "_installer\resources\game-and-watch-patch-old_method\interface\*.*" mkdir "_installer\resources\game-and-watch-patch-old_method\interface"
	if not exist "_installer\resources\game-and-watch-patch-old_method\openocd\*.*" mkdir "_installer\resources\game-and-watch-patch-old_method\openocd"
	if not exist "_installer\resources\game-and-watch-patch-old_method\target\*.*" mkdir "_installer\resources\game-and-watch-patch-old_method\target"
	if not exist "_installer\resources\game-and-watch-retro-go\*.*" mkdir "_installer\resources\game-and-watch-retro-go"
	if not exist "_installer\resources\game-and-watch-retro-go\interface\*.*" mkdir "_installer\resources\game-and-watch-retro-go\interface"
	if not exist "_installer\resources\game-and-watch-retro-go\scripts\*.*" mkdir "_installer\resources\game-and-watch-retro-go\scripts"
	if not exist "_installer\resources\game-and-watch-retro-go\target\*.*" mkdir "_installer\resources\game-and-watch-retro-go\target"
	if not exist "_installer\resources\game-and-watch-smw\*.*" mkdir "_installer\resources\game-and-watch-smw"
	if not exist "_installer\resources\game-and-watch-smw\interface\*.*" mkdir "_installer\resources\game-and-watch-smw\interface"
	if not exist "_installer\resources\game-and-watch-smw\smw\*.*" mkdir "_installer\resources\game-and-watch-smw\smw"
	if not exist "_installer\resources\game-and-watch-smw\smw\assets\*.*" mkdir "_installer\resources\game-and-watch-smw\smw\assets"
	if not exist "_installer\resources\game-and-watch-smw\target\*.*" mkdir "_installer\resources\game-and-watch-smw\target"
	if not exist "_installer\resources\game-and-watch-zelda3\*.*" mkdir "_installer\resources\game-and-watch-zelda3"
	if not exist "_installer\resources\game-and-watch-zelda3\interface\*.*" mkdir "_installer\resources\game-and-watch-zelda3\interface"
	if not exist "_installer\resources\game-and-watch-zelda3\target\*.*" mkdir "_installer\resources\game-and-watch-zelda3\target"
	if not exist "_installer\resources\game-and-watch-zelda3\zelda3\*.*" mkdir "_installer\resources\game-and-watch-zelda3\zelda3"
	if not exist "_installer\resources\game-and-watch-zelda3\zelda3\tables\*.*" mkdir "_installer\resources\game-and-watch-zelda3\zelda3\tables"
	if not exist "_installer\resources\openocd\*.*" mkdir "_installer\resources\openocd"
	if not exist "languages\*.*" mkdir "languages"

	"_installer\wget.exe" -q %project_base_download_path%_installer/wget.exe -O "_installer\wget_temp.exe"
	IF !errorlevel! NEQ 0 (
		set update_error=1 & goto:pass_update
	) else (
		copy /B /V /Y "_installer\wget_temp.exe" "_installer\wget.exe" >nul
		del /q "_installer\wget_temp.exe" >nul
	)

	"_installer\wget.exe" -q %project_base_download_path%languages/FR_fr.bat -O "languages\FR_fr.bat"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%languages/EN_us.bat -O "languages\EN_us.bat"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update

	"_installer\wget.exe" -q %project_base_download_path%LICENSE -O "LICENSE"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%README.md -O "README.md"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update

	"_installer\wget.exe" -q %project_base_download_path%_installer/msys2_install.sh -O "_installer\msys2_install.sh"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/pull_repos.sh -O "_installer\pull_repos.sh"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update

	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/libusb-1.0.dll -O "_installer\resources\libusb-1.0.dll"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update

	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-backup/mem_helper.tcl -O "_installer\resources\game-and-watch-backup\mem_helper.tcl"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-backup/unlock_gnw.sh -O "_installer\resources\game-and-watch-backup\unlock_gnw.sh"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-backup/backups/put_GnW_dumps_backups_here.txt -O "_installer\resources\game-and-watch-backup\backups\put_GnW_dumps_backups_here.txt"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-backup/interface/cmsis-dap.cfg -O "_installer\resources\game-and-watch-backup\interface\cmsis-dap.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-backup/interface/stlink.cfg -O "_installer\resources\game-and-watch-backup\interface\stlink.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-backup/openocd/interface_pico.cfg -O "_installer\resources\game-and-watch-backup\openocd\interface_pico.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-backup/target/stm32h7x.cfg -O "_installer\resources\game-and-watch-backup\target\stm32h7x.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-backup/target/stm32h7x_dual_bank.cfg -O "_installer\resources\game-and-watch-backup\target\stm32h7x_dual_bank.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-backup/target/swj-dp.tcl -O "_installer\resources\game-and-watch-backup\target\swj-dp.tcl"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update

	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-patch/build.sh -O "_installer\resources\game-and-watch-patch\build.sh"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-patch/mem_helper.tcl -O "_installer\resources\game-and-watch-patch\mem_helper.tcl"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-patch/put_GnW_dumps_backups_here.txt -O "_installer\resources\game-and-watch-patch\put_GnW_dumps_backups_here.txt"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-patch/interface/cmsis-dap.cfg -O "_installer\resources\game-and-watch-patch\interface\cmsis-dap.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-patch/interface/stlink.cfg -O "_installer\resources\game-and-watch-patch\interface\stlink.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-patch/openocd/interface_pico.cfg -O "_installer\resources\game-and-watch-patch\openocd\interface_pico.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-patch/target/stm32h7x.cfg -O "_installer\resources\game-and-watch-patch\target\stm32h7x.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-patch/target/swj-dp.tcl -O "_installer\resources\game-and-watch-patch\target\swj-dp.tcl"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update

	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-patch-old_method/build.sh -O "_installer\resources\game-and-watch-patch-old_method\build.sh"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-patch-old_method/mem_helper.tcl -O "_installer\resources\game-and-watch-patch-old_method\mem_helper.tcl"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-patch-old_method/put_GnW_dumps_backups_here.txt -O "_installer\resources\game-and-watch-patch-old_method\put_GnW_dumps_backups_here.txt"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-patch-old_method/interface/cmsis-dap.cfg -O "_installer\resources\game-and-watch-patch-old_method\interface\cmsis-dap.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-patch-old_method/interface/stlink.cfg -O "_installer\resources\game-and-watch-patch-old_method\interface\stlink.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-patch-old_method/openocd/interface_pico.cfg -O "_installer\resources\game-and-watch-patch-old_method\openocd\interface_pico.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-patch-old_method/target/stm32h7x.cfg -O "_installer\resources\game-and-watch-patch-old_method\target\stm32h7x.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-patch-old_method/target/swj-dp.tcl -O "_installer\resources\game-and-watch-patch-old_method\target\swj-dp.tcl"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update

	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-retro-go/mem_helper.tcl -O "_installer\resources\game-and-watch-retro-go\mem_helper.tcl"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-retro-go/build.sh -O "_installer\resources\game-and-watch-retro-go\build.sh"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-retro-go/_make_links.cmd -O "_installer\resources\game-and-watch-retro-go\_make_links.cmd"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-retro-go/_remove_links.cmd -O "_installer\resources\game-and-watch-retro-go\_remove_links.cmd"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-retro-go/interface/cmsis-dap.cfg -O "_installer\resources\game-and-watch-retro-go\interface\cmsis-dap.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-retro-go/interface/stlink.cfg -O "_installer\resources\game-and-watch-retro-go\interface\stlink.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-retro-go/scripts/interface_pico.cfg -O "_installer\resources\game-and-watch-retro-go\scripts\interface_pico.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-retro-go/target/stm32h7x.cfg -O "_installer\resources\game-and-watch-retro-go\target\stm32h7x.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-retro-go/target/stm32h7x_dual_bank.cfg -O "_installer\resources\game-and-watch-retro-go\target\stm32h7x_dual_bank.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-retro-go/target/swj-dp.tcl -O "_installer\resources\game-and-watch-retro-go\target\swj-dp.tcl"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update

	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-smw/mem_helper.tcl -O "_installer\resources\game-and-watch-smw\mem_helper.tcl"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-smw/build.sh -O "_installer\resources\game-and-watch-smw\build.sh"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-smw/interface/cmsis-dap.cfg -O "_installer\resources\game-and-watch-smw\interface\cmsis-dap.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-smw/interface/stlink.cfg -O "_installer\resources\game-and-watch-smw\interface\stlink.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-smw/smw/assets/put_SMW_sfc_roms_here.txt -O "_installer\resources\game-and-watch-smw\smw\assets\put_SMW_sfc_roms_here.txt"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-smw/target/stm32h7x.cfg -O "_installer\resources\game-and-watch-smw\target\stm32h7x.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-smw/target/stm32h7x_dual_bank.cfg -O "_installer\resources\game-and-watch-smw\target\stm32h7x_dual_bank.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-smw/target/swj-dp.tcl -O "_installer\resources\game-and-watch-smw\target\swj-dp.tcl"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update

	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-zelda3/mem_helper.tcl -O "_installer\resources\game-and-watch-zelda3\mem_helper.tcl"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-zelda3/build.sh -O "_installer\resources\game-and-watch-zelda3\build.sh"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-zelda3/interface/cmsis-dap.cfg -O "_installer\resources\game-and-watch-zelda3\interface\cmsis-dap.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-zelda3/interface/stlink.cfg -O "_installer\resources\game-and-watch-zelda3\interface\stlink.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-zelda3/target/stm32h7x.cfg -O "_installer\resources\game-and-watch-zelda3\target\stm32h7x.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-zelda3/target/stm32h7x_dual_bank.cfg -O "_installer\resources\game-and-watch-zelda3\target\stm32h7x_dual_bank.cfg"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-zelda3/target/swj-dp.tcl -O "_installer\resources\game-and-watch-zelda3\target\swj-dp.tcl"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/game-and-watch-zelda3/zelda3/tables/put_zelda3_sfc_roms_here.txt -O "_installer\resources\game-and-watch-zelda3\zelda3\tables\put_zelda3_sfc_roms_here.txt"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update

	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/openocd/libcapstone.dll -O "_installer\resources\openocd\libcapstone.dll"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/openocd/libftdi1.dll -O "_installer\resources\openocd\libftdi1.dll"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/openocd/libhidapi-0.dll -O "_installer\resources\openocd\libhidapi-0.dll"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/openocd/libjaylink-0.dll -O "_installer\resources\openocd\libjaylink-0.dll"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/openocd/libusb-1.0.dll -O "_installer\resources\openocd\libusb-1.0.dll"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update
	"_installer\wget.exe" -q %project_base_download_path%_installer/resources/openocd/openocd.exe -O "_installer\resources\openocd\openocd.exe"
	IF !errorlevel! NEQ 0 set update_error=1 & goto:pass_update

)
:pass_update
if "%~0"=="%base_script_path%ultimate-gnw-hack-script-update.bat" (
	if "%update_error%"=="1" (
		if %try_update_count% LSS 4 (
			call "%language_path%" "main_script_downloading_error_with_retry"
			pause
			goto:update_ressources_start
		) else (
			call "%language_path%" "main_script_downloading_error"
			pause
			exit
		)
	)
	call "%language_path%" "main_script_downloading_success"
	pause
	copy /V /Y ultimate-gnw-hack-script-update.bat ultimate-gnw-hack-script.bat >nul
	start /i "" "%windir%\system32\cmd.exe" /c call "ultimate-gnw-hack-script.bat"
	exit
) else (
	if not "%~0"=="%base_script_path%ultimate-gnw-hack-script-update.bat" (
		if exist "ultimate-gnw-hack-script-update.bat" del /q "ultimate-gnw-hack-script-update.bat" >nul
	)
)

:main
	call :header
	set val_m=0
	SET IN_M=
	call "%language_path%" "display_main_menu"
	IF /I '%IN_M%'=='1' (
		set val_m=1
		call "%language_path%" "msys2_downloading"
		"_installer\wget.exe" -q https://github.com/msys2/msys2-installer/releases/download/2024-01-13/msys2-x86_64-20240113.exe -O "_installer\msys2_installer.exe"
		IF %errorlevel% EQU 0 (
			.\_installer\msys2_installer.exe -t "%base_script_path%msys2" --am --al -c -g ifw.*=true in
		) else (
			call "%language_path%" "msys2_downloading_error"
			pause
			goto main
		)
		IF %errorlevel% EQU 0 (
			del /q "_installer\msys2_installer.exe" >nul
			del /q InstallationLog.txt >nul
			call "%language_path%" "msys2_install_success"
			pause
			goto main
		) else (
			del /q "_installer\msys2_installer.exe" >nul
			del /q InstallationLog.txt >nul
			call "%language_path%" "msys2_install_error"
			pause
			goto main
		)
	)
	IF /I '%IN_M%'=='2' set val_m=1 & call :install_env
	IF /I '%IN_M%'=='3' set val_m=1 & call :run_mingw64 _installer/ , pull_repos.sh
	IF /I '%IN_M%'=='4' set val_m=1 & call :backup_menu
	IF /I '%IN_M%'=='5' set val_m=1 & call :run_patch
	IF /I '%IN_M%'=='6' set val_m=1 & call :run_patch_old
	IF /I '%IN_M%'=='7' set val_m=1 & call :run_patch_sd_mod
	IF /I '%IN_M%'=='8' set val_m=1 & call :run_patch_sd_mod_gnwpatch
	IF /I '%IN_M%'=='9' set val_m=1 & call :run_retrogo
	IF /I '%IN_M%'=='10' set val_m=1 & call :run_zelda3
	IF /I '%IN_M%'=='11' set val_m=1 & call :run_smw
	IF /I '%IN_M%'=='0' set val_m=1 & start "" https://github.com/shadow2560/Ultimate-GNW-Hack-Script
	IF /I '%IN_M%'=='L' set val_m=1 & call :set_language
	IF /I '%IN_M%'=='U' set val_m=1 & call :update_script
	IF /I '%IN_M%'=='S' set val_m=1 & call :settings & call :record_params
	IF /I '%IN_M%'=='R' set val_m=1 & call :retrogo_settings & call :record_params
	IF /I '%IN_M%'=='Z' set val_m=1 & call :zelda3_settings & call :record_params
	IF /I '%IN_M%'=='D' set val_m=1 & IF EXIST params.bat (del /q params.bat & exit) else (echo No need to restore params. & pause)
	IF /I '%IN_M%'=='G' set val_m=1 & call :donate_menu
	IF /I '%IN_M%'=='Q' set val_m=1 & call :record_params & goto eof
	IF /I '%IN_M%'=='' set val_m=1
	if %val_m%==0 call :invalid_input 1 11 "Q, L, G, D, S, R, Z."
goto main

:update_script
	call "%language_path%" "main_script_downloading"
	"_installer\wget.exe" %project_base_download_path%ultimate-gnw-hack-script.bat -O "ultimate-gnw-hack-script-update.bat"
	IF %errorlevel% EQU 0 (
		start /i "" "%windir%\system32\cmd.exe" /c call "ultimate-gnw-hack-script-update.bat"
		exit
	) else (
		call "%language_path%" "main_script_downloading_error"
		pause
		exit /b
	)
pause
exit

:donate_menu
	cls
	set action_choice=
	call "%language_path%" "display_donate_menu"
	IF "%action_choice%"=="1" (
		start https://www.paypal.me/shadow256
		goto:donate_menu
	)
	IF "%action_choice%"=="2" (
		start https://www.paypal.com/donate/?hosted_button_id=XZXKWXNX5V3KN 
		goto:donate_menu
	)
	if /i "%action_choice%"=="Q" exit /b
	call :invalid_input 1 2 "Q." & goto:donate_menu

:backup_menu
	call :header
	set val_b=0
	SET IN_B=
	call "%language_path%" "display_backup_menu"
	IF /I '%IN_B%'=='1' set val_b=1 & call :run_mingw64 ./game-and-watch-backup/, "1_sanity_check.sh %adapter% %system%"
	IF /I '%IN_B%'=='2' set val_b=1 & call :run_mingw64 ./game-and-watch-backup/, "2_backup_flash.sh %adapter% %system%"
	IF /I '%IN_B%'=='3' set val_b=1 & call :run_mingw64 ./game-and-watch-backup/, "3_backup_internal_flash.sh %adapter% %system%"
	IF /I '%IN_B%'=='4' set val_b=1 & call :run_mingw64 ./game-and-watch-backup/, "4_unlock_device.sh %adapter% %system%"
	IF /I '%IN_B%'=='5' set val_b=1 & call :run_mingw64 ./game-and-watch-backup/, "5_restore.sh %adapter% %system%"
	IF /I '%IN_B%'=='6' set val_b=1 & call :run_mingw64 ./game-and-watch-backup/, "unlock_gnw.sh "
	IF /I '%IN_B%'=='S' set val_b=1 & call :settings & call :record_params
	IF /I '%IN_B%'=='Q' exit /b
	IF /I '%IN_B%'=='' set val_b=1
	if %val_b%==0	call :invalid_input 1 6 "Q, S."
goto backup_menu

:settings
	call :header
	set val_s=0
	SET IN_S=
	call "%language_path%" "display_general_settings_menu"
	IF /I '%IN_S%'=='1' set val_s=1 & call :switch_system
	IF /I '%IN_S%'=='2' set val_s=1 & call :switch_adapter
	IF /I '%IN_S%'=='3' set val_s=1 & call :set_storage
	IF /I '%IN_S%'=='4' set val_s=1 & call :toggle_TB
	IF /I '%IN_S%'=='5' set val_s=1 & call :toggle_CB
	IF /I '%IN_S%'=='6' set val_s=1 & call :set_proc_number
	IF /I '%IN_S%'=='7' set val_s=1 & call :toggle_pyocd
	IF /I '%IN_S%'=='8' set val_s=1 & call :toggle_gnwmanager_debug
	IF /I '%IN_S%'=='Q' exit /b
	if %val_s%==0	call :invalid_input 1 8 "Q."
	goto settings

:toggle_TB
	if %boot_type%==0 (
		set boot_type=1
	) else if %boot_type%==1 (
		set boot_type=2
	) else if %boot_type%==2 (
		set boot_type=3
	) else (
		set boot_type=0
	)
exit /b

:toggle_CB
	if %clean_build%==1 (
		set clean_build=0
	) else (
		set clean_build=1
	)
exit /b

:toggle_pyocd
	if %force_pyocd%==1 (
		set force_pyocd=0
	) else (
		set force_pyocd=1
	)
exit /b

:toggle_gnwmanager_debug
	if %gnwmanager_debug%==1 (
		set gnwmanager_debug=0
	) else (
		set gnwmanager_debug=1
	)
exit /b

:switch_system
	if %system%==zelda (
		set system=mario
	) else (
		set system=zelda
	)
exit /b

:switch_adapter
	if %adapter%==pico (
		set adapter=stlink
	) else (
		set adapter=pico
	)
exit /b

:set_storage
	call :header
	SET VALUE=
	call "%language_path%" "display_storage_setting"
	set true=0
	IF /I '%VALUE%'=='4' set true=1
	IF /I '%VALUE%'=='8' set true=1
	IF /I '%VALUE%'=='16' set true=1
	IF /I '%VALUE%'=='32' set true=1
	IF /I '%VALUE%'=='64' set true=1
	IF /I '%VALUE%'=='128' set true=1
	IF /I '%VALUE%'=='256' set true=1
	IF /I '%VALUE%'=='512' set true=1
	IF /I '%VALUE%'=='' exit /b
	IF /I %true%==1 set "storage_meg=%VALUE%" & exit /b
	call :invalid_input 4 512
goto set_storage

:set_proc_number
	call :header
	SET VALUE=
	call "%language_path%" "display_proc_number_setting"
	IF /I '%VALUE%'=='' exit /b
	call :strlen nb "%VALUE%"
	set i=0
	:check_chars_proc_value
	IF %i% NEQ %nb% (
		set check_chars=0
		FOR %%z in (0 1 2 3 4 5 6 7 8 9) do (
			IF "!VALUE:~%i%,1!"=="%%z" (
				set /a i+=1
				set check_chars=1
				goto :check_chars_proc_value
			)
		)
		IF "!check_chars!"=="0" (
		call "%language_path%" "proc_number_value_char_error"
		pause
		goto :set_proc_number
		)
	)
	IF /I %VALUE% LSS 1 set proc_number=1 & exit /b
	IF NOT "%NUMBER_OF_PROCESSORS%"=="" (
		IF /I %VALUE% GTR %NUMBER_OF_PROCESSORS% set proc_number=%NUMBER_OF_PROCESSORS% & exit /b
	)
	set proc_number=%VALUE%
exit /b

:retrogo_settings
	call :header
	set val_r=0
	SET IN_R=
	call "%language_path%" "display_retrogo_settings_menu"
	IF /I '%IN_R%'=='1' set val_r=1 & call :toggle_retrogo_savestate
	IF /I '%IN_R%'=='2' set val_r=1 & call :set_retrogo_lng
	IF /I '%IN_R%'=='3' set val_r=1 & call :toggle_retrogo_coverflows
	IF /I '%IN_R%'=='4' set val_r=1 & call :toggle_retrogo_screenshots
	IF /I '%IN_R%'=='5' set val_r=1 & call :toggle_retrogo_cheats
	IF /I '%IN_R%'=='6' set val_r=1 & call :toggle_retrogo_shared_hibernate_savestate
	IF /I '%IN_R%'=='7' set val_r=1 & call :toggle_retrogo_splash_screen
	IF /I '%IN_R%'=='8' set val_r=1 & call :toggle_retrogo_old_nes_emulator
	IF /I '%IN_R%'=='9' set val_r=1 & call :toggle_retrogo_old_gb_emulator
	IF /I '%IN_R%'=='10' set val_r=1 & call :toggle_retrogo_single_font
	IF /I '%IN_R%'=='11' set val_r=1 & call :set_retrogo_filesystem_size
	IF /I '%IN_R%'=='Q' exit /b
	if %val_r%==0	call :invalid_input 1 11 "Q."
	goto retrogo_settings

:set_retrogo_filesystem_size
	call :header
	SET VALUE=
	call "%language_path%" "display_retrogo_filesystem_size_setting"
	IF /I '%VALUE%'=='' exit /b
	call :strlen nb "%VALUE%"
	set i=0
	:check_chars_rfs_value
	IF %i% NEQ %nb% (
		set check_chars=0
		FOR %%z in (0 1 2 3 4 5 6 7 8 9) do (
			IF "!VALUE:~%i%,1!"=="%%z" (
				set /a i+=1
				set check_chars=1
				goto :check_chars_rfs_value
			)
		)
		IF "!check_chars!"=="0" (
		call "%language_path%" "retrogo_filesystem_value_char_error"
		pause
		goto :set_retrogo_filesystem_size
		)
	)
	IF /I %VALUE% LSS 0 set retrogo_filesystem_size=0 & exit /b
	IF /I %VALUE% GTR 99 set retrogo_filesystem_size=99 & exit /b
	set retrogo_filesystem_size=%VALUE%
exit /b

:toggle_retrogo_old_gb_emulator
	if %retrogo_old_gb_emulator%==1 (
		set retrogo_old_gb_emulator=0
	) else (
		set retrogo_old_gb_emulator=1
	)
exit /b

:toggle_retrogo_single_font
	if %retrogo_single_font%==1 (
		set retrogo_single_font=0
	) else (
		set retrogo_single_font=1
	)
exit /b

:toggle_retrogo_savestate
	if %retrogo_savestate%==1 (
		set retrogo_savestate=0
	) else (
		set retrogo_savestate=1
	)
exit /b

:set_retrogo_lng
	call :header
	SET VALUE=
	call "%language_path%" "display_retrogo_language_param"
	IF /I '%VALUE%'=='1' set retrogo_lng=1252 & exit /b
	IF /I '%VALUE%'=='2' set retrogo_lng=12523 & exit /b
	IF /I '%VALUE%'=='3' set retrogo_lng=12525 & exit /b
	IF /I '%VALUE%'=='4' set retrogo_lng=12524 & exit /b
	IF /I '%VALUE%'=='5' set retrogo_lng=12522 & exit /b
	IF /I '%VALUE%'=='6' set retrogo_lng=12511 & exit /b
	IF /I '%VALUE%'=='7' set retrogo_lng=12521 & exit /b
	IF /I '%VALUE%'=='8' set retrogo_lng=932 & exit /b
	IF /I '%VALUE%'=='9' set retrogo_lng=936 & exit /b
	IF /I '%VALUE%'=='10' set retrogo_lng=950 & exit /b
	IF /I '%VALUE%'=='11' set retrogo_lng=949 & exit /b
	IF /I '%VALUE%'=='Q' exit /b
	call :invalid_input 1 11 "Q."
goto set_retrogo_lng

:toggle_retrogo_coverflows
	if %retrogo_coverflows%==1 (
		set retrogo_coverflows=0
	) else (
		set retrogo_coverflows=1
	)
exit /b

:toggle_retrogo_screenshots
	if %retrogo_screenshots%==1 (
		set retrogo_screenshots=0
	) else (
		set retrogo_screenshots=1
	)
exit /b

:toggle_retrogo_cheats
	if %retrogo_cheats%==1 (
		set retrogo_cheats=0
	) else (
		set retrogo_cheats=1
	)
exit /b

:toggle_retrogo_shared_hibernate_savestate
	if %retrogo_shared_hibernate_savestate%==1 (
		set retrogo_shared_hibernate_savestate=0
	) else (
		set retrogo_shared_hibernate_savestate=1
	)
exit /b

:toggle_retrogo_splash_screen
	if %retrogo_splash_screen%==1 (
		set retrogo_splash_screen=0
	) else (
		set retrogo_splash_screen=1
	)
exit /b

:toggle_retrogo_old_nes_emulator
	if %retrogo_old_nes_emulator%==1 (
		set retrogo_old_nes_emulator=0
	) else (
		set retrogo_old_nes_emulator=1
	)
exit /b

:zelda3_settings
	call :header
	set val_z=0
	SET IN_Z=
	call "%language_path%" "display_zelda3_settings_menu"
	IF /I '%IN_Z%'=='1' set val_z=1 & call :set_zelda3_lng
	IF /I '%IN_Z%'=='2' set val_z=1 & call :toggle_zelda3_savestate
	IF /I '%IN_Z%'=='Q' exit /b
	if %val_z%==0	call :invalid_input 1 2 "Q."
	goto zelda3_settings

:set_zelda3_lng
	call :header
	SET zelda3_lng=us
	call "%language_path%" "display_zelda3_language_param"
exit /b

:toggle_zelda3_savestate
	if %zelda3_savestate%==1 (
		set zelda3_savestate=0
	) else (
		set zelda3_savestate=1
	)
exit /b

:install_env
	call :run_mingw64 _installer/, msys2_install.sh
	if exist _installer\run_again.txt (
		goto install_env
	)
exit /b

:run_retrogo
	cd game-and-watch-retro-go
	IF EXIST external\*.* (
		call :reset_pyocd
	)
	if %errorlevel% NEQ 0 cd .. & exit /b
	call _make_links.cmd "%base_script_path%"
	cd ..
	call :run_mingw64 ./game-and-watch-retro-go/, "build.sh %adapter% %system% %storage_meg% %boot_type% %clean_build% %proc_number% %retrogo_savestate% %retrogo_lng% %retrogo_coverflows% %retrogo_screenshots% %retrogo_cheats% %retrogo_shared_hibernate_savestate% %retrogo_splash_screen% %retrogo_old_nes_emulator% %retrogo_old_gb_emulator% %retrogo_single_font% %retrogo_filesystem_size% %force_pyocd% %gnwmanager_path%" %gnwmanager_debug%
	cd game-and-watch-retro-go
	call _remove_links.cmd
	cd ..
exit /b

:run_zelda3
	if /i NOT "%zelda3_lng%" == "us" (
		if  exist .\game-and-watch-zelda3\zelda3\tables\zelda3_%zelda3_lng%.sfc (
			if  exist .\game-and-watch-zelda3\zelda3\tables\zelda3.sfc (
				call :run_mingw64 ./game-and-watch-zelda3/, "build.sh %adapter% %system% %storage_meg% %boot_type% %clean_build% %proc_number% %zelda3_lng% %zelda3_savestate%"
				goto:eof
			)
		)
	) else (
		if  exist .\game-and-watch-zelda3\zelda3\tables\zelda3.sfc (
			call :run_mingw64 ./game-and-watch-zelda3/, "build.sh %adapter% %system% %storage_meg% %boot_type% %clean_build% %proc_number% %zelda3_lng% %zelda3_savestate%"
			goto:eof
		)
	)
)
	if /i NOT "%zelda3_lng%" == "us" (
		call "%language_path%" "zelda3_file_missing_not_us_version"
	) else (
		call "%language_path%" "zelda3_file_missing_us_version"
	)
	pause
exit /b

:run_smw
	if  exist .\game-and-watch-smw\smw\assets\smw.sfc (
		call :run_mingw64 ./game-and-watch-smw/, "build.sh %adapter% %system% %storage_meg% %boot_type% %clean_build% %proc_number% %zelda3_savestate%"
		goto:eof
	)
	call "%language_path%" "smw_missing_file"
	pause
exit /b

:run_patch
	if not exist "%gnwmanager_path%" (
		call "%language_path%" "gnwmanager_not_installed_error"
		pause
		exit /b
	)
	if %boot_type%==0 (
		call "%language_path%" "single_boot_not_authorized"
		pause
		exit /b
	)
	if %boot_type%==2 (
		call "%language_path%" "dual_boot_2_not_authorized"
		pause
		exit /b
	)
	set run_p=1
	if NOT exist .\game-and-watch-patch\flash_backup_%system%.bin (
		if exist .\game-and-watch-patch-old_method\flash_backup_%system%.bin ( copy .\game-and-watch-patch-old_method\flash_backup_%system%.bin .\game-and-watch-patch\ 1>NUL)
	)
	if NOT exist .\game-and-watch-patch\flash_backup_%system%.bin (
		if exist .\game-and-watch-backup\backups\flash_backup_%system%.bin ( copy .\game-and-watch-backup\backups\flash_backup_%system%.bin .\game-and-watch-patch\ 1>NUL ) else (set run_p=0)
	)
	if NOT exist .\game-and-watch-patch\internal_flash_backup_%system%.bin (
		if exist .\game-and-watch-patch-old_method\internal_flash_backup_%system%.bin ( copy .\game-and-watch-patch-old_method\internal_flash_backup_%system%.bin .\game-and-watch-patch\ 1>NUL)
	)
	if NOT exist .\game-and-watch-patch\internal_flash_backup_%system%.bin (
		if exist .\game-and-watch-backup\backups\internal_flash_backup_%system%.bin ( copy .\game-and-watch-backup\backups\internal_flash_backup_%system%.bin .\game-and-watch-patch\ 1>NUL ) else (set run_p=0)
	)
	if %run_p%==1 (
		call :reset_pyocd
	)
	if %errorlevel% NEQ 0 (
		exit /b
	)
	if %run_p%==1 (
		call :run_mingw64 ./game-and-watch-patch/, "build.sh %adapter% %system% %storage_meg% %boot_type% %clean_build% %force_pyocd% %gnwmanager_path%" %gnwmanager_debug%
	) else (
		call "%language_path%" "backups_not_founded_error"
		pause
	)
exit /b

:run_patch_sd_mod
	if not exist "%gnwmanager_path%" (
		call "%language_path%" "gnwmanager_not_installed_error"
		pause
		exit /b
	)
	if %boot_type%==2 (
		call "%language_path%" "dual_boot_2_not_authorized"
		pause
		exit /b
	)
	if %boot_type%==3 (
		call "%language_path%" "tripple_boot_not_authorized"
		pause
		exit /b
	)
	set /a temp_storage_meg=%storage_meg%
	if %temp_storage_meg% lss 64 (
		call "%language_path%" "need_64_mb_storage_error"
		pause
		exit /b
	)
	if %boot_type%==1 (
		set sd_patch_backup=
		set sd_patch_internal_backup=
		if exist .\game-and-watch-backup\backups\flash_backup_%system%.bin (
			set sd_patch_backup=.\game-and-watch-backup\backups\flash_backup_%system%.bin
			if exist .\game-and-watch-backup\backups\internal_flash_backup_%system%.bin (
				set sd_patch_internal_backup=.\game-and-watch-backup\backups\internal_flash_backup_%system%.bin
				goto:flash_sd_mod
			)
		)
		if exist .\game-and-watch-patch\flash_backup_%system%.bin (
			set sd_patch_backup=.\game-and-watch-patch\flash_backup_%system%.bin
			if exist .\game-and-watch-patch\internal_flash_backup_%system%.bin (
				set sd_patch_internal_backup=.\game-and-watch-patch\internal_flash_backup_%system%.bin
				goto:flash_sd_mod
			)
		)
		if exist .\game-and-watch-patch-old-method\flash_backup_%system%.bin (
			set sd_patch_backup=.\game-and-watch-patch-old-method\flash_backup_%system%.bin
			if exist .\game-and-watch-patch-old-method\internal_flash_backup_%system%.bin (
				set sd_patch_internal_backup=.\game-and-watch-patch-old-method\internal_flash_backup_%system%.bin
				goto:flash_sd_mod
			)
		)
	) else (
		goto:flash_sd_mod
	)
	call "%language_path%" "backups_not_founded_error"
	pause
	exit /b
	:flash_sd_mod
	if %boot_type%==1 (
		"%gnwmanager_path%" flash-patch %system% %sd_patch_internal_backup% %sd_patch_backup% --bootloader
	) else if %boot_type%==0 (
		"%gnwmanager_path%" flash-bootloader bank1
	)
	pause
exit /b

:run_patch_sd_mod_gnwpatch
	if not exist "%gnwmanager_path%" (
		call "%language_path%" "gnwmanager_not_installed_error"
		pause
		exit /b
	)
	if %boot_type%==2 (
		call "%language_path%" "dual_boot_2_not_authorized"
		pause
		exit /b
	)
	if %boot_type%==3 (
		call "%language_path%" "tripple_boot_not_authorized"
		pause
		exit /b
	)
	if %boot_type%==0 (
		call "%language_path%" "single_boot_not_authorized"
		pause
		exit /b
	)
	set /a temp_storage_meg=%storage_meg%
	if %temp_storage_meg% lss 64 (
		call "%language_path%" "need_64_mb_storage_error"
		pause
		exit /b
	)
	set run_p=1
	if NOT exist .\game-and-watch-patch\flash_backup_%system%.bin (
		if exist .\game-and-watch-patch-old_method\flash_backup_%system%.bin ( copy .\game-and-watch-patch-old_method\flash_backup_%system%.bin .\game-and-watch-patch\ 1>NUL)
	)
	if NOT exist .\game-and-watch-patch\flash_backup_%system%.bin (
		if exist .\game-and-watch-backup\backups\flash_backup_%system%.bin ( copy .\game-and-watch-backup\backups\flash_backup_%system%.bin .\game-and-watch-patch\ 1>NUL ) else (set run_p=0)
	)
	if NOT exist .\game-and-watch-patch\internal_flash_backup_%system%.bin (
		if exist .\game-and-watch-patch-old_method\internal_flash_backup_%system%.bin ( copy .\game-and-watch-patch-old_method\internal_flash_backup_%system%.bin .\game-and-watch-patch\ 1>NUL)
	)
	if NOT exist .\game-and-watch-patch\internal_flash_backup_%system%.bin (
		if exist .\game-and-watch-backup\backups\internal_flash_backup_%system%.bin ( copy .\game-and-watch-backup\backups\internal_flash_backup_%system%.bin .\game-and-watch-patch\ 1>NUL ) else (set run_p=0)
	)
	if %run_p%==1 (
		call :reset_pyocd
	)
	if %errorlevel% NEQ 0 (
		exit /b
	)
	if %run_p%==1 (
		call :run_mingw64 ./game-and-watch-patch/, "build.sh %adapter% %system% %storage_meg% %boot_type% %clean_build% %force_pyocd% %gnwmanager_path%" %gnwmanager_debug% --sd-bootloader
	) else (
		call "%language_path%" "backups_not_founded_error"
		pause
	)
exit /b

:run_patch_old
	if %boot_type%==0 (
		call "%language_path%" "single_boot_not_authorized"
		pause
		exit /b
	)
	if %boot_type%==2 (
		call "%language_path%" "dual_boot_2_not_authorized"
		pause
		exit /b
	)
	set run_p=1
	if NOT exist .\game-and-watch-patch-old_method\flash_backup_%system%.bin (
		if exist .\game-and-watch-patch\flash_backup_%system%.bin ( copy .\game-and-watch-patch\flash_backup_%system%.bin .\game-and-watch-patch-old_method\ 1>NUL)
	)
	if NOT exist .\game-and-watch-patch-old_method\flash_backup_%system%.bin (
		if exist .\game-and-watch-backup\backups\flash_backup_%system%.bin ( copy .\game-and-watch-backup\backups\flash_backup_%system%.bin .\game-and-watch-patch-old_method\ 1>NUL ) else (set run_p=0)
	)
	if NOT exist .\game-and-watch-patch-old_method\internal_flash_backup_%system%.bin (
		if exist .\game-and-watch-patch\internal_flash_backup_%system%.bin ( copy .\game-and-watch-patch\internal_flash_backup_%system%.bin .\game-and-watch-patch-old_method\ 1>NUL)
	)
	if NOT exist .\game-and-watch-patch-old_method\internal_flash_backup_%system%.bin (
		if exist .\game-and-watch-backup\backups\internal_flash_backup_%system%.bin ( copy .\game-and-watch-backup\backups\internal_flash_backup_%system%.bin .\game-and-watch-patch-old_method\ 1>NUL ) else (set run_p=0)
	)
	if %run_p%==1 (
		call :run_mingw64 ./game-and-watch-patch-old_method/, "build.sh %adapter% %system% %storage_meg% %boot_type% %clean_build%"
	) else (
		call "%language_path%" "backups_not_founded_error"
		pause
	)
exit /b

:run_mingw64
	mkdir _tmp
	echo cd %~1 > _tmp\launch.sh
	echo export GCC_PATH="%base_script_slash_path%gcc-arm-none-eabi-10.3-2021.10/bin/" >> _tmp\launch.sh
	::echo export GCC_PATH="%base_script_slash_path%arm-gnu-toolchain-13.2.Rel1-mingw-w64-i686-arm-none-eabi/bin/" >> _tmp\launch.sh
	::echo export GCC_PATH="%base_script_slash_path%msys2/mingw64/bin/" >> _tmp\launch.sh
	echo ./%~2 >> _tmp\launch.sh
	call "%language_path%" "pause_for_msys_scripts"
	"%mingw64_path%" ./_tmp/launch.sh
	call :wait "mintty.exe"
	rd /s /q _tmp
exit /b

:invalid_input
	CLS
	call "%language_path%" "invalid_input_start"
	echo                [%~1-%~2] 
	if not "%~3"=="" (
		call "%language_path%" "invalid_input_letters"
		echo %~3
	)
	ECHO -------------------------------------
	PAUSE
exit /b

:wait
	%windir%\system32\timeout.exe /t 1 /nobreak >nul 2>&1
	%windir%\system32\tasklist.exe /fi "ImageName eq %~1" /fo csv 2>NUL | %windir%\system32\find.exe /I "%~1" >NUL
	if %errorlevel% EQU 1 goto wait_end
	goto wait
:wait_end
exit /b

:strlen
	set "string=%~2"
	set stringLength=0
	IF "%string%"=="" goto:end_lengthLoop
	:lengthLoop
		set "string=%string:~1%"
		set /a stringLength +=1
		if defined string goto:lengthLoop
	:end_lengthLoop
	set %~1=%stringLength%
exit /b

:record_params
echo set "language=%language%">params.bat
echo set "system=%system%">>params.bat
echo set "storage_meg=%storage_meg%">>params.bat
echo set "adapter=%adapter%">>params.bat
echo set "boot_type=%boot_type%">>params.bat
echo set "clean_build=%clean_build%">>params.bat
echo set "force_pyocd=%force_pyocd%">>params.bat
echo set "gnwmanager_debug=%gnwmanager_debug%">>params.bat
echo set "retrogo_savestate=%retrogo_savestate%">>params.bat
echo set "retrogo_lng=%retrogo_lng%">>params.bat
echo set "retrogo_coverflows=%retrogo_coverflows%">>params.bat
echo set "retrogo_screenshots=%retrogo_screenshots%">>params.bat
echo set "retrogo_cheats=%retrogo_cheats%">>params.bat
echo set "retrogo_shared_hibernate_savestate=%retrogo_shared_hibernate_savestate%">>params.bat
echo set "retrogo_splash_screen=%retrogo_splash_screen%">>params.bat
echo set "retrogo_old_nes_emulator=%retrogo_old_nes_emulator%">>params.bat
echo set "retrogo_old_gb_emulator=%retrogo_old_gb_emulator%">>params.bat
echo set "retrogo_single_font=%retrogo_single_font%">>params.bat
echo set "retrogo_filesystem_size=%retrogo_filesystem_size%">>params.bat
echo set "zelda3_lng=%zelda3_lng%">>params.bat
echo set "zelda3_savestate=%zelda3_savestate%">>params.bat
exit /b

:reset_pyocd
	set pyocd_confirm=
	IF %force_pyocd% EQU 1 (
		call "%language_path%" "reset_pyocd_wait"
		%gnwmanager_path% -b pyocd info >nul
		call "%language_path%" "reset_pyocd_confirm"
	)
IF %force_pyocd% EQU 1 (	
		if /i "%pyocd_confirm%"=="c" exit /b 1
		if /i "%pyocd_confirm%"=="o" exit /b 0
	)
	goto reset_pyocd

:eof
