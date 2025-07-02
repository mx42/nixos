{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
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
      determinate,
      disko,
      flake-utils,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        arcueid = nixpkgs.lib.nixosSystem {
          specialArgs = {
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
        iso-installer = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./hosts/iso/configuration.nix
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
        "xmorel@MacLaptop.local" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."aarch64-darwin";
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./hosts/mac-laptop/home.nix
          ];
        };
      };
      # homeManagerModules.default = ./modules/home-manager;
      # nixosModules.default = ./modules/nixos;
    };
}
