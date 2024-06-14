{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # import necessary additional files
  imports = [
    ./hardware-configuration.nix
    ./virtualbox.nix
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
      experimental-features = "nix-command flakes";
      # opinionated: disable global registry
      flake-registry = "";
      # workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };

    # opinionated: disable channels
    channel.enable = false;

    # opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # configure bootloader
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    useOSProber = true;
    device = "nodev";
  };

  # nix store and GC related configurations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.settings.auto-optimise-store = true;

  # TODO: port other aspects directly from monix repo
  # TODO: fix up NTP servers with google

  # configure xserver
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
  };

  # configure hostname
  networking.hostName = "monix";

  # configure system-wide users
  users.users = {
    shankar = {
      initialPassword = "password";
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
