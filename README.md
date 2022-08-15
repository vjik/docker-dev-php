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

## Build an image

```shell
task build -- {PHP_VERSION}
```

For example, build an image with PHP 8.1:

```shell
task build -- 8.1
```
