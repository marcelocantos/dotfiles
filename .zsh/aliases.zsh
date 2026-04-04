# Shell startup docs: ~/CLAUDE.md § "Shell Startup Scripts"
alias eal='vi ~/.zsh/aliases.zsh'

alias p=ipython3
alias tig='tig --all'
alias vi=nvim
alias m=make
alias mp=multipass

alias d=docker
alias dri='docker run -it --rm'
alias dei='docker exec -it --rm'
alias denvei='docker exec -it $(docker ps -q --filter ancestor=envelope-dev) bash'
alias dkenv='docker rm -f $(docker ps -q --filter ancestor=envelope-dev)'
alias k=kubectl

alias tree='tree --gitignore'
alias ls='eza --icons --git'
alias l='ls -a'
alias ll='ls -al'

alias gmi='go mod init "${PWD#$HOME/work/}"'
alias gmt='go mod tidy'
alias gap='ga -p'
alias gs='git status --short --branch'
alias ghs='/opt/homebrew/bin/gs'
alias gpu='git push -u origin @'
alias grup='git remote update -p'

alias h='http --check-status --follow'

alias clc='claude --continue'

unalias g la lsa 2>/dev/null
unalias gg 2>/dev/null
