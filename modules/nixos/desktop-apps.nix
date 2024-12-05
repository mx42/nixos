{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.services.desktop-apps;
in
{
  imports = [];

  options.services.desktop-apps = {
    enable = mkEnableOption "enable desktop-apps";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kitty
      skypeforlinux
    ];
    programs.firefox.enable = true;
  };
}
