
if ! is-macos; then
  return 1
fi

# Displays the macOS download history.
#   Author: Sorin Ionescu <sorin.ionescu@gmail.com>
function osx-ls-download-history {
    local db
    for db in ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV*; do
    if grep -q 'LSQuarantineEvent' < <(sqlite3 "$db" .tables); then
        sqlite3 "$db" 'SELECT LSQuarantineDataURLString FROM LSQuarantineEvent'
    fi
    done
}


#
# Deletes .DS_Store and __MACOSX directories.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
function osx-rm-dir-metadata {
    find "${@:-$PWD}" \( \
    -type f -name '.DS_Store' -o \
    -type d -name '__MACOSX' \
    \) -print0 | xargs -0 rm -rf
}

#
# Displays the current Finder.app directory.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
function pfd {
    osascript 2> /dev/null <<EOF
  tell application "Finder"
    return POSIX path of (target of first window as text)
  end tell
EOF
}

#
# Displays the current Finder.app selection.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
function pfs {
    osascript 2>&1 <<EOF
tell application "Finder" to set the_selection to selection
if the_selection is not {}
    repeat with an_item in the_selection
    log POSIX path of (an_item as text)
    end repeat
end if
EOF
}

#
# Previews files in Quick Look.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
function ql {
    if (( $# > 0 )); then
    qlmanage -p "$@" &> /dev/null
    fi
}


#
# Opens man pages in Preview.app.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
function manp {
  local page
  if (( $# > 0 )); then
    for page in "$@"; do
      man -t "$page" | open -f -a Preview
    done
  else
    print 'What manual page do you want?' >&2
  fi
}


# Changes directory to the current Finder directory.
alias cdf='cd "$(pfd)"'

# Pushes directory to the current Finder directory.
alias pushdf='pushd "$(pfd)"'
