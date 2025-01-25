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
