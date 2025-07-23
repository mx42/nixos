{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myHome.services.nix.enable = lib.mkEnableOption "enable nix configuration";
  config = lib.mkIf config.myHome.services.nix.enable {
    home.sessionVariables = {
      FLAKE = "${config.home.homeDirectory}/nixos/";
      NH_FLAKE = "${config.home.homeDirectory}/nixos/";
    };
    home.packages = map lib.lowPrio [
      pkgs.nh
      pkgs.nil
      pkgs.nixfmt-rfc-style
    ];
    nix = {
      settings = {
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-users = [
          "root"
        ];
      };
      gc = {
        automatic = true;
        #  dates = "weekly";
      };
      nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
      extraOptions = ''
        extra-substituters = https://devenv.cachix.org
        extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
      '';
    };
  };
}
