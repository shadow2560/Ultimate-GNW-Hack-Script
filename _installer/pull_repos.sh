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
	cd $S_DIR
else
    git clone --recurse-submodules https://github.com/ghidraninja/game-and-watch-backup.git ./../$folder
fi
cp -r ./resources/$folder/* ./../$folder/

echo ""

echo "--------------- game-and-watch-patch -----------------------------------------------"
folder=game-and-watch-patch
#rm -r ./../$folder
if [ -d "./../$folder" ]; then
	cd ./../$folder
	git pull --recurse-submodules
	cd $S_DIR
else
    git clone --recurse-submodules https://github.com/BrianPugh/game-and-watch-patch.git ./../$folder
fi
cp -r ./resources/$folder/* ./../$folder/

echo ""

echo "--------------- game-and-watch-retro-go --------------------------------------------"
folder=game-and-watch-retro-go
#rm -r ./../$folder
if [ -d "./../$folder" ]; then
	cd ./../$folder
	git pull --recurse-submodules
	cd $S_DIR
else
    git clone --recurse-submodules https://github.com/sylverb/game-and-watch-retro-go ./../$folder
fi
cp -r ./resources/$folder/* ./../$folder/

echo ""

echo "--------------- game-and-watch-zelda3 ----------------------------------------------"
folder=game-and-watch-zelda3
#rm -r ./../$folder
if [ -d "./../$folder" ]; then
	cd ./../$folder
	git pull --recurse-submodules
	cd $S_DIR
else
    git clone --recurse-submodules https://github.com/marian-m12l/game-and-watch-zelda3.git ./../$folder
fi
cp -r ./resources/$folder/* ./../$folder/