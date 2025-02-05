{ config, pkgs, commonParams, ... }:

{
  # modular imports
  imports = [ ./console ./graphical ./services ];

  # configure nixpkgs as necessary
  nixpkgs = {
    config = {
      # we want unfree stuff
      allowUnfree = true;

      # workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # set your user's details
  home = {
    username = "${commonParams.defaultUser}";
    homeDirectory = "/home/${commonParams.defaultUser}";
    packages = with pkgs; [ python3Full arandr ];
    sessionPath = [ "$HOME/${commonParams.localBin}" ];
  };

  # configure home-manager
  programs.home-manager.enable = true;

  # allow font configuration
  fonts.fontconfig.enable = true;

  # enable sane XDG directories
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
