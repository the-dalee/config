# Enables proj command to list and go to a subfolder contained in folder $PROJDIR/$TEAM
# or $PROJDIR/common
#
# Required congiguration env variables:
#   - PROJDIR   Path where the projects are stored
#   - TEAM      Name of the team

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


