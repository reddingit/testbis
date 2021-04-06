#!/bin/bash
set -e

proxyServerUrl=$1

do_install() {
	echo "# Executing bistoury install script, args: ${@}"
	mkdir -p /opt/bistoury
	cd /opt/bistoury
	curl -O https://arthas.aliyun.com/bistoury-agent-bin.tar.gz
	tar -zxvf bistoury-agent-bin.tar.gz
	cd ./bin
	sed -i 's,BISTOURY_APP_LIB_CLASS,BISTOURY_PROXY_HOST="'${proxyServerUrl}'"\nBISTOURY_APP_LIB_CLASS,' bistoury-agent-env.sh
	target_pid=`jps -l | grep -i org.springframework.boot.loader.JarLauncher | awk '{print $1}' | sort -n -k 1 | head -n 1`
	./bistoury-agent.sh -p ${target_pid} -j $JAVA_HOME restart
	echo "# Start bistoury, command: ./bistoury-agent.sh -p ${target_pid} -j $JAVA_HOME restart"
}

do_install
