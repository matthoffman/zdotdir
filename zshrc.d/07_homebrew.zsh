# Add homebrew to path
if (( $+commands[brew] )); then 
  # make sure we have Homebrew env vars
  if [[ -z "$HOMEBREW_PREFIX" ]]; then
    source <(brew shellenv)
  fi 
  # Add homebrew completions to $fpath
  fpath=("${HOMEBREW_PREFIX}/share/zsh/site-functions" $fpath)
fi
