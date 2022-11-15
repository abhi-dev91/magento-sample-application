#!/bin/bash

sudo -u www-data bin/magento setup:install \
	--base-url=$MAGENTO_HOST \
	--db-host=$DB_HOST \
	--db-name=$DB_NAME \
	--db-user=$DB_USER \
	--db-password=$DB_PASS \
	--admin-firstname=$MAGENTO_ADMIN_FIRST_NAME \
	--admin-lastname=$MAGENTO_ADMIN_LAST_NAME \
	--admin-email=$MAGENTO_ADMIN_EMAIL \
	--admin-user=$MAGENTO_ADMIN_USER \
	--admin-password=$MAGENTO_ADMIN_PASSWORD \
	--language=$MAGENTO_LANGUAGE \
	--currency=$MAGENTO_CURRENCY \
	--timezone=$MAGENTO_TIMEZONE \
	--use-rewrites="1" \
	--backend-frontname=$MAGENTO_ADMIN_URI \
	--elasticsearch-host=$ELASTICSEARCH_HOST \
	--elasticsearch-port=$ELASTICSEARCH_PORT \
	--elasticsearch-username=$ELASTICSEARCH_USER \
	--elasticsearch-enable-auth=$ELASTICSEARCH_AUTH \
	--elasticsearch-password=$ELASTICSEARCH_PASS \
	--session-save-redis-host=$REDIS_HOST \
	--session-save-redis-password=$REDIS_PASSWORD \
	--session-save=redis

sudo -u www-data bin/magento module:disable Magento_TwoFactorAuth 
sudo -u www-data bin/magento cache:flush  

service php8.1-fpm start
nginx -g 'daemon off;'
