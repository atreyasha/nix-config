{ inputs, pkgs, ... }:

{
  # TODO: add plugin as own nix package
  # TODO: figure out how to import stuff
  programs.ranger = {
    enable = true;
    extraPackages = with pkgs [
      ueberzugpp
    ];
    plugins = [
      {
        name = "ranger_devicons";
        src = inputs.ranger-devicons;
      };
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
