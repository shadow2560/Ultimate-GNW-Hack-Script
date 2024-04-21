# Ultimate-GNW-Hack-Script

Game-and-Watch "all-in-one" solution for Windows using MSYS2.

Largely based on the work of [this project of ManCloud](https://github.com/ManCloud/game-and-watch-msys2)

## Important notes

You must install the drivers of your adapter yourself, this will be not covered by the script. For now only Pico and Stlink adapters are supported by the script.

You must know how to configure the different elements installed on the Game-and-Watch (how to backup it, unlock it, install CFW, install Retro-go, install Super Mario World and install Zelda3), for example you should know where to place the original backup of the Game-and-Watch to install the CFW or you should know where to place the roms for Retro-go, all these things will not be covered here. The script will only help you to setup correctly the commands used to flash the elements.

Pin out and method to launch the flash will not be covered here

If you have some problems first delete every folders around the script except the "_installer" folder and re-install the environement by executing choices "1", "2" and "3" in the main menu.

Please don't disable the "Clean build" param except if you know what you do, enabling this param is more secure.

## Possible configurations before first launch or before repositories initialization/update

You can put some important files to automaticaly copy them during initialization/update of the repositories. The base folder for taht is "_installer/resources", then for each repository you have some possible configs:
* game-and-watch-backup/backups: Put your GnW dumps backups files "flash_backup_mario.bin", "internal_flash_backup_mario.bin", "itcm_backup_mario.bin", "flash_backup_zelda.bin", "internal_flash_backup_zelda.bin" and "itcm_backup_zelda.bin". If you don't have them you will need to make the backups manualy.
* game-and-watch-patch: You can put the GnW backups their, "flash_backup_mario.bin", "internal_flash_backup_mario.bin", "flash_backup_zelda.bin" and "internal_flash_backup_zelda.bin". This is not very usful if you have already copied them to "game-and-watch-backup/backups" or if you have made the backups manualy because the script will copy them automaticaly if needed.
* game-and-watch-smw/smw/assets: Put the US sfc rom of Super Mario World named "smw.sfc", required to build the project.
* game-and-watch-zelda3/zelda3/tables: Put the US sfc rom of Zelda3 named "zelda3.sfc", required to build the project. You can also put others sfc roms to use others languages, for example for french you must put the french rom of Zelda3 named "zelda3_fr.sfc".

## First launch

Execute the first, second and third choice in the main menu to install the environement. If you want to update the environement you can re-execute the second and third choice.

## Typical use

Most settings are set by default for a typical use, adjust them if you need before launching any script. If you close the script the settings will be reset to default. Most often you will need to change the size of the memory according to the one used on the Game-and-Watch, the model of the Game-and-Watch used and the boot type that you want. The settings are always displayed before the proposed choices in every menus.

The backups are not unic for each console, only for each model so if you've already have the backup files of hte model you don't need to make it again. If you don't have it you will need to do them in the GnW-Backup menu (choice "2" and "3" in this menu).

After this you will need to unlock the device (if you want to change the memory in the Game-and-Watch don't do it before unlocking it), this is the choice "4" in the GnW-Backup menu.

After this and eventualy after changing the memory of the Game-and-Watch you can flash what you want, if you want to have a dual boot with the original firmware and Retro-go ("Boot type" param is set by default for this configuration) you need to flash GnW-Patch (don't forget to put the backup files of the model you want to flash in the "game-and-watch-patch" folder) and the flash Retro-go, if you only want Retro-go you will only need to flash it with the single boot set for the "Boot type" param.

Note: With the explained dual boot configuration you can launch Retro-go with the shortcut "Game+left" on the original firmware.

## Credits

* [Game-and-watch-msys2]((https://github.com/ManCloud/game-and-watch-msys2)
* [Msys2](https://www.msys2.org/)
* [Wget](https://eternallybored.org/misc/wget)
* [Game-and-watch-backup](https://github.com/ghidraninja/game-and-watch-backup)
* [Game-and-watch-patch](https://github.com/BrianPugh/game-and-watch-patch)
* [Game-and-watch-retro-go](https://github.com/sylverb/game-and-watch-retro-go)
* [Game-and-watch-smw](https://github.com/marian-m12l/game-and-watch-smw)
* [Game-and-watch-zelda3](https://github.com/marian-m12l/game-and-watch-zelda3)