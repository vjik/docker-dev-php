ARG PHP_VERSION
FROM php:$PHP_VERSION

ARG PHP_VERSION
ARG XDEBUG_VERSION
ARG INSTALL_XDEBUG=1
ARG INSTALL_UOPZ=0

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

# Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - &&\
    apt-get install -y nodejs

# Xdebug
RUN if [ $INSTALL_XDEBUG -eq 1 ] ; \
      then \
        if [ -z $XDEBUG_VERSION ] ; \
          then pecl install xdebug ; \
          else pecl install "xdebug-$XDEBUG_VERSION" ; \
        fi ; \
        docker-php-ext-enable xdebug ; \
    fi
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# uopz
RUN if [ $INSTALL_UOPZ -eq 1 ] ; \
      then \
        pecl install uopz ; \
        docker-php-ext-enable uopz ; \
    fi

# PHP extensions
RUN docker-php-ext-install \
    bcmath \
    intl \
    gettext \
    pcntl \
    sockets

# OPcache PHP extension
RUN docker-php-ext-install opcache
COPY opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# APCu
RUN pecl install apcu
COPY apcu.ini /usr/local/etc/php/conf.d/apcu.ini

# PDO PostgreSQL driver
RUN apt -y install libpq-dev
RUN docker-php-ext-install pdo_pgsql

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

# GitHub Lookup Next ID Utility
COPY ./utils/github-lookup-next-id /usr/bin/github-lookup-next-id

# Initial script
COPY docker-entrypoint.sh /usr/bin

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
