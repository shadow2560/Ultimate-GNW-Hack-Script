::::::::::::::::::::::::::::::::::::::::::::
:: Automatically check & get admin rights V2
::::::::::::::::::::::::::::::::::::::::::::
@echo off
CLS
ECHO.
ECHO =============================
ECHO Running Admin shell
ECHO =============================

:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO.
ECHO **************************************
ECHO Invoking UAC for Privilege Escalation
ECHO **************************************

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

rem ------------ START OF ACTUAL SCRIPT ------------------------------------------------
setlocal EnableDelayedExpansion
set system=zelda
set storage_meg=64
set adapter=stlink
set boot_type=1
set clean_build=1
set force_pyocd=1
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

set base_script_path=%~dp0
set base_script_slash_path=%base_script_path:\=/%
set mingw64_path=%base_script_path%\msys2\mingw64.exe
set gnwmanager_path=%base_script_slash_path%_installer/python/tools/scripts/gnwmanager.exe
set path=%base_script_path%_installer\resources\openocd;%path%

IF EXIST params.bat call params.bat

goto main

:head
	CLS
	title Ultimate-GNW-Hack-Script v1.0.0
	echo === Ultimate-GNW-Hack-Script ==
	echo ========== v1.0.0 by Shadow256, originaly made by ManCloud =========
	echo -------------------------------------
	echo.
	echo General Settings:
	echo.
	echo Number of processor cores used for compilation: %proc_number%
	echo System: %system%
	echo Selected Storage: %storage_meg% MBytes 
	if %boot_type%==1 (
		echo Boot type: Dual boot ^(CFW patch in bank 1 and Retrogo or Zelda3 or Super Mario World in bank 2^)
	) else if %boot_type%==2 (
		echo Boot type: Dual boot ^(Retrogo in bank 1 and Zelda3 or Super Mario World in bank 2^)
	) else if %boot_type%==3 (
		echo Boot type: Triple boot ^(Retrogo very limited^)
	) else (
		echo Boot type: Single boot
	)
	if %clean_build%==1 (echo Clean Build: Enabled) else (echo Clean Build: Disabled)
	if %force_pyocd%==1 (echo Force Pyocd for Gnwmanager: Enabled) else (echo Force Pyocd for Gnwmanager: Disabled)
	echo Adapter: %adapter%
	echo.
	echo Retrogo Settings:
	echo.
	if %retrogo_savestate%==1 (echo Retrogo savestates: Enabled) else (echo Retrogo savestates: Disabled)
	if %retrogo_lng%==1252 (
		echo Retrogo language: English
	) else if %retrogo_lng%==932 (
		echo Retrogo language: Japanese
	) else if %retrogo_lng%==936 (
		echo Retrogo language: simple Chinese
	) else if %retrogo_lng%==950 (
		echo Retrogo language: traditional Chinese
	) else if %retrogo_lng%==949 (
		echo Retrogo language: Korean
	) else if %retrogo_lng%==12511 (
		echo Retrogo language: Russian
	) else if %retrogo_lng%==12521 (
		echo Retrogo language: Spanish
	) else if %retrogo_lng%==12522 (
		echo Retrogo language: Portuguese
	) else if %retrogo_lng%==12523 (
		echo Retrogo language: French
	) else if %retrogo_lng%==12524 (
		echo Retrogo language: Italian
	) else if %retrogo_lng%==12525 (
		echo Retrogo language: German
	) else (
		echo Retrogo language: badly configured, verify values in the script
	)
	if %retrogo_coverflows%==1 (echo Retrogo coverflows: Enabled) else (echo Retrogo coverflows: Disabled)
	if %retrogo_screenshots%==1 (echo Retrogo xcreenshots: Enabled) else (echo Retrogo screenshots: Disabled)
	if %retrogo_cheats%==1 (echo Retrogo cheats: Enabled) else (echo Retrogo cheats: Disabled)
	if %retrogo_shared_hibernate_savestate%==1 (echo Retrogo shared hibernate savestate: Enabled) else (echo Retrogo shared hibernate savestate: Disabled)
	if %retrogo_splash_screen%==0 (echo Retrogo splash screen on boot: Enabled) else (echo Retrogo splash screen on boot: Disabled)
	if %retrogo_old_nes_emulator%==1 (echo Retrogo use old NES emulator: Enabled) else (echo Retrogo use old NES emulator: Disabled)
	if %retrogo_old_gb_emulator%==1 (echo Retrogo use old GB emulator: Enabled) else (echo Retrogo use old GB emulator: Disabled)
	if %retrogo_single_font%==1 (echo Retrogo single font: Enabled) else (echo Retrogo single font: Disabled)
	echo retrogo filesystem_size: %retrogo_filesystem_size%%%
	echo.
	echo Zelda3 and Super Mario World Settings:
	echo.
	echo Zelda3 language: %zelda3_lng%
	if %zelda3_savestate%==1 (echo Zelda3 and Super Mario World savestate: Enabled) else (echo Zelda3 and Super Mario World savestate: Disabled)
	echo.
goto eof

:main
	call :head
	echo - [Main Menu] -----------------------
	echo.
	echo 1. Install Msys2
	echo 2. Install/update Build-Environment 
	echo 3. Init/Update Repos
	echo 4. GnW-Backup Menu
	echo 5. Flash GnW-Patch ^(needs Backup files in "game-and-watch-patch" folder^)
	echo 6. Flash GnW-Patch ^(old method, needs Backup files in "game-and-watch-patch-old_method" folder^)
	echo 7. Flash GnW-Retro-Go
	echo 8. Flash GnW-Zelda3
	echo 9. Flash GnW-Super-Mario-World
	echo.
	echo -------------------------------------
	echo.
	echo S. General Settings Menu
	echo R. Retrogo Settings Menu
	echo Z. Zelda3 and Super Mario World Settings Menu
	echo D. Restore params to default ^(will also exit the script^)
	echo Q. Quit
	echo.
	echo -------------------------------------
	echo.
	set val_m=0
	SET IN_M=
	SET /P IN_M=Please select a number: 
	IF /I '%IN_M%'=='1' (
		set val_m=1
		echo Downloading Msys2 installer...
		"_installer\wget.exe" -q https://github.com/msys2/msys2-installer/releases/download/2024-01-13/msys2-x86_64-20240113.exe -O "_installer\msys2_installer.exe"
		IF %errorlevel% EQU 0 (
			.\_installer\msys2_installer.exe -t "%base_script_path%\msys2" --am --al -c -g ifw.*=true in
		) else (
			echo Error when downloading Msys2.
			pause
			goto main
		)
		IF %errorlevel% EQU 0 (
			del /q "_installer\msys2_installer.exe" >nul
			del /q InstallationLog.txt >nul
			echo Installation of Msys2 succesful.
			pause
			goto main
		) else (
			del /q "_installer\msys2_installer.exe" >nul
			del /q InstallationLog.txt >nul
			echo Installation of Msys2 failed.
			pause
			goto main
		)
	)
	IF /I '%IN_M%'=='2' set val_m=1 & call :install_env
	IF /I '%IN_M%'=='3' set val_m=1 & call :run_mingw64 _installer/ , pull_repos.sh
	IF /I '%IN_M%'=='4' set val_m=1 & call :backup_menu
	IF /I '%IN_M%'=='5' set val_m=1 & call :run_patch
	IF /I '%IN_M%'=='6' set val_m=1 & call :run_patch_old
	IF /I '%IN_M%'=='7' set val_m=1 & call :run_retrogo
	IF /I '%IN_M%'=='8' set val_m=1 & call :run_zelda3
	IF /I '%IN_M%'=='9' set val_m=1 & call :run_smw
	IF /I '%IN_M%'=='S' set val_m=1 & call :settings
	IF /I '%IN_M%'=='R' set val_m=1 & call :retrogo_settings
	IF /I '%IN_M%'=='Z' set val_m=1 & call :zelda3_settings
	IF /I '%IN_M%'=='D' set val_m=1 & IF EXIST params.bat (del /q params.bat & exit) else (echo No need to restore params.)
	IF /I '%IN_M%'=='Q' set val_m=1 & GOTO eof
	IF /I '%IN_M%'=='' set val_m=1
	if %val_m%==0 call :invald_input 1, 9
goto main

:backup_menu
	call :head
	echo - [GnW-Backup Menu] -----------------
	echo.
	echo 1. Sanity Check
	echo 2. Backup Ext-Flash
	echo 3. Backup Int-Flash
	echo 4. Unlock Device
	echo 5. Restore Device ^(need Backup files in "game-and-watch-backup\backups" folder^)
	echo 6. Unlock device with Gnwmanager ^(Beta, perform steps 1 to 5 automaticaly without needed to indicate proper model in settings^)
	echo -------------------------------------
	echo.
	echo S. General Settings Menu
	echo Q. Back
	echo.
	echo -------------------------------------
	echo.
	set val_b=0
	SET IN_B=
	SET /P IN_B=Please select a number: 
	IF /I '%IN_B%'=='1' set val_b=1 & call :run_mingw64 ./game-and-watch-backup/, "1_sanity_check.sh %adapter% %system%"
	IF /I '%IN_B%'=='2' set val_b=1 & call :run_mingw64 ./game-and-watch-backup/, "2_backup_flash.sh %adapter% %system%"
	IF /I '%IN_B%'=='3' set val_b=1 & call :run_mingw64 ./game-and-watch-backup/, "3_backup_internal_flash.sh %adapter% %system%"
	IF /I '%IN_B%'=='4' set val_b=1 & call :run_mingw64 ./game-and-watch-backup/, "4_unlock_device.sh %adapter% %system%"
	IF /I '%IN_B%'=='5' set val_b=1 & call :run_mingw64 ./game-and-watch-backup/, "5_restore.sh %adapter% %system%"
	IF /I '%IN_B%'=='6' set val_b=1 & call :run_mingw64 ./game-and-watch-backup/, "unlock_gnw.sh "
	IF /I '%IN_B%'=='S' set val_b=1 & call :settings
	IF /I '%IN_B%'=='Q' goto eof
	IF /I '%IN_B%'=='' set val_b=1
	if %val_b%==0	call :invald_input 1, 6
goto backup_menu

:settings
	call :head
	echo - [Settings Menu ] ------------------
	echo.
	echo 1. Change System [mario^|zelda]
	echo 2. Change Adapter [pico^|stlink]
	echo 3. Set Storage Size
	echo 4. Switch between Boot Types
	echo 5. Toggle Clean Build
	echo 6. Set Number Of Processor Used For Compilation
	echo 7. Toggle use of Pyocd for Gnwmanager
	echo.
	echo -------------------------------------
	echo.
	echo Q. Back
	echo.
	echo -------------------------------------
	echo.
	set val_s=0
	SET IN_S=
	SET /P IN_S=Please select a number: 
	IF /I '%IN_S%'=='1' set val_s=1 & call :switch_system
	IF /I '%IN_S%'=='2' set val_s=1 & call :switch_adapter
	IF /I '%IN_S%'=='3' set val_s=1 & call :set_storage
	IF /I '%IN_S%'=='4' set val_s=1 & call :toggle_TB
	IF /I '%IN_S%'=='5' set val_s=1 & call :toggle_CB
	IF /I '%IN_S%'=='6' set val_s=1 & call :set_proc_number
	IF /I '%IN_S%'=='7' set val_s=1 & call :toggle_pyocd
	IF /I '%IN_S%'=='Q' goto eof
	if %val_s%==0	call :invald_input 1, 7
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
goto eof

:toggle_CB
	if %clean_build%==1 (
		set clean_build=0
	) else (
		set clean_build=1
	)
goto eof

:toggle_CB
	if %force_pyocd%==1 (
		set force_pyocd=0
	) else (
		set force_pyocd=1
	)
goto eof

:switch_system
	if %system%==zelda (
		set system=mario
	) else (
		set system=zelda
	)
goto eof

:switch_adapter
	if %adapter%==pico (
		set adapter=stlink
	) else (
		set adapter=pico
	)
goto eof

:set_storage
	call :head
	echo - [Setting Storage Size] ------------
	echo.
	SET VALUE=
	echo Please input a Storage Size between 4 and 512MBytes ^(must be a multiple of 2, leave empty to cancel^)
	SET /P VALUE=Value: 

	set true=0
	IF /I '%VALUE%'=='4' set true=1
	IF /I '%VALUE%'=='8' set true=1
	IF /I '%VALUE%'=='16' set true=1
	IF /I '%VALUE%'=='32' set true=1
	IF /I '%VALUE%'=='64' set true=1
	IF /I '%VALUE%'=='128' set true=1
	IF /I '%VALUE%'=='256' set true=1
	IF /I '%VALUE%'=='512' set true=1
	IF /I '%VALUE%'=='' goto eof
	IF /I %true%==1 set "storage_meg=%VALUE%" & goto eof

	call :invald_input 4, 512
goto set_storage

:set_proc_number
	call :head
	echo - [Setting Number Of Processors] ------------
	echo.
	SET VALUE=
	echo Please input a number of processor^(s^), leave empty to cancel^)
	SET /P VALUE=Value: 
	IF /I '%VALUE%'=='' goto eof
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
		echo Unauthorised char for proc number value.
		pause
		goto :set_proc_number
		)
	)
	IF /I %VALUE% LSS 1 set proc_number=1 & goto eof
	IF NOT "%NUMBER_OF_PROCESSORS%"=="" (
		IF /I %VALUE% GTR %NUMBER_OF_PROCESSORS% set proc_number=%NUMBER_OF_PROCESSORS% & goto eof
	)
	set proc_number=%VALUE%
	goto eof

:retrogo_settings
	call :head
	echo - [Retrogo Settings Menu ] ------------------
	echo.
	echo 1. Toggle Retrogo savestate
	echo 2. Set default UI language
	echo 3. Toggle Coverflows
	echo 4. Toggle Screenshots
	echo 5. Toggle Cheat Codes
	echo 6. Toggle Shared Hibernate Savestate
	echo 7. Toggle Splash Screen On Boot
	echo 8. Toggle Usage Of The Old NES Emulator
	echo 9. Toggle Usage Of The Old Gameboy Emulator
	echo 10. Toggle Usage Of Single Font
	echo 11. Set Retrogo Filesystem Size
	echo.
	echo -------------------------------------
	echo.
	echo Q. Back
	echo.
	echo -------------------------------------
	echo.
	set val_r=0
	SET IN_R=
	SET /P IN_R=Please select a number: 
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
	IF /I '%IN_R%'=='Q' goto eof
	if %val_r%==0	call :invald_input 1, 11
	goto retrogo_settings

:set_retrogo_filesystem_size
	call :head
	echo - [Setting Retrogo Filesystem Size] ------------
	echo.
	SET VALUE=
	echo Please input a size in %% for Retrogo filesystem ^(0 to 99, leave empty to cancel^)
	SET /P VALUE=Value: 
	IF /I '%VALUE%'=='' goto eof
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
		echo Unauthorised char for filesystem size value.
		pause
		goto :set_retrogo_filesystem_size
		)
	)
	IF /I %VALUE% LSS 0 set retrogo_filesystem_size=0 & goto eof
	IF /I %VALUE% GTR 99 set retrogo_filesystem_size=99 & goto eof
	set retrogo_filesystem_size=%VALUE%
	goto eof

:toggle_retrogo_old_gb_emulator
	if %retrogo_old_gb_emulator%==1 (
		set retrogo_old_gb_emulator=0
	) else (
		set retrogo_old_gb_emulator=1
	)
goto eof

:toggle_retrogo_single_font
	if %retrogo_single_font%==1 (
		set retrogo_single_font=0
	) else (
		set retrogo_single_font=1
	)
goto eof

:toggle_retrogo_savestate
	if %retrogo_savestate%==1 (
		set retrogo_savestate=0
	) else (
		set retrogo_savestate=1
	)
goto eof

:set_retrogo_lng
	call :head
	echo - [Setting Retrogo Language] ------------
	echo.
	SET VALUE=
	echo 1. English
	echo 2. French
	echo 3. German
	echo 4. Italian
	echo 5. Portuguese
	echo 6. Russian
	echo 7. Spanish
	echo 8. Japanese
	echo 9. simple Chinese
	echo 10. traditional Chinese
	echo 11. Korean
	echo Q. Back
	echo.
	SET /P VALUE=Please select a number: 

	IF /I '%VALUE%'=='1' set retrogo_lng=1252 & goto eof
	IF /I '%VALUE%'=='2' set retrogo_lng=12523 & goto eof
	IF /I '%VALUE%'=='3' set retrogo_lng=12525 & goto eof
	IF /I '%VALUE%'=='4' set retrogo_lng=12524 & goto eof
	IF /I '%VALUE%'=='5' set retrogo_lng=12522 & goto eof
	IF /I '%VALUE%'=='6' set retrogo_lng=12511 & goto eof
	IF /I '%VALUE%'=='7' set retrogo_lng=12521 & goto eof
	IF /I '%VALUE%'=='8' set retrogo_lng=932 & goto eof
	IF /I '%VALUE%'=='9' set retrogo_lng=936 & goto eof
	IF /I '%VALUE%'=='10' set retrogo_lng=950 & goto eof
	IF /I '%VALUE%'=='11' set retrogo_lng=949 & goto eof
	IF /I '%VALUE%'=='Q' goto eof
	
	call :invald_input 1, 11
goto set_retrogo_lng

:toggle_retrogo_coverflows
	if %retrogo_coverflows%==1 (
		set retrogo_coverflows=0
	) else (
		set retrogo_coverflows=1
	)
goto eof

:toggle_retrogo_screenshots
	if %retrogo_screenshots%==1 (
		set retrogo_screenshots=0
	) else (
		set retrogo_screenshots=1
	)
goto eof

:toggle_retrogo_cheats
	if %retrogo_cheats%==1 (
		set retrogo_cheats=0
	) else (
		set retrogo_cheats=1
	)
goto eof

:toggle_retrogo_shared_hibernate_savestate
	if %retrogo_shared_hibernate_savestate%==1 (
		set retrogo_shared_hibernate_savestate=0
	) else (
		set retrogo_shared_hibernate_savestate=1
	)
goto eof

:toggle_retrogo_splash_screen
	if %retrogo_splash_screen%==1 (
		set retrogo_splash_screen=0
	) else (
		set retrogo_splash_screen=1
	)
goto eof

:toggle_retrogo_old_nes_emulator
	if %retrogo_old_nes_emulator%==1 (
		set retrogo_old_nes_emulator=0
	) else (
		set retrogo_old_nes_emulator=1
	)
goto eof

:zelda3_settings
	call :head
	echo - [Zelda3 and Super Mario World Settings Menu ] ------------------
	echo.
	echo 1. Set Zelda3 Language Code
	echo 2. Toggle Zelda3 and Super Mario World Savestate
	echo.
	echo -------------------------------------
	echo.
	echo Q. Back
	echo.
	echo -------------------------------------
	echo.
	set val_z=0
	SET IN_Z=
	SET /P IN_Z=Please select a number: 
	IF /I '%IN_Z%'=='1' set val_z=1 & call :set_zelda3_lng
	IF /I '%IN_Z%'=='2' set val_z=1 & call :toggle_zelda3_savestate
	IF /I '%IN_Z%'=='Q' goto eof
	if %val_z%==0	call :invald_input 1, 6
	goto zelda3_settings

:set_zelda3_lng
	call :head
	echo - [Setting Zelda3 language] ------------
	echo.
	SET zelda3_lng=us
	echo Please input a language code for zelda3 translation, if different than "us" you will need to also put the rom containing the language named "zelda3_[language_code].sfc" into the folder "game-and-watch-zelda3\zelda3\tables" in addition of the US rom of zelda3 named "zelda3.sfc" ^(if empty value language will be set to "us"^).
	SET /P zelda3_lng=Zelda3 language value: 
goto eof

:toggle_zelda3_savestate
	if %zelda3_savestate%==1 (
		set zelda3_savestate=0
	) else (
		set zelda3_savestate=1
	)
goto eof

:run_mingw64
	mkdir _tmp
	echo cd %~1 > _tmp\launch.sh
	echo export GCC_PATH="%base_script_slash_path%gcc-arm-none-eabi-10.3-2021.10/bin/" >> _tmp\launch.sh
	::echo export GCC_PATH="%base_script_slash_path%arm-gnu-toolchain-13.2.Rel1-mingw-w64-i686-arm-none-eabi/bin/" >> _tmp\launch.sh
	::echo export GCC_PATH="%base_script_slash_path%msys2/mingw64/bin/" >> _tmp\launch.sh
	echo ./%~2 >> _tmp\launch.sh
	echo read -p ^"Press enter to continue^" >> _tmp\launch.sh
	"%mingw64_path%" ./_tmp/launch.sh
	call :wait "mintty.exe"
	rd /s /q _tmp
goto eof

:invald_input
	CLS
	ECHO ============INVALID INPUT============
	ECHO -------------------------------------
	ECHO      Please select a number from 
	echo                [%~1-%~2] 
	echo        or select 'Q' to quit.
	ECHO -------------------------------------
	PAUSE
goto eof


:install_env
	call :run_mingw64 _installer/, msys2_install.sh
	if exist _installer\run_again.txt (
		goto install_env
	)
goto eof

:run_retrogo
	cd game-and-watch-retro-go
	IF EXIST external\*.* (
		call :reset_pyocd
	)
	if %errorlevel% NEQ 0 goto eof
	call _make_links.cmd "%base_script_path%"
	cd ..
	call :run_mingw64 ./game-and-watch-retro-go/, "build.sh %adapter% %system% %storage_meg% %boot_type% %clean_build% %proc_number% %retrogo_savestate% %retrogo_lng% %retrogo_coverflows% %retrogo_screenshots% %retrogo_cheats% %retrogo_shared_hibernate_savestate% %retrogo_splash_screen% %retrogo_old_nes_emulator% %retrogo_old_gb_emulator% %retrogo_single_font% %retrogo_filesystem_size% %force_pyocd% %gnwmanager_path%"
	cd game-and-watch-retro-go
	call _remove_links.cmd
	cd ..
	goto eof

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
		echo "Please put a copy of \"zelda3_%zelda3_lng%.sfc\" ^(rom with the language wanted^) and \"zelda3.sfc\" ^(rom USA^) into \".\game-and-watch-zelda3\zelda3\tables\""
	) else (
		echo "Please put a copy of \"zelda3.sfc\" ^(rom USA^) into folder \".\game-and-watch-zelda3\zelda3\tables\""
	)
	pause
	goto eof

:run_smw
	if  exist .\game-and-watch-smw\smw\assets\smw.sfc (
		call :run_mingw64 ./game-and-watch-smw/, "build.sh %adapter% %system% %storage_meg% %boot_type% %clean_build% %proc_number% %zelda3_savestate%"
		goto:eof
	)
	echo "Please put a copy of \"smw.sfc\" ^(rom USA of Super Mario World^) into folder \".\game-and-watch-smw\smw\assets\""
	pause
	goto eof

:run_patch
	if %boot_type%==0 (
		echo Not possible to use this function in single mode boot.
		pause
		goto eof
	)
	if %boot_type%==2 (
		echo Not possible to use this function in dual boot Retrogo + Zelda3 or Super Mario World.
		pause
		goto eof
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
	if %errorlevel% NEQ 0 goto eof
	if %run_p%==1 (
		call :run_mingw64 ./game-and-watch-patch/, "build.sh %adapter% %system% %storage_meg% %boot_type% %clean_build% %force_pyocd% %gnwmanager_path%"
	) else (
		echo "Missing Backup-Files in game-and-watch-backup."
		pause
	)
goto eof

:reset_pyocd
	set pyocd_confirm=
	IF %force_pyocd% EQU 1 (
		echo Trying to reboot the device in flash mode for Pyocd, please wait...
		%gnwmanager_path% info >nul
		echo The device should be in flash mode, on the next screen if you see a message witch say ^"Waiting for a debug prob to be connected^" just disconect and reconect the adapter.
		echo If you're not in flash mode reboot the device, disconect the adapter and retry.
		echo.
		echo C. Cancel
		echo O. Validate that you are in flash mode
		echo All other choices: Retry
		echo.
		set /p pyocd_confirm=Make your choice: 
	)
IF %force_pyocd% EQU 1 (	
		if /i "%pyocd_confirm%"=="c" exit /b 1
		if /i "%pyocd_confirm%"=="o" exit /b 0
	)
	goto reset_pyocd

:run_patch_old
	if %boot_type%==0 (
		echo Not possible to use this function in single mode boot.
		pause
		goto eof
	)
	if %boot_type%==2 (
		echo Not possible to use this function in dual boot Retrogo + Zelda3 or Super Mario World.
		pause
		goto eof
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
		echo "Missing Backup-Files in game-and-watch-backup."
		pause
	)
goto eof

:wait
	%windir%\system32\timeout.exe /t 1 /nobreak >nul 2>&1
	%windir%\system32\tasklist.exe /fi "ImageName eq %~1" /fo csv 2>NUL | %windir%\system32\find.exe /I "%~1" >NUL
	if errorlevel 1 goto wait_end
	goto wait
:wait_end
goto eof

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
	goto eof

:record_params
echo set "system=%system%">params.bat
echo set "storage_meg=%storage_meg%">>params.bat
echo set "adapter=%adapter%">>params.bat
echo "set boot_type=%boot_type%">>params.bat
echo set "clean_build=%clean_build%">>params.bat
echo set "force_pyocd=%force_pyocd%">>params.bat
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
goto eof2

:eof
call :record_params

:eof2
