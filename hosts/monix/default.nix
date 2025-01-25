{
  # import necessary additional files
  imports = [
    ../common/default.nix
    ./hardware.nix
  ];

  # configure hostnam
  networking.hostName = "monix";

  # here we declare our home manager
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs buildVars; };
    users = {
      ${buildVars.user} = import ../../home-manager/monix;
    };
  };
}
