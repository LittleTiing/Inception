#!/bin/sh

# if mysqld not present
if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
fi

# Change owner to solve socket error
chown -R mysql:mysql /run/mysqld

# Datadir must owned by mysql user
chown -R mysql:mysql /var/lib/mysql

# if database not exists
if [ ! -d "/var/lib/mysql/mysql" ]; then
    # install database
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql

    # run mktemp command to create tempfile and save file path
    tempFile=`mktemp`
    # if create file fail
    if [ ! -f "$tempFile"]; then
        tempFile = "/tmp/tmp.file"
        touch tempFile
    fi

    cat << END_OF_CAT > $tempFile
USE mysql;
FLUSH PRIVILEGES;

ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';

CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};
CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
FLUSH PRIVILEGES;
END_OF_CAT

    # init database with tempFile content
    /usr/bin/mysqld --user=mysql --bootstrap < $tempFile
    rm -f $tempFile

fi

/usr/bin/mysqld --user=mysql --skip-name-resolve --skip-networking=0