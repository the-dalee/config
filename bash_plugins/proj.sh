# Enables proj command to list and go to a subfolder contained in folder $PROJDIR

proj(){
    cd $PROJDIR/$1 &> /dev/null  \
    || echo Project $1 not found && return 1
}

_proj(){
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="$(echo $(ls $PROJDIR))"

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

complete -F _proj proj


