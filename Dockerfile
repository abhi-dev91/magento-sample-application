FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update &&  apt-get upgrade -y
RUN apt-get install -y tzdata curl sudo
RUN apt-get install software-properties-common -y 
RUN  add-apt-repository ppa:ondrej/php -y &&  apt-get update
RUN apt-get install -y php8.1-bcmath php8.1-curl php8.1-common php8.1-fpm php8.1-gd php8.1-intl php8.1-mbstring php8.1-mysql php8.1-soap php-xml php8.1-xsl php8.1-zip php8.1-cli 
RUN  sed -i "s/memory_limit = .*/memory_limit = 768M/" /etc/php/8.1/fpm/php.ini
RUN  sed -i "s/upload_max_filesize = .*/upload_max_filesize = 128M/" /etc/php/8.1/fpm/php.ini
RUN  sed -i "s/zlib.output_compression = .*/zlib.output_compression = on/" /etc/php/8.1/fpm/php.ini
RUN  sed -i "s/max_execution_time = .*/max_execution_time = 18000/" /etc/php/8.1/fpm/php.ini
RUN  apt install nginx -y
COPY magento.conf /etc/nginx/sites-enabled/magento.conf
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN  php composer-setup.php --install-dir=/usr/local/bin --filename=composer
COPY magento2 /opt/magento2
WORKDIR /opt/magento2
RUN  chown -R www-data:www-data /opt/magento2
ENV MAGENTO_HOST=https://localhost
ENV MAGENTO_ADMIN_FIRST_NAME=admin
ENV MAGENTO_ADMIN_LAST_NAME=admin
ENV MAGENTO_ADMIN_EMAIL=EXAMPLE@EXAMPLE.COM
ENV MAGENTO_ADMIN_URI=admin
ENV MAGENTO_ADMIN_USER=admin
ENV MAGENTO_ADMIN_PASSWORD=password
ENV MAGENTO_LANGUAGE=en_US
ENV MAGENTO_CURRENCY=USD
ENV MAGENTO_TIMEZONE="America/Chicago"
ENV DB_HOST=localhost
ENV DB_NAME=magento
ENV DB_USER=root
ENV DB_PASS=pass1234
ENV ELASTICSEARCH_AUTH=true
ENV ELASTICSEARCH_HOST=localhost
ENV ELASTICSEARCH_PORT=9200
ENV ELASTICSEARCH_USER=elastic
ENV ELASTICSEARCH_PASS=admin123
ENV RABBITMQ_HOST=localhost
ENV RABBITMQ_PASSWORD=admin123
ENV RABBITMQ_USER=admin
ENV REDIS_HOST=REDIS
ENV REDIS_PASSWORD=redis123
ENV SERVER_NAME=localhost
COPY start.sh .
RUN chmod u+x start.sh
CMD ./start.sh

