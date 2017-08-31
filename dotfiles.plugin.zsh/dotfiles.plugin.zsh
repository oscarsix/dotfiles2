#!/bin/zsh
source ~/.dotfiles/functions.zsh

() {
#  git remote update
#  git status
#  local_last_commit_date=$(git log -1 --format=%cd)
#  local_last_commitid=$(git log --format="%H" -n 1)
#  print -P "%F{white}version from: ${local_last_commit_date}%f"
  async_init
  async_start_worker dotfiles_worker -n

  COMPLETED=0
  completed_callback() {
    COMPLETED=$(( COMPLETED + 1 ))
    print $@
  }

  async_register_callback dotfiles_worker completed_callback
#  async_job dotfiles_worker ~/.dotfiles/install

  if [[ $(hostname -f) =~ ".rz01.riseops.*$" ]]; then
    print -P "%F{green}Activating rz01 profile%f"
    ZSH_THEME="xxf"
  elif [[ $(hostname -f) =~ ".akx.evva.*$" ]]; then
    print -P "%F{green}Activating evva profile%f"
    ZSH_THEME="xxf"
  else
    print -P "%F{green}Activating default profile%f"
    ZSH_THEME="xxf"
  fi

}

edit_aliases() {
  vim ~/.dotfiles/aliases.zsh
  git -C ~/.dotfiles add ~/.dotfiles/aliases.zsh
  git -C ~/.dotfiles commit -m "changed aliases.zsh"
  git -C ~/.dotfiles push origin master
}

edit_assh_dots() {
  vim ~/.dotfiles/dots/assh_dots.yml
  git -C ~/.dotfiles/dots add ~/.dotfiles/dots
  git -C ~/.dotfiles/dots commit -m "changed assh misc"
  git -C ~/.dotfiles/dots push origin master
}

edit_assh_rz01() {
  vim ~/.dotfiles/dots/assh_rz01.yml
  git -C ~/.dotfiles/dots add ~/.dotfiles/dots
  git -C ~/.dotfiles/dots commit -m "changed assh rz01"
  git -C ~/.dotfiles/dots push origin master
}

edit_assh_bsm() {
  vim ~/.dotfiles/dots/assh_bsm.yml
  git -C ~/.dotfiles/dots add ~/.dotfiles/dots
  git -C ~/.dotfiles/dots commit -m "changed assh bsm"
  git -C ~/.dotfiles/dots push origin master
}

edit_dotfiles_plugin() {
  vim ~/.dotfiles/dotfiles.plugin.zsh/dotfiles.plugin.zsh
  git -C ~/.dotfiles add ~/.dotfiles/dotfiles.plugin.zsh/dotfiles.plugin.zsh
  git -C ~/.dotfiles commit -m "changed dotfiles plugin"
  git -C ~/.dotfiles push origin master
}

update_dotfiles() {
  git -C ~/.dotfiles pull --rebase
  ~/.dotfiles/install
  zsh
}

dotfiles_version() {
  gittag=$(git --git-dir=$HOME/.dotfiles/.git log --format=oneline -1)
  echo "$gittag"
}

check_dotfiles_last_update() {
  if [[ ! -f "$HOME/.dotfiles/last_update" ]]; then
    print -P "%F{red}Cant find last_update file%f"
    return 1
  fi

  result=$(find ./last_update -mtime -10 -type f | wc -l)
  if [[ $result == 0 ]]; then
    print -P "%F{red}Dotfiles has not been updated in the last 10 days"
    return 0
  fi
}

update_dotfiles_submodules() {
  git -C ~/.dotfiles submodule update --remote --recursive
  if [[ $? == 0 ]]; then
    git -C ~/.dotfiles commit --all --message "update dotfiles submodules"
  fi
}

