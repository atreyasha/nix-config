{ lib, config, pkgs, commonParams, ... }:

# TODO: ensure becks and monix work for now
# TODO: move brightnessctl program to monix only
# TODO: delete brightnessctl from common

let
  modifier = config.xsession.windowManager.i3.config.modifier;
  wifiRealTimeSignal = 8;
  keyboardRealTimeSignal = 9;
in
{
  # make additional configurations for i3
  xsession.windowManager.i3.config = {
    keybindings = lib.mkAfter {
        "XF86MonBrightnessUp" = ''exec --no-startup-id "brightnessctl set +10%"'';
        "XF86MonBrightnessDown" = ''exec --no-startup-id "[ $(brightnessctl -m | cut -d , -f 4 | sed 's/%//') -gt 10 ] && brightnessctl set 10%-"'';
        "${modifier}+Shift+w" = ''exec --no-startup-id "wifi toggle && pkill -SIGRTMIN+${builtins.toString wifiRealTimeSignal} i3status-rs"'';
    };
    startup = [
      {
        command = "picom-wrapper";
        notification = false;
        always = true;
      }
    ];
  };

  # make additional status bar configurations
  programs.i3status-rust = {
    bars = {
      default = {
        blocks = lib.mkForce [
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
            signal = wifiRealTimeSignal;
          }
          {
            block = "net";
            format = " $icon ^icon_net_down$speed_down.eng(prefix:K) ^icon_net_up$speed_up.eng(prefix:K) ";
            inactive_format = "";
            signal = wifiRealTimeSignal;
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
            signal = keyboardRealTimeSignal;
          }
        ];
      };
    };
  };

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
