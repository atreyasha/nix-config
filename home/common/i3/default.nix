{ pkgs, ... }:

{
  # standard i3 configuration
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
  };

  # add packages that we commonly use
  home.packages = with pkgs; [
    feh
    unclutter-xfixes
    xorg.xset
    xss-lock
    xkb-switch
    i3lock-fancy-rapid
    autorandr
    scrot
    i3-balance-workspace
  ];

  # set up xinitrc to launch startx
  home.file.".xinitrc" = {
    source = ./.xinitrc;
    executable = true;
  };

  # add zsh configuration lines
  programs.zsh.initExtra = builtins.readFile ./x11_hooks.zsh;

  # setup local shell scripts
  home.file.".local/bin/feh-wrapper" = {
    source = ./feh-wrapper;
    executable = true;
  };
  home.file.".local/bin/i3lock-wrapper" = {
    source = ./i3lock-wrapper;
    executable = true;
  };
}
