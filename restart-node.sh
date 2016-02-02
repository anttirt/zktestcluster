#!/bin/bash -xe

n=$1

if [ -z "$n" ]; then
	echo "Usage: $0 1|2|3"
fi

pushd /opt/zookeeper/zookeeper
export ZOO_LOG_DIR=cluster/server$n/logs
bin/zkServer.sh stop cluster/server$n/conf/zoo.cfg
bin/zkServer.sh start cluster/server$n/conf/zoo.cfg
