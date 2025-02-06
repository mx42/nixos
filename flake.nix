{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    disko = {
      "url" = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        arcueid = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit inputs;
          };
          modules = [
            ./modules/nixos/cli-environment.nix
            ./modules/nixos/desktop-apps.nix
            ./modules/nixos/dev-environment.nix
            ./modules/nixos/fonts.nix
            ./modules/nixos/gaming.nix
            ./modules/nixos/window-manager.nix
            ./hosts/home/configuration.nix
            inputs.stylix.nixosModules.stylix
            inputs.home-manager.nixosModules.default
          ];
        };
        work-laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./modules/nixos/cli-environment.nix
            ./modules/nixos/dev-environment.nix
            ./modules/nixos/fonts.nix
            ./modules/nixos/window-manager.nix
            disko.nixosModules.disko
            inputs.stylix.nixosModules.stylix
            inputs.home-manager.nixosModules.default
            ./hosts/work/configuration.nix
            ./hosts/work/hardware-configuration.nix
          ];
        };
      };
      homeConfigurations = {
        "xmorel@work-laptop" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./hosts/work/home.nix
          ];
        };
      };
      # homeManagerModules.default = ./modules/home-manager;
      # nixosModules.default = ./modules/nixos;
    };
}
