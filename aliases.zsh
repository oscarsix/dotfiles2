#ZSH Aliases
alias dc='docker-compose $@'
alias dcup='docker-compose up -d'
alias dcdn='docker-compose down'
alias dclf='docker-compose logs -f'
alias dcex='docker-compose exec $@'

alias ppp='puppet agent --enable ; puppet agent -t ; puppet agent --disable'
alias pppn='puppet agent --enable ; puppet agent -t --noop ; puppet agent --disable'
alias ppon='puppet agent --enable'
alias ppoff='puppet agent --disable'

