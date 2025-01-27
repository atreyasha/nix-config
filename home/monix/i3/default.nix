{ pkgs, ... }:

{
  # set up standard picom
  home.packages = with pkgs; [ picom ];
  xdg.configFile."picom/picom.conf".source = ./picom.conf;

  # add bin script
  home.".local/bin/picom-wrapper" = {
    source = ./picom-wrapper;
    executable = true;
  };
}
