ARG PHP_VERSION
FROM php:${PHP_VERSION}

# Upgrade packages
RUN apt -y update && apt -y upgrade

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

# Starship shell prompt
RUN sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes

# Initial script
COPY docker-entrypoint.sh /usr/bin

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
