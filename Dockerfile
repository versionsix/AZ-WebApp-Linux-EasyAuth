FROM ubuntu:16.04

# AZ Webapp config + packages.
# Note the SSH-sshd_config. This is because azure wants a custom ssh setup to connect their web-ssh system to the container.
ENV SSH_PASSWD "root:Docker!"
RUN apt-get update \
        && apt-get install -y --no-install-recommends dialog \
        && apt-get update \
	&& apt-get install -y --no-install-recommends openssh-server \
	&& echo "$SSH_PASSWD" | chpasswd \
    && apt-get install -y --no-install-recommends apache2 php libapache2-mod-php php-mcrypt php-pgsql 
COPY sshd_config /etc/ssh/

# Application
RUN rm /var/www/html/index.html
WORKDIR /var/www/html
ADD index.php /var/www/html/index.php
# RUN mkdir /code
# WORKDIR /code
# ADD . /code/

# Startup container
COPY init.sh /usr/local/bin/
EXPOSE 80
ENTRYPOINT ["init.sh"]
