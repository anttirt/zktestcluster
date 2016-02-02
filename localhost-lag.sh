#!/bin/bash -e

timespec=$1

if sudo tc qdisc | grep 'netem .: dev lo root'; then
	sudo tc qdisc del dev lo root
	echo Removed old latency emulation
fi

if [ -n "$timespec" ]; then
	echo Add $timespec latency to loopback
	sudo tc qdisc add dev lo root handle 1:0 netem delay $1
fi

