S_DIR=$(cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P)
cd $S_DIR

update_or_clone_project() {
    local project_name="$1"
    local folder="$2"
    local project_address="$3"
    local branch="$4"

    echo "--------------- $project_name ----------------------------------------------"
    #rm -r ./../$folder
    if [ -d "./../$folder" ]; then
        cd "./../$folder" || exit 1
        git fetch --all --recurse-submodules
        local effective_branch="$branch"
        if [ -z "$effective_branch" ]; then
            effective_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
        fi
        git reset --hard "origin/$effective_branch"
        git submodule update --init --recursive
        cd "$S_DIR" || exit 1
    else
        if [ -n "$branch" ]; then
            git clone --recurse-submodules -b "$branch" --single-branch "$project_address" "./../$folder"
        else
            git clone --recurse-submodules "$project_address" "./../$folder"
        fi
    fi
    cp -r "./resources/$folder/"* "./../$folder/"
}

echo "Installing or updating repositories"
echo ""

update_or_clone_project \
    "game-and-watch-backup" \
    "game-and-watch-backup" \
    "https://github.com/ghidraninja/game-and-watch-backup.git"

echo ""

update_or_clone_project \
    "game-and-watch-patch" \
    "game-and-watch-patch" \
    "https://github.com/shadow2560/game-and-watch-patch.git"

echo ""

update_or_clone_project \
    "game-and-watch-patch-old_method" \
    "game-and-watch-patch-old_method" \
    "https://github.com/shadow2560/game-and-watch-patch.git" \
    "old_method"

echo ""

update_or_clone_project \
    "game-and-watch-retro-go" \
    "game-and-watch-retro-go" \
    "https://github.com/shadow2560/game-and-watch-retro-go.git" \
    "filesystem_wip"

	# git clone --recurse-submodules https://github.com/sylverb/game-and-watch-retro-go.git ./../$folder
	# git clone --recurse-submodules -b filesystem_wip --single-branch https://github.com/sylverb/game-and-watch-retro-go.git ./../$folder
	 # git clone --recurse-submodules https://github.com/marian-m12l/game-and-watch-retro-go.git ./../$folder
	# git clone --recurse-submodules https://github.com/BenjaminSoelberg/game-and-watch-retro-go.git ./../$folder

echo ""

update_or_clone_project \
    "game-and-watch-zelda3" \
    "game-and-watch-zelda3" \
    "https://github.com/marian-m12l/game-and-watch-zelda3.git"

echo ""

update_or_clone_project \
    "game-and-watch-smw" \
    "game-and-watch-smw" \
    "https://github.com/marian-m12l/game-and-watch-smw.git"