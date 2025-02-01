{ pkgs, ... }:

{
  # adapted from: https://github.com/NixOS/nixpkgs/issues/274554#issuecomment-2211307799
  gtk = {
    enable = true;
    font = {
      name = "Canterell";
      size = 11;
      pkg = pkgs.cantarell-fonts;
    };
    iconTheme = {
      name = "Arc";
      pkg = pkgs.arc-icon-theme;
    };
    theme = {
      name = "Adwaita-dark";
      pkg = pkgs.gnome.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "Adwaita-dark";
    style = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
}
