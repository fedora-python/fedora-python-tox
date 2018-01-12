#!/bin/sh

# This script will clone project from $GIT_URL (if defined)
# and run tox in project directory

TEMP_DIR=temp_project_dir

if [ ! -z $GIT_URL ]; then
    git clone $GIT_URL $TEMP_DIR && cd $TEMP_DIR
fi

/usr/bin/tox
