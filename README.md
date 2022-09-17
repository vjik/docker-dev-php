# `vjik/dev-php` Docker Image

PHP docker image for local development that include:

- Bash terminal with [predefined aliases](#aliases)
- [Composer](https://getcomposer.org/) with [completion](https://getcomposer.org/doc/03-cli.md#bash-completions)
- [GIT](https://git-scm.com/)
- [Starship shell prompt](https://starship.rs/)

![](screenshot.png)

## General usage

### Pull image from DockerHub

[Image on DockerHub](https://hub.docker.com/r/vjik/dev-php), docker pull command:

```shell
docker pull vjik/dev-php:8.1
```

Tags are named by PHP version used: `8.1`, `8.0`, `7.4`.

### Run container

Recommended run command:

```shell
docker run -it --rm --name dev-php -v /host/projects:/projects vjik/dev-php:8.1 --uname vjik --uid 1000 --gname vjik -gid 1000
```

- `-it` — Interactive mode with allocate a pseudo terminal.
- `--rm` — Automatically remove the container when it exits.
- `--name dev-php` — Assign name "dev-php" to the container.
- `-v /host/projects:/projects` — Mount folder with your projects (replace `/host/projects` to your path) to container
  (`/projects`).
- `vjik/dev-php:8.1` — Image name.
- `--uname vjik` — Set username in container.
- `--uid 1000` — Set user ID in container.
- `--gname vjik` — Set user group name in container.
- `--gid 1000` — Set user group ID in container.

Recommended to use the same username and group as in your system.

#### SSH configuration

You can configure SSH in container via mount folder with SSH configuration to path `/config/.ssh`. For what add to run 
container command argument, for example, `-v ~/.ssh:/config/.ssh`.

## Features

### Aliases

| Alias   | Command                                         |
|---------|-------------------------------------------------|
| c       | composer                                        |
| cu      | composer update                                 |
| pu      | ./vendor/bin/phpunit                            |
| puc     | ./vendor/bin/phpunit --coverage-html=cover      |
| puct    | ./vendor/bin/phpunit --coverage-text            |
| puf     | ./vendor/bin/phpunit --filter                   |
| psalm   | ./vendor/bin/psalm --no-cache                   |
| psalm74 | ./vendor/bin/psalm --no-cache --php-version=7.4 |
| psalm80 | ./vendor/bin/psalm --no-cache --php-version=8.0 |
| psalm81 | ./vendor/bin/psalm --no-cache --php-version=8.1 |
| cls     | clear                                           |

## Build an image

Use [Task](https://taskfile.dev/) for simplify run:

```shell
task build -- {PHP_VERSION}
```

For example, build an image with PHP 8.1:

```shell
task build -- 8.1
```
