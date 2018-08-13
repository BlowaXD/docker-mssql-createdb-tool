FROM mcr.microsoft.com/mssql-tools

ENV MSSQL_IP=database \
    MSSQL_USER_ID=sa \
    MSSQL_USER_PW=strong_pass2018 \
    DATABASE_NAME=created_db \
    DATABASE_OWNER_ID=created_db_user \
    DATABASE_OWNER_PW=strong_pass2018
    
RUN mkdir -p /usr/src/app
COPY entrypoint.sh /usr/src/app/
WORKDIR /usr/src/app
RUN chmod +x /usr/src/app/entrypoint.sh

CMD /bin/bash ./entrypoint.sh