#!/bin/usr/env bash
#
# Storing credentials in a version control repo is really a bad idea.
#
# However, for simplicity's sake, some application store a credential type string
# in their configuration (dot files). These can be "application tokens", "API tokens",
# or worse, passwords.
#
# To handle these cases safely, we are storing these CREDENTIALS type strings here,
# accessible as environment variables. The file should have 600 permissions accessible
# only to the current user (similar to the .ssh/ folder).
#
# Of course this would only make sense assuming that the `$HOME` directory is
# been secured via a different mechanism.
#
# **AVOID USING THIS APPROACH AS MUCH AS POSSIBLE**
#
# CONSIDER USING pass instead
#
# The actual credentials are stored in the `.gitignore`'ed `CREDENTIALS` files.

application_tokens() {
  USAGE="Usage: application_tokens [KEY TOKEN]"
  CREDENTIALS="$HOME/.bashrc.d/CREDENTIALS"

  if ! [ -e ${CREDENTIALS} ]; then
    touch ${CREDENTIALS}
    chmod 600 ${CREDENTIALS}
  fi

  if ! [ $(stat -c "%a" ${CREDENTIALS}) -eq 600 ]; then
    >&2 echo "The ${CREDENTIALS} needs to have 600 permissions"
    return 100
  fi

  case $# in
  0)
    cat $CREDENTIALS
    ;;
  2)
    echo "export $1=$2" >>$CREDENTIALS
    ;;
  *)
    echo "$USAGE"
    ;;
  esac
}
