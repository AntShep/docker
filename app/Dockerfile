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

WORKDIR /var/www/

EXPOSE 80

RUN yum install -y redis php56w-pecl-redis
CMD sh -c "redis-server &"; httpd; /bin/bash