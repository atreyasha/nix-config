{ pkgs, ... }:

{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-commentary
      vim-lastplace
    ];
  };
}
