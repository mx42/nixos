{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.services.dev-environment;
in
{
  imports = [];

  options.services.dev-environment = {
    enable = mkEnableOption "enable dev-environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      docker
      docker-compose
      git
      cargo
      rustup
    ];
  };
}
