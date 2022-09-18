#!/bin/bash

USER_ID=1000
USER_NAME=vjik
GROUP_ID=1000
GROUP_NAME=vjik

OPTS=$(getopt -q -l uid:,uname:,gid:,gname: -o "" -- "$@")

eval set -- "$OPTS"
while true; do
  case "$1" in
  --uid)
    USER_ID="$2"
    shift 2
    ;;
  --uname)
    USER_NAME="$2"
    shift 2
    ;;
  --gid)
    GROUP_ID="$2"
    shift 2
    ;;
  --gname)
    GROUP_NAME="$2"
    shift 2
    ;;
  --)
    shift
    break
    ;;
  *)
    break
    ;;
  esac
done

groupadd -g "$GROUP_ID" "$GROUP_NAME"
useradd \
    -u "$USER_ID" \
    -g "$GROUP_NAME" \
    -G sudo \
    -m \
    "$USER_NAME"
echo -e "q1w2e3r4\nq1w2e3r4\n" | passwd "$USER_NAME" &> /dev/null

homedir=$( getent passwd "$USER_NAME" | cut -d: -f6 )

# SSH configuration
if [ -d /config/.ssh ]; then
  ln -s /config/.ssh "$homedir"/.ssh
fi

# GIT configuration
if [ -f /config/.gitconfig ]; then
  ln -s /config/.gitconfig "$homedir"/.gitconfig
fi

# GnuPG keys
if [ -d /config/.gnupg ]; then
  ln -s /config/.gnupg "$homedir"/.gnupg
fi

# Starship for bash
echo 'eval "$(starship init bash)"' >> "$homedir"/.bashrc

# Composer Aliases
echo '
alias c="composer"
alias cu="composer update"
' >> "$homedir"/.bashrc

# PHPUnit Aliases
echo '
alias pu="./vendor/bin/phpunit"
alias puct="./vendor/bin/phpunit --coverage-text"
alias puc="./vendor/bin/phpunit --coverage-html=cover"
alias puf="./vendor/bin/phpunit --filter"
' >> "$homedir"/.bashrc

# Psalm Aliases
echo '
alias psalm="./vendor/bin/psalm --no-cache"
alias psalm74="./vendor/bin/psalm --no-cache --php-version=7.4"
alias psalm80="./vendor/bin/psalm --no-cache --php-version=8.0"
alias psalm81="./vendor/bin/psalm --no-cache --php-version=8.1"
' >> "$homedir"/.bashrc

# Other Aliases
echo 'alias cls="clear"' >> "$homedir"/.bashrc

exec runuser -u "$USER_NAME" -- bash
