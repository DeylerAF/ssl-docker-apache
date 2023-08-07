#!/bin/bash

# Start the Apache web server
apache2-foreground &

# Wait for the Apache server to start
sleep 5

# Use Certbot to obtain the SSL certificate
# certbot --apache --non-interactive --agree-tos --email your_email@example.com -d localhost
certbot --apache --non-interactive --agree-tos -d localhost

# Setup a cron job to automatically renew the certificate every week
echo "0 0 * * 0 certbot renew --apache --non-interactive --post-hook 'apache2ctl graceful' >> /var/log/cron.log 2>&1" | crontab -

# Keep the script running to prevent the container from exiting
tail -f /dev/null
