#!/bin/zsh

find ~ -nouser 2>&1 >/dev/null
if [[ $? == 1 ]]; then
    sudo chown -R $(id -u):$(id -g) ~
fi

if [[ -d dots ]]; then
  print -P "%F{green}Folder dots already exists.%f"
  print -P "%F{green}Updating dots.%f"
  git -C ~/.dotfiles/dots pull --rebase
  print -P "%F{green}Updating dotfiles.%f"
  git -C ~/.dotfiles pull --rebase
  exit 0
fi

print -P "%F{white}Bootstraping dots.%f"

if [[ $(hostname -f) =~ ".rz01.riseopsi.*$" ]]; then
  print -P "Downloading dots for rz01 environment"
  git clone ssh://git@b1t.uk:1848/om/rise-dots.git dots
  exit 0
fi

if [[ $(hostname -f) =~ ".akx.evva.*$" ]]; then
  print -P "Downloading dots for evva environment"
  git clone ssh://git@b1t.uk:1848/om/evva-dots.git dots
  exit 0
fi

print -P "Downloading universal dots"
git clone ssh://git@b1t.uk:1848/om/dots.git dots

