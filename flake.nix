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
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      "url" = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
  };

  outputs =
    inputs: with (import ./myLib inputs); {
      nixosConfigurations = {
        arcueid = mkSystem ./hosts/home/configuration.nix;
        work-laptop = mkSystem ./hosts/work/configuration.nix;
      };
      homeConfigurations = {
        "yoru@arcueid" = mkHome "x86_64-linux" ./hosts/home/home.nix;
        "xmorel@work-laptop" = mkHome "x86_64-linux" ./hosts/work/home.nix;
        "xmorel@MacLaptop.local" = mkHome "aarch64-darwin" ./hosts/mac-laptop/home.nix;
      };
      homeManagerModules.default = import ./modules/home-manager;
      nixosModules.default = import ./modules/nixos;
    };
}
