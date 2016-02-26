################################################################################
# Base image
################################################################################

FROM nginx

MAINTAINER "Andrew McLagan" <andrew@ethicaljobs.com.au>

################################################################################
# Add HHVM repo
################################################################################

ENV HHVM_VERSION "3.12.0~jessie"

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 && \
    echo deb http://dl.hhvm.com/debian jessie main | tee /etc/apt/sources.list.d/hhvm.list

################################################################################
# Install supervisor, HHVM & tools
################################################################################

RUN apt-get update && apt-get install -my supervisor hhvm=${HHVM_VERSION} git wget mailutils sendmail \
    && apt-get clean

################################################################################
# Install tools
################################################################################

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

COPY ./config/php.ini /etc/hhvm/php.ini

COPY ./config/nginx.conf /etc/nginx/nginx.conf

################################################################################
# Copy source
##############################################################################

COPY ./index.php /var/www/public/index.php

################################################################################
# Boot
################################################################################

EXPOSE 80 443

CMD ["/usr/bin/supervisord"]
