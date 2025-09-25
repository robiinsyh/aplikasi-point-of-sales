FROM php:7.4-apache

RUN apt-get update && apt install nano git unzip libzip-dev npm -y

WORKDIR /app
COPY . .
COPY .env.example .env
RUN chown -R www-data:www-data .

COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

RUN docker-php-ext-install pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer install
RUN php artisan key:generate
#RUN php artisan migrate
#RUN php artisan db:seed

RUN a2enmod rewrite
EXPOSE 5000

#dont forget to change port configurations in /etc/apache2/ports.conf
