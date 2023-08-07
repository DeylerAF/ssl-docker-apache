# Use the official PHP-Apache base image
FROM php:8.2.8-apache-bullseye

# Install Certbot and other required packages
RUN apt-get update \
    && apt-get install -y certbot python3-certbot-apache

# Expose ports for HTTP and HTTPS
EXPOSE 80
EXPOSE 443

# Copy your PHP application files to the appropriate directory
# For example, if your PHP application files are in a folder named "app":
WORKDIR /var/www/html

# Copy the init-ssl.sh script to a location in the container
COPY ./init-ssl.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init-ssl.sh

# Start the Apache web server
CMD ["apache2-foreground"]