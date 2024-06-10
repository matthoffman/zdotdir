

# Plugin location
ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

# If you are using Powerlevel10k prompt, and want to use instant prompt, uncomment this.
# Enable Powerlevel10k instant prompt. Should stay close to the top of .zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Use a zshrc.d directory to source .zshrc files
#
# Originally from https://github.com/mattmc3/zshrc.d, but I'm trying to minimize the 
# number of external repos I have to clone for zsh
#

# Init aliases.
[[ -r ${ZDOTDIR:-$HOME}/.zaliases ]] && source ${ZDOTDIR:-$HOME}/.zaliases

# Run local settings. This is done here so that it can set things that affect the 
# behavior of zshrc.d files. 
[[ -r ${ZDOTDIR:-$HOME}/.zshrc.local ]] && source ${ZDOTDIR:-$HOME}/.zshrc.local

typeset -ga _zshrcd=(
  $ZSHRCD
  ${ZDOTDIR:-/dev/null}/zshrc.d(N)
  ${ZDOTDIR:-/dev/null}/conf.d(N)
  ${ZDOTDIR:-/dev/null}/rc.d(N)
  ${ZDOTDIR:-$HOME}/.zshrc.d(N)
)
if [[ -e "$_zshrcd[1]" ]]; then
    typeset -ga _zshrcd=("$_zshrcd[1]"/*.{sh,zsh}(N))
    typeset -g _zshrcd_file
    for _zshrcd_file in ${(o)_zshrcd}; do
    [[ ${_zshrcd_file:t} != '~'* ]] || continue  # ignore tilde files
    source "$_zshrcd_file"
    done
    unset _zshrcd{,_file}
fi


# completion stuff is now set in zshrc.d, not there. 
#
# ZSH_COMPDUMP=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump
# [[ -d $ZSH_COMPDUMP:h ]] || mkdir -p $ZSH_COMPDUMP:h
# autoload -Uz compinit && compinit -i -d $ZSH_COMPDUMP

# Prompts
#
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
#[[ ! -f ~/.config/zsh/themes/lean.p10k.zsh ]] || source ~/.config/zsh/themes/lean.p10k.zsh
#prompt p10k lean
