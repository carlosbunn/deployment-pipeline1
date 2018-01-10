#!/bin/bash

AGENT_KEY=$1

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
update-locale
locale
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections

echo "deb https://download.gocd.org /" | sudo tee /etc/apt/sources.list.d/gocd.list
curl https://download.gocd.org/GOCD-GPG-KEY.asc | sudo apt-key add -

add-apt-repository ppa:webupd8team/java -y
apt-get update
apt-get install oracle-java8-installer maven git go-agent -y

sed -i "s|https://127.0.0.1:8154/go|https://138.197.76.246:8154/go|g" /etc/default/go-agent
sed -i -E 's|AGENT_WORK_DIR=.*$|AGENT_WORK_DIR=/app|g' /etc/default/go-agent
mkdir -p /app/jar /app/config/
chmod -R 777 /app

echo "agent.auto.register.key=$AGENT_KEY
agent.auto.register.resources=maven,java
agent.auto.register.environments=PROD
agent.auto.register.hostname=$(hostname)" >> /app/config/autoregister.properties
/etc/init.d/go-agent start

curl https://raw.githubusercontent.com/carlosbunn/deployment-pipeline1/master/calculator-service > /etc/init.d/calculator-service
chmod 755 /etc/init.d/calculator-service

