{
  description = "NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spacemacs = {
      url = "github:syl20bnr/spacemacs/develop";
      flake = false;
    };
    ranger-devicons = {
      url = "github:alexanderjeurissen/ranger_devicons";
      flake = false;
    };
    zsh-system-clipboard = {
      url = "github:kutsan/zsh-system-clipboard";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;

      # define common parameters
      commonParams = {
        defaultUser = "shankar";
        localBin = ".local/bin";
        localNixos = "/etc/nix-config";
      };
    in {
      # NixOS configuration entrypoint
      nixosConfigurations = {
        # personal laptop
        monix = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs commonParams; };
          modules = [ ./hosts/monix ];
        };

        # VMWare emulating personal laptop
        becks = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs commonParams; };
          modules = [ ./hosts/becks ];
        };
      };
    };
}
