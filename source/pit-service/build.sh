#!/bin/bash
set -e

SERVICE_NAME=pit-service

echo "Cloning remote repository."
cd /kitdm20/
#In order to clone a specific branch, e.g. a tagged release, you may add an additional argument --branch=<BRANCH_NAME>
git clone --recursive https://git.scc.kit.edu/kitdatamanager/2.0/$SERVICE_NAME.git
cd $SERVICE_NAME

echo "Building submodules and project from source."
# TODO test and asciidoctor fail, so they are excluded. Tracking issue: https://git.scc.kit.edu/kitdatamanager/2.0/docker-kitdm-2.0/-/issues/1
./gradlew -Pclean-release build --stacktrace

echo "Copying service and configuration files to release folder."
mkdir release
ls build/libs/
cp build/libs/$SERVICE_NAME.jar ./release
cp -R conf release/config

echo "Build done."
