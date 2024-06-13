# Add homebrew to path
if [[ -z "$HOMEBREW_PREFIX" ]] || [[ -x "/opt/homebrew/bin/brew" ]] || [[ -x "/usr/local/bin/brew" ]]; then 
  # make sure we have Homebrew env vars
  if [[ -z "$HOMEBREW_PREFIX" ]]; then
  	if [[ -x "/opt/homebrew/bin/brew" ]]; then
	  source <(/opt/homebrew/bin/brew shellenv)
	elif [[ -x "/usr/local/bin/brew" ]]; then
	  source <(/usr/local/bin/brew shellenv)
	fi
  fi 
  # Add homebrew completions to $fpath
  fpath=("${HOMEBREW_PREFIX}/share/zsh/site-functions" $fpath)
fi
