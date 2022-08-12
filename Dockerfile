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

# Starship shell prompt
RUN sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes

# Create user
RUN groupadd -g ${GROUP_ID} ${GROUP_NAME}
RUN useradd \
    -u ${USER_ID} \
    -g ${GROUP_NAME} \
    -m \
    ${USER_NAME}

USER ${USER_NAME}

# Starship for bash
RUN echo 'eval "$(starship init bash)"' >> ~/.bashrc

# Composer Aliases
RUN echo 'alias c="composer"' >> ~/.bashrc
RUN echo 'alias cu="composer update"' >> ~/.bashrc

# PHPUnit Aliases
RUN echo 'alias pu="./vendor/bin/phpunit"' >> ~/.bashrc
RUN echo 'alias puf="./vendor/bin/phpunit --filter"' >> ~/.bashrc

# Psalm Aliases
RUN echo 'alias psalm="./vendor/bin/psalm --no-cache"' >> ~/.bashrc
RUN echo 'alias psalm74="./vendor/bin/psalm --no-cache --php-version=7.4"' >> ~/.bashrc
RUN echo 'alias psalm80="./vendor/bin/psalm --no-cache --php-version=8.0"' >> ~/.bashrc
RUN echo 'alias psalm81="./vendor/bin/psalm --no-cache --php-version=8.1"' >> ~/.bashrc

# Other Aliases
RUN echo 'alias cls="clear"' >> ~/.bashrc

CMD ["bash"]
