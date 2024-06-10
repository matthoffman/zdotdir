# 
# Aliases and defaults for various common utilities
#

# Return if requirements are not found.
[[ "$TERM" != 'dumb' ]] || return 1

# Built-in zsh colors.
autoload -Uz colors && colors

# Disable globbing.
alias bower='noglob bower'
alias fc='noglob fc'
alias find='noglob find'
alias ftp='noglob ftp'
alias history='noglob history'
alias locate='noglob locate'
alias rake='noglob rake'
alias rsync='noglob rsync'
alias scp='noglob scp'
alias sftp='noglob sftp'

# Some general aliases
alias _='sudo'

alias p='${(z)PAGER}'

# Safe ops. Ask the user before doing anything destructive.
alias rm="${aliases[rm]:-rm} -i"
alias mv="${aliases[mv]:-mv} -i"
alias cp="${aliases[cp]:-cp} -i"
alias ln="${aliases[ln]:-ln} -i"


# Colorize man pages.
export LESS_TERMCAP_md=$fg_bold[blue]   # start bold
export LESS_TERMCAP_mb=$fg_bold[blue]   # start blink
export LESS_TERMCAP_so=$'\e[00;47;30m'  # start standout: white bg, black fg
export LESS_TERMCAP_us=$'\e[04;35m'     # start underline: underline magenta
export LESS_TERMCAP_se=$reset_color     # end standout
export LESS_TERMCAP_ue=$reset_color     # end underline
export LESS_TERMCAP_me=$reset_color     # end bold/blink

# Set LS_COLORS using (g)dircolors if found.
if (( $+commands[dircolors] )); then
    if [[ -z "$LS_COLORS" ]]; then
        for dircolors_cmd in dircolors gdircolors; do
            if (( $+commands[$dircolors_cmd] )); then
            if [[ -s "$HOME/.dir_colors" ]]; then
                eval "$($dircolors_cmd --sh "$HOME/.dir_colors")"
            else
                eval "$(dircolors --sh)"
            fi
            if zstyle -t ':kickstart.zsh:feature:color' 'use-cache'; then
                cached-eval "$dircolors_cmd" $dircolors_cmd --sh
            else
                source <($dircolors_cmd --sh)
            fi
            break
            fi
        done
        # Or, pick a reasonable default.
        export LS_COLORS="${LS_COLORS:-di=34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43}"
    fi
else
    # We're probably on BSD / MacOS

    # Define colors for BSD ls if they're not already defined
    if [[ -z "$LSCOLORS" ]]; then
      export LSCOLORS='exfxcxdxbxGxDxabagacad'
    fi

    # Define colors for the completion system if they're not already defined
    if [[ -z "$LS_COLORS" ]]; then
      export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
    fi

    export CLICOLOR=${CLICOLOR:-1}
fi

# https://github.com/romkatv/powerlevel10k/blob/8fefef228571c08ce8074d42304adec3b0876819/config/p10k-lean.zsh#L6C5-L6C105
##? Show a simple colormap
function colormap {
  for i in {0..255}; do
    print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
  done
}

# Set colors for ls.
if (( ! $+commands[dircolors] )) || is-macos; then
  alias ls="${aliases[ls]:-ls} -G"
else
  alias ls="${aliases[ls]:-ls} --group-directories-first --color=auto"
fi

# Set colors for diff
if command diff --color /dev/null{,} &>/dev/null; then
  alias diff="${aliases[diff]:-diff} --color"
fi

# Colorize completions.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Grep
export GREP_COLOR='37;45'           # BSD.
export GREP_COLORS="mt=$GREP_COLOR" # GNU.

alias grep="${aliases[grep]:-grep} --color=auto"

# Resource Usage
alias df='df -kh'
alias du='du -kh'

# Serves a directory via HTTP.
if (( $+commands[python3] )); then
  alias http-serve='python3 -m http.server'
else
  alias http-serve='python -m SimpleHTTPServer'
fi

# Prints columns 1 2 3 ... n.
function slit {
  awk "{ print ${(j:,:):-\$${^@}} }"
}

# Finds files and executes a command on them.
function find-exec {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

# Displays user owned processes status.
function psu {
  ps -U "${1:-$LOGNAME}" -o 'pid,%cpu,%mem,command' "${(@)argv[2,-1]}"
}

