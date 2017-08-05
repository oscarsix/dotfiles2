#!/bin/zsh 
source ~/.dotfiles/functions.zsh

_chown_home_user

_check_dotfiles_last_update
if [[ $? == 1 ]]; then
  _git_pull_dotfiles_repo
  _update_dotfiles_submodules  
  _bootstrap_dots
  _touch_dotfiles_last_update_file
fi

