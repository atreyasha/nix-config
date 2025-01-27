# -*- mode: shell-script -*-

# xterm title pre-command
function xterm_title_precmd {
  print -Pn -- '\e]2;%n@%m: %~\a'
  [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

# xterm title pre-execution
function xterm_title_preexec {
  print -Pn -- '\e]2;%n@%m: %~ %(!.#.$) ' && print -n -- "${(q)1}\a"
  [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

# x-term-title (source: https://wiki.archlinux.org/index.php/zsh#xterm_title)
autoload -Uz add-zsh-hook
if [[ "$TERM" == (screen*|xterm*|rxvt*|tmux*|putty*|konsole*|gnome*|alacritty*) ]]; then
  add-zsh-hook -Uz precmd xterm_title_precmd
  add-zsh-hook -Uz preexec xterm_title_preexec
fi
