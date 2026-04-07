FROM adminer:5.4.2

USER root
RUN apk add --no-cache --virtual .php-ext-deps unixodbc freetds
RUN apk add --no-cache --virtual .build-deps unixodbc-dev freetds-dev
RUN docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr 
RUN docker-php-ext-install pdo_odbc pdo_dblib
RUN apk del .build-deps && rm -rf /var/cache/apk/*
USER adminer
