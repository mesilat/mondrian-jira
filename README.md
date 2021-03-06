# Mondrian for JIRA Server

This is Mondrian 4 server for Atlassian JIRA based on Pentaho Mondrian 4.3.0.1.2-SPARK.
To build the docker image:

```
mvn package
docker build -t mondrian-jira .
```

Or you can use public image:

```
docker run -p 8080:8080 \
-e "XMLA_USER=<xmla user>" \
-e "XMLA_PASSWORD=<xmla password>" \
-e "POSTGRES_URL=jdbc:postgresql://postgres:5432/jira" \
-e "POSTGRES_USER=<postgres user>" \
-e "POSTGRES_PASSWORD=<postgres password>" \
-v "$(pwd)/webapps:/usr/local/tomcat/webapps" \
-v "$(pwd)/logs:/usr/local/tomcat/logs" \
mesilat/mondrian-jira
```

To debug:

```
docker run -p 8080:8080 -p 5000:5000 \
-e "XMLA_USER=<xmla user>" \
-e "XMLA_PASSWORD=<xmla password>" \
-e "POSTGRES_URL=jdbc:postgresql://postgres:5432/jira" \
-e "POSTGRES_USER=<postgres user>" \
-e "POSTGRES_PASSWORD=<postgres password>" \
-e "JAVA_OPTS=-agentlib:jdwp=transport=dt_socket,address=*:5000,server=y,suspend=n" \
-v "$(pwd)/webapps:/usr/local/tomcat/webapps" \
-v "$(pwd)/logs:/usr/local/tomcat/logs" \
mesilat/mondrian-jira
```

Using with RDBMS other than PostgreSQL:

## MS SQL Server

Download `mssql-jdbc` driver from
https://docs.microsoft.com/en-us/sql/connect/jdbc/microsoft-jdbc-driver-for-sql-server
The following example uses `mssql-jdbc-7.2.1.jre8.jar` driver:

```
docker run -p 8080:8080 \
-e "XMLA_USER=<xmla user>" \
-e "XMLA_PASSWORD=<xmla password>" \
-e "MSSQL_URL=jdbc:sqlserver://mssql:1433;jdbc.databaseName=jiradb" \
-e "MSSQL_USER=<mssql user>" \
-e "MSSQL_PASSWORD=<mssql password>" \
-v "$(pwd)/webapps:/usr/local/tomcat/webapps" \
-v "$(pwd)/logs:/usr/local/tomcat/logs" \
-v "$(pwd)/mssql-jdbc-7.2.1.jre8.jar:/usr/local/tomcat/lib/mssql-jdbc.jar:ro" \
mesilat/mondrian-jira
```

## MySQL

Download MySQL Java connector from https://dev.mysql.com/downloads/connector/j/
The following example uses `mysql-connector-java-8.0.22.jar` driver:

```
docker run -p 8080:8080 \
-e "XMLA_USER=<xmla user>" \
-e "XMLA_PASSWORD=<xmla password>" \
-e "MYSQL_URL=jdbc:mysql://mysql:3306/jiradb" \
-e "MYSQL_USER=<mysql user>" \
-e "MYSQL_PASSWORD=<mysql password>" \
-v "$(pwd)/webapps:/usr/local/tomcat/webapps" \
-v "$(pwd)/logs:/usr/local/tomcat/logs" \
-v "$(pwd)/mysql-connector-java-8.0.22.jar:/usr/local/tomcat/lib/mysql-connector.jar:ro" \
mesilat/mondrian-jira
```

## Oracle

Download Oracle JDBC driver from Oracle http://www.oracle.com/technetwork/database/features/jdbc/jdbc-ucp-122-3110062.html
The following example uses `ojdbc8.jar` driver:

```
docker run -p 8080:8080 \
-e "XMLA_USER=<xmla user>" \
-e "XMLA_PASSWORD=<xmla password>" \
-e "ORACLE_URL=jdbc:oracle:thin:@//oracle:1521/jiradb" \
-e "ORACLE_USER=<oracle user>" \
-e "ORACLE_PASSWORD=<oracle password>" \
-v "$(pwd)/webapps:/usr/local/tomcat/webapps" \
-v "$(pwd)/logs:/usr/local/tomcat/logs" \
-v "$(pwd)/ojdbc8.jar:/usr/local/tomcat/lib/ojdbc8.jar:ro" \
mesilat/mondrian-jira
```

## Using without Docker

To use this application with a standalone Tomcat:

- Install Apache Tomcat 9 or later
- Download JDBC driver for your JIRA database and save it to `${TOMCAT_HOME}/lib` directory
- Edit the `${TOMCAT_HOME}/lib/tomcat-users.xml` file and add some users with `xmla_user` role; these are the credentials you use to connect to your Mondrian server
- Deploy the `mondrian.war` application
- Edit Mondrian schema file at `${TOMCAT_HOME}/webapps/mondrian/WEB-INF/classes/schemas/default.xml` (or alternatively you may download one from Confluence Custom Fields plugin for JIRA administration page as described in the [plugin documentation](https://www.mesilat.com/confluence-fields.html))
- Edit `${TOMCAT_HOME}/webapps/mondrian/WEB-INF/classes/datasources.xml` and update the `DataSourceInfo` property to match your JIRA database connection settings
- Edit `${TOMCAT_HOME}/webapps/mondrian/WEB-INF/classes/mondrian.properties` if required. For details please refer to [Mondrian documentation](https://mondrian.pentaho.com/documentation/configuration.php)

## Using with MS Excel

You can use this application with MS Excel for Windows and [XMLA Connect](https://sourceforge.net/projects/xmlaconnect/). For details please refer to the [plugin documentation](https://www.mesilat.com/confluence-fields.html).

## Troubleshooting

Logs could be found in file `${TOMCAT_HOME}/logs/xmla.log`. To manage logs please edit the configuration file `${TOMCAT_HOME}/webapps/mondrian/WEB-INF/classes/log4j.properties`.

