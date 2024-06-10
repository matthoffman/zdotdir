
#
# Directories
#
setopt AUTO_CD              # Auto changes to a directory without typing cd.
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME        # Push to home directory when no argument is given.
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt MULTIOS              # Write to multiple descriptors.
setopt EXTENDED_GLOB        # Use extended globbing syntax.
setopt glob_dots            # Include dotfiles when globbing.
setopt path_dirs            # Perform path search even on command names with slashes.


# Safe redirects
unsetopt CLOBBER            # Do not overwrite existing files with > and >>.
                            # Use >! and >>! to bypass.
setopt NO_rm_star_silent    # Ask for confirmation for `rm *' or `rm path/*'

alias -- -='cd -'
#
# Previous directory aliases
#
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

#
# Another form of directory aliases. 
#
() {
  local index dotdots=".."
  for index in {1..9}; do
    alias "$index"="cd -${index}"   # dirstack aliases (eg: "3"="cd -3")
    alias -g "..$index"="$dotdots"  # backref aliases (eg: "..3"="../../..")
    dotdots+='/..'
  done
}

# Set up "z" plugin, which tracks most recent & frequently used directories and lets
# you CD to them using "z [pattern]". 
# Change where it will save its DB.
_Z_DATA=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/z
plugin-load https://github.com/rupa/z
