{ pkgs, ... }:

{
  # core program
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-commentary
      vim-lastplace
    ];
    extraConfig = builtins.readFile ./basic.vim;
  };

  # additional packages
  home.packages = with pkgs; [ xsel ];
}
