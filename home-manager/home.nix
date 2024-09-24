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

  # TODO: zsh (enableSupport from other files, remove corresponding equals, move variable declaration to sessionVariables where possible)
  # TODO: X11 and i3 (needs system level, remove picom starting since we have service to autostart this), i3status-rust, autorandr, mimeapps, bin
  # TODO: neomutt + systemd + mbsync + msmtp (perhaps can remove this)
  # TODO: fontconfig and gtk and qt (consider adding fonts to alacritty and i3 and ranger that need them, also update session variables as necessary), emacs
  # TODO: add i3-cycle package as flake git/tarball dependency with package: https://github.com/nix-community/nix-init, check if we need to add a "~/.local/bin" to path for this
  # TODO: use XDG directories with capital names instead of current ones
  # TODO: port all packages including fonts, but take note difference for fonts in system configuration vs. home-manager: https://discourse.nixos.org/t/home-manager-nerdfonts/11226, https://nixos.asia/en/tips/hm-fonts
  # TODO: check if we even need to configure ruby path or if this is done automatically, maybe add older ruby version (https://github.com/bobvanderlinden/nixpkgs-ruby)

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
