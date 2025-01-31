{ config, pkgs, commonParams, ... }:

let
  backgroundsDir = "backgrounds";
  modifier = config.xsession.windowManager.i3.config.modifier;
  exitMode = "${modifier}+Shift+e";
  adjustMode = "${modifier}+r";
  scrotMode = "${modifier}+Shift+s";
  exitModeMessage = "exit: [s]uspend, ab[o]rt-X, [l]ock, [r]eboot, [p]oweroff";
  adjustModeMessage = "adjust size/gaps: j,k,l,h [size] | J,K,L,H [gaps]";
  scrotModeMessage = "screen-capture: s[e]lection, foc[u]sed, [a]ll";
  wifiRealTimeSignal = 8;
  keyboardRealTimeSignal = 9;
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
          statusCommand = "i3status-rs config-default.toml";
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
      keybindings = {
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
        "XF86AudioMute" = ''exec --no-startup-id "amixer -q sset Master toggle"'';

        "XF86MonBrightnessUp" = ''exec --no-startup-id "brightnessctl set +10%"'';
        "XF86MonBrightnessDown" = ''exec --no-startup-id "[ $(brightnessctl -m | cut -d , -f 4 | sed 's/%//') -gt 10 ] && brightnessctl set 10%-"'';

        "${modifier}+Shift+w" = ''exec --no-startup-id "wifi toggle && pkill -SIGRTMIN+${wifiRealTimeSignal} i3status-rs"'';
        "${modifier}+Shift+k" = ''exec --no-startup-id "xkb-switch -n && pkill -SIGRTMIN+${keyboardRealTimeSignal} i3status-rs"'';

        "${modifier}+q" = "exec --no-startup-id qutebrowser";
        "${modifier}+Shift+m" = ''exec --no-startup-id "autorandr --change && feh-wrapper"'';
        "${modifier}+Shift+b" = "exec --no-startup-id i3_balance_workspace";
        "${modifier}+b" = ''exec --no-startup-id "i3_balance_workspace --scope focus"'';

        "${exitMode}" = ''mode "${exitModeMessage}"'';
        "${adjustMode}" = ''mode "${adjustModeMessage}"'';
        "${scrotMode}" = ''mode "${scrotModeMessage}"'';
      };
      menu = "";
      modes = {
        "${exitModeMessage}" = {
          s = "mode default; exec --no-startup-id systemctl suspend";
          o = "exec --no-startup-id i3-msg exit";
          l = "mode default; exec --no-startup-id loginctl lock-session";
          r = "exec --no-startup-id systemctl reboot";
          p = "exec --no-startup-id systemctl poweroff";
          Escape = "mode default";
          Return = "mode default";
          "${exitMode}" = "mode default";
        };
        "${adjustModeMessage}" = {
          h = "resize shrink width 10 px or 1 ppt";
          j = "resize grow height 10 px or 1 ppt";
          k = "resize shrink height 10 px or 1 ppt";
          l = "resize grow width 10 px or 1 ppt";
          "Shift+j" = "gaps inner all plus 2";
          "Shift+k" = "gaps inner all minus 2";
          "Shift+l" = "gaps outer all plus 2";
          "Shift+h" = "gaps outer all minus 2";
          Return = "mode default";
          Escape = "mode default";
          "${adjustMode}" = "mode default";
        };
        "${scrotModeMessage}" = {
          "--release e" = "exec --no-startup-id scrot --line style=dash --select; mode default";
          u = "exec --no-startup-id scrot -u -b; mode default";
          a = ''mode default; exec --no-startup-id "sleep 0.5 && scrot"'';
          Return = "mode default";
          Escape = "mode default";
          "${scrotMode}" = "mode default";
        };
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
      ];
    };
    extraConfig = builtins.readFile ./config;
  };

  # add i3status-rust configuration
  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        blocks = [
          { block = "sound"; }
          {
            block = "backlight";
            invert_icons = true;
          }
          {
            block = "cpu";
            format = " $icon $utilization.eng(w:3) @ $frequency ";
          }
          {
            block = "temperature";
            idle = 50;
          }
          {
            block = "memory";
            format = " $icon $mem_used.eng(prefix:Mi)/$mem_total.eng(prefix:Mi) ($mem_used_percents.eng(w:1)) ";
          }
          {
            block = "disk_space";
            format = " $icon $available ($percentage.eng(w:1)) ";
          }
          {
            block = "custom";
            command = "wifi | grep -q '= on' && echo '{\"icon\": \"net_wireless\", \"state\": \"Info\", \"text\": \"enabled\"}' || echo '{\"icon\": \"net_wireless\", \"text\": \"disabled\"}'";
            json = true;
            signal = "${wifiRealTimeSignal}";
          }
          {
            block = "net";
            format = " $icon ^icon_net_down$speed_down.eng(prefix:K) ^icon_net_up$speed_up.eng(prefix:K) ";
            inactive_format = "";
            signal = "${wifiRealTimeSignal}";
          }
          {
            block = "battery";
            format = " $icon $percentage {($time)|} ";
            driver = "upower";
            device = "";  # forces upower to not use DisplayDevice
            empty_threshold = -1;  # empty battery will not be shown
          }
          {
            block = "time";
            format = " $timestamp.datetime(f:'%a %d/%m/%Y') ";
          }
          {
            block = "time";
            format = " $timestamp.datetime(f:'%R') ";
          }
          {
            block = "keyboard_layout";
            driver = "xkbswitch";
            format = builtins.fromJSON ''" \uf11c $layout "'';  # see workaround: https://github.com/NixOS/nix/issues/10082
            signal = "${keyboardRealTimeSignal}";
          }
        ];
        icons = "awesome4";
        settings = {
          theme = {
            theme = "dracula";
            overrides = {
              alternating_tint_bg = "#151515";
            };
          };
        };
      };
    };
  };

  # add zsh configuration lines
  programs.zsh.initExtra = builtins.readFile ./x11_hooks.zsh;

  # enable autorandr
  programs.autorandr.enable = true;

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
    font-awesome_4
    jq
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
