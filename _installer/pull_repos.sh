S_DIR=$(cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P)
cd $S_DIR

echo "Installing or updating repositories"
echo ""

echo "--------------- game-and-watch-backup ----------------------------------------------"
folder=game-and-watch-backup
#rm -r ./../$folder
if [ -d "./../$folder" ]; then
	cd ./../$folder
	git pull --recurse-submodules
	# git submodule update --init --recursive --remote --force
	cd $S_DIR
else
    git clone --recurse-submodules https://github.com/ghidraninja/game-and-watch-backup.git ./../$folder
	# cd ./../$folder
	# git submodule update --init --recursive --remote --force
	# cd $S_DIR
fi
cp -r ./resources/$folder/* ./../$folder/

echo ""

echo "--------------- game-and-watch-patch -----------------------------------------------"
folder=game-and-watch-patch
#rm -r ./../$folder
if [ -d "./../$folder" ]; then
	cd ./../$folder
	git pull --recurse-submodules
	# git submodule update --init --recursive --remote --force
	cd $S_DIR
else
	git clone --recurse-submodules https://github.com/BrianPugh/game-and-watch-patch.git ./../$folder
	# cd ./../$folder
	# git submodule update --init --recursive --remote --force
	# cd $S_DIR
fi
cp -r ./resources/$folder/* ./../$folder/

echo ""

echo "--------------- game-and-watch-patch-old_method -----------------------------------------------"
folder=game-and-watch-patch-old_method
#rm -r ./../$folder
if [ -d "./../$folder" ]; then
	cd ./../$folder
	git pull --recurse-submodules
	# git submodule update --init --recursive --remote --force
	cd $S_DIR
else
	git clone --recurse-submodules -b old_method --single-branch https://github.com/shadow2560/game-and-watch-patch.git ./../$folder
	# cd ./../$folder
	# git submodule update --init --recursive --remote --force
	# cd $S_DIR
fi
cp -r ./resources/$folder/* ./../$folder/

echo ""

echo "--------------- game-and-watch-retro-go --------------------------------------------"
folder=game-and-watch-retro-go
#rm -r ./../$folder
if [ -d "./../$folder" ]; then
	cd ./../$folder
	git pull --recurse-submodules
	# git submodule update --init --recursive --remote --force
	cd $S_DIR
else
	# git clone --recurse-submodules https://github.com/shadow2560/game-and-watch-retro-go.git ./../$folder
	# git clone --recurse-submodules -b filesystem --single-branch https://github.com/shadow2560/game-and-watch-retro-go.git ./../$folder
	git clone --recurse-submodules -b filesystem_wip --single-branch https://github.com/shadow2560/game-and-watch-retro-go.git ./../$folder
	# git clone --recurse-submodules https://github.com/sylverb/game-and-watch-retro-go.git ./../$folder
	# git clone --recurse-submodules -b filesystem --single-branch https://github.com/sylverb/game-and-watch-retro-go.git ./../$folder
	 # git clone --recurse-submodules https://github.com/marian-m12l/game-and-watch-retro-go.git ./../$folder
	# git clone --recurse-submodules https://github.com/BenjaminSoelberg/game-and-watch-retro-go.git ./../$folder
	# cd ./../$folder
	# git submodule update --init --recursive --remote --force
	# cd $S_DIR
fi
cp -r ./resources/$folder/* ./../$folder/

echo ""

echo "--------------- game-and-watch-zelda3 ----------------------------------------------"
folder=game-and-watch-zelda3
#rm -r ./../$folder
if [ -d "./../$folder" ]; then
	cd ./../$folder
	git pull --recurse-submodules
	# git submodule update --init --recursive --remote --force
	cd $S_DIR
else
    git clone --recurse-submodules https://github.com/marian-m12l/game-and-watch-zelda3.git ./../$folder
	# cd ./../$folder
	# git submodule update --init --recursive --remote --force
	# cd $S_DIR
fi
cp -r ./resources/$folder/* ./../$folder/

echo ""

echo "--------------- game-and-watch-SMW ----------------------------------------------"
folder=game-and-watch-smw
#rm -r ./../$folder
if [ -d "./../$folder" ]; then
	cd ./../$folder
	git pull --recurse-submodules
	# git submodule update --init --recursive --remote --force
	cd $S_DIR
else
    git clone --recurse-submodules https://github.com/marian-m12l/game-and-watch-smw.git ./../$folder
	# cd ./../$folder
	# git submodule update --init --recursive --remote --force
	# cd $S_DIR
fi
cp -r ./resources/$folder/* ./../$folder/