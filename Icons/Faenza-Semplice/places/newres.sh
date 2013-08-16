#!/bin/bash

[ ! -e $1 ] && mkdir $1

for file in scalable/*; do
	newfile=${file//'scalable'/$1}
	newfile=${newfile//'.svg'/'.png'}
	
	# Check if it's a link
	lnk="`readlink $file`"
	if [ "$?" = "1" ]; then
		# Not a link, convert...
		inkscape -z -e $newfile -w $1 -h $1 $file
	else
		# Link. Copy it.
		ln -s ${lnk//'.svg'/'.png'} $newfile
	fi
done
