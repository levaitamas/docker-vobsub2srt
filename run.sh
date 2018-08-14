#!/bin/bash

mkdir -p /tmp/subtitles

echo "Copy subfile.idx and subfile.sub into /tmp/subtitles"
echo "Then run $ conv subfile"
echo "A subfile.srt will be created"

docker run \
    --rm -ti \
    --volume /tmp/subtitles:/subs \
    vobsub2srt
