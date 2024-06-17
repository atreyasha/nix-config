let
  alacrittyFont = "BitstromWera Nerd Font Mono";
in
{
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
    };
  };
}
