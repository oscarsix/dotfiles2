#!/bin/zsh

() {
  # Autoload

}

edit_aliases(){
  vim ~/.dotfiles/aliases.zsh
  git -C ~/.dotfiles add ~/.dotfiles/aliases.zsh
  git -C ~/.dotfiles commit -m "changed aliases.zsh"
  git -C ~/.dotfiles push origin master
}
