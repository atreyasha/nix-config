{ inputs, outputs, lib, config, pkgs, commonParams, ... }:

{
  # import necessary additional files
  imports = [ ../common/default.nix ./hardware.nix ];

  # blacklist clunky speaker
  boot.extraModprobeConfig = "blacklist pcspkr";

  # configure hostnam
  networking.hostName = "monix";

  # enable power management with TLP
  services.tlp = {
    enable = true;
    settings = { DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth nfc wifi wwan"; };
  };

  # update system packages
  environment.systemPackages = with pkgs; [ brightnessctl ];

  # update default user groups
  users = {
    users."${commonParams.defaultUser}" = { extraGroups = [ "video" ]; };
  };

  # here we declare our home manager
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs commonParams; };
    users = { ${commonParams.defaultUser} = import ../../home/monix; };
  };
}
