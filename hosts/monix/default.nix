{ inputs, outputs, lib, config, pkgs, buildVars, ...}:

{
  # import necessary additional files
  imports = [
    ../common/default.nix
    ./hardware.nix
  ];

  # blacklist clunky speaker
  boot.extraModprobeConfig = "blacklist pcspkr";

  # configure hostnam
  networking.hostName = "monix";

  # enable power management with TLP
  services.tlp = {
    enable = true;
    settings = {
      DEVICES_TO_DISABLE_ON_STARTUP="bluetooth nfc wifi wwan";
    };
  };

  # enable docker
  virtualisation.docker.enable = true;

  # here we declare our home manager
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs buildVars; };
    users = {
      ${buildVars.user} = import ../../home-manager/monix;
    };
  };
}
