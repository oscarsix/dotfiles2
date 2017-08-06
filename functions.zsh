foo() {
  print "test"
}

_chown_home_user() {
  find ~ -nouser 2>&1 >/dev/null
  if [[ $? == 1 ]]; then
    print -P "%F{red}Fixing file owner in users home%f"
    sudo chown -R $(id -u):$(id -g) ~
  fi
}

_dotfiles_version() {
  gittag=$(git --git-dir=$HOME/.dotfiles/.git log --format=oneline -1)
  echo "$gittag"
}

_check_dotfiles_last_update() {
  if [[ ! -f "$HOME/.dotfiles/last_update" ]]; then
    print -P "%F{red}Cant find last_update file%f"
    return 2
  fi

  result=$(find ./last_update -mmin -1 -type f | wc -l)
  if [[ $result == 0 ]]; then
    print -P "%F{red}Dotfiles has not been updated in the last 10 days. Updateing dotfiles ..."
    return 1
  fi

  return 0
}

_update_dotfiles_submodules() {
  git -C ~/.dotfiles submodule update --remote --recursive
}

_touch_dotfiles_last_update_file() {
  touch ~/.dotfiles/last_update
  _dotfiles_version > ~/.dotfiles/last_update
}

_is_dotfiles_repo_dirty() {
  #git diff --no-ext-diff --quiet --exit-code
  git diff-index HEAD --exit-code
  return $?
}

_git_pull_dotfiles_repo() {
  _is_dotfiles_repo_dirty
  if [[ $? == 0 ]]; then
    git -C ~/.dotfiles pull
  fi
}

_bootstrap_dots() {
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
}

_commit_push_changes() {
  git commit --all --message "auto updates ..."
  git push origin master
}
