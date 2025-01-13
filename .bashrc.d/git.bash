alias gg='git grep -nI --recurse-submodules'
alias gls='git ls --recurse-submodules'

gf() {
  PATH_REGEX_NAME=$1
  shift
  gls | grep ${PATH_REGEX_NAME}
}

# Get current repository's directory name
# basename `git rev-parse --show-toplevel`
