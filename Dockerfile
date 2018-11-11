# Start
FROM ubuntu:bionic

# Make existing software up to date.
RUN apt-get update
RUN apt-get dist-upgrade -y

# Install nano
RUN apt-get install -y nano

# Install Supervisor
RUN apt-get install -y supervisor

# Install Nginx
RUN apt-get install -y nginx

# Install PHP-FPM
RUN apt-get install -y php7.2-fpm

# Install "curl", "libmemcached-dev", "libpq-dev", "libjpeg-dev",
# "libpng-dev", "libfreetype6-dev", "libssl-dev", "libmcrypt-dev",
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    curl \
    libmemcached-dev \
    libz-dev \
    libpq-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libssl-dev \
    libmcrypt-dev \
  && rm -rf /var/lib/apt/lists/*


 
# Install the PHP pdo_mysql extention
RUN docker-php-ext-install pdo_mysql \
# Install the PHP pdo_pgsql extention
&& docker-php-ext-install pdo_pgsql \
# Install the PHP gd library
&& docker-php-ext-configure gd \
  --with-jpeg-dir=/usr/lib \
  --with-freetype-dir=/usr/include/freetype2 && \
  docker-php-ext-install gd

# Install Tokenizer
RUN docker-php-ext-install tokenizer
	
# Create directory for PHP-FPM socket.
RUN mkdir /run/php

# Import file system: Final.
COPY /container /

# Import app source.
COPY /src /app

# RUN Supervisor
CMD ["supervisord", "-n"]
