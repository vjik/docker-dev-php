# `vjik/dev-php` Docker Image

PHP docker images for local development. All images contain:

- PHP with extensions:
  [BCMath](https://www.php.net/manual/book.bc.php),
  [intl](https://www.php.net/manual/book.intl.php),
  [Gettext](https://www.php.net/manual/book.gettext.php),
  [Sockets](https://www.php.net/manual/book.sockets.php),
  PDO ([MySQL](https://www.php.net/manual/ru/ref.pdo-mysql.php), [PostgreSQL](https://www.php.net/manual/ref.pdo-pgsql.php)),
  [APCu](https://www.php.net/manual/book.apcu.php),
  [Memcached](https://www.php.net/manual/book.memcached.php),
  [Process Control (PCNTL)](https://www.php.net/manual/en/book.pcntl.php)
- Bash terminal with [predefined aliases](#aliases)
- [Starship shell prompt](https://starship.rs/)
- [Composer](https://getcomposer.org/) with [completion](https://getcomposer.org/doc/03-cli.md#bash-completions)
- [GIT](https://git-scm.com/)
- [GnuPG](https://www.gnupg.org/) for sign commits
- OpenSSH authentication agent (`ssh-agent`)

![](screenshot.png)

## General usage

### Pull image from DockerHub

[Image on DockerHub](https://hub.docker.com/r/vjik/dev-php), docker pull command:

```shell
docker pull vjik/dev-php:8.3
```

Development tags:

- [Node.js](https://nodejs.org/)
- [Xdebug](https://xdebug.org/)
- [OPcache](https://www.php.net/manual/book.opcache.php) PHP extension
- [GitHub Lookup Next ID Utility](https://github.com/vjik/github-lookup-next-id)
- [uopz](https://www.php.net/manual/book.uopz.php) PHP extension

|   Tag    | PHP version | Xdebug | uopz |
|:--------:|:-----------:|:------:|:----:|
|   8.3    |     8.3     |   ✔️   |  ❌  |
|   8.2    |     8.2     |   ✔️   |  ❌  |
|   8.1    |     8.1     |   ✔️   |  ❌  |
|   8.0    |     8.0     |   ✔️   |  ❌  |
|   7.4    |     7.4     |   ✔️   |  ❌  |
| 8.1-uopz |     8.1     |   ✔️   |  ✔️  |

Benchmark tags:

- [OPcache](https://www.php.net/manual/book.opcache.php) PHP extension

|        Tag        | PHP version | OPcache |
|:-----------------:|:-----------:|:-------:|
|     8.2-bench     |     8.2     |    ❌   |
| 8.2-bench-opcache |     8.2     |    ✔️   |

### Run container

Recommended run command:

```shell
docker run -it --rm --name dev-php -v /host/projects:/projects -w /projects vjik/dev-php:8.2 --uname `id -un` --uid `id -u` --gname `id -gn` -gid `id -g`
```

- `-it` — Interactive mode with allocate a pseudo terminal.
- `--rm` — Automatically remove the container when it exits.
- `--name dev-php` — Assign name "dev-php" to the container.
- `-v /host/projects:/projects` — Mount folder with your projects (replace `/host/projects` to your path) to container
  (`/projects`).
- `-w /projects` — Set `/projects` as working directory inside the container.
- `vjik/dev-php:8.2` — Image name.
- ``--uname `id -un` `` — Set username in container (`id -un` returns current user name).
- ``--uid `id -u` `` — Set user ID in container (`id -u` returns current user ID).
- ``--gname `id -gn` `` — Set user group name in container (`id -gn` returns current user group name).
- ``--gid `id -g` `` — Set user group ID in container (`id -g` returns current user group ID).

Recommended to use the same username and group as in your system.

#### SSH configuration

You can configure SSH in container via mount folder with SSH configuration to path `/config/.ssh`. To do this, add the
appropriate argument to the container run command. For example:

`-v ~/.ssh:/config/.ssh`

#### GIT configuration

You can configure GIT in container via mount configuration file `.gitconfig` to path `/config/.gitconfig`. To do this, 
add the appropriate argument to the container run command. For example:

`-v ~/.gitconfig:/config/.gitconfig`

#### GnuPG configuration

You can configure GnuPG in container via mount folder with GnuPG configuration to path `/config/.gnupg`. To do this, add the
appropriate argument to the container run command. For example:

`-v ~/dev-gnupg:/config/.gnupg`

Recommend don't use system `.gnupg` directory. Better create new directory and mount it.

To request passphrase in terminal add `pinentry-mode loopback` option to `gpg.conf` file (create if not exist).

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
| psalm82 | ./vendor/bin/psalm --no-cache --php-version=8.2 |
| psalm83 | ./vendor/bin/psalm --no-cache --php-version=8.3 |
| cls     | clear                                           |

## Build an image

Use [Task](https://taskfile.dev/) for simplify run.
