
plugin-load https://github.com/zsh-users/zsh-autosuggestions

# I don't know what these do exactly, but they're from Prezto, so I'm probably used to 
# them.

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
#
# Key Bindings
#

if [[ -n "$key_info" ]]; then
  # vi
  bindkey -M viins "$key_info[Control]F" vi-forward-word
  bindkey -M viins "$key_info[Control]E" vi-add-eol
fi
