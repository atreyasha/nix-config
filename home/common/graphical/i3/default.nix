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
          statusCommand = "i3status-rust ${config.xdg.configHome}/i3status-rust/config-default.toml";
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
      keybindings = let
        modifier = config.xsession.windowManager.i3.config.modifier;
      in {
        "${modifier}+Return" = ''exec --no-startup-id "i3-sensible-terminal --working-directory ~"'';
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = ''exec --no-startup-id "i3-msg -t get_workspaces | jq '.[] | select(.focused==true).output' | xargs -I{} rofi -monitor {} -show drun"'';

        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        "${modifier}+h" = "split horizontal";
        "${modifier}+v" = "split vertical";
        "${modifier}+f" = "fullscreen toggle";

        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";

        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";

        "${modifier}+a" = "focus parent";
        "${modifier}+c" = "focus child";

        "${modifier}+1" = "workspace number $ws1";
        "${modifier}+2" = "workspace number $ws2";
        "${modifier}+3" = "workspace number $ws3";
        "${modifier}+4" = "workspace number $ws4";
        "${modifier}+5" = "workspace number $ws5";
        "${modifier}+6" = "workspace number $ws6";
        "${modifier}+7" = "workspace number $ws7";
        "${modifier}+8" = "workspace number $ws8";
        "${modifier}+9" = "workspace number $ws9";
        "${modifier}+0" = "workspace number $ws10";

        "${modifier}+Shift+1" =
          "move container to workspace number $ws1";
        "${modifier}+Shift+2" =
          "move container to workspace number $ws2";
        "${modifier}+Shift+3" =
          "move container to workspace number $ws3";
        "${modifier}+Shift+4" =
          "move container to workspace number $ws4";
        "${modifier}+Shift+5" =
          "move container to workspace number $ws5";
        "${modifier}+Shift+6" =
          "move container to workspace number $ws6";
        "${modifier}+Shift+7" =
          "move container to workspace number $ws7";
        "${modifier}+Shift+8" =
          "move container to workspace number $ws8";
        "${modifier}+Shift+9" =
          "move container to workspace number $ws9";
        "${modifier}+Shift+0" =
          "move container to workspace number $ws10";
        "${modifier}+m" = "move workspace to output left";
        "${modifier}+n" = "move workspace to output right";

        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";

        "XF86AudioRaiseVolume" = ''exec --no-startup-id "amixer -q sset Master unmute && amixer -q sset Master 5%+"'';
        "XF86AudioLowerVolume" = ''exec --no-startup-id "amixer -q sset Master unmute && amixer -q sset Master 5%-"'';
        "XF86AudioMute" = ''exec --no-startup-id "amixer -q sset master toggle"'';

        "XF86MonBrightnessUp" = ''exec --no-startup-id "brightnessctl set +10%"'';
        "XF86MonBrightnessDown" = ''exec --no-startup-id "[ $(brightnessctl -m | cut -d , -f 4 | sed 's/%//') -gt 10 ] && brightnessctl set 10%-"'';

        "${modifier}+Shift+w" = ''exec --no-startup-id "wifi toggle && pkill -SIGRTMIN+8 -x i3status-rs"'';
        "${modifier}+Shift+k" = ''exec --no-startup-id "xkb-switch -n && pkill -SIGRTMIN+9 -x i3status-rs"'';

        "${modifier}+q" = "exec --no-startup-id qutebrowser";
        "${modifier}+Shift+m" = ''exec --no-startup-id "autorandr --change && feh-wrapper"'';
        "${modifier}+Shift+b" = "exec --no-startup-id i3_balance_workspace";
        "${modifier}+b" = ''exec --no-startup-id "i3_balance_workspace --scope focus"'';

        "${modifier}+Shift+e" = ''mode "exit: [s]uspend, ab[o]rt-X, [l]ock, [r]eboot, [p]oweroff"''
        "${modifier}+r" = ''mode "adjust size/gaps: j,k,l,h [size] | J,K,L,H [gaps]"''
        "${modifier}+Shift+s" = ''mode "screen-capture: s[e]lection, foc[u]sed, [a]ll"''
      };
      menu = "";
      modes = {};
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
      ];
    };
    extraConfig = builtins.readFile ./config;
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

  # add i3status-rust configuration
  programs.i3status-rust = {
    enable = true;
  };

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
