{ pkgs, ... }:

{
  # adapted from: https://github.com/NixOS/nixpkgs/issues/274554#issuecomment-2211307799
  gtk = {
    enable = true;
    font = {
      name = "Canterell";
      size = 11;
      package = pkgs.cantarell-fonts;
    };
    iconTheme = {
      name = "Arc";
      package = pkgs.arc-icon-theme;
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = { name = "adwaita-dark"; };
  };

  # packages to inspect configuration
  home.packages = with pkgs; [
    lxappearance
    libsForQt5.qt5ct
    qt6Packages.qt6ct
  ];
}
