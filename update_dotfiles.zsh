#!/bin/zsh 
source ~/.dotfiles/functions.zsh

_chown_home_user
_ossystem=$(uname -s)

if [[ ! -d ~/.ssh ]]; then
  mkdir ~/.ssh
fi

if [[ ! -f ~/.ssh/assh_known_hosts ]]; then
  touch ~/.ssh/assh_known_hosts
fi

if [[ ! -d ~/.ssh/assh.d ]]; then
  mkdir ~/.ssh/assh.d
fi

if [[ ! -f ~/.bin/assh ]]; then
  _download_assh  
fi

_check_dotfiles_last_update
_res=$?
if [[ $_res == 1 ]]; then
  _git_pull_dotfiles_repo
  _update_dotfiles_submodules  
  _bootstrap_dots
  assh config build > ~/.ssh/config
  _touch_dotfiles_last_update_file
fi
if [[ $_res == 2 ]]; then
  _bootstrap_dots
  assh config build > ~/.ssh/config
  _touch_dotfiles_last_update_file
fi
