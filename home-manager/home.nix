{ config, pkgs, buildVars, ... }:

{
  # modular imports
  imports = [
    ./alacritty.nix
    ./backgrounds
    ./dircolors.nix
    ./fonts.nix
    ./git.nix
    ./gpg.nix
    ./htop.nix
    ./picom.nix
    ./qutebrowser.nix
    ./ranger.nix
    ./readline.nix
    ./rofi.nix
    ./sxiv.nix
    ./systemd.nix
    ./tmux.nix
    ./vim.nix
    ./zathura.nix
    ./zsh.nix
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
    packages = with pkgs; [ ruby ];
    sessionPath = [
      "$HOME/bin"
    ];
  };

  # configure home-manager
  programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
