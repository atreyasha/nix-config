# configure completions (source: https://wiki.archlinux.org/index.php/zsh#Command_completion)
zstyle ':completion:*' use-cache on
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

# configure vim keybindings
bindkey -v

# configure history search keybindings (source: https://wiki.archlinux.org/index.php/zsh#History_search)
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# configure extra keybindings directly from terminfo (source: https://wiki.archlinux.org/index.php/zsh#Key_bindings)
typeset -g -A key
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[ShiftTab]="${terminfo[kcbt]}"

# setup keys accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-beginning-search
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-beginning-search
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[ShiftTab]}"  ]] && bindkey -- "${key[ShiftTab]}"  reverse-menu-complete

# finally, make sure the terminal is in application mode, when zle is active
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  autoload -Uz add-zle-hook-widget
  function zle_application_mode_start {
    echoti smkx
  }
  function zle_application_mode_stop {
    echoti rmkx
  }
  add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
  add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# configure command-line edits in editor keybinding
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# configure keybinding for clearing and returning line
bindkey '^q' push-line-or-edit

# configure history-related options
setopt hist_find_no_dups

# configure completion options
setopt complete_aliases

# enabling and setting git info var to be used in prompt config
# source: https://medium.com/pareture/simplest-zsh-prompt-configs-for-git-branch-name-3d01602a6f33
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*' formats " @%b"

# set precmd which is executed before each prompt
function precmd {
  # compute vcs information and hide errors
  vcs_info 2>/dev/null

  # define command prompt prefix and suffix
  _PREFIX="[%F{011}%B%n@%m%f%b:%F{blue}%B%~%b%f"
  _SUFFIX="${vcs_info_msg_0_}]"

  # strip right-hand-side to get everything on the left
  if [[ "$PROMPT" == *"$_PREFIX"* && "$PROMPT" != "$_PREFIX"* ]]; then
    _PREFIX="${PROMPT//"$_PREFIX"*/"$_PREFIX"}"
  fi
}

# define function for changing prompt depending on zsh vim mode (source and more: https://superuser.com/a/156204)
function zle-line-init zle-keymap-select {
  # create new prompt based on keymap
  case ${KEYMAP} in
    (vicmd)
      PROMPT="${_PREFIX}${_SUFFIX}%F{green}%#%f "
      ;;
    (*)
      PROMPT="${_PREFIX}${_SUFFIX}%# "
      ;;
  esac
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
