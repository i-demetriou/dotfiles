#!/usr/bin/env bash
#
# Prepare to receive the .dotfile repo
#
# It is assumed that this machine has access to the repo via `git`

SCRIPT_NAME=$0
BACKUP_DOTFILES=$HOME/.dotfiles-backup
export PREFIX=${PREFIX:-"$HOME/.local/share"}
export DOTFILES_D=$PREFIX/dotfiles
export DOTFILES_REPO=$DOTFILES_D/bare.git
REPO_URL=${REPO_URL:-https://github.com/i-demetriou/dotfiles.git}
USAGE="\
Usage: $(basename ${SCRIPT_NAME}) [-h|--help]

Optional Arguments
 -h, --help    display this help and exit

Environment Variables
  REPO_URL  The URL of the bare repo (Default: $REPO_URL)

If you want to send this to a fresh device, you can do so with nc.

From fresh device:
	ip a s    # To get the IP
	nc -lp 5000 | sh
From the trusted device:
	nc <IP> 5000 < $(basename ${SCRIPT_NAME})
"

args=$(getopt -l "help" -o "h" -- "$@")
eval set -- "$args"
while [ $# -ge 1 ]; do
  case "$1" in
  --)
    # No more options left
    shift
    break
    ;;
  -h | --help)
    printf "${USAGE}"
    exit 100
    ;;
  esac
  shift
done

.f() {
  # A useful alias to manage git in a different work tree
  /usr/bin/git --git-dir=${DOTFILES_REPO} --work-tree=$HOME "${@}"
}

authenticate_git_server() {
  local user_input
  local GIT_SERVER_KEY_PAGE=$1
  echo "Copy your public key to: ${GIT_SERVER_KEY_PAGE%%/*}"
  cat $HOME/.ssh/id_rsa.pub
  firefox --new-tab $GIT_SERVER_KEY_PAGE
  read -p "Press any key to continue" user_input
}

clone_naked_repo() {
  git clone --bare ${REPO_URL} ${DOTFILES_REPO}

  .f config --local status.showUntrackedFiles no
  .f checkout >/dev/null

  if [ $? = 0 ]; then
    echo "Successfully checked out dot files"
  else
    echo "Conflicts detected. Backing up existing dotfiles to $BACKUP_DOTFILES"
    echo "Warning: Files backed up in $BACKUP_DOTFILES will not preserve directory structure"

    mkdir -p ${BACKUP_DOTFILES}
    pushd $HOME >/dev/null
    .f checkout 2>&1 |
      egrep "\s+\." | awk {'print $1'} |
      xargs -I{} mv -vb $(readlink -f "{}") $BACKUP_DOTFILES/
    popd >/dev/null
    .f checkout
  fi
}

if ! ls $HOME/.ssh/*.pub &>/dev/null; then
  ssh-keygen -t rsa -b 4096 -N "" -f "$HOME/.ssh/id_rsa"
  ssh-keygen -t ed25519 -N "" -f "$HOME/.ssh/id_ed25519"
else
  echo "Found the following keys:"
  for key in $(ls $HOME/.ssh/*.pub); do
    ssh-keygen -lv -f $key
  done
fi

if ls $HOME/.ssh/*.pub &>/dev/null; then
  read -t 10 -p 'Would you like to add your new key to your git servers?' user_input

  case ${user_input:-N} in
  [Yy])
    authenticate_git_server "gitlab.com/-/profile/keys"
    authenticate_git_server "github.com/settings/ssh/new"
    ;;
  esac
fi

# Some distributions do not come with `git` installed by default.
# If this is the case get it now
if ! dpkg -s git >/dev/null; then
  echo "Need to install some packages first"
  sudo apt install git
fi

if [[ -d $DOTFILES_REPO ]]; then
  echo "Bare repository already cloned at $DOTFILES_REPO"
else
  echo "Initializing dotfile repo"
  mkdir -p $DOTFILES_D
  clone_naked_repo
fi

echo "Done"
echo "Open a new terminal to use your new environment, or source it:"
echo "	source $HOME/.bashrc"
