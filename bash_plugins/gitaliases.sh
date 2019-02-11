alias gcm='git commit'
alias gp='git push'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gpl='git pull'
alias gl='git log'

function ga(){
  git add $@
}

function gco(){
  git checkout $@
}
