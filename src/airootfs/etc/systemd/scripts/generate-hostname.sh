#!/bin/sh

FILES=/sys/class/net
for f in $FILES/e*
do
  cat $f/address
done

MAC=`sed 's/://g' $f/address`
#MAC=`echo $MAC | sed 's/\(.*\)/\U\1/'`

echo bat-${MAC} > /etc/hostname
