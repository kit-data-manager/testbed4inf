#!/bin/bash
set -e

if test $# -lt 2
then
    echo "No arguments supplied, expected two. Call was: $@"
    exit 1
fi

SERVICE_FOLDER=$1
BINARY_NAME=$2
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

function exec() {
    echo "RUN-SCRIPT COMMAND:" $@
    $@
    return $?
}

cd /$SCRIPT_DIR/$SERVICE_FOLDER/release
java -cp ".:./config:./$BINARY_NAME.jar" -Dloader.path=file://`pwd`/$BINARY_NAME.jar,./lib/,. -jar $BINARY_NAME.jar
