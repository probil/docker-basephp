FROM famly/base

MAINTAINER Henrik Rasmussen, hmr@famly.dk

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5 php5-curl php5-gd php5-mysql php5-json php5-mcrypt php-pear php5-dev ruby-dev rubygems libsqlite3-dev

RUN gem install mailcatcher

RUN pear upgrade pear && pecl install redis && pecl install igbinary

# Fix broken mcrypt in this version of ubuntu
RUN cd /etc/php5 && mv conf.d/mcrypt.ini mods-available/mcrypt.ini && php5enmod mcrypt

ADD files/php.ini /etc/php5/conf.d/php.ini
RUN cd /etc/php5/cli/conf.d && ln -s ../../conf.d/php.ini php.ini &&\
    cd /etc/php5/apache2/conf.d && ln -s ../../conf.d/php.ini php.ini

ADD files/opcache.ini /etc/php5/conf.d/opcache.ini
RUN cd /etc/php5/cli/conf.d && ln -s ../../conf.d/opcache.ini opcache.ini &&\
    cd /etc/php5/apache2/conf.d && ln -s ../../conf.d/opcache.ini opcache.ini


ADD files/redis.ini /etc/php5/conf.d/redis.ini
RUN cd /etc/php5/cli/conf.d && ln -s ../../conf.d/redis.ini redis.ini &&\
    cd /etc/php5/apache2/conf.d && ln -s ../../conf.d/redis.ini redis.ini

ADD files/igbinary.ini /etc/php5/conf.d/igbinary.ini
RUN cd /etc/php5/cli/conf.d && ln -s ../../conf.d/igbinary.ini igbinary.ini &&\
    cd /etc/php5/apache2/conf.d && ln -s ../../conf.d/igbinary.ini igbinary.ini

ADD files/mailcatcher.ini /etc/php5/conf.d/mailcatcher.ini
RUN cd /etc/php5/cli/conf.d && ln -s ../../conf.d/mailcatcher.ini mailcatcher.ini &&\
    cd /etc/php5/apache2/conf.d && ln -s ../../conf.d/mailcatcher.ini mailcatcher.ini
