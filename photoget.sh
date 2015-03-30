#!/bin/sh

TMP_DIR=/tmp/photos-tmp
DOWNLOAD_HOME=/disks/beta/media/photos

download_all() {
    SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
    mkdir -p $TMP_DIR
    cd $TMP_DIR
    TODAY=$(date +%Y-%m-%d)
    echo dollar "$1"
    if [ -z "$1" ];
    then
	DOWNLOAD_DIR="$DOWNLOAD_HOME/$TODAY"
    else
	DOWNLOAD_DIR="$DOWNLOAD_HOME/$1"
    fi
    mkdir -p "$DOWNLOAD_DIR"
    export "DOWNLOAD_DIR"
    echo $DOWNLOAD_DIR
    gphoto2 --get-all-files --hook-script $SCRIPT_DIR/download.sh
    gphoto2 --get-all-raw-data --hook-script $SCRIPT_DIR/download.sh
    rm -rf "$TMP_DIR"
}

hook() {
    mv -n "$ARGUMENT" "$DOWNLOAD_DIR"
} 

# Find location of this script
if [ -z "$ACTION" ]; 
then
    download_all "$1"
else
    if [ "$ACTION" = "download" ]; 
    then
	hook
    fi
fi
