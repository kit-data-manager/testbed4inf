#!/bin/bash
set -e

function exec() {
    echo "BUILD-SCRIPT COMMAND:" $@
    $@
    return $?
}

function log() {
    echo "BUILD-SCRIPT LOG:" $@
}

if test $# -lt 2
then
    log "No arguments supplied, expected two. Call was:" $@
    exit 1
fi

SERVICE_FOLDER=$1
BINARY_NAME=$2
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

log "Cloning remote repository into $SCRIPT_DIR."
exec cd $SCRIPT_DIR
#In order to clone a specific branch, e.g. a tagged release, you may add an additional argument --branch=<BRANCH_NAME>
exec git clone --recursive https://github.com/kit-data-manager/$SERVICE_FOLDER.git
exec cd $SERVICE_FOLDER

log "Building submodules and project from source."
exec ./gradlew -Pclean-release build --stacktrace

log "Copying service and configuration files to release folder."
exec mkdir release
exec cp build/libs/$BINARY_NAME.jar ./release
exec cp -R conf release/config

log "Build done."
