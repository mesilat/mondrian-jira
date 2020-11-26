FROM tomcat:9-jdk15-openjdk-slim

ENV XMLA_USER xmla
ENV XMLA_PASSWORD secret
ENV POSTGRES_URL jdbc:postgresql://postgres:5432/jira
ENV POSTGRES_USER jira_user
ENV POSTGRES_PASSWORD secret

RUN apt-get update \
 && apt-get install -y wget unzip

COPY tomcat-users.xml /root
COPY datasources.xml /root
COPY docker-entrypoint.sh /root
COPY target/mondrian.war /usr/local/tomcat/webapps.dist

RUN cd /root \
 && wget -q https://bitbucket.org/babinvn/mustache-cli/downloads/mustache.jar \
 && mv /usr/local/tomcat/conf/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml.orig \
 && wget -q https://jdbc.postgresql.org/download/postgresql-42.2.18.jar \
 && mv postgresql-42.2.18.jar /usr/local/tomcat/lib/

ENTRYPOINT ["/root/docker-entrypoint.sh"]
CMD ["catalina.sh", "run"]
