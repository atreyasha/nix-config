{ inputs, outputs, lib, config, pkgs, commonParams, ... }:

{
  # import necessary additional files
  imports = [ ../common/default.nix ./hardware.nix ];

  # configure hostname
  networking.hostName = "becks";

  # here we declare our home manager
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs commonParams; };
    users = { ${commonParams.defaultUser} = import ../../home/becks; };
  };

  # enable VMWare tools eg. for 3D acceleration
  virtualisation.vmware.guest.enable = true;
}
