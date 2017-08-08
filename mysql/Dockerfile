FROM mysql:5.6

RUN apt-get update -y
RUN apt-get install -y less

RUN mysqld_safe --skip-grant-tables &

WORKDIR /home/

RUN mkdir data

COPY ./dump/setup.sh .
RUN chmod 760 setup.sh

RUN apt-get clean all

CMD sh -c "service mysql start && ./setup.sh"; /bin/bash