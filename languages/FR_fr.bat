goto:%~1

:set_title
	title Ultimate-GNW-Hack-Script v1.0.0
goto:eof

:display_header
	echo === Ultimate-GNW-Hack-Script ==
	echo ========== v1.0.0 par Shadow256, créé à l’origine par ManCloud =========
	echo -------------------------------------
	echo.
	echo Paramètres généraux :
	echo.
	echo Nombre de cœurs processeur utilisés pour la compilation : %proc_number%
	echo Système : %system%
	echo Stockage sélectionné : %storage_meg% Mo
	if %boot_type%==1 (
		echo Type de démarrage : Dual boot ^(CFW patch dans bank 1 et Retrogo ou Zelda3 ou Super Mario World dans bank 2^)
	) else if %boot_type%==2 (
		echo Type de démarrage : Dual boot ^(Retrogo dans bank 1 et Zelda3 ou Super Mario World dans bank 2, obsolète^)
	) else if %boot_type%==3 (
		echo Type de démarrage : Triple boot ^(Retrogo très limité, obsolète^)
	) else (
		echo Type de démarrage : single boot
	)
	if %clean_build%==1 (echo Compilation propre : Activée) else (echo Compilation propre : Désactivée)
	if %force_pyocd%==1 (echo Forcer Pyocd pour Gnwmanager : Activé) else (echo Forcer Pyocd pour Gnwmanager : Désactivé)
	if %gnwmanager_debug%==1 (echo Verbosité de débogage GNWManager : activée) else (echo Verbosité de débogage GNWManager : désactivée)
	echo Adaptateur : %adapter%
	echo.
	echo Paramètres de Retrogo :
	echo.
	if %retrogo_savestate%==1 (echo Savestates de Retrogo : Activées) else (echo Savestates de Retrogo : Désactivées)
	if %retrogo_lng%==1252 (
		echo Langue de Retrogo : Anglais
	) else if %retrogo_lng%==932 (
		echo Langue de Retrogo : Japonais
	) else if %retrogo_lng%==936 (
		echo Langue de Retrogo : Chinois simplifié
	) else if %retrogo_lng%==950 (
		echo Langue de Retrogo : Chinois traditionnel
	) else if %retrogo_lng%==949 (
		echo Langue de Retrogo : Coréen
	) else if %retrogo_lng%==12511 (
		echo Langue de Retrogo : Russe
	) else if %retrogo_lng%==12521 (
		echo Langue de Retrogo : Espagnol
	) else if %retrogo_lng%==12522 (
		echo Langue de Retrogo : Portugais
	) else if %retrogo_lng%==12523 (
		echo Langue de Retrogo : Français
	) else if %retrogo_lng%==12524 (
		echo Langue de Retrogo : Italien
	) else if %retrogo_lng%==12525 (
		echo Langue de Retrogo : Allemand
	) else (
		echo Langue de Retrogo : mal configurée, vérifiez les valeurs dans le script
	)
	if %retrogo_coverflows%==1 (echo Coverflows de Retrogo : Activés) else (echo Coverflows de Retrogo : Désactivés)
	if %retrogo_screenshots%==1 (echo Captures d’écran de Retrogo : Activées) else (echo Captures d’écran de Retrogo : Désactivées)
	if %retrogo_cheats%==1 (echo Codes de triche de Retrogo : Activés) else (echo Codes de triche de Retrogo : Désactivés)
	if %retrogo_shared_hibernate_savestate%==1 (echo Sauvegarde d’hibernation partagée de Retrogo : Activée) else (echo Sauvegarde d’hibernation partagée de Retrogo : Désactivée)
	if %retrogo_splash_screen%==0 (echo Splash screen Retrogo au démarrage : Activé) else (echo Splash screen Retrogo au démarrage : Désactivé)
	if %retrogo_old_nes_emulator%==1 (echo Utiliser l’ancien émulateur NES Retrogo : Activé) else (echo Utiliser l’ancien émulateur NES Retrogo : Désactivé)
	if %retrogo_old_gb_emulator%==1 (echo Utiliser l’ancien émulateur GB Retrogo : Activé) else (echo Utiliser l’ancien émulateur GB Retrogo : Désactivé)
	if %retrogo_single_font%==1 (echo Police unique Retrogo : Activée) else (echo Police unique Retrogo : Désactivée)
	echo Taille du système de fichiers de Retrogo : %retrogo_filesystem_size%%%
	echo.
	echo Paramètres Zelda3 et Super Mario World :
	echo.
	echo Langue de Zelda3 : %zelda3_lng%
	if %zelda3_savestate%==1 (echo Savestate de Zelda3 et Super Mario World : Activée) else (echo Savestate de Zelda3 et Super Mario World : Désactivée)
	echo.
goto:eof

:display_main_menu
	echo - [Menu principal] -----------------------
	echo.
	echo 1. Installer Msys2
	echo 2. Installer / Mettre à jour l’environnement de compilation
	echo 3. Initialiser / Mettre à jour les dépôts
	echo 4. Menu de sauvegarde GnW
	echo 5. Flasher GnW-Patch ^(nécessite les fichiers de sauvegarde dans le dossier "game-and-watch-patch"^)
	echo 6. Flasher GnW-Patch ^(ancienne méthode, nécessite les fichiers dans "game-and-watch-patch-old_method"^)
	echo 7. Flasher le patch SD mod directement avec GNWManager ^(fonction bêta, uniquement pour single boot ou dual boot avec le firmware dans bank 1, sauvegarde requise dans "game-and-watch-backup\backups" ou "game-and-watch-patch" ou "game-and-watch-patch-old_method" pour la configuration dual boot, nécessite au moins une NAND de 64 Mo^)
	echo 8. Flasher le patch SD mod avec le dépôt Game-and-watch-patch  ^(fonction bêta, uniquement pour dual boot avec le firmware dans bank 1, sauvegarde requise dans les mêmes dossiers, nécessite au moins une NAND de 64 Mo^)
	echo 9. Flasher GnW-Retro-Go
	echo 10. Flasher GnW-Zelda3 ^(obsolète^)
	echo 11. Flasher GnW-Super-Mario-World ^(obsolète^)
	echo.
	echo -------------------------------------
	echo.
	echo L. Changer la langue
	echo U. Mettre à jour vers la dernière version du script
	echo S. Menu des paramètres généraux
	echo R. Menu des paramètres Retrogo
	echo Z. Menu des paramètres Zelda3 et Super Mario World
	echo D. Restaurer les paramètres par défaut ^(quittera aussi le script^)
	echo G. Faire un don
	echo Q. Quitter
	echo 0. Ouvrir la page Github du projet
	echo.
	echo -------------------------------------
	echo.
	SET /P IN_M=Faites votre choix : 
goto:eof

:msys2_downloading
	echo Téléchargement de l'installateur de Msys2...
goto:eof

:msys2_downloading_error
	echo Erreur de téléchargement de Msys2.
goto:eof

:msys2_install_success
	echo Installation de Msys2 effectuée.
goto:eof

:msys2_install_error
	echo Installation de Msys2 échouée.
goto:eof

:main_script_downloading
	echo Téléchargement du script principal...
goto:eof

:main_script_downloading_error
	echo Erreur lors du téléchargement du script principal.
goto:eof

:script_ressources_downloading
	echo Téléchargement des ressources supplémentaires...
goto:eof

:main_script_downloading_error_with_retry
	echo Erreur durant le téléchargement des ressources du script, tentative de retéléchargement  %try_update_count%/2...
goto:eof

:main_script_downloading_error
	echo Erreur durant le téléchargement des ressources du script, celui-ci pourrait ne pas fonctionner comme prévu, la mise à jour peut être réessayée  ou une mise à jour manuelle est peut-être nécessaire.
	echo Le script va être fermé.
goto:eof

:main_script_downloading_success
	echo Ressources du script téléchargées avec succès.
	echo Il peut être aussi nécessaire de mettre à jour les bibliothèques et les dépôts Github utilisés par le script via le menu de celui-ci.
	echo Le script va redémarrer.
goto:eof

:display_donate_menu
	echo - Menu de donation -----------------
	echo.
	echo Merci d’avance pour votre don.
	echo.
	echo Comment souhaitez-vous effectuer le don :
	echo 1. Donner via Paypal si vous avez un compte Paypal ^(ouvre ma page Paypal, sans frais de transaction^)
	echo 2. Donner par carte bancaire si vous n’avez pas de compte Paypal ^(ouvre ma page Paypal, avec frais de transaction^)
	echo Q. Retour au menu précédent
	echo.
	set /p action_choice=Faites votre choix : 
goto:eof

:display_backup_menu
	echo - [Menu de sauvegarde GnW] -----------------
	echo.
	echo 1. Vérification de fonctionnement
	echo 2. Sauvegarder la mémoire Flash externe
	echo 3. Sauvegarder la mémoire Flash interne
	echo 4. Déverrouiller l’appareil
	echo 5. Restaurer l’appareil ^(nécessite des fichiers dans "game-and-watch-backup\backups"^)
	echo 6. Déverrouiller l’appareil avec Gnwmanager ^(bêta, effectue automatiquement les étapes 1 à 5 sans indiquer le modèle^)
	echo -------------------------------------
	echo.
	echo S. Menu des paramètres généraux
	echo Q. Retour au menu précédent
	echo.
	echo -------------------------------------
	echo.
	SET /P IN_B=Faites votre choix : 
goto:eof

:display_general_settings_menu
	echo - [Menu des paramètres généraux] ------------------
	echo.
	echo 1. Changer le système [mario^|zelda]
	echo 2. Changer l’adaptateur [pico^|stlink]
	echo 3. Définir la taille du stockage
	echo 4. Basculer entre les types de démarrage
	echo 5. Activer/Désactiver la compilation propre
	echo 6. Définir le nombre de coeurs processeur utilisés pour la compilation
	echo 7. Activer/Désactiver l’utilisation de Pyocd pour Gnwmanager
	echo 8. Activer/Désactiver la verbosité de débogage pour GNWManager
	echo.
	echo -------------------------------------
	echo.
	echo Q. Retour au menu précédent
	echo.
	echo -------------------------------------
	echo.
	SET /P IN_S=Faites votre choix : 
goto:eof

:display_storage_setting
	echo - [Définition de la taille du stockage] ------------
	echo.
	echo Veuillez entrer une taille comprise entre 4 et 512 Mo ^(multiple de 2, laisser vide pour annuler^)
	SET /P VALUE=Entrer la valeur : 
goto:eof

:display_proc_number_setting
	echo - [Définition du nombre de coeurs processeur] ------------
	echo.
	echo Veuillez entrer un nombre de coeurs processeur, laisser vide pour annuler^)
	SET /P VALUE=Entrer la valeur : 
goto:eof

:proc_number_value_char_error
	echo Caractère non autorisé pour la valeur du nombre de coeurs processeur.
goto:eof

:display_retrogo_settings_menu
	echo - [Menu des paramètres de Retrogo] ------------------
	echo.
	echo 1. Activer/Désactiver les savestates de Retrogo
	echo 2. Définir la langue de l’interface par défaut
	echo 3. Activer/Désactiver les Coverflows
	echo 4. Activer/Désactiver les captures d’écran
	echo 5. Activer/Désactiver les codes de triche
	echo 6. Activer/Désactiver la sauvegarde d’hibernation partagée
	echo 7. Activer/Désactiver le splash screen au démarrage
	echo 8. Activer/Désactiver l’ancien émulateur NES
	echo 9. Activer/Désactiver l’ancien émulateur Gameboy
	echo 10. Activer/Désactiver la police unique
	echo 11. Définir la taille du système de fichiers de Retrogo
	echo.
	echo -------------------------------------
	echo.
	echo Q. Retour au menu précédent
	echo.
	echo -------------------------------------
	echo.
	SET /P IN_R=Faites votre choix : 
goto:eof

:display_retrogo_filesystem_size_setting
	echo - [Définition de la taille du système de fichiers de Retrogo] ------------
	echo.
	echo Veuillez entrer une taille en % pour le système de fichiers Retrogo ^(0 à 99, laisser vide pour annuler^)
	SET /P VALUE=Entrer la valeur : 
goto:eof

:retrogo_filesystem_value_char_error
	echo Caractère non autorisé pour la taille du système de fichiers.
goto:eof

:display_retrogo_language_param
	echo - [Définition de la langue de Retrogo] ------------
	echo.
	echo 1. Anglais
	echo 2. Français
	echo 3. Allemand
	echo 4. Italien
	echo 5. Portugais
	echo 6. Russe
	echo 7. Espagnol
	echo 8. Japonais
	echo 9. Chinois simplifié
	echo 10. Chinois traditionnel
	echo 11. Coréen
	echo Q. Retour au menu précédent
	echo.
	SET /P VALUE=Faites votre choix : 
goto:eof

:display_zelda3_settings_menu
	echo - [Menu des paramètres Zelda3 et Super Mario World] ------------------
	echo.
	echo 1. Définir le code de langue de Zelda3
	echo 2. Activer/Désactiver la savestate pour Zelda3 et Super Mario World
	echo.
	echo -------------------------------------
	echo.
	echo Q. Retour au menu précédent
	echo.
	echo -------------------------------------
	echo.
	SET /P IN_Z=Faites votre choix : 
goto:eof

:display_zelda3_language_param
	echo - [Définition de la langue de Zelda3] ------------
	echo.
	echo Veuillez entrer un code de langue pour la traduction de Zelda3 ; si différent de "us", vous devrez aussi placer la rom correspondante nommée "zelda3_[code_langue].sfc" dans le dossier "game-and-watch-zelda3\zelda3\tables" en plus de la rom US nommée "zelda3.sfc" ^(si vide, la langue sera définie sur "us"^).
	SET /P zelda3_lng=Entrer la valeur de langue pour Zelda3 : 
goto:eof

:zelda3_file_missing_not_us_version
	echo "Veuillez placer une copie de \"zelda3_%zelda3_lng%.sfc\" ^(rom dans la langue souhaitée^) et de \"zelda3.sfc\" ^(rom USA^) dans \".\game-and-watch-zelda3\zelda3\tables\""
goto:eof

:zelda3_file_missing_us_version
	echo "Veuillez placer une copie de \"zelda3.sfc\" ^(rom USA^) dans le dossier \".\game-and-watch-zelda3\zelda3\tables\""
goto:eof

:smw_missing_file
	echo "Veuillez placer une copie de \"smw.sfc\" ^(rom USA de Super Mario World^) dans le dossier \".\game-and-watch-smw\smw\assets\""
goto:eof

:gnwmanager_not_installed_error
	echo GNWManager non trouvé, veuillez d’abord effectuer l’installation des bibliothèques ^(choix "1", "2" et "3" dans le menu principal^).
goto:eof

:single_boot_not_authorized
	echo Impossible d’utiliser cette fonction en mode single boot.
goto:eof

:dual_boot_2_not_authorized
	echo Impossible d’utiliser cette fonction en mode dual boot Retrogo + Zelda3 ou Super Mario World.
goto:eof

:tripple_boot_not_authorized
	echo Impossible d’utiliser cette fonction en triple boot.
goto:eof

:need_64_mb_storage_error
	echo Erreur : un stockage NAND d’au moins 64 Mo est requis.
goto:eof

:backups_not_founded_error
	echo Fichiers de sauvegarde manquants dans "game-and-watch-backup\backups" ou "game-and-watch-patch" ou "game-and-watch-patch-old_method".
goto:eof

:pause_for_msys_scripts
	echo read -p ^"Appuyez sur Entrée pour continuer^" >> _tmp\launch.sh
goto:eof

:reset_pyocd_wait
	echo Tentative de redémarrage de l’appareil en mode flash pour Pyocd, veuillez patienter...
goto:eof

:reset_pyocd_confirm
	echo L’appareil devrait être en mode flash ; sur l’écran suivant, si vous voyez le message ^"Waiting for a debug prob to be connected^", déconnectez puis reconnectez l’adaptateur.
	echo Si vous n’êtes pas en mode flash, redémarrez l’appareil, déconnectez l’adaptateur et réessayez.
	echo.
	echo C. Annuler
	echo O. Valider que vous êtes en mode flash
	echo Tout autre choix : Réessayer
	echo.
	set /p pyocd_confirm=Faites votre choix : 
goto:eof

:invalid_input_start
	ECHO ============ENTRÉE NON VALIDE============
	ECHO -------------------------------------
	ECHO      Veuillez sélectionner un numéro :
goto:eof

:invalid_input_letters
	echo        ou sélectionnez la lettre :
goto:eof