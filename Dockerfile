FROM leandrosilva/php:5.6-apache

MAINTAINER Leandro Silva <leandro.silva@zoox.com.br>

RUN echo "AllowEncodedSlashes On" >> /etc/apache2/apache2.conf \
	&& sed -i 's!/var/www/html!/var/www!g' /etc/apache2/apache2.conf \
	&& cp /usr/src/php/php.ini-production /usr/local/etc/php/php.ini \
	&& sed -i 's/memory_limit\ =\ 128M/memory_limit\ =\ 512M/g' /usr/local/etc/php/php.ini \
	&& printf '[Date]\ndate.timezone=America/Sao_Paulo' > /usr/local/etc/php/conf.d/timezone.ini

RUN apt-get update && apt-get install -y freetds-dev libmagickwand-dev
RUN docker-php-ext-configure mssql --with-libdir=lib/x86_64-linux-gnu && docker-php-ext-install mssql
RUN docker-php-pecl-install imagick

WORKDIR /var/www

