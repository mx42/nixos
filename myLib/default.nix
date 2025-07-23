inputs:
let
  myLib = (import ./default.nix) { inherit inputs; };
  outputs = inputs.self.outputs;
  nixpkgs = inputs.nixpkgs;
in
rec {
  pkgsFor = system: import nixpkgs { inherit system; };

  mkSystem =
    config:
    nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs outputs myLib; };
      modules = [
        config
        outputs.nixosModules.default
      ];
    };

  mkHome =
    sys: config:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsFor sys;
      extraSpecialArgs = { inherit inputs outputs myLib; };
      modules = [
        inputs.stylix.homeManagerModules.stylix
        config
        outputs.homeManagerModules.default
      ];
    };
}
