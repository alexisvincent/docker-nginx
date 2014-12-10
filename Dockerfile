#
# Nginx Dockerfile
#
# https://github.com/dockerfile/nginx
#

# Pull base image.
FROM alexisvincent/ubuntu

# Install Nginx.
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  sudo apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

COPY build/nginx.conf /etc/nginx/conf.d/nginx.conf
COPY build/default-site /etc/nginx/sites-enabled/default

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx"]

# Define working directory.
WORKDIR /etc/nginx

# Define default command
CMD ["nginx"]

# Expose ports.
EXPOSE 80
EXPOSE 443