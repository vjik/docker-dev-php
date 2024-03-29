ARG PHP_VERSION
FROM php:$PHP_VERSION

ARG PHP_VERSION
ARG INSTALL_OPCACHE=0

# Upgrade packages
RUN apt -y update && apt -y upgrade

# Required tools
# - Composer: git, unzip, bash-completion
# - PHP intl extension: libicu-dev
# - SSH agent: openssh-client
RUN apt -y install \
    sudo \
    git \
    gnupg \
    unzip \
    libicu-dev \
    bash-completion \
    locales \
    openssh-client

# PHP extensions
RUN docker-php-ext-install \
    bcmath \
    intl \
    gettext \
    pcntl \
    sockets

# OPcache PHP extension
RUN if [ $INSTALL_OPCACHE -eq 1 ] ; \
      then \
        docker-php-ext-install opcache ; \
    fi
COPY opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# APCu
RUN pecl install apcu
COPY apcu.ini /usr/local/etc/php/conf.d/apcu.ini

# PDO PostgreSQL driver
RUN apt -y install libpq-dev
RUN docker-php-ext-install pdo_pgsql

# Memcached
RUN apt -y install libmemcached-dev zlib1g-dev && pecl install memcached
RUN docker-php-ext-enable memcached

# PHP configuration
COPY php.ini /usr/local/etc/php/conf.d/php.ini

# Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN composer completion bash | tee /etc/bash_completion.d/composer

# Locales
RUN sed -i '/en_US\.UTF-8/s/^# //g' /etc/locale.gen
RUN locale-gen
ENV LC_ALL en_US.UTF-8

# Starship shell prompt
RUN sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes

# Initial script
COPY docker-entrypoint.sh /usr/bin

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
