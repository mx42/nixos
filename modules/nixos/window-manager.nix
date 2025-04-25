{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.services.window-manager;
in
{
  imports = [ ];

  options.services.window-manager = {
    enable = mkEnableOption "enable window-manager";
  };

  config = mkIf cfg.enable {
    # services.displayManager.defaultSession = "none+i3";
    services.xserver = {
      enable = true;
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          # dmenu
          i3lock
          i3status
        ];
      };
    };
    services.picom.enable = true;
    programs.dconf.enable = true;

    programs.hyprland.enable = true;
    programs.hyprlock.enable = true;
    security.pam.services.hyprlock = { };
    environment.systemPackages = with pkgs; [
      # wofi
      kdePackages.dolphin
      waybar
      pavucontrol
      libnotify
      xclip
      wl-clipboard
      hyprpaper
      libnotify
      hyprpicker
      slurp
      grim
      swappy
      swww
      file-roller
      rofi
    ];

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
