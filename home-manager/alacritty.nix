{ pkgs, ... }:

let
  alacrittyFont = "BitstromWera Nerd Font Mono";
in
{
  # update session variable
  home.sessionVariables = {
    TERMINAL = "alacritty";
  };

  # core program
  programs.alacritty = {
    enable = true;
    settings = {
      colors.primary = {
        background = "#171717";
        foreground = "#dcdccc";
      };

      window = {
        opacity = 0.97;
      };

      env = {
        WINIT_X11_SCALE_FACTOR = "1.0";
      };

      font = {
        size = 12.0;
        bold = {
          family = "${alacrittyFont}";
          style = "Bold";
        };
        bold_italic = {
          family = "${alacrittyFont}";
          style = "Bold Italic";
        };
        italic = {
          family = "${alacrittyFont}";
          style = "Italic";
        };
        normal = {
          family = "${alacrittyFont}";
          style = "Regular";
        };
      };

      keyboard.bindings = [
        {
          action = "ScrollPageUp";
          key = "PageUp";
          mode = "~Alt";
          mods = "Control|Shift";
        }
        {
          action = "ScrollPageDown";
          key = "PageDown";
          mode = "~Alt";
          mods = "Control|Shift";
        }
        {
          action = "ScrollLineUp";
          key = "Up";
          mode = "~Alt";
          mods = "Control|Shift";
        }
        {
          action = "ScrollLineDown";
          key = "Down";
          mode = "~Alt";
          mods = "Control|Shift";
        }
      ];
    };
  };

  # update session variable
  home.sessionVariables = {
    TERMINAL = "alacritty";
  };

  # add necessary fonts
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "BitstreamVeraSansMono" ]; })
  ];
}
