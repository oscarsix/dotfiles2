#!/bin/zsh

() {
  async_init
  async_start_worker dotfiles_worker -n
  COMPLETED=0
  completed_callback() {
    COMPLETED=$(( COMPLETED + 1 ))
    print $@
  }

  async_register_callback dotfiles_worker completed_callback
# #  async_job dotfiles_worker ~/.dotfiles/install
#
#   if [[ $(hostname -f) =~ ".rz01.riseops.*$" ]]; then
#     print -P "%F{green}Activating rz01 profile%f"
#     ZSH_THEME="xxf"
#   elif [[ $(hostname -f) =~ ".akx.evva.*$" ]]; then
#     print -P "%F{green}Activating evva profile%f"
#     ZSH_THEME="xxf"
#   else
#     print -P "%F{green}Activating default profile%f"
#     ZSH_THEME="xxf"
#   fi
#
}

dotfiles_edit_aliases() {
  vim ~/.dotfiles/aliases.zsh
  git -C ~/.dotfiles add ~/.dotfiles/aliases.zsh
  git -C ~/.dotfiles commit -m "changed aliases.zsh"
  git -C ~/.dotfiles push origin master
}

dotfiles_edit_assh_dots() {
  vim ~/.dotfiles/dots/assh_dots.yml
  git -C ~/.dotfiles/dots add ~/.dotfiles/dots
  git -C ~/.dotfiles/dots commit -m "changed assh misc"
  git -C ~/.dotfiles/dots push origin master
}

dotfiles_edit_assh_rz01() {
  vim ~/.dotfiles/dots/assh_rz01.yml
  git -C ~/.dotfiles/dots add ~/.dotfiles/dots
  git -C ~/.dotfiles/dots commit -m "changed assh rz01"
  git -C ~/.dotfiles/dots push origin master
}

dotfiles_edit_assh_bsm() {
  vim ~/.dotfiles/dots/assh_bsm.yml
  git -C ~/.dotfiles/dots add ~/.dotfiles/dots
  git -C ~/.dotfiles/dots commit -m "changed assh bsm"
  git -C ~/.dotfiles/dots push origin master
}

dotfiles_edit_dotfiles_plugin() {
  vim ~/.dotfiles/dotfiles.plugin.zsh/dotfiles.plugin.zsh
  git -C ~/.dotfiles add ~/.dotfiles/dotfiles.plugin.zsh/dotfiles.plugin.zsh
  git -C ~/.dotfiles commit -m "changed dotfiles plugin"
  git -C ~/.dotfiles push origin master
}

dotfiles_update() {
  git -C "${HOME}/.dotfiles" pull --rebase
  ~/.dotfiles/install
  source $ZSH/oh-my-zsh.sh
}

dotfiles_version() {
  gittag=$(git --git-dir=$HOME/.dotfiles/.git log --format=oneline -1)
  echo "$gittag"
}

dotfiles_chown_home_folder() {
  find ~ -nouser 2>&1 >/dev/null
  if [[ $? == 1 ]]; then
    print -P "%F{red}Fixing file owner in users home%f"
    sudo chown -R $(id -u):$(id -g) ~
  fi
}

_dotfiles_update_submodules() {
  git -C ~/.dotfiles submodule update --remote --recursive
  if [[ $? == 0 ]]; then
    git -C ~/.dotfiles commit --all --message "update dotfiles submodules"
  fi
}

_dotfiles_check_last_update() {
  if [[ ! -f "$HOME/.dotfiles/last_update" ]]; then
    print -P "%F{red}Cant find last_update file%f"
    return 2
  fi
  result=$(find ./last_update -mtime -10 -type f | wc -l)
  if [[ $result == 0 ]]; then
    print -P "%F{red}Dotfiles has not been updated in the last 10 days. Updateing dotfiles ...%f"
    return 1
  fi
  return 0
}

_dotfiles_commit_push_changes() {
  git commit --all --message "auto updates ..."
  git push origin master
}

_dotfiles_download_assh() {
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

_dotfiles_git_fetch_diff() {
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

_dotfiles_foo() {
  echo "BAR"
}
