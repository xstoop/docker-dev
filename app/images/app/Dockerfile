# registry.cn-hangzhou.aliyuncs.com/namespace/appbaseimage as base image.
# build app image
FROM registry.cn-hangzhou.aliyuncs.com/namespace/appbaseimage:latest

# Add project.
COPY ./ /var/www/html/app/

# Add app nginx virtual hosts config
COPY ./build/images/app/nginx/virtual-hosts/app /etc/nginx/virtual-hosts/app

# chown app storage path(with laravel)
RUN chown -R www-data:www-data /var/www/html/app/storage
