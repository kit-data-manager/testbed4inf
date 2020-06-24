#!/usr/bin/env bash
set -e

function exec() {
    echo "BUILD-SCRIPT COMMAND:" $@
    $@
    return $?
}

function log() {
    echo "BUILD-SCRIPT LOG:" $@
}

function compile() {
    log "compile: $@"
    exec cd $1
    exec ./gradlew -Pclean-release build --debug
    # take the JAR to the BINARY_DIR
    exec cp $(ls build/libs/*.jar) $SCRIPT_DIR/$BINARY_DIR
    # configs are used from this repository.
}

BINARY_DIR=bin
REPO_DIR=tmp
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# check and create directories
exec cd $SCRIPT_DIR
if test ! -d $BINARY_DIR; then exec mkdir $BINARY_DIR; fi
if test ! -d $REPO_DIR; then exec mkdir $REPO_DIR; fi

for service in pit-service metastore2
do
    exec cd $SCRIPT_DIR/$REPO_DIR
    if test ! -d $service;
    then
        exec git clone --recursive git@git.scc.kit.edu:kitdatamanager/2.0/$service.git
    fi
    compile $service
done
