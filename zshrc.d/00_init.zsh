# 
# Some helpers & utilities used by other scripts
#


##? Checks if a name is a command, function, or alias.
function is-callable {
  (( $+commands[$1] || $+functions[$1] || $+aliases[$1] || $+builtins[$1] ))
}

##? Check whether a string represents "true" (1, y, yes, t, true, o, on).
function is-true {
  [[ -n "$1" && "$1:l" == (1|y(es|)|t(rue|)|o(n|)) ]]
}

# OS checks.
function is-macos  { [[ "$OSTYPE" == darwin* ]] }
function is-darwin { is-macos }
function is-linux  { [[ "$OSTYPE" == linux*  ]] }
function is-bsd    { [[ "$OSTYPE" == *bsd*   ]] }
function is-cygwin { [[ "$OSTYPE" == cygwin* ]] }
function is-termux { [[ "$OSTYPE" == linux-android ]] }

#
# Plugin loading functions
#
# Some other zshrc scripts may load plugins, which in this context are just zsh init
# scripts that live in external repos. These are the functions they'll use for that.
#
# Courtesy of mattmc3 from https://github.com/mattmc3/zsh_unplugged
#
# TODO: I don't actually want to clone a repo dynamically if it's not there. 
#
##? Clone a plugin, identify its init file, source it, and add it to fpath.
# Note that unlike most plugin loading functions, this does *not* assume the 
# "github.com" part of the repo URL. That must be explicit. 
# If zsh-defer has been laoded before this, then it will be used to load the plugin's 
# init file.
function plugin-load {
  local repo plugdir initfile initfiles=()
  : ${ZPLUGINDIR:=${ZDOTDIR:-~/.config/zsh}/plugins}
  for repo in $@; do
    plugdir=$ZPLUGINDIR/${repo:t}
    initfile=$plugdir/${repo:t}.plugin.zsh
	# mattmc3's version clones the repo on demand if it isn't there. I am taking the 
	# absence of the plugin dir as a sign that we don't want to use this plugin in 
	# this environment. 
    if [[ -d $plugdir ]]; then
		if [[ ! -e $initfile ]]; then
		  initfiles=($plugdir/*.{plugin.zsh,zsh-theme,zsh,sh}(N))
		  (( $#initfiles )) || { echo >&2 "No init file '$repo'." && continue }
		  # Don't create a symlink, just because that pollutes the repo with untracked files, which is annoying.
		  #ln -sf $initfiles[1] $initfile
		  initfile=$initfiles[1]
		fi
		fpath+=$plugdir
		(( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
	fi
  done
}

##? Compiles all plugins in $ZPLUGINDIR
function plugin-compile {
  ZPLUGINDIR=${ZPLUGINDIR:-$HOME/.config/zsh/plugins}
  autoload -U zrecompile
  local f
  for f in $ZPLUGINDIR/**/*.zsh{,-theme}(N); do
    zrecompile -pq "$f"
  done
}
