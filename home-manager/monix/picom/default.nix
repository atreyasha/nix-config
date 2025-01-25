{ pkgs, ... }:

{
  home.packages = with pkgs; [ picom ];
  xdg.configFile."nixpkgs/config.nix".source = ./picom.conf;
}
