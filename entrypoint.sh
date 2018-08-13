#!/bin/bash

CREATION_SQL_DB=creation.sql
SQL_FILE=setup.sql

#run the setup script to create the DB and the schema in the DB
if [ ! -f .created ] 
then
    # create the SQL script
    # create db
    echo "CREATE DATABASE $DATABASE_NAME;" > $CREATION_SQL_DB
    /opt/mssql-tools/bin/sqlcmd -S "$MSSQL_IP" -U "$MSSQL_USER_ID" -P "$MSSQL_USER_PW" -d master -i $CREATION_SQL_DB

    # use db
    # echo "USING $DATABASE_NAME" > $SQL_FILE
    # echo "GO" >> $SQL_FILE

    # create db's owner
    echo "CREATE LOGIN $DATABASE_OWNER_ID" >> $SQL_FILE
    echo "WITH PASSWORD = 'strong_pass2018'," >> $SQL_FILE
    echo -e "\tCHECK_POLICY = OFF," >> $SQL_FILE
    echo -e "\tCHECK_EXPIRATION = OFF;" >> $SQL_FILE
    echo "GO" >> $SQL_FILE

    # setup db's owner's role
    echo "IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'$DATABASE_OWNER_ID')" >> $SQL_FILE
    echo "BEGIN">> $SQL_FILE
    echo -e "\tCREATE USER $DATABASE_OWNER_ID FOR LOGIN $DATABASE_OWNER_ID" >> $SQL_FILE
    echo -e "\tEXEC sp_addrolemember N'db_owner', N'$DATABASE_OWNER_ID'" >> $SQL_FILE

    echo "END;" >> $SQL_FILE
    echo "GO" >> $SQL_FILE

    # connect to db and execute the script
    /opt/mssql-tools/bin/sqlcmd -S "$MSSQL_IP" -U "$MSSQL_USER_ID" -P "$MSSQL_USER_PW" -d "$DATABASE_NAME" -i $SQL_FILE

    # db created, setup a file to not recreate db each container's instance's reboot
    touch .created
fi