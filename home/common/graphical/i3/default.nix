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
        "$ws5" = [
          { class = "^vmware$"; }
          { class = "^Vmware$"; }
        ];
      };
      bars = [
        {
          fonts = config.xsession.windowManager.i3.config.fonts;
          statusCommand = "i3status-rust";
          position = "top";
        }
      ];
      focus = {
        followMouse = false;
        wrapping = "force";
        mouseWarping = false;
        newWindow = "none";
      };
      fonts = {
        names = [ "DejaVu Sans" ];
        size = 10.0;
      };
      gaps = {
        inner = 6;
        outer = 4;
        smartBorders = "on";
        smartGaps = true;
      };
      modifier = "Mod4";
      startup = [
        {
          command = "i3-msg workspace $ws1; { i3-sensible-terminal --working-directory ~ & }; { i3-sensible-terminal --working-directory ~ & }";
          notification = false;
        }
        {
          command = "amixer -q sset Master 50% && amixer -q sset Master mute";
          notification = false;
        }
        {
          command = "autorandr --change && feh-wrapper";
          notification = false;
        }
        {
          command = "picom-wrapper";
          notification = false;
          always = true;
        }
      ];
      # TODO: think of best way to configure modes i.e. here or file
      # TODO: complete keybindings later and edit defaultWorkspace
      menu = ''
        i3-msg -t get_workspaces | \
        jq '.[] | select(.focused==true).output' | \
        xargs -I{} rofi -monitor {} -show drun"
      '';
      defaultWorkspace = "workspace number 1";
    };
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
    dejavu_fonts
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
