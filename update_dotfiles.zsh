#!/bin/zsh
source ~/.dotfiles/functions.zsh

_ossystem=$(uname -s)
# git -C ~/.dotfiles/dots pull --rebase

if [[ ! -d ~/.ssh ]]; then
  mkdir ~/.ssh
fi
#
# if [[ ! -f ~/.ssh/assh_known_hosts ]]; then
#   touch ~/.ssh/assh_known_hosts
# fi
#
# if [[ ! -d ~/.ssh/assh.d ]]; then
#   mkdir ~/.ssh/assh.d
# fi
#
# if [[ ! -d ~/.ssh/.sockets ]]; then
#   mkdir ~/.ssh/.sockets
# fi
#
# if [[ ! -f ~/.bin/assh ]]; then
#   _download_assh
# fi
#
if [[ ! -f "$HOME/.dotfiles/last_update" ]]; then
  print -P "%F{red}Cant find last_update file%f"
  git diff-index HEAD --exit-code
  if [[ $? == 0 ]]; then
    git -C $HOME/.dotfiles pull
  fi
  git -C ~/.dotfiles submodule update --remote --recursive
  print -P "%F{white}Bootstraping dots.%f"
  rm -rf dots
  git clone ssh://om@home.1210.uk:20000/red01/home_om/git/om/dots.git $HOME/.dotfiles/dots
  touch $HOME/.dotfiles/last_update
  dotfiles_version > $HOME/.dotfiles/last_update
else
  result=$(find $HOME/.dotfiles/last_update -mtime -10 -type f | wc -l)
  if [[ $result == 0 ]]; then
    print -P "%F{red}Dotfiles has not been updated in the last 10 days%f"
    print -P "%F{white}Bootstraping dots.%f"
    rm -rf dots
    git clone ssh://om@home.1210.uk:20000/red01/home_om/git/om/dots.git $HOME/.dotfiles/dots
    touch $HOME/.dotfiles/last_update
    dotfiles_version > $HOME/.dotfiles/last_update
  fi
fi
