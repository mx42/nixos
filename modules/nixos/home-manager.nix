{
  lib,
  config,
  inputs,
  outputs,
  myLib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS;
in
{
  options.myNixOS.home-users = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          userConfig = lib.mkOption {
            default = ./../../hosts/home/home.nix;
          };
          userNixosSettings = lib.mkOption {
            default = { };
          };
        };
      }
    );
    default = { };
  };
  config = {
    programs.fish.enable = true;
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        inherit inputs;
        inherit myLib;
        outputs = inputs.self.outputs;
      };
      users = builtins.mapAttrs (
        name: user:
        { ... }:
        {
          imports = [
            (import user.userConfig)
            outputs.homeManagerModules.default
          ];
        }
      ) (config.myNixOS.home-users);
    };
    users.users = builtins.mapAttrs (
      name: user:
      {
        isNormalUser = true;
        initialPassword = "toto";
        description = "";
        shell = pkgs.fish;
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
          "lp"
        ];
      }
      // user.userNixosSettings
    ) (config.myNixOS.home-users);
  };
}
