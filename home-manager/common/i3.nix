{ pkgs, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
  };

  home.file.".xinitrc".text = "exec i3";
}
