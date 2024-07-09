{ config, pkgs, buildVars, ... }:

{
  # modular imports
  imports = [
    ./alacritty.nix
    ./backgrounds.nix
    ./dircolors.nix
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
    ./vim/vim.nix
    ./zathura.nix
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

  # TODO: vim, zsh (enable support in other files)
  # TODO: X11 and i3 (needs system level, remove picom as we have service), autorandr, mimeapps, bin, neomutt + systemd
  # TODO: fontconfig and gtk and qt, emacs
  # TODO: add i3-cycle package as flake git/tarball dependency with package: https://github.com/nix-community/nix-init
  # TODO: use XDG directories with capital names instead of current ones
  # TODO: port all packages including fonts and fontConfig, but take note difference for fonts in system configuration vs. home-manager: https://discourse.nixos.org/t/home-manager-nerdfonts/11226, https://nixos.asia/en/tips/hm-fonts

  # set your user's details
  home = {
    username = "${buildVars.user}";
    homeDirectory = "/home/${buildVars.user}";
    packages = with pkgs; [];
  };

  # configure home-manager
  programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
