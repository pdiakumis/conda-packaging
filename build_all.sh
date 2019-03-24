#!/usr/bin/env bash

# courtesy of Vlad: NGS_Utils/conda_pkg/build_all.sh

# Builds and uploads packages for linux-32, linux-64, and macos, for py2 and py3

#. $HOME/my_apps/miniconda/etc/profile.d/conda.sh

#if ! command -v conda; then
#    echo "conda executable not in PATH: $PATH"
#    exit
#fi
#if ! command -v anaconda; then
#    echo "anaconda executable not in PATH: $PATH"
#    exit
#fi

function condabuildpy() {
    local NAME=$1
    echo "Building $NAME";

    CHANNELS="-c pdiakumis -c conda-forge -c bioconda -c defaults"
    for PY in 3.7 ; do
        PACKAGE_PATH=$(conda build $NAME $CHANNELS --output --py $PY | tail -n1)
        if [ -f $PACKAGE_PATH ] ; then
            echo "$PACKAGE_PATH exists, skipping"
        else
            echo "Building $PACKAGE_PATH"
            conda build $NAME $CHANNELS --py $PY
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
    done
}

function condabuildr() {
    local NAME=$1
    echo "Building $NAME";
    echo "PATH is $PATH"

    #CHANNELS="-c pdiakumis -c conda-forge -c bioconda -c defaults"
    #PACKAGE_PATH=$(conda build $NAME $CHANNELS --output | tail -n1)
    PACKAGE_PATH=$(conda build $NAME --output | tail -n1)
    if [ -f $PACKAGE_PATH ] ; then
        echo "$PACKAGE_PATH exists, skipping"
    else
        echo "Building $PACKAGE_PATH"
        conda build $NAME
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
}

