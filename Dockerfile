################################################################################
# Base image
################################################################################

FROM nginx

MAINTAINER "Andrew McLagan" <andrew@ethicaljobs.com.au>

################################################################################
# Install supervisor
################################################################################

RUN apt-get update && apt-get install -my supervisor \
  	&& apt-get clean

################################################################################
# Install HHVM
################################################################################

ENV HHVM_VERSION "3.12.0~jessie"

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 && \
    echo deb http://dl.hhvm.com/debian jessie main | tee /etc/apt/sources.list.d/hhvm.list && \
    apt-get update -y && \
    apt-get install -y hhvm=${HHVM_VERSION} \
    && apt-get clean

################################################################################
# Install tools
################################################################################

RUN apt-get update -y && apt-get install -y git wget \
    && apt-get clean

RUN cd $HOME && \
    wget http://getcomposer.org/composer.phar && \
    chmod +x composer.phar && \
    mv composer.phar /usr/local/bin/composer && \
    wget https://phar.phpunit.de/phpunit.phar && \
    chmod +x phpunit.phar && \
    mv phpunit.phar /usr/local/bin/phpunit  

RUN composer global require hirak/prestissimo

################################################################################
# Configuration
##############################################################################

COPY ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY ./config/php.ini /etc/hhvm/custom.ini

COPY ./config/nginx.conf /etc/nginx/nginx.conf

################################################################################
# Copy source
##############################################################################

COPY ./index.php /var/www/public

################################################################################
# Boot
################################################################################

EXPOSE 80 443

CMD ["/usr/bin/supervisord"]
