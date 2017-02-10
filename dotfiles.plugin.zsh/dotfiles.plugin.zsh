#!/bin/zsh

() {
  # Autoload
  if [[ $(hostname -f) =~ ".rz01.riseops.*$" ]]; then
    print -P "%F{green}Activating rz01 profile%f"
    ZSH_THEME="spaceship"
    exit 0
  fi
  
  if [[ $(hostname -f) =~ ".akx.evva.*$" ]]; then
    print -P "%F{green}Activating evva profile%f"
    ZSH_THEME="spaceship"
    exit 0
  fi

  print -P "%F{green}Activating default profile%f"
  ZSH_THEME="xxf"
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
  ~/.dotfiles/install
}

