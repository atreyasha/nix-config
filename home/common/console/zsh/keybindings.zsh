# configure vim keybindings as default
bindkey -v

# configure command-line edits in editor keybinding
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# configure keybinding for clearing and returning line
bindkey '^q' push-line-or-edit
