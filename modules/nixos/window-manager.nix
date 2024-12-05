{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.services.window-manager;
in
{
  imports = [];

  options.services.window-manager = {
    enable = mkEnableOption "enable window-manager";
  };

  config = mkIf cfg.enable {
    programs.hyprland.enable = true;
    programs.hyprlock.enable = true;
    security.pam.services.hyprlock = {};
    environment.systemPackages = with pkgs; [
      wofi
      dolphin
      waybar
      pavucontrol
    ];
  };
}
