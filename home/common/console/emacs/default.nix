{ inputs, pkgs, ... }:

{
  programs.emacs.enable = true;
  home.file.".emacs.d" = {
    source = inputs.spacemacs;
    recursive = true;
  };
  home.file.".spacemacs".source = ./init.el;
  home.packages = with pkgs; [ source-code-pro ];
}
