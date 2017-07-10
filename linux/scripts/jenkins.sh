#!/usr/bin/env bash

sudo yum update -y
sudo yum install -y epel-release
sudo yum install -y java-1.8.0-openjdk.x86_64
sudo su -c 'cat > /etc/profile.d/java.sh <<EOF
export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk
export JRE_HOME=/usr/lib/jvm/jre
EOF'
sudo curl -o /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key
sudo yum install -y jenkins
sudo echo "JENKINS_JAVA_OPTIONS=\"$JENKINS_JAVA_OPTIONS -Djava.io.tmpdir=/var/tmp\"" >> /etc/sysconfig/jenkins
sudo systemctl enable jenkins
sudo sed -i '/dport 22/a -A INPUT -p tcp -m state --state NEW -m tcp --dport 8080 -j ACCEPT' /etc/sysconfig/iptables
sudo su -c 'echo COMMIT >> /etc/sysconfig/iptables'

