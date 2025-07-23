{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myHome.bundle.myhypr.enable = lib.mkEnableOption "enable hypr bundle";
  config = lib.mkIf config.myHome.bundle.myhypr.enable {
    myHome.services.hyprland.enable = true;
    myHome.services.waybar.enable = true;
    home.packages = map lib.lowPrio [
      pkgs.mako
      pkgs.swayidle
      pkgs.swaylock
      pkgs.swaybg
    ];
  };
}
