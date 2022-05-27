#!/bin/sh -e

# This script will clone project from $GIT_URL (if defined)
# and run tox in project directory

TEMP_DIR=temp_project_dir

if [ ! -z $GIT_URL ]; then
    git clone $GIT_URL $TEMP_DIR && cd $TEMP_DIR
fi

if [ ! -z "$DNF_INSTALL" ]; then
    dnf -y --setopt=tsflags=nodocs --setopt=deltarpm=false install $DNF_INSTALL
fi

# Mark the current directory as safe for Git:
git --git-dir=~ config --system --add safe.directory $PWD

/usr/bin/tox $TOX_PARAMS
