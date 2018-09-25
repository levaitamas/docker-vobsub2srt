#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

docker build --tag vobsub2srt "$SCRIPTPATH"
