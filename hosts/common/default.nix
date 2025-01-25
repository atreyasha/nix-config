{ inputs, outputs, lib, config, pkgs, buildVars, ...}:

{
  # import necessary additional files
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # configure our nixpkgs
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # configure flakes
  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # we need this to enable flakes
      experimental-features = "nix-command flakes";

      # opinionated: disable global registry
      flake-registry = "";

      # workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;

      # always optimize store
      auto-optimise-store = true;
    };

    # opinionated: disable channels
    channel.enable = false;

    # opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

    # define garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # configure bootloader and EFI
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        device = "nodev";
      };
    };
  };

  # define default locale
  i18n.defaultLocale = "en_US.UTF-8";

  # enable network manager
  networking.networkmanager.enable = true;

  # time-related settings
  services.automatic-timezoned.enable = true;
  services.timesyncd = {
    enable = true;
    servers = [ "time.google.com" ];
  };

  # configure console and xserver
  console.keyMap = "us";
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    xkb.layout = "us,de";
  };

  # configure system-wide users
  programs.zsh.enable = true;
  users = {
    defaultUserShell = pkgs.zsh;
    users.${buildVars.user} = {
      initialPassword = "password";
      isNormalUser = true;
      extraGroups = [ "wheel" "video" "docker" ];
    };
  };

  # install system-level packages
  environment = {
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [ vim git ];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
