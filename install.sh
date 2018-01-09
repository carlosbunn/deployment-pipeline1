#!/bin/bash
curl https://download.gocd.org/gocd.repo -o /etc/yum.repos.d/gocd.repo
yum -y install java-1.8.0-openjdk go-agent maven
sed -i "s|https://127.0.0.1:8154/go|https://138.197.76.246:8154|g" /etc/default/go-agent

echo "agent.auto.register.key=49016d72-878d-48ca-8263-735d7eb26019
agent.auto.register.resources=maven,java
agent.auto.register.environments=QA
agent.auto.register.hostname=Agent01" >> /var/lib/go-agent/config/autoregister.properties
/etc/init.d/go-agent start
