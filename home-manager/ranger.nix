{ pkgs, ... }:

{
  # TODO: add plugin as own nix package
  # TODO: figure out how to import stuff
  programs.ranger = {
    enable = true;
    extraPackages = [
      pkgs.ueberzugpp
    ];
    extraConfig = ''
      set preview_images true
      set preview_images_method ueberzug
      set preview_max_size 10000000
      set draw_borders both
      default_linemode devicons
    '';
  };
}
