# Contains all the cool FS aliases for making terminal fun
## Handy ls shortcuts
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'

## Safety
alias rm='rm --preserve-root'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

## Speed up file seach
gfind() {
  PATH_REGEX_NAME=$1
  shift
  find -iname "*${PATH_REGEX_NAME}*" ${@} | grep "${PATH_REGEX_NAME}"
}

alias gr='grep -rnI'
