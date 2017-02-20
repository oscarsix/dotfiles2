#ZSH Aliases
alias dc='docker-compose $@'
alias dcup='docker-compose up -d $@'
alias dcdn='docker-compose down'
alias dclf='docker-compose logs -f'
alias dcex='docker-compose exec $@'
alias dcre='docker-compose restart $@'

alias ppp='puppet agent --enable ; puppet agent -t ; puppet agent --disable'
alias pppn='puppet agent --enable ; puppet agent -t --noop ; puppet agent --disable'
alias ppon='puppet agent --enable'
alias ppoff='puppet agent --disable'

alias ps_top='ps -eo pcpu,args --sort=-%cpu|head'

##
alias tar_etc='tar czvf /etc-"$(date +%FT%T)".tar.gz /etc'
##
