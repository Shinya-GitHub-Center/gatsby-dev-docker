#!/bin/bash

# Please execute this script upon attaching to the container
# This script won't install gatsby-cli globally, but cloning from repo and yarn install

# Getting variables from external txt file
. /home/node/workdir/variables.txt
# .LocalDevFiles init
rm -f ./"$ADDLDIR"/delete-this-file_m32dzcVZ5gm6.txt
# This is a recommended setting for VSCode users
if [ -d "$VSCDIR" ]; then
    if [ ! -f "$VSCJSON" ]; then
        echo -e "$VSCSET" >"$VSCJSON"
    fi
    code --install-extension donjayamanne.githistory
fi
# Store git-credentials at container home dir upon first time git authorization
git config --global credential.helper store
# Skip this field if app repo is already installed into current directory
if [ ! -d "$REPODIR" ]; then
    git clone "$RMT_REPO_ADDR"
    # Copy the locally-unique file such as API-key file into app repository if necessary
    if [ -n "$(ls -A "$ADDLDIR")" ]; then
        cp -r ./"$ADDLDIR"/. ./"$REPODIR"
    fi
fi
# Move to app repository
cd "$REPODIR" || exit 1
# Store git user info locally
git config user.name "$GIT_UNAME"
git config user.email "$GIT_UMAIL"
# If you want to use VSCode for default git editor
if [ -d "$VSCDIR" ]; then
    git config core.editor "code --wait"
else
    git config core.editor "vim"
fi
# Module installation if necessary
if [ ! -d "$MDLDIR" ]; then
    yarn install
fi
