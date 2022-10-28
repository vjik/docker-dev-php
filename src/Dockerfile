ARG PHP_VERSION
FROM php:${PHP_VERSION}

# Upgrade packages
RUN apt -y update && apt -y upgrade

# Required tools
# - Composer: git, unzip, bash-completion
# - PHP intl extension: libicu-dev
RUN apt -y install \
    sudo \
    git \
    gnupg \
    unzip \
    libicu-dev \
    bash-completion \
    locales

# Add "en_US.UTF-8" locale
RUN sed -i '/en_US\.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

# PHP extensions
RUN docker-php-ext-install \
    intl \
    gettext

# Xdebug
RUN pecl install xdebug
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# PHP configuration
COPY php.ini /usr/local/etc/php/conf.d/php.ini

# Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN composer completion bash | tee /etc/bash_completion.d/composer

# Starship shell prompt
RUN sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes

# Initial script
COPY docker-entrypoint.sh /usr/bin

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
