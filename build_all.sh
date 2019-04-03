#!/usr/bin/env bash

conda activate cbuild

NAME=$1
echo "Building $NAME";
echo "PATH is $PATH"

CHANNELS="-c pdiakumis -c conda-forge -c bioconda -c defaults"
#PACKAGE_PATH=$(conda build $NAME $CHANNELS --output | tail -n1)
PACKAGE_PATH=$(conda build $NAME --output | tail -n1)
if [ -f $PACKAGE_PATH ] ; then
    echo "$PACKAGE_PATH exists, skipping"
else
    echo "Building $PACKAGE_PATH"
    conda build $NAME $CHANNELS
    anaconda upload $PACKAGE_PATH
    BASEDIR=$(dirname $(dirname $PACKAGE_PATH))
    FILENAME=$(basename $PACKAGE_PATH)
    echo "Converting packages into $BASEDIR"
    for PLATFORM in osx-64 linux-64 ; do
        if [ -f $BASEDIR/$PLATFORM/$FILENAME ] ; then
            echo "$BASEDIR/$PLATFORM/$FILENAME exists, skipping"
        else
            conda convert -p $PLATFORM $PACKAGE_PATH -o $BASEDIR -f
            anaconda upload $BASEDIR/$PLATFORM/$FILENAME
        fi
    done
fi
