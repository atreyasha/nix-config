{
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    mouse = true;
    terminal = "screen-256color";
    prefix = "C-a";
    escapeTime = 10;
    keyMode = "vi";
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
