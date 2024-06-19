{
  programs.rofi = {
    enable = true;
    theme = "gruvbox-dark-hard";
    extraConfig = {
      modi = "drun";
      font = "mono 11";
      bw = 0;
      location = 1;
      disable-history = false;
      line-margin = 0;
      line-padding = 1;
      separator-style = "none";
    };
  };
}
