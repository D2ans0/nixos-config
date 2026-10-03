{
  description = "";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    openlogi = {
      url = "github:AprilNEA/OpenLogi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    openlogi,
    ...
  } @ inputs: let
  in {
    nixosConfigurations = {
      stumper = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix
          openlogi.nixosModules.default { programs.openlogi.enable = true; }
        ];
      };
    };
  };
}
