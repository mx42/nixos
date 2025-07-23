{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myNixOS.features.stylix.enable = lib.mkEnableOption "enable Stylix";
  config = lib.mkIf config.myNixOS.features.stylix.enable {
    stylix = {
      enable = true;
      image = ../../../wall.jpg;
      polarity = "dark";
      opacity.terminal = 0.9;
      cursor.package = pkgs.bibata-cursors;
      cursor.name = "Bibata-Modern-Ice";
      cursor.size = 24;
      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font Mono";
        };
        sansSerif = {
          package = pkgs.montserrat;
          name = "Montserrat";
        };
        serif = {
          package = pkgs.montserrat;
          name = "Montserrat";
        };
        sizes = {
          applications = 12;
          terminal = 12;
          desktop = 11;
          popups = 12;
        };
      };
      targets = {
        chromium.enable = true;
        grub.enable = true;
        grub.useImage = true;
        plymouth.enable = true;
      };
    };
  };
}
