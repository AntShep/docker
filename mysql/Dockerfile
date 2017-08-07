FROM mysql:5.6

RUN apt-get update -y

COPY ./dump/createDatabase.sql /tmp/
COPY ./dump/grants.sql /tmp/

WORKDIR /home/

RUN cat /tmp/createDatabase.sql | sed 's/${env}/dev/g' > createDatabase2.sql
RUN cat /tmp/grants.sql |sed 's/${env}/dev/g' > grants2.sql

RUN apt-get clean all && rm -rf /tmp/*

CMD sh -c "service mysql start"; /bin/bash

# Execute in runtime mode:
# cat createDatabase2.sql | mysql -uroot -p
# cat grants2.sql | mysql -uroot -p