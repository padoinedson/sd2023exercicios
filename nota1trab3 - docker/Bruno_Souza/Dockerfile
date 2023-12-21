# Use a official WordPress runtime as a parent image
FROM wordpress:php7.4-apache

# Install any needed packages specified in requirements.txt
COPY ./requirements.txt /usr/src/app/
RUN pip install --trusted-host pypi.python.org -r /usr/src/app/requirements.txt

# Install additional packages and setup WordPress
RUN apt-get update && apt-get install -y \
    wget \
    && rm -rf /var/lib/apt/lists/* \
    && wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Install the WordPress plugin from a URL
ENV WORDPRESS_PLUGIN_URL="https://downloads.wordpress.org/plugin/akismet.5.0.zip"
RUN wget -q "${WORDPRESS_PLUGIN_URL}" -O /tmp/akismet.zip \
    && unzip -q /tmp/akismet.zip -d /var/www/html/wp-content/plugins \
    && rm /tmp/akismet.zip

# Install the WordPress theme from a URL
ENV WORDPRESS_THEME_URL="https://downloads.wordpress.org/theme/twentynineteen.1.2.zip"
RUN wget -q "${WORDPRESS_THEME_URL}" -O /tmp/twentynineteen.zip \
    && unzip -q /tmp/twentynineteen.zip -d /var/www/html/wp-content/themes \
    && rm /tmp/twentynineteen.zip

# Copy custom files
COPY ./custom.wp-config.php /var/www/html/
COPY ./custom.htaccess /var/www/html/

# Expose ports for the Apache web server
EXPOSE 80