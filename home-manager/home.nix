{ config, pkgs, user, ... }:

{
  # modular imports
  imports = [
    ./alacritty.nix
    ./dircolors.nix
    ./git.nix
    ./htop.nix
    ./qutebrowser.nix
    ./ranger.nix
    ./readline.nix
    ./rofi.nix
    ./systemd.nix
    ./tmux.nix
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

  # TODO: easy porting: alacritty, dircolors, git(d), gnupg, gtk-2.0, gtk-3.0, htop, mimeapps, picom, qt5ct, qt6ct, qutebrowser, readline, rofi, sxiv, tmux, zathura
  # TODO: harder portinng: X11, autorandr, backgrounds, bash, bin, emacs, i3, neomutt, ranger, systemd, vim, zsh
  # TODO: port all monix packages including fonts
  # TODO: add i3-cycle pip package
  # TODO: use XDG directories instead of our current one

  # set your user's details
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = with pkgs; [ ];
  };

  # configure home-manager
  programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
