{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myNixOS.feature.gaming.enable = lib.mkEnableOption "enable gaming";

  config = lib.mkIf config.myNixOS.feature.gaming.enable {
    environment.systemPackages = with pkgs; [
      bottles
      steam
      discord
    ];
    programs.steam.enable = true;
    programs.gamemode.enable = true;
  };
}
