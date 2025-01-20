{ inputs, pkgs, ... }:

{
  # core program
  programs.ranger = {
    enable = true;
    extraPackages = with pkgs; [
      ueberzugpp
    ];
    plugins = [
      {
        name = "ranger_devicons";
        src = inputs.ranger-devicons;
      }
    ];
    extraConfig = ''
      set preview_images true
      set preview_images_method ueberzug
      set preview_max_size 10000000
      set draw_borders both
      default_linemode devicons
    '';
  };

  # add function to .zshrc
  programs.zsh.initExtra = ''
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
  '';
}
