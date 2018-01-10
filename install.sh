#!/bin/bash

AGENT_KEY=$1

curl https://download.gocd.org/gocd.repo -o /etc/yum.repos.d/gocd.repo
yum -y install java-1.8.0-openjdk go-agent maven git
sed -i "s|https://127.0.0.1:8154/go|https://138.197.76.246:8154/go|g" /etc/default/go-agent

echo "agent.auto.register.key=$AGENT_KEY
agent.auto.register.resources=maven,java
agent.auto.register.environments=QA
agent.auto.register.hostname=Agent01" >> /var/lib/go-agent/config/autoregister.properties
/etc/init.d/go-agent start

curl https://raw.githubusercontent.com/carlosbunn/deployment-pipeline1/master/calculator-service > /etc/init.d/calculator-service
chmod 755 /etc/init.d/calculator-service
