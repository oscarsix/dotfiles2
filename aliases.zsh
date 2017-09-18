#ZSH Aliases
alias dc='docker-compose $@'
alias dcup='docker-compose up -d $@'
alias dcdn='docker-compose down'
alias dclf='docker-compose logs -f'
alias dcex='docker-compose exec $@'
alias dcre='docker-compose restart $@'
alias dps='docker ps $@'

alias ppp='puppet agent --enable ; puppet agent -t ; puppet agent --disable'
alias pppn='puppet agent --enable ; puppet agent -t --noop ; puppet agent --disable'
alias ppon='puppet agent --enable'
alias ppoff='puppet agent --disable'

alias ps_top='ps -eo pcpu,args --sort=-%cpu|head'
alias tcpl='lsof -iTCP -sTCP:LISTEN -P -n'

##
alias tar_etc='tar czvf /etc-"$(date +%FT%T)".tar.gz /etc'
###
alias fpm-cook='docker run --rm -ti -v "$(pwd):/build" fpm-cook'
#
alias install_climate='sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/adtac/climate/master/install)"'

#alias ssh='assh wrapper ssh'

alias sctl='systemctl $@'
alias sstart='systemctl start $@'
