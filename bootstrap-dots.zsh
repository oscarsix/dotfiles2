#!/bin/zsh

find ~ -nouser 2>&1 >/dev/null
if [[ $? == 1 ]]; then
    sudo chown -R $(id -u):$(id -g) ~
fi

print -P "%F{white}Bootstraping dots.%f"
rm -rf dots

if [[ $(hostname -f) =~ ".rz01.riseops.*$" ]]; then
  print -P "Downloading dots for rz01 environment"
  git clone ssh://om@home.1210.uk:20000/red01/home_om/git/om/rise-dots.git dots
  exit 0
fi

if [[ $(hostname -f) =~ ".akx.evva.*$" ]]; then
  print -P "Downloading dots for evva environment"
  git clone ssh://om@home.1210.uk:20000/red01/home_om/git/om/evva-dots.git dots
  exit 0
fi

print -P "Downloading universal dots"
git clone ssh://om@home.1210.uk:20000/red01/home_om/git/om/dots.git dots

