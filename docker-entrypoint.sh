#!/bin/bash

if [ ! -f /usr/local/tomcat/conf/tomcat-users.xml ]; then
  java -jar /root/mustache.jar /root/tomcat-users.xml > /usr/local/tomcat/conf/tomcat-users.xml
fi
if [ ! -d /usr/local/tomcat/webapps/mondrian ]; then
  mkdir /usr/local/tomcat/webapps/mondrian
  cd /usr/local/tomcat/webapps/mondrian
  unzip /usr/local/tomcat/webapps.dist/mondrian.war
  mv /usr/local/tomcat/webapps/mondrian/WEB-INF/classes/datasources.xml /usr/local/tomcat/webapps/mondrian/WEB-INF/classes/datasources.xml.orig
  java -jar /root/mustache.jar /root/datasources.xml > /usr/local/tomcat/webapps/mondrian/WEB-INF/classes/datasources.xml
fi

exec "$@"
