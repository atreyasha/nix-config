{
  programs.alacritty = {
    enable = true;
    settings = ''
      [colors.primary]
      background = "#171717"
      foreground = "#dcdccc"

      [env]
      WINIT_X11_SCALE_FACTOR = "1.0"

      [font]
      size = 12.0

      [font.bold]
      family = "BitstromWera Nerd Font Mono"
      style = "Bold"

      [font.bold_italic]
      family = "BitstromWera Nerd Font Mono"
      style = "Bold Italic"

      [font.italic]
      family = "BitstromWera Nerd Font Mono"
      style = "Italic"

      [font.normal]
      family = "BitstromWera Nerd Font Mono"
      style = "Regular"

      [[keyboard.bindings]]
      action = "ScrollPageUp"
      key = "PageUp"
      mode = "~Alt"
      mods = "Shift|Control"

      [[keyboard.bindings]]
      action = "ScrollPageDown"
      key = "PageDown"
      mode = "~Alt"
      mods = "Shift|Control"

      [[keyboard.bindings]]
      action = "ScrollLineUp"
      key = "Up"
      mode = "~Alt"
      mods = "Shift|Control"

      [[keyboard.bindings]]
      action = "ScrollLineDown"
      key = "Down"
      mode = "~Alt"
      mods = "Shift|Control"

      [[keyboard.bindings]]
      action = "Last"
      key = 5
      mode = "Vi|~Search"
      mods = "Shift"

      [window]
      opacity = 0.97
      '';
  };
}
