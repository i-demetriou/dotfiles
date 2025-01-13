# Contains all the cool network aliases for making terminal fun

## Resume wget by default
alias curl-json='curl --write-out "\n%{http_code}\n" --header "Content-Type: application/json" --request POST'
alias fastping='ping -c 100 -s 2'
alias ip='ip -c'
alias ports='netstat -tuplan'
alias wget='wget -c'
