#
# Nginx Dockerfile
#
# https://github.com/dockerfile/nginx
#

# Pull base image.
FROM nginx:1.7.9

RUN mkdir -p /data/www

COPY container/nginx.conf /etc/nginx/nginx.conf
COPY container/default.conf /etc/nginx/conf.d/default.conf
COPY container/index.html /data/www/index.html

# Define mountable directories.
VOLUME ["/etc/nginx/conf.d", "/data/www"]

# Define default command
CMD ["nginx"]

# Expose ports.
EXPOSE 80 443