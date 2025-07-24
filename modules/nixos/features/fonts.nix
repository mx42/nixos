{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myNixOS.feature.fonts.enable = lib.mkEnableOption "enable fonts";

  config = lib.mkIf config.myNixOS.feature.fonts.enable {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      fira-code
      roboto

      nerd-fonts.fira-code
      nerd-fonts.hack
      nerd-fonts.droid-sans-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.fantasque-sans-mono
    ];
  };
}
