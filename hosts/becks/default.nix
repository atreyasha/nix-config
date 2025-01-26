{ inputs, outputs, lib, config, pkgs, buildVars, ...}:

{
  # import necessary additional files
  imports = [
    ../common/default.nix
    ./hardware.nix
  ];

  # configure hostname
  networking.hostName = "becks";

  # here we declare our home manager
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs buildVars; };
    users = {
      ${buildVars.user} = import ../../home/becks;
    };
  };

  # enable VMWare tools eg. for 3D acceleration
  virtualisation.vmware.guest.enable = true;
}
