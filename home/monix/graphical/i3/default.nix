{ pkgs, commonParams, ... }:

{
  # set up standard picom
  home.packages = with pkgs; [ picom ];
  xdg.configFile."picom/picom.conf".source = ./picom.conf;

  # add bin script
  home.file."${commonParams.localBin}/picom-wrapper" = {
    text = ''
      #!/usr/bin/env bash

      # conditions for launching picom
      if pgrep -u "$USER" -x picom &>/dev/null; then
        pkill -u "$USER" -x picom
        sleep 1.5
      fi

      # launch picom
      picom -b
    '';
    executable = true;
  };
}
