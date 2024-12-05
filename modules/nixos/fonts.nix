{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.services.fonts;
in
{
  imports = [];

  options.services.fonts = {
    enable = mkEnableOption "enable fonts";
  };

  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      fira-code

      nerd-fonts.fira-code
      nerd-fonts.hack
      nerd-fonts.droid-sans-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.fantasque-sans-mono
    ];
  };
}
