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
dumb_and_dangerous ls /fuse/
dumb_and_dangerous echo "xxx" \> /fuse/echo
dumb_and_dangerous mv /fuse/echo /fuse/mv
dumb_and_dangerous mv /fuse/mv /fuse2/mv
dumb_and_dangerous mv /fuse/mv /fuse2/mv

hr
