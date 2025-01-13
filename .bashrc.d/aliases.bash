# Contains all the cool aliases for making terminal fun

## Utilities
alias bc='bc -l'
alias diff='diff --color=always --unified --show-function-line="^    \w.*\:$" --new-file --report-identical-files'
alias now='date +"%T"'
alias sha1='openssl sha1'
alias sl='sl -e'

## Repeated tasks
alias update='sudo apt update && sudo apt upgrade --yes --auto-remove && sudo apt autoremove'
