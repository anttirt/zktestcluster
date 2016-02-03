#!/bin/bash -xe

leader_id=$(grep -e '- LEADING -' /opt/zookeeper/zookeeper/cluster/server*/logs/zookeeper.out | sort | tail -1 | sed -E 's/.*myid:([0-9]+).*/\1/')

pushd /opt/zookeeper/zookeeper
export ZOO_LOG_DIR=cluster/server$leader_id/logs
bin/zkServer.sh stop cluster/server$leader_id/conf/zoo.cfg
bin/zkServer.sh start cluster/server$leader_id/conf/zoo.cfg

