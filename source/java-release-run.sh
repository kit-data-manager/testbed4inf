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
    echo "No arguments supplied, expected two. Call was: $@"
    exec exit 1
fi

SERVICE_FOLDER=$1
BINARY_NAME=$2
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

log SERVICE_FOLDER: $SERVICE_FOLDER
log BINARY_NAME: $BINARY_NAME

exec cd $SCRIPT_DIR/$SERVICE_FOLDER/release
exec java -cp ".:./config:./$BINARY_NAME.jar" -Dloader.path=file://`pwd`/$BINARY_NAME.jar,./lib/,. -jar $BINARY_NAME.jar
