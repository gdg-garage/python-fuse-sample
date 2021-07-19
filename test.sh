#!/usr/bin/env bash

set -eu

hr() {
	echo "======================================" >>$log
}

dumb_and_dangerous() {
	hr
	printf "\n" >>$log
	hr
	for x; do
		printf "%s " "$x" >>$log
	done
	printf "\n" >>$log
	hr
	sleep .1
	eval "$@" >/dev/null
}

#log=log/$$.log
log=/dev/stdout

printf "\n\n" >>$log
hr
echo "TEST RUN" >>$log
date >>$log

(python3 passthrough.py /real /fuse >>$log) &
(python3 passthrough.py /real2 /fuse2 >>$log) &

dumb_and_dangerous touch /fuse/touched
dumb_and_dangerous touch /fuse/touched
dumb_and_dangerous ls /fuse/touched
dumb_and_dangerous ls /fuse/
dumb_and_dangerous rm /fuse/touched
dumb_and_dangerous echo "xxx" \> /fuse/echo
dumb_and_dangerous ls /fuse/echo
dumb_and_dangerous cat /fuse/echo
dumb_and_dangerous mv /fuse/echo /fuse/mv
dumb_and_dangerous mv /fuse/mv /fuse2/mv
#dumb_and_dangerous mv /fuse/mv /fuse2/mv
dumb_and_dangerous cp /fuse2/mv /fuse2/cp
dumb_and_dangerous cp /fuse2/cp /fuse/cp
dumb_and_dangerous chmod 777 /fuse2/cp
dumb_and_dangerous chown root:root /fuse2/cp
dumb_and_dangerous mkdir /fuse/aaa
dumb_and_dangerous mkdir -p /fuse/a/b/c
dumb_and_dangerous rm -rf /fuse/aaa
dumb_and_dangerous ln -s /fuse/cp /fuse/cp-sl
dumb_and_dangerous ln -s /fuse/cp /fuse2/cp-sl
dumb_and_dangerous ln /fuse/cp /fuse/cp-hl

hr
