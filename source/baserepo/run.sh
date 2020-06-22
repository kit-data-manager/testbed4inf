#!/bin/bash

cd /kitdm20/base-repo/release
java -cp ".:./config:./base-repo.jar" -Dloader.path=file://`pwd`/base-repo.jar,./lib/,. -jar base-repo.jar

