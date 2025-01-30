{ config, pkgs, commonParams, ... }:

let
  backgroundsDir = "backgrounds";
in
{
  # standard i3 configuration
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      assigns = {
        "$ws2" = [
          { class = "^firefox$"; }
          { class = "^Firefox$"; }
          { class = "^qutebrowser$"; }
        ];
        "$ws3" = [
          { class = "^emacs$"; }
          { class = "^Emacs$"; }
        ];
        "$ws4" = [
          { class = "^signal$"; }
          { class = "^Signal$"; }
          { class = "^zoom$"; }
          { class = "^Zoom$"; }
        ];
        "$ws4" = [
          { class = "^vmware$"; }
          { class = "^Vmware$"; }
        ];
      };
    };
    bars = [
      {
        statusCommand = "${pkgs.i3status}/bin/i3status";
        position = "top";
      };
    ];
  };

  # add packages that we commonly use
  home.packages = with pkgs; [
    feh
    unclutter-xfixes
    xorg.xset
    xss-lock
    xkb-switch
    i3lock-fancy-rapid
    scrot
    i3-balance-workspace
  ];

  # set up desktop backgrounds
  xdg.dataFile."${backgroundsDir}" = {
    source = ./backgrounds;
    recursive = true;
  };

  # set up xinitrc to launch startx
  home.file.".xinitrc" = {
    source = ./.xinitrc;
    executable = true;
  };

  # add zsh configuration lines
  programs.zsh.initExtra = builtins.readFile ./x11_hooks.zsh;

  # setup local shell scripts
  home.file."${commonParams.localBin}/feh-wrapper" = {
    text = ''
      #!/usr/bin/env bash

      # this script sets up a default filled background
      # --no-fehbg ensures that no executable at $HOME/.fehbg is written
      feh --no-fehbg --bg-fill "${config.xdg.dataHome}/${backgroundsDir}/cosmic_drive.png"
    '';
    executable = true;
  };
  home.file."${commonParams.localBin}/i3lock-wrapper" = {
    source = ./i3lock-wrapper;
    executable = true;
  };
}
