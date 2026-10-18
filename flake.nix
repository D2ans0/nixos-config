{
  description = "";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    ghidra_11_3_2.url = "github:nixos/nixpkgs/cff659446eccd532661ea86f0caec4d7f0a8722f";
  };

  outputs = {
    self,
    nixpkgs,
    ghidra_11_3_2,
    ...
  } @ inputs: let
  in {
    nixosConfigurations = {
      stumper = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          {
            nixpkgs.overlays = [
              (_: old: { ghidra = ghidra_11_3_2.legacyPackages.${old.system}.ghidra; })
            ];
          }
          ./configuration.nix
        ];
      };
    };
  };
}
