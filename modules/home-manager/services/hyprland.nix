{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHome.services.hyprland.enable = lib.mkEnableOption "enables hyprland";

  config = lib.mkIf config.myHome.services.hyprland.enable {
    home.file.".config/hypr" = {
      source = ../../../dotfiles/hypr;
      recursive = true;
    };

    wayland.windowManager.hyprland.enable = true;

    home.packages = with pkgs; [
      libnotify
      xclip
      wl-clipboard
      hyprpaper
      libnotify
      hyprpicker
      slurp
      swappy
      grim
      rofi
    ];

    services = {
      picom.enable = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal
      ];
      configPackages = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal
      ];
    };
  };
}
