{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myHome.bundle.work-apps.enable = lib.mkEnableOption "enable work-apps bundle";
  config = lib.mkIf config.myHome.bundle.work-apps.enable {
    home.packages = map lib.lowPrio [
      pkgs.tailscale
      pkgs.tailscale-systray
      pkgs.slack
      pkgs.openvpn
    ];
  };
}
