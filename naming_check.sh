#!/bin/bash
# ch if the name contains only small or capital letter or _
case $* in
	+([A-Za-z0-9_]) )
		res="valid"
		;;
	*)
		echo "name can only contains small or capital letter or _"
		res="notvalid"
		;;
esac
