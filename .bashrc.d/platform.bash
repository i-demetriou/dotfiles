# Contains all the cool platform aliases for making terminal fun

## Platform control
alias meminfo='free -m -l -t'

### get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'

### get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'

alias zombies='ps aux | grep "defunct" | grep -v "grep"'

### get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
