################################################################################
# Base image
################################################################################

FROM nginx

MAINTAINER "Andrew McLagan" <andrew@ethicaljobs.com.au>

################################################################################
# Default Environment 
################################################################################

ENV APP_PATH "./"

ENV CONFIG_SUPERVISORD "./config/supervisord.conf"

ENV CONFIG_PHP "./config/php.ini"

ENV CONFIG_NGINX "./config/nginx.conf"

ENV CONFIG_ENTRY "./docker-entrypoint.sh"

################################################################################
# Install supervisor
################################################################################

RUN apt-get update && apt-get install -my supervisor \
  	&& apt-get clean

################################################################################
# Install HHVM
################################################################################

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 && \
    echo deb http://dl.hhvm.com/debian jessie main | tee /etc/apt/sources.list.d/hhvm.list && \
    apt-get update -y && \
    apt-get install -y hhvm

################################################################################
# Install tools
################################################################################

RUN apt-get update -y && apt-get install -y git wget curl \
    && apt-get clean

RUN cd $HOME && \
    wget http://getcomposer.org/composer.phar && \
    chmod +x composer.phar && \
    mv composer.phar /usr/local/bin/composer && \
    wget https://phar.phpunit.de/phpunit.phar && \
    chmod +x phpunit.phar && \
    mv phpunit.phar /usr/local/bin/phpunit  

################################################################################
# Install application
################################################################################

RUN mkdir -p /var/www
WORKDIR /var/www
ADD ${APP_PATH} /var/www
RUN composer install --prefer-dist --no-interaction -vvv  

################################################################################
# Configuration
##############################################################################

COPY ${CONFIG_ENTRY} /entrypoint.sh
RUN chmod +x /entrypoint.sh  

COPY ${CONFIG_SUPERVISORD} /etc/supervisor/conf.d/supervisord.conf

COPY ${CONFIG_PHP} /etc/hhvm/custom.ini

COPY ${CONFIG_NGINX} /etc/nginx/nginx.conf

################################################################################
# Boot
################################################################################

EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/supervisord"]
