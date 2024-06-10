This directory should be symlinked to .config/zsh, and .zshenv within this directory 
should be symlinked to ~/.zshenv.  
Alternately, you can create a separate ~/.zshenv that sources in .config/zsh/.zshenv. 
The .zshenv file in this directory sets ZDOTDIR to ~/.config/zsh, so the rest of the 
zsh config files will be read from here. 
