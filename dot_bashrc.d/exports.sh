export EDITOR="/usr/bin/hx"
export VISUAL="/usr/bin/subl"

export HISTSIZE='32768'
export HISTFILESIZE="${HISTSIZE}";
export HISTCONTROL=ignorespace:erasedups

shopt -s autocd
shopt -s histappend

export PROMPT_COMMAND="history -a; history -n"

