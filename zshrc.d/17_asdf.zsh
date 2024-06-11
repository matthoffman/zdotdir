# Source in asdf's shell config, in old or new location. 
# If it's in both places, the XDG location will override the old one. 
if [[ -f "${HOME}/.asdf/asdf.sh" ]]; then
	. $HOME/.asdf/asdf.sh
fi

if [[ -f "${XDG_DATA_HOME}/asdf/asdf.sh" ]]; then
	export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
	export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
	. ${XDG_DATA_HOME}/asdf/asdf.sh
fi

