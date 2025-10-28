set "lng_label_exist=0"
for /f "usebackq delims=" %%L in ("%~0") do (
    if /i "%%L"==":%~1" (
        set "lng_label_exist=1"
        goto found_label
    )
)

:found_label
if "%lng_label_exist%"=="0" (
    call "%base_script_path%languages\FR_fr.bat" "%~1"
    goto :eof
) else (
    goto :%~1
)

:set_title
	title Ultimate-GNW-Hack-Script v1.0.0
goto:eof

:display_header
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
		echo Boot type: Dual boot ^(Retrogo in bank 1 and Zelda3 or Super Mario World in bank 2, obsolete^)
	) else if %boot_type%==3 (
		echo Boot type: Triple boot ^(Retrogo very limited, obsolete^)
	) else (
		echo Boot type: Single boot
	)
	if %clean_build%==1 (echo Clean Build: Enabled) else (echo Clean Build: Disabled)
	if %force_pyocd%==1 (echo Force Pyocd for Gnwmanager: Enabled) else (echo Force Pyocd for Gnwmanager: Disabled)
	if %gnwmanager_debug%==1 (echo GNWManager verbosity debug: enabled) else (echo echo GNWManager verbosity debug: disabled)
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
goto:eof

:display_main_menu
	echo - [Main Menu] -----------------------
	echo.
	echo 1. Install Msys2
	echo 2. Install/update Build-Environment 
	echo 3. Init/Update Repos
	echo 4. GnW-Backup Menu
	echo 5. Flash GnW-Patch ^(needs Backup files in "game-and-watch-patch" folder^)
	echo 6. Flash GnW-Patch ^(old method, needs Backup files in "game-and-watch-patch-old_method" folder^)
	echo 7. Flash patch for SD mod directly with GNWManager ^(Beta function, only for single boot or dual boot with firmware in bank 1, backup needed in "game-and-watch-backup\backups" or "game-and-watch-patch" or "game-and-watch-patch-old_method" for dual boot config, need at least a nand of 64 MB^)
	echo 8. Flash patch for SD mod with Game-and-watch-patch repository  ^(Beta function, only for  dual boot with firmware in bank 1, backup needed in "game-and-watch-backup\backups" or "game-and-watch-patch" or "game-and-watch-patch-old_method", need at least a nand of 64 MB^)
	echo 9. Flash GnW-Retro-Go
	echo 10. Flash GnW-Zelda3 ^(obsolete^)
	echo 11. Flash GnW-Super-Mario-World ^(obsolete^)
	echo.
	echo -------------------------------------
	echo.
	echo L. Change language
	echo U. Update to the script's latest version (alpha test)
	echo S. General Settings Menu
	echo R. Retrogo Settings Menu
	echo Z. Zelda3 and Super Mario World Settings Menu
	echo D. Restore params to default ^(will also exit the script^)
	echo G. Make me a donation
	echo Q. Quit
	echo 0. Open Github project page
	echo.
	echo -------------------------------------
	echo.
	SET /P IN_M=Make your choice: 
goto:eof

:msys2_downloading
	echo Downloading Msys2 installer...
goto:eof

:msys2_downloading_error
	echo Error when downloading Msys2.
goto:eof

:msys2_install_success
	echo Installation of Msys2 succesful.
goto:eof

:msys2_install_error
	echo Installation of Msys2 failed.
goto:eof

:main_script_downloading
	echo Downloading main script...
goto:eof

:main_script_downloading_error
	echo Error when downloading main script.
goto:eof

:script_ressources_downloading
	echo Downloading script's ressources...
goto:eof

:main_script_downloading_error_with_retry
	echo Error when downloading script's ressources, retrying %try_update_count%/2...
goto:eof

:main_script_downloading_error
	echo Error when downloading script's ressources, script will not work as intended, concider to update it manualy.
	echo Script will be closed.
goto:eof

:main_script_downloading_success
	echo Script's ressources downloaded succesfuly.
	echo Remember that you may need to update libraries and Github repositories used by the script via the script's menu.
	echo The script will restart.
goto:eof

:display_donate_menu
	echo - Donation Menu -----------------
	echo.
	echo Thanks in advance for your donation.
	echo.
	echo How do you want to do the donation:
	echo 1. Donate via Paypal if you have a Paypal account ^(open my Paypal page, no transaction fees^)
	echo 2. Donate by credit card if you don't have a Paypal account ^(opens my Paypal page, transaction fees^)
	echo Q. Back to previous menu
	echo.
	set /p action_choice=Make your choice: 
goto:eof

:display_backup_menu
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
	echo Q. Back to previous menu
	echo.
	echo -------------------------------------
	echo.
	SET /P IN_B=Make your choice: 
goto:eof

:display_general_settings_menu
	echo - [General Settings Menu ] ------------------
	echo.
	echo 1. Change System [mario^|zelda]
	echo 2. Change Adapter [pico^|stlink]
	echo 3. Set Storage Size
	echo 4. Switch between Boot Types
	echo 5. Toggle Clean Build
	echo 6. Set Number Of Processor Used For Compilation
	echo 7. Toggle use of Pyocd for Gnwmanager
	echo 8. Toggle debug verbosity for GNWManager
	echo.
	echo -------------------------------------
	echo.
	echo Q. Back to previous menu
	echo.
	echo -------------------------------------
	echo.
	SET /P IN_S=Make your choice: 
goto:eof

:display_storage_setting
	echo - [Setting Storage Size] ------------
	echo.
	echo Please input a Storage Size between 4 and 512MBytes ^(must be a multiple of 2, leave empty to cancel^)
	SET /P VALUE=Enter value: 
goto:eof

:display_proc_number_setting
	echo - [Setting Number Of Processors] ------------
	echo.
	echo Please input a number of processor^(s^), leave empty to cancel^)
	SET /P VALUE=Enter value: 
goto:eof

:proc_number_value_char_error
	echo Unauthorised char for proc number value.
goto:eof

:display_retrogo_settings_menu
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
	echo Q. Back to previous menu
	echo.
	echo -------------------------------------
	echo.
	SET /P IN_R=Make your choice: 
goto:eof

:display_retrogo_filesystem_size_setting
	echo - [Setting Retrogo Filesystem Size] ------------
	echo.
	echo Please input a size in %% for Retrogo filesystem ^(0 to 99, leave empty to cancel^)
	SET /P VALUE=Enter value: 
goto:eof

:retrogo_filesystem_value_char_error
	echo Unauthorised char for filesystem size value.
goto:eof

:display_retrogo_language_param
	echo - [Setting Retrogo Language] ------------
	echo.
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
	echo Q. Back to previous menu
	echo.
	SET /P VALUE=Make your choice: 
goto:eof

:display_zelda3_settings_menu
	echo - [Zelda3 and Super Mario World Settings Menu ] ------------------
	echo.
	echo 1. Set Zelda3 Language Code
	echo 2. Toggle Zelda3 and Super Mario World Savestate
	echo.
	echo -------------------------------------
	echo.
	echo Q. Back to previous menu
	echo.
	echo -------------------------------------
	echo.
	SET /P IN_Z=Make your choice: 
goto:eof

:display_zelda3_language_param
	echo - [Setting Zelda3 language] ------------
	echo.
	echo Please input a language code for zelda3 translation, if different than "us" you will need to also put the rom containing the language named "zelda3_[language_code].sfc" into the folder "game-and-watch-zelda3\zelda3\tables" in addition of the US rom of zelda3 named "zelda3.sfc" ^(if empty value language will be set to "us"^).
	SET /P zelda3_lng=Enter Zelda3 language value: 
goto:eof

:zelda3_file_missing_not_us_version
	echo "Please put a copy of \"zelda3_%zelda3_lng%.sfc\" ^(rom with the language wanted^) and \"zelda3.sfc\" ^(rom USA^) into \".\game-and-watch-zelda3\zelda3\tables\""
goto:eof

:zelda3_file_missing_us_version
	echo "Please put a copy of \"zelda3.sfc\" ^(rom USA^) into folder \".\game-and-watch-zelda3\zelda3\tables\""
goto:eof

:smw_missing_file
	echo "Please put a copy of \"smw.sfc\" ^(rom USA of Super Mario World^) into folder \".\game-and-watch-smw\smw\assets\""
goto:eof

:gnwmanager_not_installed_error
	echo GNWManager not founded, please make the libraries installations first ^(choices "1", "2" and "3" in main menu^).
goto:eof

:single_boot_not_authorized
	echo Not possible to use this function in single boot.
goto:eof

:dual_boot_2_not_authorized
	echo Not possible to use this function in dual boot Retrogo + Zelda3 or Super Mario World.
goto:eof

:tripple_boot_not_authorized
	echo Not possible to use this function in triple boot.
goto:eof

:need_64_mb_storage_error
	echo Error, 64 MB min for nand storage is required.
goto:eof

:backups_not_founded_error
	echo Missing Backup files in "game-and-watch-backup\backups" or "game-and-watch-patch" or "game-and-watch-patch-old_method".
goto:eof

:pause_for_msys_scripts
	echo read -p ^"Press enter to continue^" >> _tmp\launch.sh
goto:eof

:reset_pyocd_wait
	echo Trying to reboot the device in flash mode for Pyocd, please wait...
goto:eof

:reset_pyocd_confirm
		echo The device should be in flash mode, on the next screen if you see a message witch say ^"Waiting for a debug prob to be connected^" just disconect and reconect the adapter.
		echo If you're not in flash mode reboot the device, disconect the adapter and retry.
		echo.
		echo C. Cancel
		echo O. Validate that you are in flash mode
		echo All other choices: Retry
		echo.
		set /p pyocd_confirm=Make your choice: 
goto:eof

:invalid_input_start
	ECHO ============INVALID INPUT============
	ECHO -------------------------------------
	ECHO      Please select a number from:
goto:eof

:invalid_input_letters
	echo        or select the letter:
goto:eof