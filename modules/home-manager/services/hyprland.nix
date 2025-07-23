{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myNixOS.feature.hyprland.enable = lib.mkEnableOption "enables hyprland";

  config = lib.mkIf config.myNixOS.feature.hyprland.enable {
    home.file.".config/hypr" = {
      source = ../../../dotfiles/hypr;
      recursive = true;
    };
    programs = {
      dconf.enable = true;
      hyprland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      libnotify
      xclip
      wl-clipboard
      hyprpaper
      libnotify
      hyprpicker
      slurp
      grim
      rofi
    ];

    services = {
      picom.enable = true;
      xserver.enable = true;
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
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
