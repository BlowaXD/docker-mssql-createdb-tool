# docker-mssql-createdb-tool
A docker that will create a database with the given ENV variables (used as an automatic dev tool mainly)


## How To use

Default command considering that `mssql-server-linux` is the name of your MSSQL Container
```
docker run mssql-tool-test --name test-db -e MSSQL_IP=database -e MSSQL_USER_ID=sa -e MSSQL_USER_PW=DevNos#2018 -e DATABASE_NAME=anothersharp DATABASE_OWNER_ID=anothersharp_user DATABASE_OWNER_PW=another_pass123 --link database:mssql-server-linux
```

Env variables : 
`MSSQL_IP`: Ip or domain that will be used to connect to MSSQL
`MSSQL_USER_ID`: MSSQL's user that has enough rights to connect to MSSQL to create the future database
`MSSQL_USER_PW`: MSSQL_USER_ID's password


`DATABASE_NAME`: Database that will be created by the script
`DATABASE_OWNER_ID`: Database owner that will be created by the script
`DATABASE_OWNER_PW`: Database owner's password that will be set by the script