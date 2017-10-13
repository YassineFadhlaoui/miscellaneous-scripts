#!/bin/bash

formats=$(youtube-dl -F $1 | grep "audio only" | awk '{print $1}')
tmp_max=0
function max()
{
for i in $formats
do
if [ $i -gt $tmp_max ]
then
tmp_max=$i
fi

done
}
max
best=$tmp_max


youtube-dl -f $best --restrict-filenames  $1
last_download= youtube-dl -f 171 --get-filename --restrict-filenames $1
echo "download complete"
echo "converting to mp3"
if test -e $last_download
then
echo "yes"
fi
