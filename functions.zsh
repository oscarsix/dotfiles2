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

  result=$(find ./last_update -mtime -10 -type f | wc -l)
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
  git clone ssh://om@home.1210.uk:20000/red01/home_om/git/om/dots.git dots

	# if [[ $(hostname -f) =~ ".rz01.riseops.*$" ]]; then
	# 	print -P "Downloading dots for rz01 environment"
	# 	git clone ssh://om@home.1210.uk:20000/red01/home_om/git/om/rise-dots.git dots
	# 	exit 0
	# fi

	# if [[ $(hostname -f) =~ ".akx.evva.*$" ]]; then
	# 	print -P "Downloading dots for evva environment"
	# 	git clone ssh://om@home.1210.uk:20000/red01/home_om/git/om/evva-dots.git dots
	# 	exit 0
	# fi

	# print -P "Downloading universal dots"
	# git clone ssh://om@home.1210.uk:20000/red01/home_om/git/om/dots.git dots
}

_commit_push_changes() {
  git commit --all --message "auto updates ..."
  git push origin master
}

_download_assh() {
  _ossystem=$(uname -s)
  case $_ossystem in 
    Linux)
      _assh_bin="assh_linux_386"
      ;;
    Darwin)
      _assh_bin="assh_darwin_amd64"
      ;;
    *)
      echo "Unknown system"
      exit 1
  esac
  wget "https://github.com/moul/advanced-ssh-config/releases/download/v2.6.0/${_assh_bin}"
  if [[ $? == 0 ]]; then
    mv ${_assh_bin} ~/.bin/assh && chmod +x ~/.bin/assh
    rm -f ${assh_bin}
  fi
}

function extract {
	echo Extracting $1 ...
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xjf $1  ;;
			*.tar.gz)    tar xzf $1  ;;
			*.bz2)       bunzip2 $1  ;;
			*.rar)       unrar x $1    ;;
			*.gz)        gunzip $1   ;;
			*.tar)       tar xf $1   ;;
			*.tbz2)      tar xjf $1  ;;
			*.tgz)       tar xzf $1  ;;
			*.zip)       unzip $1   ;;
			*.Z)         uncompress $1  ;;
			*.7z)        7z x $1  ;;
			*)        echo "'$1' cannot be extracted via extract()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

_git_fetch_diff() {
  git -C ~/.dotfiles fetch origin master
  res=$(git -C ~/.dotfiles diff --quiet --exit-code origin/master)
  if [[ $res == 0 ]]; then
    print -P "%F{green}Repo is uptodate%f"
    return 0
  else
    print -P "%F{red}Repo is dirty%f"
    return 1
  fi
}
