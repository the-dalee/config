source ~/.bash_config
for f in ~/.bash_plugins/*; do source $f; done

alias reloadrc='. ~/.bashrc'
alias ls='ls -G'
alias ll='ls -l'

# Set prompt to username@hostname ~$ 
export PS1="\[\033[38;5;1m\]\u@\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;12m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\\$ \[$(tput sgr0)\]"

if [ -f $HOME/.bashrc_local ]; then
    source ~/.bashrc_local
fi
