export TEAM="sokoban"
PROJDIR="$HOME/development"

# Exit using the same command as vi
alias :wq="exit"
alias :q="exit"
alias reloadrc='. ~/.bashrc'

alias ls='ls -G'
alias ll='ls -l'

# Set prompt to username@hostname ~$ 
export PS1="\[\033[38;5;1m\]\u@\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;12m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\\$ \[$(tput sgr0)\]"

proj(){
    cd $PROJDIR/$TEAM/$1 &> /dev/null  \
    || cd $PROJDIR/common/$1 &> /dev/null \
    || echo Project $1 not found && return 1
}

_proj(){
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="$(echo $(ls $PROJDIR/$TEAM) $(ls $PROJDIR/common))"

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

complete -F _proj proj

if [ -f $HOME/.bashrc_local ]; then
    source ~/.bashrc_local
fi
