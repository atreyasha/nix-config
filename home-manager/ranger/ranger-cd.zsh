# define nice function which we can use in TTY
function ranger-cd {
  tempfile="$(mktemp -t tmp.XXXXXX)"
  ranger --choosedir="$tempfile" "${@:-$(pwd)}"
  test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
      cd -- "$(cat "$tempfile")"
    fi
  rm -f -- "$tempfile"
}

# if ranger exists, create ranger-cd useful function and binding
if command -v ranger &>/dev/null; then
  zle -N ranger-cd
  bindkey -s '^r' '^qranger-cd^m'
fi
