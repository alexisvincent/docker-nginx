#
# Nginx Dockerfile
#
# https://github.com/dockerfile/nginx
#

# Pull base image.
FROM alexisvincent/ubuntu

# Install Nginx.
# RUN apt-get update

ENV NGINX_VERSION 1.7.8-1~trusty

RUN  \
	apt-key adv --keyserver pgp.mit.edu --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 && \
	echo "deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.list && \
	apt-get update && \
	apt-get install -y nginx=${NGINX_VERSION} && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	chown -R www-data:www-data /usr/share/nginx/html

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/cache/nginx"]

# Define working directory.
WORKDIR /etc/nginx

# Define default command
CMD ["nginx", "-g", "daemon off;"]

# Expose ports.
EXPOSE 80 443