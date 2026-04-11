#!/bin/bash

# set library shared library path


if [ -d "${HOME}/tools" ];  then
    echo "Tools directory exists, linking shared.db to ${HOME}/tools/sioyek/shared.db"
    echo "shared_database_path  ${HOME}/tools/sioyek/shared.db" >> "${HOME}/.config/sioyek/prefs_user.config"
else 
    echo "Tools directory does not exist. Create first. Exiting..."
    exit 1
fi
