# Python virtualenv aliases
alias ve='python3 -m venv ./.venv'
alias va='source ./.venv/bin/activate'


# ls -> exa
alias ls="exa --color=auto"
alias la="ls -A"
alias ll="ls -lhF --icons"
alias lla="ll -A"
alias l="ls -F"

alias lt="ls -T"
alias lta="lt -A"

alias peaclock="peaclock --config-dir $HOME/.config/peaclock"

alias sd="cd ~ && cd \$(fzf --walker=dir,hidden)" # Fuzzy cd


# rmtrash aliases
alias rm="rmtrash"
alias rmdir="rmdirtrash"
alias sudo="sudo " # necessary for some reason
