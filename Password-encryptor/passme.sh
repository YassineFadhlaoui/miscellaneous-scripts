#!/bin/bash
cd ~
openssl aes-256-cbc -d -in .pass.enc -out .pass.txt
BEFORE_VIEW=$(md5sum .pass.txt | awk {'print $1'})
nano .pass.txt
AFTER_VIEW=$(md5sum .pass.txt | awk {'print $1'})
echo "verifying Hash"
if [ "$BEFORE_VIEW" != "$AFTER_VIEW" ]
then 
echo "changes accured"
openssl aes-256-cbc -in .pass.txt -out .pass.enc
else
echo "no changes"
fi
echo "cleaning traces ..."
rm -f .pass.txt
