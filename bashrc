TEAMNAME="graviton"

#Set prompt to username@hostname ~$ 
PS1="\u@\h \W\$ "

#Enable colors
alias reloadrc='. ~/.bashrc'

proj(){
    cd ~/development/$TEAMNAME/$1 &> /dev/null  \
    || cd ~/development/common/$1 &> /dev/null \
    || echo Project $1 not found && return 1
}

_proj(){
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="$(echo $(ls ~/development/$TEAMNAME/) $(ls ~/development/common))"

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

complete -F _proj proj
