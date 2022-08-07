ARG PHP_VERSION
FROM php:${PHP_VERSION}

ARG USER_ID=1000
ARG USER_NAME=vjik
ARG GROUP_ID=1000
ARG GROUP_NAME=vjik

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
ENV COMPOSER_ALLOW_SUPERUSER=1

# Psalm
RUN composer global require vimeo/psalm

# Starship shell prompt
RUN sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
RUN echo 'eval "$(starship init bash)"' >> /etc/bash.bashrc

# Create user
RUN groupadd -g ${GROUP_ID} ${GROUP_NAME}
RUN useradd \
    -u ${USER_ID} \
    -g ${GROUP_NAME} \
    -m \
    ${USER_NAME}

USER ${USER_NAME}

CMD ["bash"]
