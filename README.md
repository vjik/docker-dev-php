# `vjik/dev-php` Docker Image

PHP docker image for local development that include:

- [Composer](https://getcomposer.org/)
- [GIT](https://git-scm.com/)
- [Starship shell prompt](https://starship.rs/)

## DockerHub

[Image on DockerHub](https://hub.docker.com/r/vjik/dev-php), docker pull command:

```shell
docker pull vjik/dev-php:8.1
```

Tags are named by PHP version used: `8.1`, `8.0`, `7.4`.

## Aliases

| Alias   | Command                                         |
|---------|-------------------------------------------------|
| c       | composer                                        |
| cu      | composer update                                 |
| pu      | ./vendor/bin/phpunit`                           |
| puc     | ./vendor/bin/phpunit --coverage-html=cover      |
| puct    | ./vendor/bin/phpunit --coverage-text            |
| puf     | ./vendor/bin/phpunit --filter                   |
| psalm   | ./vendor/bin/psalm --no-cache                   |
| psalm74 | ./vendor/bin/psalm --no-cache --php-version=7.4 |
| psalm80 | ./vendor/bin/psalm --no-cache --php-version=8.0 |
| psalm81 | ./vendor/bin/psalm --no-cache --php-version=8.1 |
| cls     | clear                                           |

## Build an image

```shell
task build -- {PHP_VERSION}
```

For example, build an image with PHP 8.1:

```shell
task build -- 8.1
```
