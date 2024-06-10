
#
# prompt: Setup Zsh prompt.
#

# Load external prompt
#plugin-load https://github.com/sindresorhus/pure
plugin-load https://github.com/romkatv/powerlevel10k

# 16.2.8 Prompting
setopt prompt_subst       # Expand parameters in prompt variables.
setopt transient_rprompt  # Remove right prompt artifacts from prior commands.

function prompt_p10k_setup {
  if [[ -n "$1" ]]; then
    local -a configs=($__zsh_config_dir/themes/$1.p10k.zsh(N))
    (( $#configs )) && source $configs[1]
  fi
  prompt_powerlevel10k_setup
}

# function prompt_starship_setup {
#   # When loaded through the prompt command, these prompt_* options will be enabled
#   prompt_opts=(cr percent sp subst)

#   if [[ -n "$1" ]]; then
#     local -a configs=(
#       $__zsh_config_dir/themes/$1.toml(N)
#       ${XDG_CONFIG_HOME:-$HOME/.config}/starship/$1.toml(N)
#     )
#     (( $#configs )) && export STARSHIP_CONFIG=$configs[1]
#   fi

#   # Initialize starship.
#   if zstyle -t ':kickstart.zsh:feature:prompt' 'use-cache'; then
#     cached-eval 'starship-init-zsh' starship init zsh
#   else
#     source <(starship init zsh)
#   fi
# }

# Wrap promptinit.
# function promptinit {
#   # Initialize real built-in prompt system.
#   unfunction promptinit
#   autoload -Uz promptinit && promptinit

#   # Hook P10k into Zsh's prompt system.
#   if (( $+functions[prompt_powerlevel10k_setup] )); then
#     prompt_themes+=( p10k )
#   else
#     unfunction prompt_p10k_setup
#   fi

#   # Hook starship into Zsh's prompt system.
#   if (( $+commands[starship] )); then
#     prompt_themes+=( starship )
#   else
#     unfunction prompt_starship_setup
#   fi

#   # Keep prompt array sorted.
#   prompt_themes=( "${(@on)prompt_themes}" )
# }


# # Init prompt.
# if (( $#prompt_themes == 0 )); then
#   promptinit

#   # Set prompt
#   if [[ $TERM == dumb ]]; then
#       prompt 'off'
#   else
#       local -a prompt_argv
#       zstyle -a ':kickstart.zsh:feature:prompt' 'theme' 'prompt_argv' \
#       || prompt_argv=(off)
#       echo "prompt_argv = " $prompt_argv[@]
#       echo "or $prompt_argv"
#       prompt "$prompt_argv[@]"
#   fi
# fi


# plugin-load adds to fpath automatically, this isn't necessary
# fpath+=($HOME/.zsh/pure)

#prompt pure


# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/prompts/rounded.p10k.zsh ]] || source ~/.config/zsh/prompts/rounded.p10k.zsh
#prompt p10k lean
