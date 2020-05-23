#!/bin/sh

x=1

IMAGE_DIRECTORY="${1:-images}"

rm -rf ./tmp/*.jpg

for i in $(ls -r -t ./"${1:-images}"/*jpg); do
  counter=$(printf %03d $x)
  ln -s ../"$i" ./tmp/img"$counter".jpg
  x=$(($x+1))
done

FRAME_RATE="${2:-24}"
VIDEO_FILENAME=timelapse_`date +%s`.mov

# compile video
ffmpeg -r $FRAME_RATE -i ./tmp/img%03d.jpg -b 15000k $VIDEO_FILENAME
