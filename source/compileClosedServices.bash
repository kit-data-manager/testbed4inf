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
    exec $2
    # take the JAR to the BINARY_DIR
    exec cp $(ls build/libs/*.jar) $SCRIPT_DIR/$BINARY_DIR/$service.jar
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
    # defaults for most applications:
    GIT_URL=git@git.scc.kit.edu:kitdatamanager/2.0/$service.git
    COMPILE_CMD="./gradlew -Pclean-release build --warning-mode all"

    # Workaround for metastore2 because it is WIP.
    if test $service = metastore2;
    then
        GIT_URL="git@git.scc.kit.edu:td5416/metastore2.git --branch=migrateApiDoc"
        COMPILE_CMD="./gradlew -Pclean-release build -x test -x asciidoctor --stacktrace"
    fi

    exec cd $SCRIPT_DIR/$REPO_DIR
    if test ! -d $service;
    then
        exec git clone --recursive $GIT_URL
    fi
    compile $service "$COMPILE_CMD"
done
