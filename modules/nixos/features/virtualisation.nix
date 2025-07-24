{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myNixOS.feature.virtualisation.enable = lib.mkEnableOption "enable virtualisation";

  config = lib.mkIf config.myNixOS.feature.virtualisation.enable {
    virtualisation.podman = {
      enable = true;
      autoPrune.enable = true;
      dockerCompat = true;
      dockerSocker.enable = true;
    };
  };
}
