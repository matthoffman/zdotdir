# ZDOTDIR 

My current $ZDOTDIR zsh config directory. 

# Installation

This more-or-less follows the [XDG base directory](https://wiki.archlinux.org/title/XDG_Base_Directory) spec: 
 - Config (this repo) goes `~/.config/zsh/` instead of directly in $HOME
 - Cache files go in `~/.cache/zsh/`
 - Local data files (like dynamically downloaded plugins, for example) go in 
 `~/.local/share`

This directory should be checked out into (or symlinked to) `.config/zsh`, and .zshenv within this 
directory should be symlinked to `~/.zshenv`.  

Alternately, you can create a separate ~/.zshenv that sources in `.config/zsh/.zshenv`.  The 
`.zshenv` file in this directory sets `ZDOTDIR` to `~/.config/zsh`, so the rest of the zsh config 
files will be read from here. 


# Plugins

This uses plugins sparingly. I'm more likely to copy bits that I want into my config than bring in
whole repos, and I'm not comfortable downloading plugins at runtime. Sadly, we're in the age of 
supply chain attacks.


# History

I used [Prezto](https://github.com/sorin-ionescu/prezto) for many, many years – from back when it 
was a fork of Oh-My-Zsh. And it works well, and there's no real need to change.

But recently I decided I wanted to set up my own anyway. Why? Maybe because I had a lot of other 
things that I really needed to do, so clearly refreshing my zsh config was what I did. Maybe peer 
pressure got to me. Maybe I wanted to go through the exercise of putting it together so that I 
understood it a little better. Maybe because I ran across [zsh unplugged](https://github.com/mattmc3/zsh_unplugged) 
and it clicked with me. 

But Prezto is intelligently put together, and the author understands Zsh better than I ever will, 
so this ~~steals~~ borrows _liberally_ from it. I also followed the breadcrumbs from 
[zsh unplugged](https://github.com/mattmc3/zsh_unplugged) and cribbed a lot from mattmc3's 
[dotfiles](https://github.com/mattmc3/zsh_unplugged?tab=readme-ov-file) as well. 

# Order of Loading

Just dropping this here for reference, because I tend to forget: 

For login shells, files are loaded in this order: 

.zshenv → .zprofile → .zshrc → .zlogin → .zlogout

For non-login, interactive shells, it is normally: 

.zshenv → .zshrc → .zlogout

However, my .zshenv sources .zprofile directly for interactive shells.

# References

Nothing here is original. 

 - https://github.com/sorin-ionescu/prezto
 - https://github.com/mattmc3/zdotdir 
