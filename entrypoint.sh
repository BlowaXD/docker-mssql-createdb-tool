#!/bin/bash

SQL_FILE=setup.sql

#run the setup script to create the DB and the schema in the DB
if [ ! -f .created ] 
then
    # create the SQL script
    # create db
    echo "CREATE DATABASE $DATABASE_NAME" > $SQL_FILE

    # use db
    echo "USING $DATABASE_NAME" >> $SQL_FILE

    # create db owner
    echo "CREATE LOGIN $DATABASE_OWNER_ID" >> $SQL_FILE
    echo "WITH PASSWORD $DATABASE_OWNER_PW" >> $SQL_FILE
    echo "GO" >> $SQL_FILE

    # - Creates a database user for the login created above.  
    echo "CREATE USER $DATABASE_OWNER_ID FOR LOGIN $DATABASE_OWNER_ID;" >> $SQL_FILE
    echo "GO" >> $SQL_FILE

    # connect to db and execute the script
    /opt/mssql-tools/bin/sqlcmd -S "$MSSQL_IP" -U "$MSSQL_USER_ID" -P "$MSSQL_USER_PW" -d master -i $SQL_FILE
    # db created, setup a file for that
    touch .created
fi