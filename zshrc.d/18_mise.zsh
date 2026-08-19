# Activate mise if it's present. 
#
if command -v mise > /dev/null 2>&1; then
    eval "$(command mise activate zsh)"
    # brew installs mise completions to /opt/homebrew/share/zsh/site-functions, so no need to activate them separately
elif [[ -f "/opt/homebrew/bin/mise" ]]; then
    eval "$(/opt/homebrew/bin/mise activate zsh)"
elif [[ -f "~/.local/bin/mise" ]]; then 
    eval "$(~/.local/bin/mise activate zsh)"
fi

