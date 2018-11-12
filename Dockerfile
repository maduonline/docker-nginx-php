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
	
# Create directory for PHP-FPM socket.
RUN mkdir /run/php

# Import file system: Final.
COPY /container /

# Import app source.
COPY /src /app

# RUN Supervisor
CMD ["supervisord", "-n"]
