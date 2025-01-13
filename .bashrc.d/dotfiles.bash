## This is the dotfile git manager alias

DOTFILES_REPO=$HOME/.local/share/dotfiles/bare.git/

alias .f="/usr/bin/git --git-dir=$DOTFILES_REPO --work-tree="'${HOME}'
alias .flazy="lazygit --git-dir=$DOTFILES_REPO --work-tree="'${HOME}'

.fk() {
  pushd $DOTFILES_REPO >/dev/null
  tig
  popd >/dev/null
}
