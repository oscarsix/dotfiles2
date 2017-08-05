#!/bin/zsh

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
  gittag=$(git --git-dir=~/.dotfiles/.git log --format=oneline -1)
  echo "$gittag"
}

