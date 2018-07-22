FROM mcr.microsoft.com/mssql-tools

ENV MSSQL_IP=database \
    MSSQL_USER_ID=sa \
    MSSQL_USER_PW=SA_PASSWORD \
    DATABASE_NAME=database \
    DATABASE_OWNER_ID=database_owner \
    DATABASE_OWNER_PW=database_owner_pw

    
RUN mkdir -p /usr/src/app
COPY entrypoint.sh /usr/src/app/
WORKDIR /usr/src/app
RUN chmod +x /usr/src/app/entrypoint.sh

CMD /bin/bash ./entrypoint.sh