# Scripts to run each time a new shell starts under TMUX

if [ -n "$TMUX" -a -f $HOME/Code/3rd-party/tmux-git/tmux-git.sh ]; then
  source $HOME/Code/3rd-party/tmux-git/tmux-git.sh
fi
