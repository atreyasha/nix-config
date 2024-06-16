{ inputs, lib, config, pkgs, user, ... }:

{
  # modular imports
  imports = [];

  # configure nixpkgs as necessary
  nixpkgs = {
    config = {
      # we want unfree stuff
      allowUnfree = true;

      # workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: add i3-cycle pip package
  # TODO: use autorandr from home manager
  # TODO: add appropriate home directories or use XDG

  # set your user's details
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = with pkgs; [ emacs ];
  };

  # enable home-manager and git
  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  # nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
