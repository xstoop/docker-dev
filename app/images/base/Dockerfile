# Use phusion/baseimage with a specific version as base image.
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for a list of version numbers.
# FROM phusion/baseimage:<VERSION>
FROM phusion/baseimage:0.9.19

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# BEGIN Build instructions =============================================================================================

# Disable SSH.
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Disable cron.
RUN rm -rf /etc/service/cron /etc/cron.* /etc/crontab

# set timezone
RUN cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime

# set vim nocompatible
COPY ./build/etc/vim/vimrc.tiny /etc/vim/vimrc.tiny

# apt-get update
RUN apt-get update

# Install PHP.
# Avoid "debconf: unable to initialize frontend: Dialog" by using DEBIAN_FRONTEND=noninteractive before install command.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php7.0-fpm php7.0-curl
RUN echo "php version: $(php -v)"

# COPY php-fpm conf
COPY ./build/php-fpm  /etc/php/7.0/fpm/

# Add php-fpm daemon. 去掉使用runit守护php-fpm进程，老是在重启php-fpm,没有找到原因
#RUN mkdir /etc/service/php-fpm
#RUN echo '#!/usr/bin/env bash\nservice php7.0-fpm start' > /etc/service/php-fpm/run
#RUN chmod +x /etc/service/php-fpm/run

# 通过添加rc.local命令开机启动php-fpm
RUN echo '#!/bin/sh -e\nservice php7.0-fpm start\nexit 0' > /etc/rc.local

# Install nginx mainline.
# "We recommend that in general you deploy the NGINX mainline branch at all times." - nginx.com
RUN add-apt-repository -y ppa:nginx/development
RUN apt-get -y install nginx
RUN echo "nginx version: $(nginx -v)"

# COPY nginx conf
COPY ./build/nginx /etc/nginx/

# Add nginx daemon.
RUN mkdir /etc/service/nginx
RUN echo '#!/usr/bin/env bash\nnginx' > /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run

# Add project.
COPY ./ /var/www/html/project/

# chown laravel project storage path
RUN chown -R www-data:www-data /var/www/html/project/storage

# END Build instructions ===============================================================================================

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
