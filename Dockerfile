FROM ubuntu:16.04

# AZ Webapp config + packages.
# Note the SSH-sshd_config. This is because azure wants a custom ssh setup to connect their web-ssh system to the container.
ENV SSH_PASSWD "root:Docker!"

COPY init.sh /usr/local/bin/

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        dialog \
        software-properties-common \
        language-pack-en \
    && apt-get update \
	&& apt-get install -y --no-install-recommends \
        openssh-server \
        python-software-properties \
    && LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
    && apt-get update \
	&& echo "$SSH_PASSWD" | chpasswd

RUN apt-get install -y --no-install-recommends \
    php-pear \
    apache2 \
    php7.2 \
    php7.2-pgsql \
    libapache2-mod-php7.2 \
    php7.2-xml \
    php7.2-mbstring \
    php7.2-zip \
    postgresql \
    postgresql-client \
    composer \
    python \
    zip \
    unzip \
    graphviz \
    fop \
    xsltproc \
    ghostscript \
    xpdf-utils \
    mscgen \
    pandoc \
    imagemagick \
    php-imagick

COPY sshd_config /etc/ssh/

RUN rm -f /var/log/apache2/* \
    && rmdir /var/lock/apache2 \
    && rmdir /var/run/apache2 \
    && rmdir /var/log/apache2 \
    && chmod 777 /var/log \
    && chmod 777 /var/run \
    && chmod 777 /var/lock \
    && rm -rf /var/www/html \
    && rm -rf /var/log/apache2 \
    && mkdir -p /home/LogFiles \
    && ln -s /home/site/wwwroot /var/www/html \
    && ln -s /home/LogFiles /var/log/apache2 


# RUN pecl install mcrypt-1.0.1


# Application
COPY post_deploy.sh /usr/local/bin/
RUN chmod 777 /usr/local/bin/post_deploy.sh

WORKDIR /var/www/html
ADD index.php /var/www/html/index.php
RUN mkdir /code
# WORKDIR /code

# Add source code here
ADD index.php /code/

EXPOSE 80 2222
ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance
ENV PATH ${PATH}:/home/site/wwwroot

# Startup container
ENTRYPOINT ["init.sh"]
