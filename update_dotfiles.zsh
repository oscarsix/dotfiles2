#!/bin/zsh
source $HOME/.dotfiles/functions.zsh
if [[ -r "$HOME/.dotfiles.conf" ]]; then
  source "$HOME/.dotfiles.conf"
fi

_ossystem=$(uname -s)
# git -C ~/.dotfiles/dots pull --rebase

if [[ ! -d "$HOME/.ssh" ]]; then
  mkdir "$HOME/.ssh"
fi

if [[ dotfiles_assh == true ]]; then
  if [[ ! -f ~/.ssh/assh_known_hosts ]]; then
    touch ~/.ssh/assh_known_hosts
  fi

  if [[ ! -d ~/.ssh/assh.d ]]; then
    mkdir ~/.ssh/assh.d
  fi

  if [[ ! -d ~/.ssh/.sockets ]]; then
    mkdir ~/.ssh/.sockets
  fi

  if [[ ! -f ~/.bin/assh ]]; then
    # TODO
  fi

fi

function _dotfiles_bootstrap_or_update_dots() {
  if [[ -d "$HOME/.dotfiles/dots" ]]; then
    print -P "%F{white}Update dots.%f"
    git -C "$HOME/.dotfiles/dots" pull --rebase
  else
    print -P "%F{white}Bootstrap dots.%f"
    git clone ssh://om@home.1210.uk:20000/red01/home_om/git/om/dots.git $HOME/.dotfiles/dots
  fi
}

if [[ ! -f "$HOME/.dotfiles/last_update" ]]; then
  print -P "%F{red}Cant find last_update file%f"
  git -C "$HOME/.dotfiles" diff-index HEAD --exit-code
  if [[ $? == 0 ]]; then
    git -C "$HOME/.dotfiles" pull
  fi
  git -C "$HOME/.dotfiles" submodule update --remote --recursive
  _dotfiles_bootstrap_or_update_dots
  touch "$HOME/.dotfiles/last_update"
  git --git-dir="$HOME/.dotfiles/.git" log --format=oneline -1 > "$HOME/.dotfiles/last_update"
else
  result=$(find $HOME/.dotfiles/last_update -mtime -10 -type f | wc -l)
  if [[ $result == 0 ]]; then
    print -P "%F{red}Dotfiles has not been updated in the last 10 days%f"
    _dotfiles_bootstrap_or_update_dots
    touch "$HOME/.dotfiles/last_update"
    git --git-dir="$HOME/.dotfiles/.git" log --format=oneline -1 > "$HOME/.dotfiles/last_update"
  fi
fi
