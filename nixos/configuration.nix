{ inputs, outputs, lib, config, pkgs, buildVars, ...}:

{
  # import necessary additional files
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
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

  # configure modprobe, bootloader and EFI
  boot = {
    extraModprobeConfig = "blacklist pcspkr";
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

  # enable network manager and add hostname
  networking.hostName = "monix";
  networking.networkmanager.enable = true;

  # time-related settings
  services.automatic-timezoned.enable = true;
  services.timesyncd = {
    enable = true;
    servers = [ "time.google.com" ];
  };

  # enable power management with TLP
  services.tlp = {
    enable = true;
    settings = {
      DEVICES_TO_DISABLE_ON_STARTUP="bluetooth nfc wifi wwan";
    };
  };

  # configure console and xserver
  console.keyMap = "us";
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    xkb.layout = "us,de";
  };

  # enable docker
  virtualisation = {
    virtualbox.host.enable = true;
    docker.enable = true;
  };

  # configure system-wide users
  programs.zsh.enable = true;
  users = {
    defaultUserShell = pkgs.zsh;
    users.${buildVars.user} = {
      initialPassword = "password";
      isNormalUser = true;
      extraGroups = [ "wheel" "video" "docker" "vboxusers" "vboxsf" ];
    };
  };

  # install system-level packages
  environment = {
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [ vim git ];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";

  # NOTE: here we declare our home manager
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs buildVars; };
    users = {
      ${buildVars.user} = import ../home-manager/home.nix;
    };
  };

  # NOTE: the following settings are used to make VMWare tools work
  # TODO: this should be removed or modularized at a later stage
  virtualisation.vmware.guest.enable = true;
}
