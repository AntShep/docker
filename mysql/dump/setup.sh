#!/bin/bash
cat data/createDatabase.sql | sed 's/${env}/dev/g' > createDatabase2.sql
cat data/grants.sql |sed 's/${env}/dev/g' > grants2.sql

query="UPDATE mysql.user SET Password=PASSWORD('$(echo $MYSQL_ROOT_PASSWORD)') where USER='root';flush privileges;"
mysql -uroot -e "$query"
cat createDatabase2.sql | mysql -uroot -proot
cat grants2.sql | mysql -uroot -proot