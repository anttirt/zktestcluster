#!/bin/bash -e

version=3.4.6

cd /opt
if [ -e zookeeper ]; then
	exit 0
fi

echo Install java

apt-get update && apt-get install -y openjdk-7-jre

echo Install zookeeper in /opt/zookeeper/zookeeper

mkdir zookeeper
pushd zookeeper
wget http://www.nic.funet.fi/pub/mirrors/apache.org/zookeeper/zookeeper-${version}/zookeeper-${version}.tar.gz &>/dev/null
tar xf zookeeper-${version}.tar.gz
rm zookeeper-${version}.tar.gz
ln -s zookeeper-${version} zookeeper
popd
chown -R vagrant:vagrant zookeeper
