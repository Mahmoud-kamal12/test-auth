# استخدم صورة PHP مع PHP-FPM
FROM php:8.2-fpm

# تثبيت الامتدادات الضرورية
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip \
    && docker-php-ext-install pdo pdo_mysql \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install ctype \
    && docker-php-ext-install iconv \
    && docker-php-ext-install opcache

# تعيين مجلد العمل
WORKDIR /var/www/html

# نسخ الملفات
COPY . .

# تثبيت Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# تثبيت الاعتماديات
RUN composer install --no-dev --prefer-dist --no-scripts --optimize-autoloader

# إعداد الأذونات
RUN chown -R www-data:www-data var
