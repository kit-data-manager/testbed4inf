#!/bin/bash
set -e

function exec() {
    echo "RUN-SCRIPT COMMAND:" $@
    $@
    return $?
}

function log() {
    echo "RUN-SCRIPT LOG:" $@
}

if test $# -lt 1
then
    echo "No arguments supplied, expected two. Call was: $@"
    exec exit 1
fi

BINARY_NAME=$1
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

log BINARY_NAME: $BINARY_NAME

exec cd $SCRIPT_DIR
exec java -cp ".:./config:./$BINARY_NAME" -Dloader.path=file://`pwd`/$BINARY_NAME,./lib/,. -jar $BINARY_NAME
