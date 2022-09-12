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
    unzip \
    libicu-dev \
    bash-completion

# PHP extensions
RUN docker-php-ext-install \
    intl

# Xdebug
RUN pecl install xdebug
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN composer completion bash | tee /etc/bash_completion.d/composer

# Starship shell prompt
RUN sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes

# Initial script
COPY docker-entrypoint.sh /usr/bin

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
