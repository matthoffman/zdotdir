
#
# prompt: Setup Zsh prompt.
#
# To override the prompt locally, set ZPROMPT=[path to prompt script] in .zshrc.local
#
# To customize the p10k prompt, run `p10k configure` or edit the prompt in ${ZDOTDIR}/prompts directly
#

# I'm not using plugin-load here, mainly because it creates symlinks that I don't need and leave the repo in a dirty state. 
if [[ -f ${ZDOTDIR}/plugins/powerlevel10k/powerlevel10k.zsh-theme ]]; then 
	source ${ZDOTDIR}/plugins/powerlevel10k/powerlevel10k.zsh-theme
	_default_prompt=${ZDOTDIR}/prompts/rounded.p10k.zsh
	[[ ! -r ${ZPROMPT:-${_default_prompt}} ]] || source ${ZPROMPT:-${_default_prompt}}
	unset _default_prompt
elif [[ -r ${ZPROMPT} ]]; then 
	# Perhaps we set ZPROMPT to be something that doesn't require powerlevel10k? 
	source ${ZPROMPT}
else
	# TODO: Set up a simple prompt to use if powerlevel10k isn't available.
fi
