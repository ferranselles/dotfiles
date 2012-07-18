function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

function preexec() {
    typeset -gi CALCTIME=1
    typeset -gi CMDSTARTTIME=SECONDS
}

function precmd() {
    if (( CALCTIME )) ; then
        typeset -gi ETIME=SECONDS-CMDSTARTTIME
    fi
    typeset -gi CALCTIME=0
}

#Initial value
typeset -gi ETIME=0

# Change the color of the symbol.
if [ `id -u ` = 0 ]; then
  local SHSCOLOR="${fg_bold[red]}"
else
  local SHSCOLOR=${fg_no_bold[cyan]}
fi

PROMPT='
[%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}$(box_name)%{$reset_color%}]-[%{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}]($(git_prompt_info))
$(virtualenv_info)%(?,,%{${fg_bold[white]}%}[%?]%{$reset_color%} )$ '

#local return_status="%{$fg[red]%}%(?..✘)%{$reset_color%}"
#RPROMPT='${return_status}%{$reset_color%}'

RPROMPT='%{$fg[blue]%}[${ETIME}s] %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

