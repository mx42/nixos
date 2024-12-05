{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }@inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    nixosConfigurations = {
      home = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./modules/nixos/cli-environment.nix
          ./modules/nixos/desktop-apps.nix
          ./modules/nixos/dev-environment.nix
          ./modules/nixos/fonts.nix
          ./modules/nixos/gaming.nix
          ./modules/nixos/window-manager.nix
          ./hosts/home/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      work = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/work/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
