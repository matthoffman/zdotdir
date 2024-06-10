#
# History-related options
# 

#
# Options
#

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt hist_reduce_blanks        # Remove extra blanks from commands added to the history list.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt inc_append_history        # Write to the history file immediately, not when the shell exits.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt NO_HIST_BEEP              # Do not beep when accessing non-existent history.

#
# Variables
#

HISTFILE=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh_history # The path to the history file.
[[ -d $HISTFILE:h ]] || mkdir -p $HISTFILE:h
[[ "$SAVEHIST" -gt 1000 ]] || SAVEHIST=1000000   # History file size
[[ "$HISTSIZE" -gt 2000 ]] || HISTSIZE=1000000   # Session history size

#
# History aliases.
#
alias hist='fc -li'

# Lists the ten most used commands.
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"


# Attempt to migrate old histfile to new location if present
if [[ -s "${OLD_HISTFILE::=$HOME/.zsh_history}" ]]; then

  # New 'HISTFILE' doesn't exist yet, rename legacy one if available and notify.
  if [[ ! -s "$HISTFILE" ]]; then
    <<EON
NOTICE: Default path of 'HISTFILE' has changed from '${OLD_HISTFILE/#$HOME/~}'
        to '${HISTFILE/#$HOME/~}'.
        Attempting to rename the existing 'HISTFILE' ...
EON
    command mv -v "$OLD_HISTFILE" "$HISTFILE"

  # New 'HISTFILE' does exist and is older than legacy one, just warn.
  elif [[ "$OLD_HISTFILE" -nt "$HISTFILE" ]]; then
    <<EOW
WARNING: Default path of 'HISTFILE' has changed from '${OLD_HISTFILE/#$HOME/~}'
         to '${HISTFILE/#$HOME/~}'.
         Either set 'HISTFILE' in '${${0:h}/#$HOME/~}'
         or move previous history from '${OLD_HISTFILE/#$HOME/~}' to
         '${HISTFILE/#$HOME/~}'.
EOW
  fi

  unset OLD_HISTFILE
fi
