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

# Install "curl"
RUN apt-get install -y curl 
 
# Install the PHP pdo_mysql extention
RUN docker-php-ext-install pdo_mysql

# Install Tokenizer
RUN docker-php-ext-install tokenizer

# Install Mbstring
RUN apt-get install php7.2-mbstring
	
# Create directory for PHP-FPM socket.
RUN mkdir /run/php

# Import file system: Final.
COPY /container /

# Import app source.
COPY /src /app

# RUN Supervisor
CMD ["supervisord", "-n"]
