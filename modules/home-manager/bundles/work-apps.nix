{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myHome.bundle.work-apps.enable = lib.mkEnableOption "enable work-apps bundle";
  config = lib.mkIf config.myHome.bundle.work-apps.enable {
    home.packages =
      with pkgs;
      map lib.lowPrio [
        tailscale
        tailscale-systray
        slack
        openvpn
        lazysql
        rainfrog
      ];
  };
}
