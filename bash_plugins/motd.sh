# Displays content of environment variable $MODT on clear and after each start

# Do nothing if not running interactively
[ -z "$PS1" ] && return

motd() {
  echo
  echo -e $MOTD
  echo
}

alias clear='clear && motd'

motd
