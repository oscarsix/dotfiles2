#!/bin/zsh

_ossystem=$(uname -s)
# git -C ~/.dotfiles/dots pull --rebase

if [[ ! -d ~/.ssh ]]; then
  mkdir ~/.ssh
fi

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
  _download_assh
fi

_dotfiles_check_last_update
_res=$?
if [[ $_res == 1 ]]; then
  _dotfiles_git_pull_repo
  _dotfiles_update_submodules
  _dotfiles_bootstrap_dots
  assh config build > ~/.ssh/config
  _dotfiles_touch_last_update_file
fi
if [[ $_res == 2 ]]; then
  _dotfiles_bootstrap_dots
  assh config build > ~/.ssh/config
  _dotfiles_touch_last_update_file
fi
