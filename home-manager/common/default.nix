{ config, pkgs, buildVars, ... }:

{
  # modular imports
  imports = [
    ./alacritty
    ./backgrounds
    ./dircolors
    ./fonts
    ./git
    ./gpg
    ./i3
    ./htop
    ./qutebrowser
    ./ranger
    ./readline
    ./rofi
    ./sxiv
    ./systemd
    ./tmux
    ./vim
    ./xdg
    ./zathura
    ./zsh
  ];

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
    username = "${buildVars.user}";
    homeDirectory = "/home/${buildVars.user}";
    packages = with pkgs; [ brightnessctl ruby python3Full ];
    sessionPath = [
      "$HOME/bin"
    ];
  };

  # configure home-manager
  programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
