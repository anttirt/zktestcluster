#!/bin/bash -e

echo Set up zookeeper cluster

cd /opt/zookeeper/zookeeper

if [ -e cluster/stop.sh ]; then
	cluster/stop.sh || true
fi

rm -rf cluster
mkdir -p cluster/server{1,2,3}/{conf,data,logs}

cp conf/log4j.properties cluster/server1/conf/
cp conf/log4j.properties cluster/server2/conf/
cp conf/log4j.properties cluster/server3/conf/

cat >cluster/server1/conf/zoo.cfg << EOF
tickTime=2000
dataDir=/opt/zookeeper/zookeeper/cluster/server1/data
clientPort=2181
initLimit=5
syncLimit=2
server.1=localhost:2888:3888
server.2=localhost:2889:3889
server.3=localhost:2890:3890
EOF

cat >cluster/server2/conf/zoo.cfg << EOF
tickTime=2000
dataDir=/opt/zookeeper/zookeeper/cluster/server2/data
clientPort=2182
initLimit=5
syncLimit=2
server.1=localhost:2888:3888
server.2=localhost:2889:3889
server.3=localhost:2890:3890
EOF

cat >cluster/server3/conf/zoo.cfg << EOF
tickTime=2000
dataDir=/opt/zookeeper/zookeeper/cluster/server3/data
clientPort=2183
initLimit=5
syncLimit=2
server.1=localhost:2888:3888
server.2=localhost:2889:3889
server.3=localhost:2890:3890
EOF

cat >cluster/server1/data/myid << EOF
1
EOF

cat >cluster/server2/data/myid << EOF
2
EOF

cat >cluster/server3/data/myid << EOF
3
EOF

cat >cluster/start.sh << EOF
#!/bin/sh
export ZOO_LOG_DIR=cluster/server1/logs; bin/zkServer.sh start cluster/server1/conf/zoo.cfg; unset ZOO_LOG_DIR
export ZOO_LOG_DIR=cluster/server2/logs; bin/zkServer.sh start cluster/server2/conf/zoo.cfg; unset ZOO_LOG_DIR
export ZOO_LOG_DIR=cluster/server3/logs; bin/zkServer.sh start cluster/server3/conf/zoo.cfg; unset ZOO_LOG_DIR
EOF
chmod 755 cluster/start.sh

cat >cluster/stop.sh << EOF
#!/bin/sh
bin/zkServer.sh stop cluster/server1/conf/zoo.cfg
bin/zkServer.sh stop cluster/server2/conf/zoo.cfg
bin/zkServer.sh stop cluster/server3/conf/zoo.cfg
EOF
chmod 755 cluster/stop.sh

cd /opt/zookeeper/zookeeper
cluster/start.sh

