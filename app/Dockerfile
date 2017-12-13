FROM centos:7
RUN yum update -y

RUN yum install -y epel-release

RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm

RUN yum install -y \
	httpd-2.4.* \
	make\
	php56w \
	php56w-intl \
	php56w-mbstring \
	php56w-mcrypt \
	php56w-mysqlnd \
	php56w-pdo \
	php56w-xml \
	php56w-imap \
	php56w-opcache \
	php-pear \
	php56w-devel \
	python35 \
	python-pip \
	gcc \
	wget \
	git \
	composer \
	ImageMagick \
	ImageMagick-devel \
	ImageMagick-libs \
	mysql

RUN pecl install xdebug

RUN pip install virtualenv

ADD httpd/httpd.conf /etc/httpd/conf/httpd.conf
ADD httpd/conf.d/* /etc/httpd/conf.d/

RUN yum clean all && rm -rf /tmp/*

ADD php/php.ini /etc/php.ini
RUN pecl install imagick
RUN echo "extension=imagick.so" > /etc/php.d/imagick.ini

# Install Java JDK (jdk-8u151-linux-x64)
WORKDIR "~/"
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.rpm"
RUN yum localinstall -y jdk-8u151-linux-x64.rpm
RUN rm ./jdk-8u151-linux-x64.rpm

# Install Maven (apache-maven-3.5.2)
WORKDIR /usr/local
RUN wget http://www-eu.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
RUN tar xzf apache-maven-3.5.2-bin.tar.gz
RUN ln -s apache-maven-3.5.2  maven
RUN rm -f ./apache-maven-3.5.2-bin.tar.gz
ADD java/maven.settings.xml apache-maven-3.5.2/.m2/settings.xml
ENV M2_HOME=/usr/local/maven
ENV PATH=${M2_HOME}/bin:${PATH}

WORKDIR /var/www/

EXPOSE 80

RUN yum install -y redis php56w-pecl-redis
CMD sh -c "redis-server &"; httpd; /bin/bash
