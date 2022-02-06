ARG PHP_VERSION
FROM php:${PHP_VERSION}

# Upgrade packages
RUN apt -y update && apt upgrade

# Required tools
# - Composer: git, unzip
# - PHP intl extension: libicu-dev
RUN apt -y install \
    git \
    unzip \
    libicu-dev

# PHP extensions
RUN docker-php-ext-install \
    intl

# Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER=1

# Psalm
RUN composer global require vimeo/psalm
