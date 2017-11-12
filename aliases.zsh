#ZSH Aliases

# Docker
alias dc='docker-compose $@'
alias dcup='docker-compose up -d $@'
alias dcdn='docker-compose down'
alias dclf='docker-compose logs -f'
alias dcex='docker-compose exec $@'
alias dcre='docker-compose restart $@'
alias dps='docker ps $@'
alias fpm-cook='docker run --rm -ti -v "$(pwd):/build" fpm-cook'

# Puppet
alias ppp='puppet agent --enable ; puppet agent -t ; puppet agent --disable'
alias pppn='puppet agent --enable ; puppet agent -t --noop ; puppet agent --disable'
alias ppon='puppet agent --enable'
alias ppoff='puppet agent --disable'

# Linux
alias ps_top='ps -eo pcpu,args --sort=-%cpu|head'
alias tcpl='lsof -iTCP -sTCP:LISTEN -P -n'
alias tar_etc='tar czvf /etc-"$(date +%FT%T)".tar.gz /etc'

alias install_climate='sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/adtac/climate/master/install)"'

# SSH
#alias ssh='assh wrapper ssh'
#alias tor-ssh="ssh -o ProxyCommand=\"nc -x localhost:9050 %h %p\" $@"
#alias mma-prod-scp="scp -o \"ProxyCommand ssh om@mma-bastion01 -W %h:%p\" om@$1\:test \."

# Systemd
alias sctl='systemctl $@'
alias sstart='systemctl start $@'
alias sstop='systemctl stop $@'
alias sstatus='systemctl status $@'

# Pass
alias pass2='PASSWORD_STORE_DIR=~/.pass2 pass $@'

# Tweaks
alias myip='curl ipinfo.io/ip'
