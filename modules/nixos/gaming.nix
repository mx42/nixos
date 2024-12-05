{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.services.gaming;
in
{
  imports = [];

  options.services.gaming = {
    enable = mkEnableOption "enable gaming";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      steam
      discord
    ];
    programs.steam.enable = true;
    programs.gamemode.enable = true;
  };
}
