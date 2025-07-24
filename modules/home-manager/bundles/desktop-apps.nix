{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myHome.bundle.desktop-apps.enable = lib.mkEnableOption "enable desktop-apps bundle";
  config = lib.mkIf config.myHome.bundle.desktop-apps.enable {
    myHome.programs.kitty.enable = true;
    myHome.programs.scanner.enable = true;
    myHome.programs.photos.enable = true;
    home.packages = map lib.lowPrio [
      pkgs.bottles
      pkgs.brightnessctl
      pkgs.flameshot
      pkgs.lutris
      pkgs.ungoogled-chromium
      pkgs.xfce.thunar
      pkgs.xfce.thunar-archive-plugin
      pkgs.xfce.thunar-volman
      pkgs.vial
      pkgs.vlc
    ];
  };
}
