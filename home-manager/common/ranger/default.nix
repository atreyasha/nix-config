{ inputs, pkgs, ... }:

{
  # core program
  programs.ranger = {
    enable = true;
    extraPackages = with pkgs; [
      ueberzugpp
    ];
    plugins = [
      {
        name = "ranger_devicons";
        src = inputs.ranger-devicons;
      }
    ];
    extraConfig = ''
      set preview_images true
      set preview_images_method ueberzug
      set preview_max_size 10000000
      set draw_borders both
      default_linemode devicons
    '';
  };

  # add function to .zshrc
  programs.zsh.initExtra = builtins.readFile ./ranger-cd.zsh;
}
