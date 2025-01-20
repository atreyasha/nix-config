{ config, pkgs, buildVars, ... }:

{
  # modular imports
  imports = [
    ./alacritty.nix
    ./backgrounds
    ./dircolors
    ./fonts.nix
    ./git.nix
    ./gpg.nix
    ./htop.nix
    ./picom.nix
    ./qutebrowser.nix
    ./ranger
    ./readline.nix
    ./rofi.nix
    ./sxiv.nix
    ./systemd.nix
    ./tmux.nix
    ./vim.nix
    ./xdg.nix
    ./zathura.nix
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
